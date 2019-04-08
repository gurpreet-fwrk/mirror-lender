//
//  EditAccountViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/09/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class EditAccountViewController : UIViewController
{
    
    @IBOutlet var tfExpireDate: UITextField!
    @IBOutlet var consDatePicker: NSLayoutConstraint!
    @IBOutlet var btnDone: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var viewPicker: UIView!
    
    override func viewDidLoad()
    {
        self.title = "Edit Account"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(EditAccountViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let btnSave = UIButton()
        btnSave.setTitle("Save", for: UIControlState.normal)
        btnSave.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        btnSave.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnSave.addTarget(self, action: #selector(EditAccountViewController.save), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnSave
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let expiryDatePicker = MonthYearPickerView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: 216))
        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
            let stringDate = String(format: "%02d / %d", month, year)
            NSLog(stringDate)
            
            self.tfExpireDate.text = stringDate
        }
        self.viewPicker.addSubview(expiryDatePicker)

            
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func save()
    {
       
    }
    
    @IBAction func openPicker(_ sender: Any) {
        self.view.endEditing(true)
        self.tabBarController?.tabBar.isHidden = true
        UIView.animate(withDuration: 0.5, animations: {
            self.consDatePicker.constant = -230
        }, completion: { finished in
        })
    }
    
    @IBAction func closePicker(_ sender: Any) {
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
