import UIKit

class SoundNoteCell: UICollectionViewCell {
    static let reuseIdentifier = "sound-note-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

final class PagingViewController: UIViewController {
    enum Section {
        case recording
        case listening
    }

    let recordingColors: [UIColor] = [.systemYellow]
    let listeningColors: [UIColor] = [.systemGreen, .systemBrown, .systemPink]

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collectionView
    }()

    var dataSource: UICollectionViewDiffableDataSource<Section, UIColor>! = nil

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        collectionView.backgroundColor = .systemBlue
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        configureDataSource()
    }
}

extension PagingViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(view.frame.width),
                                              heightDimension: .estimated(view.frame.height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(view.frame.width),
                                              heightDimension: .estimated(view.frame.height))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SoundNoteCell, UIColor> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.backgroundColor = identifier
        }

        dataSource = UICollectionViewDiffableDataSource<Section, UIColor>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: UIColor) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIColor>()
        snapshot.appendSections([.recording, .listening])
        snapshot.appendItems(recordingColors, toSection: .recording)
        snapshot.appendItems(listeningColors, toSection: .listening)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
