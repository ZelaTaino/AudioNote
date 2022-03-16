import UIKit

final class RecordingView: UIView {
    let audioVisualizerView: AudioVisualizerView
    let timeStampLabel: UILabel
    let recordButton: IconButtonView
    let sendButton: IconButtonView
    let playbackButton: IconButtonView
    let pauseButton: IconButtonView
    let cancelButton: IconButtonView

    init() {
        audioVisualizerView = AudioVisualizerView()
        timeStampLabel = UILabel()
        recordButton = IconButtonView(icon: .stop, backgroundcolor: .recordRed)
        sendButton = IconButtonView(icon: .send, backgroundcolor: .sendOrange)
        playbackButton = IconButtonView(icon: .play, backgroundcolor: .clear)
        pauseButton = IconButtonView(icon: .pause, backgroundcolor: .clear)
        cancelButton = IconButtonView(icon: .cancel, backgroundcolor: .clear)

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
        cancelButton.configuration = configuration
    }

    private func buildHierarchy() {
        addSubview(audioVisualizerView)
        addSubview(recordButton)
        addSubview(sendButton)
        addSubview(playbackButton)
        addSubview(pauseButton)
        addSubview(cancelButton)
    }

    private func activateConstraints() {
        audioVisualizerView.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        playbackButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        let playBackCenterLayoutGuide = UILayoutGuide()
        addLayoutGuide(playBackCenterLayoutGuide)

        let cancelCenterLayoutGuide = UILayoutGuide()
        addLayoutGuide(cancelCenterLayoutGuide)

        let controllerLayoutGuide = UILayoutGuide()
        addLayoutGuide(controllerLayoutGuide)

        let thirdOfControllerLayoutGuide = UILayoutGuide()
        addLayoutGuide(thirdOfControllerLayoutGuide)

        NSLayoutConstraint.activate([
            audioVisualizerView.topAnchor.constraint(equalTo: topAnchor),
            audioVisualizerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            audioVisualizerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            audioVisualizerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.68),

            controllerLayoutGuide.topAnchor.constraint(equalTo: audioVisualizerView.bottomAnchor),
            controllerLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),

            thirdOfControllerLayoutGuide.heightAnchor.constraint(equalTo: controllerLayoutGuide.heightAnchor, multiplier: 0.33),
            thirdOfControllerLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),

            recordButton.centerYAnchor.constraint(equalTo: thirdOfControllerLayoutGuide.topAnchor),
            recordButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            recordButton.heightAnchor.constraint(equalToConstant: 44),
            recordButton.widthAnchor.constraint(equalTo: recordButton.heightAnchor),

            sendButton.centerYAnchor.constraint(equalTo: thirdOfControllerLayoutGuide.topAnchor),
            sendButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 44),
            sendButton.widthAnchor.constraint(equalTo: sendButton.heightAnchor),

            playBackCenterLayoutGuide.topAnchor.constraint(equalTo: audioVisualizerView.bottomAnchor),
            playBackCenterLayoutGuide.bottomAnchor.constraint(equalTo: recordButton.topAnchor),

            playbackButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playbackButton.centerYAnchor.constraint(equalTo: playBackCenterLayoutGuide.centerYAnchor),
            playbackButton.heightAnchor.constraint(equalToConstant: 40),
            playbackButton.widthAnchor.constraint(equalTo: playbackButton.heightAnchor),

            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pauseButton.centerYAnchor.constraint(equalTo: playBackCenterLayoutGuide.centerYAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 40),
            pauseButton.widthAnchor.constraint(equalTo: pauseButton.heightAnchor),

            cancelCenterLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
            cancelCenterLayoutGuide.trailingAnchor.constraint(equalTo: recordButton.leadingAnchor, constant: -8.0),

            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalTo: cancelButton.heightAnchor),
            cancelButton.centerXAnchor.constraint(equalTo: cancelCenterLayoutGuide.centerXAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor),
        ])
    }
}
