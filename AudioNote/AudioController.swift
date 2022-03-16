import AVFoundation

final class AudioController: NSObject {
    let recordingSession: AVAudioSession
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?

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
    }
}

// MARK: Audio Recorder

extension AudioController {
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
            audioRecorder?.isMeteringEnabled = true

        } catch let error as NSError {
            stopRecording(successfully: false)
            print("Failed to record: \(error)")
        }
    }

    func startRecording() {
        audioRecorder?.record()
    }

    func getMeter() -> Float? {
        audioRecorder?.updateMeters()
        if let powerValue = audioRecorder?.averagePower(forChannel: 0) {
            return powerValue
        }

        return nil
    }

    func stopRecording(successfully: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil

        do {
            try recordingSession.setActive(false)
        } catch let error as NSError {
            print("Failed to end session: \(error)")
        }
    }
}

// MARK: Audio Player

extension AudioController {
    func prepareAudioPlayer() {
        if audioPlayer != nil { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: saveLocationURL, fileTypeHint: AVFileType.m4a.rawValue)
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
}
