import MobiusCore

final class AudioRecorderViewConnectable: Connectable {
    typealias EventConsumer = (Output) -> Void
    typealias Input = Model
    typealias Output = Event

    private let fuser = AudioRecorderFuser()
    private let diffuser = AudioRecorderDiffuser()

    private var eventConsumer: EventConsumer?

    private let view: RecordingView
    private let audioRecorderViewBinder: AudioRecorderViewBinder

    init(view: RecordingView, audioRecorderViewBinder: AudioRecorderViewBinder) {
        self.view = view
        self.audioRecorderViewBinder = audioRecorderViewBinder
    }

    func connect(_ output: @escaping EventConsumer) -> Connection<Input> {
        eventConsumer = output

        let eventConsumer: EventConsumer = { [weak self] event in
            self?.eventConsumer?(event)
        }

        fuser.connect(view: view, eventConsumer: eventConsumer)
        diffuser.connect(view: view, audioViewBinder: audioRecorderViewBinder)

        return Connection(acceptClosure: accept, disposeClosure: dispose)
    }

    private func accept(_ model: Input) {
        diffuser.render(model)
    }

    private func dispose() {
        eventConsumer = nil
        fuser.dispose()
        diffuser.disconnect()
    }
}
