//
//  UIImage+.swift
//  Test_BankMandiri
//
//  Created by Bening Ranum on 12/03/24.
//

import Foundation
import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return nil }
        color.setFill()
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        context.draw(cgImage, in: rect)
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        guard let tintedImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        return tintedImage
    }
}
