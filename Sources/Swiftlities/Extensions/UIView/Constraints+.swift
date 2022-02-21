//
//  Constraints+.swift
//  
//
//  Created by Salihcan Kahya on 21.02.2022.
//

import UIKit

public extension UIView {
    func add(child view: UIView, pins edges: ViewPin...) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = edges.compactMap { $0.createConstraint(on: view, to: self) }
        NSLayoutConstraint.activate(constraints)
    }
    
    enum ViewPin {
        case top(CGFloat = 0)
        case bottom(CGFloat = 0)
        case leading(CGFloat = 0)
        case trailing(CGFloat = 0)
        case centerX(CGFloat = 0)
        case centerY(CGFloat = 0)

        public func createConstraint(on view: UIView, to parent: UIView) -> NSLayoutConstraint {
            switch self {
                case .top(let padding):
                    return view.topAnchor.constraint(equalTo: parent.topAnchor, constant: padding)
                case .bottom(let padding):
                    return view.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: padding)
                case .leading(let padding):
                    return view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: padding)
                case .trailing(let padding):
                    return view.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: padding)
                case .centerX(let padding):
                    return view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: padding)
                case .centerY(let padding):
                    return view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: padding)
            }
        }
    }
}

