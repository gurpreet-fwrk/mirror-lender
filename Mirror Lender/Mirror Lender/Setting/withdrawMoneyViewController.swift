//
//  withdrawMoneyViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/09/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class withdrawMoneyViewController: UIViewController
{
    override func viewDidLoad()
    {
        APPDELEGATE.isFromBackToHome = false
        self.title = "Withdraw Money"
      
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(withdrawMoneyViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func withdrawMoney(_ sender: Any)
    {
        let cntr = self.storyboard?.instantiateViewController(withIdentifier: "comonalert") as! CommonAlertViewController
        cntr.strImage = "thankyou"
        cntr.strText1 = "Thank You!"
        cntr.strText2 = "Lorem ipsum dolor sit er elit lamet"
        self.navigationController?.pushViewController(cntr, animated: false)
    }
    
    @IBAction func AddOtherAccount(_ sender: Any)
    {
        let cntrAddAccount = self.storyboard?.instantiateViewController(withIdentifier: "fourViewController") as! HomeGoalFourthViewController
        cntrAddAccount.isFromWithdrawMoney = true
        self.navigationController?.pushViewController(cntrAddAccount, animated: true)
        
    }
}
