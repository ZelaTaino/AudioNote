import MobiusCore

enum AudioRecorderLogic {
    static func initiator(_ model: Model) -> First<Model, Effect> {
        let nextModel = model.withChangedRecordingState(.recordReady)
        return First(model: nextModel)
    }

    static func update(model: Model, event: Event) -> Next<Model, Effect> {
        switch event {
        case .recordButtonClicked:
            let nextModel = model.withChangedRecordingState(.recording)
            return .next(nextModel)
        default:
            return .noChange
        }
    }
}
