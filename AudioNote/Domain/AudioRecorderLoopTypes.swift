import MobiusCore
import Foundation

typealias Model = AudioRecorderModel
typealias Event = AudioRecorderEvent
typealias Effect = AudioRecorderEffect

struct AudioRecorderModel: Equatable {
    let recordingState: RecordingState
    let sendAudioState: SendAudioState
    let saveLocation: URL?

    func withChangedRecordingState(_ recordingState: RecordingState) -> AudioRecorderModel {
        return AudioRecorderModel(
            recordingState: recordingState,
            sendAudioState: sendAudioState,
            saveLocation: saveLocation
        )
    }
}

enum AudioRecorderEvent {
    case permissionGranted
    case persmissionDenied
    case recordButtonClicked

}

enum AudioRecorderEffect {}
