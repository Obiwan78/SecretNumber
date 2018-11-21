//
//  ABLaunchScreenViewController.swift
//  SecretNumber
//
//  Created by Alban BERNARD on 21/11/2018.
//  Copyright © 2018 Alban BERNARD. All rights reserved.
//

import UIKit

class ABLaunchScreenViewController: UIViewController {

    @IBOutlet weak var ui_titleImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        UIView.animate(withDuration: 0.7, animations: { // anime tous les changements de layout
//            self.view.layoutIfNeeded()
//        })
        
//        UIView.transition(with: ui_titleImageView, duration: 0.7, options: [.transitionFlipFromBottom], animations: {
//            self.ui_titleImageView.isHidden = false
//        }, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
