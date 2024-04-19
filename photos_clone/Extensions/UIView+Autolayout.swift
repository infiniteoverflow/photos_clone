//
//  UIView+Autolayout.swift
//  insta_posts
//
//  Created by Aswin Gopinathan on 22/03/24.
//

import UIKit

enum ViewAnchor {
    case top
    case trailing
    case bottom
    case leading
}

extension UIView {
    
    @discardableResult
    func add(to view: UIView) -> UIView {
        view.addSubview(self)
        return self
    }
    
    @discardableResult
    func enableAutoLayout() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func setHeightConstraint(to value: CGFloat) -> UIView {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: value)
        ])
        return self
    }
    
    @discardableResult
    func setWidthConstraint(to value: CGFloat) -> UIView {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: value)
        ])
        return self
    }
    
    @discardableResult
    func setLeadingAnchor(toLeadingOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setLeadingAnchor(toTrailingOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setTopAnchor(toTopOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setTopAnchor(toBottomOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setBottomAnchor(toBottomOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
        ])
        return self
    }
    
    @discardableResult
    func setBottomAnchor(toTopOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -constant)
        ])
        return self
    }
    
    @discardableResult
    func setCenterX(to view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setCenterY(to view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
        ])
        return self
    }
    
    @discardableResult
    func setTrailingAnchor(toTrailingOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        ])
        return self
    }
    
    @discardableResult
    func setTrailingAnchor(toLeadingOf view: UIView, constant: CGFloat = 0) -> UIView {
        NSLayoutConstraint.activate([
            self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -constant)
        ])
        return self
    }
    
    @discardableResult
    func pinAllSides(to view: UIView,
                     top: CGFloat = 0,
                     trailing: CGFloat = 0,
                     bottom: CGFloat = 0, 
                     leading: CGFloat = 0,
                     includeSafeArea: Bool = false) -> UIView {
        if includeSafeArea {
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leading),
                self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -trailing),
                self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top),
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing),
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
        }
        
        return self
    }
    
    @discardableResult
    func pinAllSides(to view: UIView,
                     top: CGFloat = 0,
                     trailing: CGFloat = 0,
                     bottom: CGFloat = 0,
                     leading: CGFloat = 0,
                     except anchor: ViewAnchor) -> UIView {
        let leadingAnchor = self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading)
        let trailingAnchor = self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing)
        let topAnchor = self.topAnchor.constraint(equalTo: view.topAnchor, constant: top)
        let bottomAnchor = self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
        
        NSLayoutConstraint.activate([
            leadingAnchor,
            trailingAnchor,
            topAnchor,
            bottomAnchor
        ])
        
        switch anchor {
        case .top:
            topAnchor.isActive = false
        case .trailing:
            trailingAnchor.isActive = false
        case .bottom:
            bottomAnchor.isActive = false
        case .leading:
            leadingAnchor.isActive = false
        }
        
        return self
    }
}
