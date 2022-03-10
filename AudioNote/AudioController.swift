import AVFoundation
import UIKit

protocol AudioControllerDelegate: AnyObject {
    func didUpdateMeter(_ value: Float)
}

final class AudioController: NSObject {
    private var timer: Timer?

    let recordingSession: AVAudioSession
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?

    weak var delegate: AudioControllerDelegate?

    // todo
    var saveLocationURL: URL {
        let name = "testRecording"
        let saveLocation: URL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(name).m4a")
        return saveLocation
    }

    override init() {
        recordingSession = AVAudioSession.sharedInstance()
    }

    func requestUserPermissions() {
        // todo
        recordingSession.requestRecordPermission { _ in }
    }

    deinit {
        audioRecorder?.stop()
        audioPlayer?.stop()
        timer?.invalidate()
    }
}

// MARK: Audio Recorder

extension AudioController: AVAudioRecorderDelegate {
    func prepareRecorder() {
        if audioRecorder != nil { return }

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            try recordingSession.setCategory(.record, mode: .spokenAudio)
            try recordingSession.setActive(true)
            audioRecorder = try AVAudioRecorder(url: saveLocationURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true

        } catch let error as NSError {
            stopRecording(successfully: false)
            print("Failed to record: \(error)")
        }
    }

    func startRecording() {
        audioRecorder?.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            self?.audioRecorder?.updateMeters()
            if let powerValue = self?.audioRecorder?.averagePower(forChannel: 0) {
                self?.delegate?.didUpdateMeter(powerValue)
            }
        })
    }

    func stopRecording(successfully: Bool) {
        audioRecorder?.stop()
        timer?.invalidate()
        audioRecorder = nil

        do {
            try recordingSession.setActive(false)
        } catch let error as NSError {
            print("Failed to end session: \(error)")
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        stopRecording(successfully: flag)
    }
}

// MARK: Audio Player

extension AudioController: AVAudioPlayerDelegate {
    func prepareAudioPlayer() {
        if audioPlayer != nil { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: saveLocationURL, fileTypeHint: AVFileType.m4a.rawValue)
            audioPlayer?.delegate = self
            try recordingSession.setCategory(.playback, mode: .spokenAudio)
            try recordingSession.setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: saveLocationURL, fileTypeHint: AVFileType.m4a.rawValue)

        } catch let error as NSError {
            print("Failed to prepare audio player: \(error)")
            stopAudio(successfully: false)
        }
    }

    func playAudio() {
        audioPlayer?.play()
    }

    func pauseAudio() {
        audioPlayer?.pause()
    }

    func stopAudio(successfully: Bool) {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio(successfully: flag)
    }
}
