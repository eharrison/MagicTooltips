//
//  ViewController.swift
//  MagicTooltips
//
//  Created by Evandro Harrison Hoffmann on 10/02/2020.
//  Copyright © 2020 It's Day Off. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    private let tooltipManager: TooltipManager = TooltipManager()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        coverImageView.layer.cornerRadius = coverImageView.frame.size.width/2
        actionButton.layer.cornerRadius = 25
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTooltips()
    }

    private func setupTooltips(forcing: Bool = false) {
        guard !tooltipManager.didSetupTooltips || forcing else {
            return
        }
        
        let tooltips: [ViewControllerTooltip] = [.title(in: titleLabel),
                                                 .image(in: coverImageView),
                                                 .button(in: actionButton)]
        
        tooltipManager.delegate = self
        tooltipManager.setup(tooltips: tooltips, darkView: view)
    }
    
    @IBAction func showAgain(_ sender: Any) {
        setupTooltips(forcing: true)
    }
}

extension ViewController: ToolTipDelegate {
    func toolTipDidComplete() {
        
    }
}
