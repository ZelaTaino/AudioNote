import UIKit

final class RecordingView: UIView {
    let audioView: UIView
    let audioVisualizerView: AudioVisualizerView
    let timeStampLabel: UILabel
    let recordButton: RecordButtonView
    let playbackButton: UIButton

    init() {
        audioView = UIView()
        audioVisualizerView = AudioVisualizerView()
        timeStampLabel = UILabel()
        recordButton = RecordButtonView()
        playbackButton = UIButton()

        super.init(frame: .zero)

        styleView()
        buildHierarchy()
        activateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func styleView() {
        backgroundColor = .vcrBlack
        audioView.backgroundColor = .vcrGrey
        audioVisualizerView.backgroundColor = .vcrGrey

        playbackButton.setTitle("Play Recording", for: .normal)
        playbackButton.setTitleColor(.systemBlue, for: .normal)

        audioView.layer.cornerRadius = 15
        audioView.clipsToBounds = true
        audioView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    private func buildHierarchy() {
        addSubview(audioView)
        addSubview(audioVisualizerView)
        addSubview(recordButton)
    }

    private func activateConstraints() {
        audioView.translatesAutoresizingMaskIntoConstraints = false
        audioVisualizerView.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        playbackButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            audioView.topAnchor.constraint(equalTo: topAnchor),
            audioView.leadingAnchor.constraint(equalTo: leadingAnchor),
            audioView.trailingAnchor.constraint(equalTo: trailingAnchor),
            audioView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.68),

            audioVisualizerView.topAnchor.constraint(equalTo: audioView.topAnchor),
            audioVisualizerView.bottomAnchor.constraint(equalTo: audioView.bottomAnchor),
            audioVisualizerView.leadingAnchor.constraint(equalTo: audioView.leadingAnchor),
            audioVisualizerView.trailingAnchor.constraint(equalTo: audioView.trailingAnchor),

            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
            recordButton.heightAnchor.constraint(equalToConstant: 44),
            recordButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
}
