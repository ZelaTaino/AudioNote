import MobiusCore
import Foundation

typealias Model = AudioRecorderModel
typealias Event = AudioRecorderEvent
typealias Effect = AudioRecorderEffect

struct AudioRecorderModel: Equatable {
    let controllerState: ControllerState
    let playbackState: PlaybackState

    func withChangedControllerState(_ controllerState: ControllerState) -> AudioRecorderModel {
        return AudioRecorderModel(
            controllerState: controllerState,
            playbackState: playbackState
        )
    }

    func withChangedPlaybackState(_ playbackState: PlaybackState) -> AudioRecorderModel {
        return AudioRecorderModel(
            controllerState: controllerState,
            playbackState: playbackState
        )
    }
}

enum AudioRecorderEvent {
    case permissionGranted
    case persmissionDenied
    case recordButtonClicked
    case playbackButtonClicked
    case pauseButtonClicked
}

enum AudioRecorderEffect {}
