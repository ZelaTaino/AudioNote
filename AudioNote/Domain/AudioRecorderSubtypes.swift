enum ControllerState {
    case idle
    case recording
    case recorded
    case playback
}

enum SendAudioState: Equatable {
    case idle
    case uploading
    case uploaded
    case failed
}

typealias AudioMeters = [Float]
