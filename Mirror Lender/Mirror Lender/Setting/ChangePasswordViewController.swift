//
//  ForgetViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 04/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        self.title = "Change Password"
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(ChangePasswordViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}
