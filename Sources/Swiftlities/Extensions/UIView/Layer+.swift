//
//  Layer+.swift
//  
//
//  Created by Salihcan Kahya on 21.02.2022.
//

import UIKit

extension UIView {
    func addBorder(with width: CGFloat, and color: UIColor, round radius: CGFloat = 0) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
    }
}
