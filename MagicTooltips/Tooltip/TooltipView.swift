//
//  TootipView.swift
//  It's Day Off
//
//  Created by Evandro Harrison on 13/05/2019.
//  Copyright © 2019 It's Day Off. All rights reserved.
//

import UIKit

class TooltipView: UIView {
    @IBOutlet weak var topIndicatorView: UIView!
    @IBOutlet weak var bottomIndicatorView: UIView!
    @IBOutlet weak var leftIndicatorView: UIView!
    @IBOutlet weak var rightIndicatorView: UIView!
    @IBOutlet weak var indicatorCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalIndicatorCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var removeCallback: (() -> Void)?
    private var timeoutTimer: Timer?
    
    static func newInstance() -> TooltipView {
        return Bundle(for: self).loadNibNamed("TooltipView", owner: self, options: nil)![0] as! TooltipView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    func setupTimeout(_ timeout: TimeInterval) {
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] (_) in
            self?.hide()
        }
    }
    
    // MARK: - Animations
    
    func show() {
        fadeIn()
    }
    
    func hide() {
        timeoutTimer?.invalidate()
        removeCallback?()
        fadeOut {
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func dismiss(_ sender: Any) {
        hide()
    }
    
}

extension UIView {
    func showTooltip(title: String? = nil,
                     message: String,
                     timeout: TimeInterval = 10,
                     action: String? = nil,
                     direction: TooltipDirection,
                     inView: UIView? = nil,
                     onHide: (() -> Void)? = nil) {
        removeTooltipView()
        
        guard let superview = inView ?? superview else { return }
        
        DispatchQueue.main.async {
            let tooltipView = TooltipView.newInstance()
            tooltipView.titleLabel.text = title
            tooltipView.titleLabel.isHidden = title == nil
            tooltipView.contentLabel.text = message
            tooltipView.removeCallback = onHide
            tooltipView.actionButton.setTitle(action, for: .normal)
            tooltipView.actionButton.isHidden = action == nil
            
            tooltipView.rightIndicatorView.isHidden = direction != .right
            tooltipView.leftIndicatorView.isHidden = direction != .left
            tooltipView.topIndicatorView.isHidden = direction != .up
            tooltipView.bottomIndicatorView.isHidden = direction != .down
            
            superview.addSubview(tooltipView)
            
            switch direction {
            case .up:
                NSLayoutConstraint.activate([tooltipView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)])
            case .down:
                NSLayoutConstraint.activate([tooltipView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 0)])
            case .right:
                NSLayoutConstraint.activate([tooltipView.rightAnchor.constraint(equalTo: self.leftAnchor, constant: 0)])
            case .left:
                NSLayoutConstraint.activate([tooltipView.leftAnchor.constraint(equalTo: self.rightAnchor, constant: 0)])
            case .center:
                NSLayoutConstraint.activate([
                    tooltipView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
                    tooltipView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
                    tooltipView.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 37),
                    tooltipView.trailingAnchor.constraint(greaterThanOrEqualTo: superview.trailingAnchor, constant: 37)
                ])
            }
            
            if direction.isVertical {
                let centerAnchor = tooltipView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
                centerAnchor.priority = .defaultHigh
                tooltipView.indicatorCenterConstraint.isActive = false
                NSLayoutConstraint.activate([centerAnchor])
                
                NSLayoutConstraint.activate([
                    tooltipView.trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -10),
                    tooltipView.leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 10),
                    tooltipView.topIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
                ])
            } else if direction.isHorizontal {
                let centerAnchor = tooltipView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
                centerAnchor.priority = .defaultHigh
                NSLayoutConstraint.activate([centerAnchor])
            }
            
            tooltipView.show()
            tooltipView.setupTimeout(timeout)
        }
    }
    
    public func removeTooltipView() {
        DispatchQueue.main.async {
            for subview in self.subviews {
                if let subview = subview as? TooltipView {
                    subview.removeFromSuperview()
                }
            }
        }
    }
}
