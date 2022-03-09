struct IconPathFactory {
    static func path(type: Icon) -> CGPath? {
        switch type {
        case .send:
            let shape = UIBezierPath()
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
            return shape.cgPath
        case .stop:
            let rect = CGRect(x: 0, y: 0, width: 18, height: 18)
            let shape = UIBezierPath(roundedRect: rect, cornerRadius: 3.0)
            return shape.cgPath
        }
    }
}
