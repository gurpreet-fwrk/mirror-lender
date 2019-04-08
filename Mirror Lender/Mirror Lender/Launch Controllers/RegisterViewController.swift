
//
//  RegisterViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 04/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController
{
    var isChecked = Bool(false)
    @IBOutlet var btnCheckUncheck: UIButton!
    @IBOutlet var svMain: UIScrollView!
    
    override func viewDidLoad()
    {
        self.title = "Register"
        
//        let btnMenu = UIButton()
//        btnMenu.setImage(UIImage(named: "Back"), for: .normal)
        
//        btnMenu.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
//        btnMenu.addTarget(self, action: #selector(RegisterViewController.moveBack), for: .touchUpInside)
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = btnMenu
//        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func viewDidLayoutSubviews()
    {
        self.svMain.contentSize = CGSize(width: self.view.frame.size.width, height: 480)
    }
    
//    @objc func moveBack()
//    {
//        self.view.endEditing(true)
//       self.navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func checkOrUncheck(_ sender: Any)
    {
        self.view.endEditing(true)
        if isChecked == false
        {
           isChecked = true
           btnCheckUncheck.setImage(UIImage(named: "checkbox"), for: UIControlState.normal)
        }
        else
        {
            isChecked = false
            btnCheckUncheck.setImage(UIImage(named: "uncheck"), for: UIControlState.normal)
        }
    }
    
    @IBAction func moveToSignIn(_ sender: Any)
    {
        self.view.endEditing(true)
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moveToTermAndConditions(_ sender: Any)
    {
        let cntrTerm = self.storyboard?.instantiateViewController(withIdentifier: "term") as! TermAndConditionsViewController
        self.present(cntrTerm, animated: false, completion: nil)
    }
}
