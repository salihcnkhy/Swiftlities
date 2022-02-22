//
//  Constraints+.swift
//  
//
//  Created by Salihcan Kahya on 21.02.2022.
//

import UIKit

public extension UIView {
    
    @discardableResult
    func activate(constraint: ViewConstraint) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = constraint.createConstraint(on: self)
        NSLayoutConstraint.activate(constraints)
        return constraint
    }
    
    @discardableResult
    func activate(constraints: [ViewConstraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = constraints.compactMap { $0.createConstraint(on: self) }
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    func fill(in view: UIView, with padding: UIEdgeInsets = .zero) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        fillSuperView(with: padding)
    }
    
    func fillSuperView(with padding: UIEdgeInsets = .zero) {
        guard let view = superview else { return }
        self.activate(constraints: [
            .top(relation: .equal(attribute: .top(ofView: view), padding.top)),
            .bottom(relation: .equal(attribute: .bottom(ofView: view), -padding.bottom)),
            .leading(relation: .equal(attribute: .leading(ofView: view), padding.left)),
            .trailing(relation: .equal(attribute: .trailing(ofView: view), -padding.right))
        ])
    }
    
    func addCenterXConstraint(with constant: CGFloat = 0) {
        guard let view = superview else { return }
        self.activate(constraints: [
            .centerX(relation: .equal(attribute: .centerX(ofView: view), constant))
        ])
    }
    
    func addCenterYConstraint(with constant: CGFloat = 0) {
        guard let view = superview else { return }
        self.activate(constraints: [
            .centerY(relation: .equal(attribute: .centerY(ofView: view), constant))
        ])
    }
    
    enum ViewConstraint {
        case top(relation: ConstraintRelation)
        case bottom(relation: ConstraintRelation)
        case leading(relation: ConstraintRelation)
        case trailing(relation: ConstraintRelation)
        case heightTo(relation: ConstraintRelation)
        case widthTo(relation: ConstraintRelation)
        case centerX(relation: ConstraintRelation)
        case centerY(relation: ConstraintRelation)
        case height(constantRelation: ConstantConstraintRelation)
        case width(constantRelation: ConstantConstraintRelation)
        
        fileprivate func createConstraint(on view: UIView) -> NSLayoutConstraint {
            switch self {
                case .top(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.topAnchor)
                case .bottom(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.bottomAnchor)
                case .leading(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.leadingAnchor)
                case .trailing(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.trailingAnchor)
                case .heightTo(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.heightAnchor)
                case .widthTo(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.widthAnchor)
                case .height(let constantRelation):
                    return constantRelation.createConstraint(on: view.heightAnchor)
                case .width(let constantRelation):
                    return constantRelation.createConstraint(on: view.widthAnchor)
                case .centerX(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.centerXAnchor)
                case .centerY(let constrainRelation):
                    return constrainRelation.createConstraint(on: view.centerYAnchor)
            }
        }
    }
    
    enum ConstantConstraintRelation {
        case equalConstant(CGFloat = 0)
        
        fileprivate func createConstraint(on anchor: NSLayoutDimension) -> NSLayoutConstraint {
            switch self {
                case .equalConstant(let cGFloat):
                    return anchor.constraint(equalToConstant: cGFloat)
            }
        }
    }
    
    enum ConstraintRelation {
        case equal(attribute: ConstraintRelationAttribute, CGFloat = 0)
        case greaterThan(attribute: ConstraintRelationAttribute, CGFloat = 0)
        case lessThan(attribute: ConstraintRelationAttribute, CGFloat = 0)
        
        fileprivate func createConstraint(on anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
            switch self {
                case .equal(let constraintRelationAttribute, let cGFloat), .greaterThan(let constraintRelationAttribute, let cGFloat), .lessThan(let constraintRelationAttribute, let cGFloat):
                    return anchor.constraint(equalTo: constraintRelationAttribute.getAnchor(), constant: cGFloat)
            }
        }
        
        fileprivate func createConstraint(on anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
            switch self {
                case .equal(let constraintRelationAttribute, let cGFloat), .greaterThan(let constraintRelationAttribute, let cGFloat), .lessThan(let constraintRelationAttribute, let cGFloat):
                    return anchor.constraint(equalTo: constraintRelationAttribute.getAnchor(), constant: cGFloat)
            }
        }
        
        fileprivate func createConstraint(on anchor: NSLayoutDimension) -> NSLayoutConstraint {
            switch self {
                case .equal(let constraintRelationAttribute, let cGFloat), .greaterThan(let constraintRelationAttribute, let cGFloat), .lessThan(let constraintRelationAttribute, let cGFloat):
                    return anchor.constraint(equalTo: constraintRelationAttribute.getAnchor(), constant: cGFloat)
            }
        }
    }
    
    enum ConstraintRelationAttribute {
        case top(ofView: UIView)
        case bottom(ofView: UIView)
        case leading(ofView: UIView)
        case trailing(ofView: UIView)
        case height(ofView: UIView)
        case width(ofView: UIView)
        case centerX(ofView: UIView)
        case centerY(ofView: UIView)
        
        fileprivate func getAnchor() -> NSLayoutYAxisAnchor {
            switch self {
                case .top(let ofView):
                    return ofView.topAnchor
                case .bottom(let ofView):
                    return ofView.bottomAnchor
                case .centerY(let ofView):
                    return ofView.centerYAnchor
                default:
                    fatalError()
            }
        }
        
        fileprivate func getAnchor() -> NSLayoutXAxisAnchor {
            switch self {
                case .leading(let ofView):
                    return ofView.leadingAnchor
                case .trailing(let ofView):
                    return ofView.trailingAnchor
                case .centerX(let ofView):
                    return ofView.centerXAnchor
                default:
                    fatalError()
            }
        }
        
        fileprivate func getAnchor() -> NSLayoutDimension {
            switch self {
                case .height(let ofView):
                    return ofView.heightAnchor
                case .width(let ofView):
                    return ofView.widthAnchor
                default:
                    fatalError()
            }
        }
    }
    
}

