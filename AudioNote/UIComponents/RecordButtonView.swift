import UIKit

final class RecordButtonView: UIButton {
    private let stopView: IconView

    init() {
        stopView = IconView(type: .stop)

        super.init(frame: .zero)

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.recordRed
        configuration.cornerStyle = .capsule
        self.configuration = configuration

        stopView.translatesAutoresizingMaskIntoConstraints = false
        stopView.isUserInteractionEnabled = false
        addSubview(stopView)

        NSLayoutConstraint.activate([
            stopView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stopView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stopView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stopView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isEnabled: Bool {
        didSet {
            stopView.isUserInteractionEnabled = isEnabled
            stopView.alpha = isEnabled ? 1.0 : 0.1
        }
    }

    override var isHighlighted: Bool {
        didSet {
            stopView.alpha = isHighlighted ? 0.8 : 1.0
        }
    }

    var isRecording: Bool = false {
        didSet {
            animateStopViewIn(isRecording)
        }
    }

    private func animateStopViewIn(_ animateIn: Bool) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                let factor = animateIn ? 1.0 : 0.0
                self?.stopView.transform = CGAffineTransform(scaleX: factor, y: factor)
            }
        )
    }
}
