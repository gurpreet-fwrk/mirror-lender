//
//  CommonAlertViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/09/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class CommonAlertViewController: UIViewController
{
    @IBOutlet var ivAlert: UIImageView!
    @IBOutlet var lblText2: UILabel!
    @IBOutlet var lblText1: UILabel!
    @IBOutlet var btnHome: UIButton!
    
    var strImage : String!
    var strText1 : String!
    var strText2 : String!
    
    var timerAlert : Timer!
    
    override func viewDidLoad()
    {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        if strImage.isEqual("thankyou")
        {
            self.btnHome.isHidden = false
        
        }
        else if strImage.isEqual("sorry")
        {
           self.btnHome.isHidden = true
              timerAlert = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideAlert), userInfo: nil, repeats: false)
        }
        else if strImage.isEqual("internet")
        {
           self.btnHome.isHidden = true
              timerAlert = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideAlert), userInfo: nil, repeats: false)
        }
        
        ivAlert.image = UIImage(named: strImage!)
        lblText1.text = strText1!
        lblText2.text = strText2!
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func backToHome(_ sender: Any)
    {
        if strImage.isEqual("thankyou")
        {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers
            {
                if aViewController is SettingViewController
                {
                    APPDELEGATE.isFromBackToHome = true
                    self.navigationController?.navigationBar.isHidden = false
                    self.tabBarController?.tabBar.isHidden = false
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
//            self.navigationController?.popViewController(animated: false)
//            self.navigationController?.popViewController(animated: true)
//            self.tabBarController?.selectedIndex = 0
        }
    }
    
    @objc func hideAlert()
    {
        self.timerAlert.invalidate()
        if strImage.isEqual("sorry")
        {
            self.navigationController?.popViewController(animated: false)
        }
        else if strImage.isEqual("internet")
        {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
}
