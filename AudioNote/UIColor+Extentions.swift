import UIKit

// MARK: Custom Colors

extension UIColor {
    static var recordRed: UIColor { return UIColor(hexaRGB: "#D60345") }
    static var sentGreen: UIColor { return UIColor(hexaRGB: "#018B76") }
    static var sendOrange: UIColor { return UIColor(hexaRGB: "#FD9100") }
    static var vcrBlack: UIColor { return UIColor(hexaRGB: "#101223") }
    static var vcrGrey: UIColor { return UIColor(hexaRGB: "1E2032") }
}

// MARK: Custom Init

extension UIColor {
    convenience init(hexaRGB: String) {
        let alpha = 1.0
            var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
            switch chars.count {
            case 3: chars = chars.flatMap { [$0, $0] }
            case 6: break
            default: self.init(white: 1.0, alpha: alpha)
            }
            self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                    green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                     blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                    alpha: alpha)
        }
}
