import UIKit

final class AudioVisualizerUIController {
    private let audioVisualizerView: AudioVisualizerView
    private var timer: Timer?

    init(view: AudioVisualizerView) {
        audioVisualizerView = view
    }

    func drawAudioVisual(with meterCallback: @escaping () -> Float?) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            if let meterValue = meterCallback() {
                self?.addAudioBar(with: meterValue)
                self?.scrollAudioVisualizer()
            }
        })
    }

    func skipPlayheadToStart() {
        timer?.invalidate()
        audioVisualizerView.scrollView.isScrollEnabled = true
        audioVisualizerView.scrollView.setContentOffset(.zero, animated: true)
        audioVisualizerView.stackView.arrangedSubviews.forEach { barView in
            barView.backgroundColor = .white
        }
    }

    func resetRecording() {
        for barView in audioVisualizerView.stackView.arrangedSubviews {
            audioVisualizerView.stackView.removeArrangedSubview(barView)
            barView.removeFromSuperview()
        }
    }

    func playAudioVisual() {
        audioVisualizerView.scrollView.isScrollEnabled = false

        var barViewIndex = 0
        var xOffset = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            if let audioVisualizerView = self?.audioVisualizerView {
                if barViewIndex < audioVisualizerView.stackView.arrangedSubviews.count {
                    audioVisualizerView.stackView.arrangedSubviews[barViewIndex].backgroundColor = UIColor.sendOrange

                    // todo: move away from hard coded
                    if barViewIndex > 25 {
                        audioVisualizerView.scrollView.setContentOffset(CGPoint(x: xOffset, y: 0.0), animated: true)
                        xOffset += audioVisualizerView.stackView.arrangedSubviews[barViewIndex].frame.width + 3.0
                    }

                    barViewIndex += 1
                }
            }
        })
    }

    private func addAudioBar(with meterValue: Float) {
        let audioBar = AudioBarView()
        audioBar.backgroundColor = .white
        audioBar.height = normalizedHeightOf(meterValue: meterValue)
        audioVisualizerView.stackView.addArrangedSubview(audioBar)
    }

    private func normalizedHeightOf(meterValue: Float) -> CGFloat {
        let boundedLevel = meterValue > 0 ? 0 : meterValue
        let height = max(8.0, ((boundedLevel + 25) / 25) * Float(audioVisualizerView.frame.height))
        return CGFloat(height)
    }

    private func scrollAudioVisualizer() {
        let xOffest = audioVisualizerView.scrollView.contentSize.width - audioVisualizerView.scrollView.bounds.width
        if xOffest > 0 { audioVisualizerView.scrollView.setContentOffset(CGPoint(x: xOffest, y: 0), animated: true) }
    }

    deinit {
        timer?.invalidate()
    }
}
