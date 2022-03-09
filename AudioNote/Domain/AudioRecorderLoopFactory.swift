import MobiusCore

struct AudioRecorderLoopFactory {
    static func makeLoopController() -> MobiusController<Model, Event, Effect> {
        let effectRouter = EffectRouter<Effect, Event>()
            .asConnectable


        let loopBuilder: Mobius.Builder<Model, Event, Effect>
            = Mobius.loop(update: AudioRecorderLogic.update, effectHandler: effectRouter)

        let initialModel = AudioRecorderModel(
            recordingState: .idle,
            sendAudioState: .idle,
            saveLocation: nil
        )

        return loopBuilder.makeController(from: initialModel, initiate: AudioRecorderLogic.initiator)
    }

    static func makeViewConnectable(view: RecordingView) -> AudioRecorderViewConnectable {
        let audioRecorderViewBinder = AudioRecorderViewBinder(view: view.audioVisualizerView)
        return AudioRecorderViewConnectable(view: view, audioRecorderViewBinder: audioRecorderViewBinder)
    }
}
