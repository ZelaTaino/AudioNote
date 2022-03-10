import Diffuser

final class AudioRecorderFuser {
    private var fuser: Fuser<Event>?
    private var fuserConnection: Fuser<Event>.Disposable?

    func connect(view: RecordingView, eventConsumer: @escaping (Event) -> Void) {
        fuser = Fuser.fromAll([
            Fuser.extractConstant(.recordButtonClicked, .fromEvents(view.recordButton, for: .touchUpInside)),
            Fuser.extractConstant(.playbackButtonClicked, .fromEvents(view.playbackButton, for: .touchUpInside)),
        ])

        fuserConnection = fuser?.connect(eventConsumer)
    }

    func dispose() {
        fuser = nil
        fuserConnection?.dispose()
        fuserConnection = nil
    }
}
