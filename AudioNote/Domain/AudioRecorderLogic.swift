import MobiusCore

enum AudioRecorderLogic {
    static func initiator(_ model: Model) -> First<Model, Effect> {
        return First(model: model)
    }

    static func update(model: Model, event: Event) -> Next<Model, Effect> {
        switch event {
        case .recordingToggleRequested:
            if model.controllerState == .idle {
                let nextModel = model.withChangedControllerState(.recording)
                return .next(nextModel)
            }

            if model.controllerState == .recording {
                let nextModel = model.withChangedControllerState(.recorded)
                return .next(nextModel)
            }

            return .noChange
        case .playbackRequested:
            let nextModel = model.withChangedPlaybackState(.play)
            return .next(nextModel)
        case .stopPlaybackRequested:
            let nextModel = model.withChangedPlaybackState(.pause)
            return .next(nextModel)
        case .resetRecordingRequested:
            let nextModel = model.withChangedControllerState(.idle)
            return .next(nextModel)
        default:
            return .noChange
        }
    }
}
