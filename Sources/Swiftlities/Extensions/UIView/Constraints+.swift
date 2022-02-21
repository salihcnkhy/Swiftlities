//
//  Constraints+.swift
//  
//
//  Created by Salihcan Kahya on 21.02.2022.
//

import UIKit

public extension UIView {
    
    func add(child view: UIView, constraint anchors: ViewAnchor...) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = anchors.compactMap { $0.createConstraint(on: view) }
        NSLayoutConstraint.activate(constraints)
    }
    
    func activate(cons: @escaping (UIView) -> [ViewAnchor]) {
        guard let parentView = self.superview else { return }
        let viewAnchors = cons(parentView)
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = viewAnchors.compactMap { $0.createConstraint(on: self) }
        NSLayoutConstraint.activate(constraints)
    }
        
    enum ViewAnchor {
        case top(ParentRelatedConstraintType, NSLayoutYAxisAnchor)
        case bottom(ParentRelatedConstraintType, NSLayoutYAxisAnchor)
        case leading(ParentRelatedConstraintType, NSLayoutXAxisAnchor)
        case trailing(ParentRelatedConstraintType, NSLayoutXAxisAnchor)
        case centerX(ParentRelatedConstraintType, NSLayoutXAxisAnchor)
        case centerY(ParentRelatedConstraintType, NSLayoutYAxisAnchor)
        case heightToView(ParentRelatedConstraintType, NSLayoutDimension)
        case widthToView(ParentRelatedConstraintType, NSLayoutDimension)
        case height(ConstantReletedConstraintType)
        case width(ConstantReletedConstraintType)
        
        public func createConstraint(on view: UIView) -> NSLayoutConstraint {
            switch self {
                case .top(let constaintType, let parentAnchor):
                    return getConstraint(with: view.topAnchor, to: parentAnchor, constraintType: constaintType)
                case .bottom(let constaintType, let parentAnchor):
                    return getConstraint(with: view.bottomAnchor, to: parentAnchor, constraintType: constaintType)
                case .leading(let constaintType, let parentAnchor):
                    return getConstraint(with: view.leadingAnchor, to: parentAnchor, constraintType: constaintType)
                case .trailing(let constaintType, let parentAnchor):
                    return getConstraint(with: view.trailingAnchor, to: parentAnchor, constraintType: constaintType)
                case .centerX(let constaintType, let parentAnchor):
                    return getConstraint(with: view.centerXAnchor, to: parentAnchor, constraintType: constaintType)
                case .centerY(let constaintType, let parentAnchor):
                    return getConstraint(with: view.centerYAnchor, to: parentAnchor, constraintType: constaintType)
                case .heightToView(let constaintType, let parentAnchor):
                    return getConstraint(with: view.heightAnchor, to: parentAnchor, constraintType: constaintType)
                case .widthToView(let constaintType, let parentAnchor):
                    return getConstraint(with: view.widthAnchor, to: parentAnchor, constraintType: constaintType)
                case .height(let constaintType):
                    return getConstraint(with: view.heightAnchor, constraintType: constaintType)
                case .width(let constaintType):
                    return getConstraint(with: view.widthAnchor, constraintType: constaintType)
 
            }
        }
        
        private func getConstraint<AnchorType>(with anchor: NSLayoutAnchor<AnchorType>, to parent: NSLayoutAnchor<AnchorType>, constraintType: ParentRelatedConstraintType) -> NSLayoutConstraint {
            switch constraintType {
                case .equalTo(let padding), .greaderThan(let padding), .lessThan(let padding):
                   return anchor.constraint(equalTo: parent, constant: padding)
            }
        }
        
        private func getConstraint(with anchor: NSLayoutDimension, constraintType: ConstantReletedConstraintType) -> NSLayoutConstraint {
            switch constraintType {
                case .equalToConstant(let padding):
                    return anchor.constraint(equalToConstant: padding)
            }
        }
    }
    
    enum ParentRelatedConstraintType {
        case equalTo(CGFloat = 0)
        case greaderThan(CGFloat = 0)
        case lessThan(CGFloat = 0)
    }
    
    enum ConstantReletedConstraintType {
        case equalToConstant(CGFloat = 0)
    }
}

