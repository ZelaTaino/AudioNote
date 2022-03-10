import UIKit

final class IconButtonView: UIButton {
    private let iconView: IconView

    init(icon: Icon, backgroundcolor: UIColor) {
        iconView = IconView(type: icon)

        super.init(frame: .zero)

        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = backgroundcolor
        configuration.cornerStyle = .capsule
        self.configuration = configuration

        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isUserInteractionEnabled = false
        addSubview(iconView)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isEnabled: Bool {
        didSet {
            iconView.alpha = isEnabled ? 1.0 : 0.1
        }
    }

    override var isHighlighted: Bool {
        didSet {
            iconView.alpha = isHighlighted ? 0.8 : 1.0
        }
    }

    func showIcon(animate: Bool) {
        animateIconView(animateIn: true, shouldAnimate: animate)
    }

    func hideIcon(animate: Bool){
        animateIconView(animateIn: false, shouldAnimate: animate)
    }

    private func animateIconView(animateIn: Bool, shouldAnimate: Bool) {
        UIView.animate(
            withDuration: shouldAnimate ? 0.3 : 0.0,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                let factor = animateIn ? 1.0 : 0.0
                self?.iconView.transform = CGAffineTransform(scaleX: factor, y: factor)
            }
        )
    }
}
