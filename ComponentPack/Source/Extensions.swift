//
//  Extensions.swift
//  ComponentPack
//
//  Created by Hailong Li on 12/24/18.
//  Copyright © 2018 Hailong Li. All rights reserved.
//

import Foundation

public extension UIView {
    
    //TODO implement insets
    func anchor(toParent parent: UIView, withInset inset:UIEdgeInsets? = .zero) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            leftAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leftAnchor),
            rightAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
