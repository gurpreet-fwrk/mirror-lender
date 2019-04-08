//
//  SettingViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController
{
    @IBOutlet var btnProfile: UIButton!
    @IBOutlet var btnBankDetails: UIButton!
    @IBOutlet var btnWithdraw: UIButton!
    @IBOutlet var btnPaymentHistory: UIButton!
    @IBOutlet var btnChangePass: UIButton!
    
    override func viewDidLoad()
    {
        self.title = "Settings"
        btnProfile.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnBankDetails.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnWithdraw.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnPaymentHistory.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnChangePass.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "Logout",
            style: .done,
            target: self,
            action: "rightButtonAction"
        )
        rightButtonItem.tintColor = UIColor.darkGray
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func rightButtonAction()
    {
        let cntrReg = self.storyboard?.instantiateViewController(withIdentifier: "navReg") as! UINavigationController
        APPDELEGATE.window?.rootViewController = cntrReg
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if APPDELEGATE.isFromBackToHome == true
        {
            APPDELEGATE.isFromBackToHome = false
            self.tabBarController?.selectedIndex = 0

        }
    }
}
