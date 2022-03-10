import MobiusCore
import Foundation

typealias Model = AudioRecorderModel
typealias Event = AudioRecorderEvent
typealias Effect = AudioRecorderEffect

struct AudioRecorderModel: Equatable {
    let controllerState: ControllerState

    func withChangedControllerState(_ controllerState: ControllerState) -> AudioRecorderModel {
        return AudioRecorderModel(controllerState: controllerState)
    }
}

enum AudioRecorderEvent {
    case permissionGranted
    case persmissionDenied
    case recordButtonClicked
    case playbackButtonClicked

}

enum AudioRecorderEffect {}
