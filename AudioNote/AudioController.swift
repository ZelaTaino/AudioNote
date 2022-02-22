import AVFoundation
import UIKit

final class AudioController: NSObject {
    private var timer: Timer?

    let recordingSession: AVAudioSession
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?

    // temp: I would like to have a layer to combine the buttons and actions
    let recordButton: UIButton
    let playbackButton: UIButton

    var saveLocationURL: URL {
        // Temporary
//        let timeStamp = NSDate().timeIntervalSince1970
        let name = "testRecording"
        let saveLocation: URL = FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(name).m4a")
        print(saveLocation)
        return saveLocation
    }

    typealias Callback = (Float) -> ()
    let updateAudioWaveFormCallback: Callback

    init(recordButton: UIButton, playbackButton: UIButton, updateAudioWaveFormCallback: @escaping Callback) {
        recordingSession = AVAudioSession.sharedInstance()
        self.recordButton = recordButton
        self.playbackButton = playbackButton
        self.updateAudioWaveFormCallback = updateAudioWaveFormCallback
    }

    func requestUserPermissions() {
        recordingSession.requestRecordPermission { [weak self] granted in
            if granted {
                // enabled recording state
                self?.recordButton.isEnabled = true

            } else {
                // disable recording state with the ability to ask for permission again
                self?.recordButton.isEnabled = false
            }
        }
    }

    func pauseAudio() {
        audioPlayer?.pause()
    }

    func prepareAudioPlayer() {
        if audioPlayer != nil { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: saveLocationURL, fileTypeHint: AVFileType.m4a.rawValue)
            audioPlayer?.delegate = self

        } catch let error as NSError {
            print("Failed to prepare audio player: \(error)")
            stopAudio(successfully: false)
        }
    }

    func playAudio() {
        do {
            try recordingSession.setCategory(.playback, mode: .spokenAudio)
            try recordingSession.setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: saveLocationURL, fileTypeHint: AVFileType.m4a.rawValue)
            audioPlayer?.delegate = self
            audioPlayer?.play()

            DispatchQueue.main.async { [weak self] in
                self?.playbackButton.setTitle("Pause", for: .normal)
            }
        } catch let error as NSError {
            print("Failed to play file at \(saveLocationURL): \(error)")
            stopAudio(successfully: false)
        }
    }

    func stopAudio(successfully: Bool) {
        audioPlayer?.stop()
        audioPlayer = nil

        if successfully {
            playbackButton.setTitle("Play", for: .normal)
        } else {
            playbackButton.setTitle("Failed to Play. Re-play", for: .normal)
        }
    }

    func startRecording() {
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
            audioRecorder?.record()

            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
                self?.audioRecorder?.updateMeters()
                // todo: find a way to separate logic
                if let powerValue = self?.audioRecorder?.averagePower(forChannel: 0) {
                    self?.updateAudioWaveFormCallback(powerValue)
                }

            })

            DispatchQueue.main.async { [weak self] in
                self?.recordButton.setTitle("Tap to stop", for: .normal)
            }

        } catch let error as NSError {
            stopRecording(successfully: false)
            print("Failed to record: \(error)")
        }
    }

    deinit {
        audioRecorder?.stop()
        timer?.invalidate()
    }

    func stopRecording(successfully: Bool) {
        audioRecorder?.stop()
        timer?.invalidate()
        audioRecorder = nil
        if successfully {
            recordButton.setTitle("Record", for: .normal)
        } else {
            recordButton.setTitle("Tap to re-record", for: .normal)
        }

        do {
            try recordingSession.setActive(false)
        } catch let error as NSError {
            print("Failed to end session: \(error)")
        }
    }
}

extension AudioController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        stopRecording(successfully: flag)
    }
}

extension AudioController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio(successfully: flag)
    }
}
