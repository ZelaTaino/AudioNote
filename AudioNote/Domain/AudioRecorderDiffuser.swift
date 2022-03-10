import Diffuser

final class AudioRecorderDiffuser {
    private var diffuser: Diffuser<Model>?

    func connect(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) {
        diffuser = .intoAll([
            .map({ $0.controllerState }, intoControllerState(view: view, audioViewBinder: audioViewBinder)),
        ])
    }

    func disconnect() {
        diffuser = nil
    }

    func render(_ model: Model) {
        diffuser?.run(model)
    }

    private func intoControllerState(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) -> Diffuser<ControllerState> {
        return .into { state in
            switch state {
            case .idle:
                view.recordButton.hideIcon(animate: false)
                view.sendButton.hideIcon(animate: false)

                view.playbackButton.showIcon(animate: false)
                view.playbackButton.isEnabled = false

                view.pauseButton.hideIcon(animate: false)
            case .recording:
                view.recordButton.showIcon(animate: true)
                audioViewBinder.startRecording()
            case .recorded:
                view.sendButton.showIcon(animate: true)

                view.recordButton.hideIcon(animate: true)
                audioViewBinder.stopRecording()

                view.playbackButton.isEnabled = true
            case .playback:
                audioViewBinder.playAudio()

                view.playbackButton.hideIcon(animate: true)
                view.pauseButton.showIcon(animate: true)
            }
        }
    }
}
