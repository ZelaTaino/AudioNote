import UIKit

final class AudioRecorderViewBinder: AudioControllerDelegate {
    private let audioVisualizerView: AudioVisualizerView
    private let audioController: AudioController

    init(view: AudioVisualizerView) {
        audioVisualizerView = view
        audioController = AudioController()
        audioController.delegate = self
    }

    func startRecording() {
        audioController.prepareRecorder()
        audioController.startRecording()
    }

    func stopRecording() {
        audioController.stopRecording(successfully: true)
    }

    func playAudio() {
        audioController.prepareAudioPlayer()
        audioController.playAudio()
    }

    func pauseAudio() {
        audioController.stopAudio(successfully: true)
    }

    func didUpdateMeter(_ value: Float) {
        addAudioBar(with: value)
        scrollAudioVisualizer()
    }

    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let boundedLevel = level > 0 ? 0 : level
        let height = max(8.0, ((boundedLevel + 25) / 25) * Float(audioVisualizerView.frame.height))
        return CGFloat(height)
    }

    private func addAudioBar(with powerValue: Float) {
        let audioBar = AudioBarView()
        audioBar.backgroundColor = .white
        audioBar.height = normalizeSoundLevel(level: powerValue)
        audioVisualizerView.stackView.addArrangedSubview(audioBar)
    }

    private func scrollAudioVisualizer() {
        let offset = CGPoint(
            x: audioVisualizerView.scrollView.contentSize.width - audioVisualizerView.scrollView.bounds.width,
            y: 0
        )
        if offset.x > 0 { audioVisualizerView.scrollView.setContentOffset(offset, animated: true) }
    }
}
