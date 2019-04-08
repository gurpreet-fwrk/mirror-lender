//
//  ViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 03/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet var svMain: UIScrollView!
    @IBOutlet var btnTouchFace: UIButton!
    
    let context = LAContext()
    var error: NSError?
    
    var modelName : String! = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Sign In"
        // Do any additional setup after loading the view, typically from a nib.
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(LoginViewController.moveBackSignup), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        modelName = UIDevice.modelName
        print(modelName)
        
        if modelName! == "iPhone X" || modelName! == "iPhone XS" || modelName! == "iPhone XR" || modelName! == "iPhone XS Max"
        {
            btnTouchFace.setTitle("Face Id", for: UIControlState.normal)
        }
        else
        {
            btnTouchFace.setTitle("Touch Id", for: UIControlState.normal)
        }
    }
    
    @objc func moveBackSignup()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews()
    {
        self.svMain.contentSize = CGSize(width: self.view.frame.size.width, height: 590)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn(_ sender: Any)
    {
        self.view.endEditing(true)
    }
    
    @IBAction func openTouchId(_ sender: Any)
    {
        // 2
        // check if Touch ID/ Face id is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            var reason : String! = ""
            if modelName! == "iPhone X" || modelName! == "iPhone XS" || modelName! == "iPhone XR" || modelName! == "iPhone XS Max"
            {
               reason = "Authenticate with Face ID"
            }
            else
            {
               reason = "Authenticate with Touch ID"
            }
            
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(success, error) in
                    // 4
                    if success {
                        DispatchQueue.main.async
                            {
                                let tabsBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                                //******** check this its not working on ipad *******//
                                let cntrHome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! UINavigationController
                                let cntrAlert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alerts") as! UINavigationController
                                let CntrInviteFriend = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "invite") as! UINavigationController
                                let CntrProgress = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "progress") as! UINavigationController
                                let cntrSettings = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "setting") as! UINavigationController
                                tabsBar.viewControllers = [cntrHome , cntrAlert , CntrInviteFriend ,CntrProgress ,cntrSettings]
                                // let nav = UINavigatitronController(rootViewController: tabsBar)
                                APPWINDOW?.rootViewController = tabsBar
                        }
//                        self.showAlertController("Touch ID Authentication Succeeded")
                    }
                    else {
//                        self.showAlertController("Touch ID Authentication Failed")
                    }
            })
        }
            // 5
        else {
            var message : String! = ""
            if modelName! == "iPhone X" || modelName! == "iPhone XS" || modelName! == "iPhone XR" || modelName! == "iPhone XS Max"
            {
                message = "Face ID not available"
            }
            else
            {
                message = "Touch ID not available"
            }
            let alertController = UIAlertController(title: nil, message: message!, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
        }
        
    }
    
//    func showAlertController(_ message: String) {
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
    
    
    //        let alert = UIAlertController(title: "", message: "Verify your account", preferredStyle: UIAlertControllerStyle.alert)
    //        let imageView = UIImageView(frame: CGRect(x: 100, y: 10, width: 50, height: 50))
    //        imageView.image = UIImage(named: "fingerPrint")
    //        alert.view.addSubview(imageView)
    //        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:nil))
    ////        alert.addAction(UIAlertAction(title: "Send", style: .default, handler:{ (UIAlertAction) in
    ////            print("User click Ok button")
    ////        }))
    //        self.present(alert, animated: true, completion: nil)
    
    
    @IBAction func openFaceId(_ sender: Any)
    {
        // 2
//        // check if Touch ID is available
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            // 3
//            let reason = "Authenticate with Touch ID"
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
//                {(success, error) in
//                    // 4
//                    if success {
//                        DispatchQueue.main.async
//                            {
//                                let tabsBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
//                                //******** check this its not working on ipad *******//
//                                let cntrHome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home") as! UINavigationController
//                                let cntrAlert = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alerts") as! UINavigationController
//                                let CntrInviteFriend = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "invite") as! UINavigationController
//                                let CntrProgress = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "progress") as! UINavigationController
//                                let cntrSettings = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "setting") as! UINavigationController
//                                tabsBar.viewControllers = [cntrHome , cntrAlert , CntrInviteFriend ,CntrProgress ,cntrSettings]
//                                // let nav = UINavigatitronController(rootViewController: tabsBar)
//                                APPWINDOW?.rootViewController = tabsBar
//                        }
//                        //                        self.showAlertController("Touch ID Authentication Succeeded")
//                    }
//                    else {
//                        //                        self.showAlertController("Touch ID Authentication Failed")
//                    }
//            })
//        }
//            // 5
//        else {
//            let alertController = UIAlertController(title: nil, message: "Touch ID not available", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alertController, animated: true, completion: nil)
//        }

    }
    
    @IBAction func forgotPassword(_ sender: Any)
    {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your register email", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler:{ (UIAlertAction) in
            print("User click Ok button")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var textField: UITextField?
    
    func configurationTextField(textField: UITextField!)
    {
        if (textField) != nil {
            self.textField = textField!        //Save reference to the UITextField
            self.textField?.placeholder = "Enter Email";
        }
    }
    
    @IBAction func moveBack(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
}

