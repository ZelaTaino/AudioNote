import UIKit
import AVFoundation

final class ScrubbingViewController: UIViewController {
    private let scrollView: UIScrollView
    private let contentView: UIView
    private let stackView: UIStackView

    // Updates
    private var timer: Timer?

    init() {
        scrollView = UIScrollView()
        contentView = UIView()
        stackView = UIStackView()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        beginAppendingStackView()
    }

    private func beginAppendingStackView() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            let view = UIView()
            view.backgroundColor = .systemBlue
            self?.stackView.addArrangedSubview(view)

            NSLayoutConstraint.activate([
              view.widthAnchor.constraint(equalToConstant: 100),
              view.heightAnchor.constraint(equalToConstant: 100)
            ])

            let bottomOffset = CGPoint(
                x: 0,
                y: (self?.scrollView.contentSize.height)! - (self?.scrollView.bounds.height)! + (self?.scrollView.contentInset.bottom)!
            )
            self?.scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }

    private func configureSubviews() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.backgroundColor = .systemYellow

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }

    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    deinit {
        timer?.invalidate()
    }
}
