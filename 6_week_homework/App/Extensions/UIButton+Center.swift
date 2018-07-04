//
//  UIButton+Center.swift
//  firstapp
//
//  Created by Jan Čislinský on 21. 03. 2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

// Source: https://stackoverflow.com/a/22621613
public extension UIButton {
    public func centerVertically(padding: CGFloat = 3.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        //print(imageViewSize)
        //print(titleLabelSize)
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )

        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
