//
//  SignupAddressViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 07/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class SignupAddressViewController: UIViewController , UITextFieldDelegate
{
    @IBOutlet var tfDate: UITextField!
    @IBOutlet var pickerDate: UIDatePicker!
    @IBOutlet var svMain: UIScrollView!
    @IBOutlet var consTopPicker: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        pickerDate.set18YearValidation()
        self.title = "Address"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(SignupAddressViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUp(_ sender: Any)
    {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.consTopPicker.constant = 30
        }, completion: { finished in
        })
    }
    
    @IBAction func selectDate(_ sender: Any)
    {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5, animations: {
            self.consTopPicker.constant = -230
        }, completion: { finished in
        })
    }
    
    @IBAction func ClosePicker(_ sender: Any)
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.long
//        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: pickerDate.date)
        tfDate.text = strDate
        
        UIView.animate(withDuration: 0.5, animations: {
            self.consTopPicker.constant = 30
        }, completion: { finished in
        })
    }
    
    
    @IBAction func selectDateWithScroll(_ sender: Any)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        let strDate = dateFormatter.string(from: pickerDate.date)
        tfDate.text = strDate
    }
    
}


extension UIDatePicker
{
    func set18YearValidation()
    {
        let currentDate: Date = Date()
        var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "GMT")!
        var components: DateComponents = DateComponents()
        components.calendar = calendar
        components.year = -10
        let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
        components.year = -100
        let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
        self.minimumDate = minDate
        self.maximumDate = maxDate
    }
}
