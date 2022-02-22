import Combine
import UIKit

final class AudioBarView: UIView {
    private var heightConstraint: NSLayoutConstraint!
    var height: CGFloat = 0.0 {
        didSet {
            heightConstraint.constant = height
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5.0
        backgroundColor = .white

        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([
            heightConstraint,
            widthAnchor.constraint(equalToConstant: 2.0)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class AudioWaveFormView: UIView {
    private let scrollView: UIScrollView
    private let contentView: UIView
    private let stackView: UIStackView

    init() {
        scrollView = UIScrollView()
        contentView = UIView()
        stackView = UIStackView()

        super.init(frame: .zero)

        setupView()
        setupConstraints()
    }

    private func setupView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 3

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let height = max(8.0, ((level + 20) / 20) * Float(frame.height))
        return CGFloat(height)
    }

    func updateSequence(with powerValue: Float) {
        let audioBar = AudioBarView()
        audioBar.backgroundColor = .white
        audioBar.height = normalizeSoundLevel(level: powerValue)
        stackView.addArrangedSubview(audioBar)

        let offset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.width , y: 0)
        if offset.x > 0 { scrollView.setContentOffset(offset, animated: true) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
