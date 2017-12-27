//
//  BaseViewController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import SWRevealViewController

class BaseViewController: UIViewController {

    var menuImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Private methods
    private func setupView() {
        
        //set menu image
        menuImage = UIImage.init(named: "nav_menu")
        //set bg color
        view.backgroundColor = UIColor.white
        
        
        
        // Navigation - Status Bar Style
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        // Navigation - Menu Button
        if (self.navigationController!.viewControllers[0] == self ) {
            
            let revealController:SWRevealViewController = self.revealViewController()
            revealController.panGestureRecognizer()
            revealController.tapGestureRecognizer()
            let sideMenuButton = UIBarButtonItem(image: menuImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(buttonMenu_touchUpInside(sender:)))
            self.navigationItem.leftBarButtonItem = sideMenuButton
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        
    }
    
    @objc func buttonMenu_touchUpInside(sender: UIBarButtonItem) {
        revealViewController().revealToggle(animated: true)
    }
}
