import MobiusCore

enum AudioRecorderLogic {
    static func initiator(_ model: Model) -> First<Model, Effect> {
        return First(model: model)
    }

    static func update(model: Model, event: Event) -> Next<Model, Effect> {
        switch event {
        case .recordButtonClicked:
            if model.controllerState == .idle {
                let nextModel = model.withChangedControllerState(.recording)
                return .next(nextModel)
            }

            if model.controllerState == .recording {
                let nextModel = model.withChangedControllerState(.recorded)
                return .next(nextModel)
            }

            return .noChange
        case .playbackButtonClicked:
            let nextModel = model.withChangedControllerState(.playback)
            return .next(nextModel)
        default:
            return .noChange
        }
    }
}
