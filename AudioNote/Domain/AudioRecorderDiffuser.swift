import Diffuser

final class AudioRecorderDiffuser {
    private var diffuser: Diffuser<Model>?

    func connect(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) {
        diffuser = .intoAll([
            .map({ $0.controllerState }, intoControllerState(view: view, audioViewBinder: audioViewBinder)),
            .map({ $0.playbackState }, intoPlaybackState(view: view, audioViewBinder: audioViewBinder)),
        ])
    }

    func disconnect() {
        diffuser = nil
    }

    func render(_ model: Model) {
        diffuser?.run(model)
    }

    private func intoPlaybackState(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) -> Diffuser<PlaybackState> {
        return .into { state in
            switch state {
            case .play:
                audioViewBinder.playAudio()
                view.playbackButton.hideIcon(animate: true)
                view.playbackButton.alpha = 0.0
                view.pauseButton.showIcon(animate: true)
                view.pauseButton.alpha = 1.0
                view.cancelButton.isEnabled = false
            case .pause:
                audioViewBinder.pauseAudio()
                view.playbackButton.showIcon(animate: true)
                view.playbackButton.alpha = 1.0
                view.pauseButton.hideIcon(animate: true)
                view.pauseButton.alpha = 0.0
                view.cancelButton.isEnabled = true
            }
        }
    }

    private func intoControllerState(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) -> Diffuser<ControllerState> {
        return .into { state in
            switch state {
            case .idle:
                view.recordButton.hideIcon(animate: true)
                view.recordButton.alpha = 1.0

                view.sendButton.hideIcon(animate: true)
                view.sendButton.alpha = 0.0

                view.playbackButton.showIcon(animate: false)
                view.playbackButton.isEnabled = false
                view.pauseButton.hideIcon(animate: false)
                view.pauseButton.alpha = 0.0

                view.cancelButton.hideIcon(animate: false)
                view.cancelButton.alpha = 0.0

                audioViewBinder.resetRecording()

            case .recording:
                view.recordButton.showIcon(animate: true)
                audioViewBinder.startRecording()
            case .recorded:
                view.sendButton.showIcon(animate: true)
                view.sendButton.alpha = 1.0
                view.recordButton.hideIcon(animate: true)
                view.recordButton.alpha = 0.0
                audioViewBinder.stopRecording()

                view.playbackButton.isEnabled = true
                view.cancelButton.showIcon(animate: true)
                view.cancelButton.alpha = 1.0
            }
        }
    }
}
