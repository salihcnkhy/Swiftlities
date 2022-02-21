//
//  Constraints+.swift
//  
//
//  Created by Salihcan Kahya on 21.02.2022.
//

import UIKit

public extension UIView {
    func add(child view: UIView, pins edges: ViewAnchor...) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = edges.compactMap { $0.createConstraint(on: view, to: self) }
        NSLayoutConstraint.activate(constraints)
    }
    
    enum ViewAnchor {
        case top(ConstraintType = .equalTo())
        case bottom(ConstraintType = .equalTo())
        case leading(ConstraintType = .equalTo())
        case trailing(ConstraintType = .equalTo())
        case centerX(ConstraintType = .equalTo())
        case centerY(ConstraintType = .equalTo())
        case height(ConstraintType = .equalTo())
        case width(ConstraintType = .equalTo())
        
        public func createConstraint(on view: UIView, to parent: UIView) -> NSLayoutConstraint {
            switch self {
                case .top(let constaintType):
                    return getConstraint(with: view.topAnchor, and: parent.topAnchor, constraintType: constaintType)
                case .bottom(let constaintType):
                    return getConstraint(with: view.bottomAnchor, and: parent.bottomAnchor, constraintType: constaintType)
                case .leading(let constaintType):
                    return getConstraint(with: view.leadingAnchor, and: parent.leadingAnchor, constraintType: constaintType)
                case .trailing(let constaintType):
                    return getConstraint(with: view.trailingAnchor, and: parent.trailingAnchor, constraintType: constaintType)
                case .centerX(let constaintType):
                    return getConstraint(with: view.leadingAnchor, and: parent.leadingAnchor, constraintType: constaintType)
                case .centerY(let constaintType):
                    return getConstraint(with: view.leadingAnchor, and: parent.leadingAnchor, constraintType: constaintType)
                case .height(let constaintType):
                    return getConstraint(with: view.heightAnchor, constraintType: constaintType)
                case .width(let constaintType):
                    return getConstraint(with: view.widthAnchor, constraintType: constaintType)
            }
        }
        
        private func getConstraint<AnchorType>(with anchor: NSLayoutAnchor<AnchorType>, and parentAnchor: NSLayoutAnchor<AnchorType>, constraintType: ConstraintType) -> NSLayoutConstraint {
            switch constraintType {
                case .equalTo(let padding):
                    return anchor.constraint(equalTo: parentAnchor, constant: padding)
                case .greaderThan(let padding):
                    return anchor.constraint(greaterThanOrEqualTo: parentAnchor, constant: padding)
                case .lessThan(let padding):
                    return anchor.constraint(lessThanOrEqualTo: parentAnchor, constant: padding)
                case .equalToConstant:
                    return NSLayoutConstraint()
            }
        }
        
        private func getConstraint(with anchor: NSLayoutDimension, constraintType: ConstraintType) -> NSLayoutConstraint {
            switch constraintType {
                case .equalToConstant(let value):
                    return anchor.constraint(equalToConstant: value)
                default:
                    return NSLayoutConstraint()
            }
        }

    }
    
    enum ConstraintType {
        case equalToConstant(CGFloat = 0)
        case equalTo(CGFloat = 0)
        case greaderThan(CGFloat = 0)
        case lessThan(CGFloat = 0)
    }
}

