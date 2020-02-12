//
//  ViewControllerTooltip.swift
//  MagicTooltips
//
//  Created by Evandro Harrison Hoffmann on 11/02/2020.
//  Copyright © 2020 It's Day Off. All rights reserved.
//

import UIKit

enum ViewControllerTooltip: Tooltip {
    case title(in: UIView)
    case image(in: UIView)
    case button(in: UIView)
    
    var key: String {
        let prefix: String = "tooltip_didshow_"
        switch self {
        case .title: return "\(prefix)title"
        case .image: return "\(prefix)image"
        case .button: return "\(prefix)button"
        }
    }
    
    var didShow: Bool {
        return false
        //return UserDefaults.standard.bool(forKey: key)
    }
    
    func setShown() {
        UserDefaults.standard.set(true, forKey: key)
    }
    
    var direction: TooltipDirection {
        switch self {
        case .title: return .up
        case .image: return .up
        case .button: return .down
        }
    }
    
    var title: String? {
        return nil
    }
    
    var message: String {
        switch self {
        case .title: return "This is the title"
        case .image: return "This is the image"
        case .button: return "This is the button"
        }
    }
    
    var view: UIView {
        switch self {
        case let .title(view):
            return view
        case let .image(view):
            return view
        case let .button(view):
            return view
        }
    }
}
