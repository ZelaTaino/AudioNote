import UIKit

final class IconView: UIView {
    override class var layerClass: AnyClass { CAShapeLayer.self }
    private let type: Icon

    private var shapeLayer: CAShapeLayer {
        guard let shapeLayer = layer as? CAShapeLayer else {
            fatalError("Unexpected layer type")
        }

        return shapeLayer
    }

    init(type: Icon) {
        self.type = type
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let path = IconPathFactory.path(type: type, onto: rect) else { return }
        shapeLayer.path = path
        shapeLayer.fillColor = UIColor.white.cgColor
    }
}
