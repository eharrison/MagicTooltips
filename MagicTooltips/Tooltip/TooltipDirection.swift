//
//  TooltipDirection.swift
//  It's Day Off
//
//  Created by Evandro Harrison Hoffmann on 28/10/2019.
//  Copyright © 2019 It's Day Off. All rights reserved.
//

import Foundation

enum TooltipDirection {
    case up
    case down
    case right
    case left
    case center
    
    var isVertical: Bool {
        switch self {
        case .up, .down:
            return true
        default:
            return false
        }
    }
    
    var isHorizontal: Bool {
        switch self {
        case .right, .left:
            return true
        default:
            return false
        }
    }
}
