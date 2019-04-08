//
//  HomeGoalFourthViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
//import MonthYearPickerView

class HomeGoalFourthViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate
{
    @IBOutlet var btnCredit: UIButton!
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var svMain: UIScrollView!
    @IBOutlet var btnBankDraft: UIButton!
    @IBOutlet var consDatePicker: NSLayoutConstraint!
    
    @IBOutlet var viewPicker: UIView!
    @IBOutlet var wvPaypal: UIWebView!
    @IBOutlet var viewCredit: UIView!
    @IBOutlet var viewBankDraft: UIView!
    @IBOutlet var ivWhiteView: UIImageView!
    @IBOutlet var tfExpireDate: UITextField!
    
    var isFromWithdrawMoney = Bool(false)
    
    
    override func viewDidLoad()
    {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        //        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: date)
        let dateMain = dateFormatter.date(from: strDate)
        
        pickerDate.minimumDate = dateMain
        
//        pickerDate.Format =
//        pickerDate.CustomFormat = "MMMM yyyy"
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(HomeGoalFourthViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        
//        let picker = MonthYearPickerView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 216))
//        print(picker.date)
////        picker.dateSelectionHandler = { date in
////            print("selected: \(date)")
////        }
//        self.view.addSubview(picker)
        
        let expiryDatePicker = MonthYearPickerView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 216))
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let stringDate = String(format: "%02d / %d", month, year)
            NSLog(stringDate)
            
            self.tfExpireDate.text = stringDate
            // should show something like 05/2015
        }
        self.viewPicker.addSubview(expiryDatePicker)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
//        self.tabBarController?.tabBar.isHidden = true
//        let url = URL (string: "www.paypal.com/signin")
        let req = NSURLRequest(url: NSURL(string: "https://www.paypal.com/signin")! as URL)
        wvPaypal.delegate = self
        wvPaypal.loadRequest(req as URLRequest)
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews()
    {
        svMain.contentSize = CGSize(width: self.svMain.frame.size.width, height: 300)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.viewCredit.frame.origin.y = 108

        UIView.animate(withDuration: 0.5, animations: {
            self.consDatePicker.constant = 30
        }, completion: { finished in
        })
    }
    
    //MARK:- WKNavigationDelegate
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        print(error.localizedDescription)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
         print("Start to load")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
         print("finish to load")
    }
    
    @IBAction func selectWhichCard(_ sender: Any)
    {
         self.viewCredit.frame.origin.y = 108
        self.view.endEditing(true)
         wvPaypal.isHidden = true
        if (sender as AnyObject).tag == 1
        {
            btnCredit.setBackgroundImage(UIImage(named: "greenCircle"), for: UIControlState.normal)
            btnBankDraft.setBackgroundImage(UIImage(named: "greyCircle"), for: UIControlState.normal)
            viewCredit.isHidden = false
            viewBankDraft.isHidden = true
        }
        else
        {
            self.tabBarController?.tabBar.isHidden = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.consDatePicker.constant = 30
            }, completion: { finished in
            })
            
            btnBankDraft.setBackgroundImage(UIImage(named: "greenCircle"), for: UIControlState.normal)
            btnCredit.setBackgroundImage(UIImage(named: "greyCircle"), for: UIControlState.normal)
            viewCredit.isHidden = true
            viewBankDraft.isHidden = false
        }
    }
    
    @IBAction func changeDateWithScroll(_ sender: Any) {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM / YY"
//        //        dateFormatter.timeStyle = DateFormatter.Style.short
//        let strDate = dateFormatter.string(from: pickerDate.date)
//        tfExpireDate.text = strDate
    }
    @IBAction func done(_ sender: Any)
    {
        if isFromWithdrawMoney == false
        {
        ivWhiteView.isHidden = false
        let alert = UIAlertController(title: "Goal has been set", message: "Enjoy your saving process.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
            switch action.style
            {
            case .default:
                self.ivWhiteView.isHidden = true
                NotificationCenter.default.post(name: Notification.Name("changePage"), object: "1")
                NotificationCenter.default.post(name: Notification.Name("homeFinal"), object: nil)
                print("default")
                
            case .cancel:
                 self.ivWhiteView.isHidden = true
                print("cancel")
                
            case .destructive:
                 self.ivWhiteView.isHidden = true
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func selectDate(_ sender: Any)
    {
        print(UIDevice.modelName)
        if UIDevice.modelName == "iPhone 5" ||  UIDevice.modelName == "iPhone 5c" ||  UIDevice.modelName == "Simulator iPhone 5s" ||  UIDevice.modelName == "iPhone 6"  ||  UIDevice.modelName == "iPhone 7"  ||  UIDevice.modelName == "iPhone 6s"  ||  UIDevice.modelName == "iPhone 8"
        {
//            if view.frame.origin.y == 0 {
                self.viewCredit.frame.origin.y = -40
//            }
        }
//        else
//        {
//             self.viewCredit.frame.origin.y = -40
//        }
        
        self.view.endEditing(true)
        self.tabBarController?.tabBar.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.consDatePicker.constant = -230
        }, completion: { finished in
        })
    }
    
    @IBAction func selectVisa(_ sender: Any)
    {
        wvPaypal.isHidden = true
    }
    
    @IBAction func selectPaypal(_ sender: Any)
    {
         self.viewCredit.frame.origin.y = 108
         self.view.endEditing(true)
        wvPaypal.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.consDatePicker.constant = 30
        }, completion: { finished in
        })
    }
    
    @IBAction func closeDate(_ sender: Any)
    {
         self.viewCredit.frame.origin.y = 108
        self.tabBarController?.tabBar.isHidden = false
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM / YY"
//        //        dateFormatter.timeStyle = DateFormatter.Style.short
//        let strDate = dateFormatter.string(from: pickerDate.date)
//        tfExpireDate.text = strDate
        
        UIView.animate(withDuration: 0.5, animations: {
            self.consDatePicker.constant = 30
        }, completion: { finished in
        })
    }
    
}
