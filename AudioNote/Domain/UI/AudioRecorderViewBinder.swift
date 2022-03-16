import AVFoundation

final class AudioRecorderViewBinder: NSObject {
    private let audioVisualizerView: AudioVisualizerView
    private let audioUiController: AudioVisualizerUIController
    private let audioController: AudioController
    private var eventConsumer: ((Event) -> Void)?

    init(view: AudioVisualizerView) {
        audioVisualizerView = view
        audioUiController = AudioVisualizerUIController(view: view)
        audioController = AudioController()
    }

    // MARK: Public methods

    func connect(output: @escaping (Event) -> Void) {
        eventConsumer = output
    }

    func disconnect() {
        eventConsumer = nil
    }
}

// MARK: Audio Recorder

extension AudioRecorderViewBinder: AVAudioRecorderDelegate {

    func resetRecording() {
        audioUiController.resetRecording()
    }

    func startRecording() {
        audioController.prepareRecorder()
        audioController.startRecording()
        audioController.audioRecorder?.delegate = self
        audioUiController.drawAudioVisual(with: audioController.getMeter)
    }

    func stopRecording() {
        audioController.stopRecording(successfully: true)
        audioUiController.skipPlayheadToStart()
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        eventConsumer?(.recordingToggleRequested)
    }
}

// MARK: Audio Player

extension AudioRecorderViewBinder: AVAudioPlayerDelegate {
    func playAudio() {
        audioController.prepareAudioPlayer()
        audioController.playAudio()
        audioController.audioPlayer?.delegate = self

        audioUiController.playAudioVisual()
    }

    func pauseAudio() {
        audioController.stopAudio(successfully: true)
        audioUiController.skipPlayheadToStart()
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        eventConsumer?(.stopPlaybackRequested)
    }
}
