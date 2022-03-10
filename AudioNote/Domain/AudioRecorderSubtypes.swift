import Combine
enum ControllerState {
    case idle
    case recording
    case recorded
}

enum PlaybackState {
    case play
    case pause
}

enum SendAudioState: Equatable {
    case idle
    case uploading
    case uploaded
    case failed
}

typealias AudioMeters = [Float]
