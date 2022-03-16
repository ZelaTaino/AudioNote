import Diffuser

final class AudioRecorderFuser {
    private var fuser: Fuser<Event>?
    private var fuserConnection: Fuser<Event>.Disposable?

    func connect(view: RecordingView, eventConsumer: @escaping (Event) -> Void) {
        fuser = Fuser.fromAll([
            Fuser.extractConstant(.recordingToggleRequested, .fromEvents(view.recordButton, for: .touchUpInside)),
            Fuser.extractConstant(.playbackRequested, .fromEvents(view.playbackButton, for: .touchUpInside)),
            Fuser.extractConstant(.stopPlaybackRequested, .fromEvents(view.pauseButton, for: .touchUpInside)),
            Fuser.extractConstant(.resetRecordingRequested, .fromEvents(view.cancelButton, for: .touchUpInside)),
        ])

        fuserConnection = fuser?.connect(eventConsumer)
    }

    func dispose() {
        fuser = nil
        fuserConnection?.dispose()
        fuserConnection = nil
    }
}
