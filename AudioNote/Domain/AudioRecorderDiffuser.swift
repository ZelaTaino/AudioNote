import Diffuser

final class AudioRecorderDiffuser {
    private var diffuser: Diffuser<Model>?

    func connect(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) {
        diffuser = .intoAll([
            .map({ $0.recordingState }, intoRecordingState(view: view, audioViewBinder: audioViewBinder)),
        ])
    }

    func disconnect() {
        diffuser = nil
    }

    func render(_ model: Model) {
        diffuser?.run(model)
    }

    private func intoRecordingState(view: RecordingView, audioViewBinder: AudioRecorderViewBinder) -> Diffuser<RecordingState> {
        return .into { state in
            switch state {
            case .recordReady:
                view.recordButton.isRecording = false
            case .recording:
                view.recordButton.isRecording = true
                audioViewBinder.startRecording()
            case .recordFailed:
                view.recordButton.isRecording = false
            default:
                break
            }
        }
    }
}
