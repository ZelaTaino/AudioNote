enum RecordingState: Equatable {
    case idle
    case noPermission
    case recordReady
    case recording
    case recorded
    case recordFailed
}

enum SendAudioState: Equatable {
    case idle
    case uploading
    case uploaded
    case failed
}

typealias AudioMeters = [Float]
