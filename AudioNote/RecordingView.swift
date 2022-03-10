import UIKit

final class RecordingView: UIView {
    let audioVisualizerView: AudioVisualizerView
    let timeStampLabel: UILabel
    let recordButton: IconButtonView
    let sendButton: IconButtonView
    let playbackButton: IconButtonView
    let pauseButton: IconButtonView

    init() {
        audioVisualizerView = AudioVisualizerView()
        timeStampLabel = UILabel()
        recordButton = IconButtonView(icon: .stop, backgroundcolor: .recordRed)
        sendButton = IconButtonView(icon: .send, backgroundcolor: .sendOrange)
        playbackButton = IconButtonView(icon: .play, backgroundcolor: .clear)
        pauseButton = IconButtonView(icon: .pause, backgroundcolor: .clear)

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
        audioVisualizerView.backgroundColor = .vcrGrey
        audioVisualizerView.layer.cornerRadius = 15
        audioVisualizerView.clipsToBounds = true
        audioVisualizerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        // todo: figure out button shit
        let configuration: UIButton.Configuration = .plain()
        playbackButton.configuration = configuration
        pauseButton.configuration = configuration
    }

    private func buildHierarchy() {
        addSubview(audioVisualizerView)
        addSubview(recordButton)
        addSubview(sendButton)
        addSubview(playbackButton)
        addSubview(pauseButton)
    }

    private func activateConstraints() {
        audioVisualizerView.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        playbackButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false

        let layoutGuide = UILayoutGuide()
        addLayoutGuide(layoutGuide)

        NSLayoutConstraint.activate([
            audioVisualizerView.topAnchor.constraint(equalTo: topAnchor),
            audioVisualizerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            audioVisualizerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            audioVisualizerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.68),

            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
            recordButton.heightAnchor.constraint(equalToConstant: 44),
            recordButton.widthAnchor.constraint(equalTo: recordButton.heightAnchor),

            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -52),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            sendButton.widthAnchor.constraint(equalToConstant: 44),

            layoutGuide.topAnchor.constraint(equalTo: audioVisualizerView.bottomAnchor),
            layoutGuide.bottomAnchor.constraint(equalTo: recordButton.topAnchor),

            playbackButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackButton.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
            playbackButton.heightAnchor.constraint(equalToConstant: 40),
            playbackButton.widthAnchor.constraint(equalTo: playbackButton.heightAnchor),

            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseButton.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 40),
            pauseButton.widthAnchor.constraint(equalTo: pauseButton.heightAnchor),
        ])
    }
}
