import UIKit

struct IconPathFactory {
    static func path(type: Icon, onto rect: CGRect) -> CGPath? {
        var shape = UIBezierPath()
        switch type {
        case .pause:
            let leftBar = CGRect(x: 0, y: 0, width: 11, height: 30)
            let rightBar = CGRect(x: 15, y: 0, width: 11, height: 30)
            shape = UIBezierPath(roundedRect: leftBar, cornerRadius: 3.0)
            let rightBarPath = UIBezierPath(roundedRect: rightBar, cornerRadius: 3.0)
            shape.append(rightBarPath)
        case .play:
            shape.move(to: CGPoint(x: 21.5, y: 12.13))
            shape.addCurve(to: CGPoint(x: 21.5, y: 13.87), controlPoint1: CGPoint(x: 22.17, y: 12.52), controlPoint2: CGPoint(x: 22.17, y: 13.48))
            shape.addLine(to: CGPoint(x: 2, y: 25.12))
            shape.addCurve(to: CGPoint(x: 0.5, y: 24.26), controlPoint1: CGPoint(x: 1.33, y: 25.51), controlPoint2: CGPoint(x: 0.5, y: 25.03))
            shape.addLine(to: CGPoint(x: 0.5, y: 1.74))
            shape.addCurve(to: CGPoint(x: 2, y: 0.88), controlPoint1: CGPoint(x: 0.5, y: 0.97), controlPoint2: CGPoint(x: 1.33, y: 0.49))
            shape.addLine(to: CGPoint(x: 21.5, y: 12.13))
            shape.close()
        case .send:
            shape.move(to: CGPoint(x: 0.86, y: 10.26))
            shape.addLine(to: CGPoint(x: 25.84, y: 0.86))
            shape.addCurve(to: CGPoint(x: 26.1, y: 1.1), controlPoint1: CGPoint(x: 26, y: 0.79), controlPoint2: CGPoint(x: 26.14, y: 0.95))
            shape.addCurve(to: CGPoint(x: 26.09, y: 1.16), controlPoint1: CGPoint(x: 26.1, y: 1.12), controlPoint2: CGPoint(x: 26.1, y: 1.14))
            shape.addLine(to: CGPoint(x: 16.4, y: 26.1))
            shape.addCurve(to: CGPoint(x: 14.76, y: 26.18), controlPoint1: CGPoint(x: 16.12, y: 26.82), controlPoint2: CGPoint(x: 15.12, y: 26.87))
            shape.addLine(to: CGPoint(x: 10.42, y: 17.74))
            shape.addCurve(to: CGPoint(x: 10.5, y: 17.17), controlPoint1: CGPoint(x: 10.32, y: 17.55), controlPoint2: CGPoint(x: 10.35, y: 17.33))
            shape.addLine(to: CGPoint(x: 22.15, y: 4.78))
            shape.addLine(to: CGPoint(x: 9.68, y: 16.29))
            shape.addCurve(to: CGPoint(x: 9.11, y: 16.37), controlPoint1: CGPoint(x: 9.53, y: 16.44), controlPoint2: CGPoint(x: 9.3, y: 16.47))
            shape.addLine(to: CGPoint(x: 0.75, y: 11.89))
            shape.addCurve(to: CGPoint(x: 0.86, y: 10.26), controlPoint1: CGPoint(x: 0.07, y: 11.53), controlPoint2: CGPoint(x: 0.13, y: 10.53))
            shape.close()
        case .stop:
            let rect = CGRect(x: 0, y: 0, width: 18, height: 18)
            shape = UIBezierPath(roundedRect: rect, cornerRadius: 3.0)
        case .sent:
            shape.move(to: CGPoint(x: 10.9, y: 16))
            shape.addCurve(to: CGPoint(x: 23, y: 3), controlPoint1: CGPoint(x: 11.5, y: 15.5), controlPoint2: CGPoint(x: 18.5, y: 8))
            shape.addCurve(to: CGPoint(x: 22.9, y: 1), controlPoint1: CGPoint(x: 23.15, y: 2.84), controlPoint2: CGPoint(x: 23.41, y: 1.87))
            shape.addCurve(to: CGPoint(x: 19.9, y: 0.5), controlPoint1: CGPoint(x: 22.43, y: 0.2), controlPoint2: CGPoint(x: 20.86, y: -0.37))
            shape.addCurve(to: CGPoint(x: 13, y: 8), controlPoint1: CGPoint(x: 18.94, y: 1.37), controlPoint2: CGPoint(x: 15.34, y: 5.54))
            shape.addCurve(to: CGPoint(x: 8.5, y: 12.85), controlPoint1: CGPoint(x: 11.29, y: 9.8), controlPoint2: CGPoint(x: 8.5, y: 12.85))
            shape.addLine(to: CGPoint(x: 7, y: 11))
            shape.addCurve(to: CGPoint(x: 4, y: 7.55), controlPoint1: CGPoint(x: 7, y: 11), controlPoint2: CGPoint(x: 4.26, y: 7.75))
            shape.addCurve(to: CGPoint(x: 2, y: 7.3), controlPoint1: CGPoint(x: 3.67, y: 7.3), controlPoint2: CGPoint(x: 2.75, y: 7))
            shape.addCurve(to: CGPoint(x: 1.15, y: 8), controlPoint1: CGPoint(x: 1.64, y: 7.44), controlPoint2: CGPoint(x: 1.26, y: 7.82))
            shape.addCurve(to: CGPoint(x: 1, y: 10), controlPoint1: CGPoint(x: 0.5, y: 9), controlPoint2: CGPoint(x: 0.94, y: 9.92))
            shape.addCurve(to: CGPoint(x: 6, y: 15.9), controlPoint1: CGPoint(x: 2.5, y: 12), controlPoint2: CGPoint(x: 4.5, y: 14.5))
            shape.addCurve(to: CGPoint(x: 7, y: 16.5), controlPoint1: CGPoint(x: 6.33, y: 16.21), controlPoint2: CGPoint(x: 7, y: 16.5))
            shape.addCurve(to: CGPoint(x: 9, y: 16.75), controlPoint1: CGPoint(x: 7, y: 16.5), controlPoint2: CGPoint(x: 7.86, y: 16.86))
            shape.addCurve(to: CGPoint(x: 10.9, y: 16), controlPoint1: CGPoint(x: 9.28, y: 16.72), controlPoint2: CGPoint(x: 10.3, y: 16.5))
            shape.close()
        }

        let path = shape.cgPath
        return scaledPath(from: path, to: rect)
    }

    private static func scaledPath(from path: CGPath, to rect: CGRect) -> CGPath? {
        let pathSize = path.boundingBox

        let factor = pathSize.height / pathSize.width > rect.height / rect.width
            ? rect.height / pathSize.height : rect.width / pathSize.width

        var transformation = CGAffineTransform(scaleX: factor, y: factor)
        return path.copy(using: &transformation)
    }
}
