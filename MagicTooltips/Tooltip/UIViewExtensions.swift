//
//  UIViewExtensions.swift
//  MagicTooltips
//
//  Created by Evandro Harrison Hoffmann on 10/02/2020.
//  Copyright © 2020 It's Day Off. All rights reserved.
//

import UIKit

extension UIView {
    func fadeIn(completion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
            completion?()
        }
    }
}
