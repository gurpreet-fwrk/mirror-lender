//
//  HomeGoalViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import DropDown

class HomeGoalViewController: UIViewController
{
    let selectMonthDropDown = DropDown()
    let selectTimePeriodDropDown = DropDown()
    @IBOutlet var svMain: UIScrollView!
    @IBOutlet var tfAmount: UITextField!
    @IBOutlet var btnNextDone: UIButton!
    
    @IBOutlet var ivWhiteView: UIImageView!
    @IBOutlet var btnSelectTimePeriod: UIButton!
    @IBOutlet var consSvTopY: NSLayoutConstraint!
    
    @IBOutlet var btnSelectMonth: UIButton!
    
    var aryMonth = ["3 Months", "6 Months", "1 Year"]
    var aryTimePeriod = ["Every Week", "After 2 Week", "After Month"]
    var needleView = UIView();
    var myLayer = CATransformLayer();
    
    var needleY : CGFloat! = 15.0
    
    override func viewDidLoad()
    {
        self.setMonthDropDown()
        self.setTimePeriodDropDown()
        self.title = "Edit Loan"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(HomeGoalViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        btnSelectTimePeriod.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnSelectMonth.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
//        needleView.frame = CGRect()
        needleView.frame = CGRect(x: (view.frame.width - 45)/2, y: needleY, width: 45, height: 140)
        let needleImage = UIImageView();
        
        needleImage.image = UIImage(named: "Needle");
        needleImage.contentMode = .scaleAspectFit;
        needleImage.frame = CGRect(x: 0, y: 0, width: needleView.frame.width, height: 130);
        needleView.frame.size.height = (needleImage.frame.height*(154/183))*2;
        needleView.addSubview(needleImage);
        needleView.backgroundColor = UIColor.clear;
        needleImage.backgroundColor = UIColor.clear;
        needleView.isUserInteractionEnabled = false
        needleImage.isUserInteractionEnabled = false
       
        let degrees = Double(-90);
        let radians = CGFloat(degrees * Double.pi / 180);
        needleView.transform = CGAffineTransform(rotationAngle:radians);
        needleView.layer.addSublayer(myLayer)
        svMain.addSubview(needleView);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if #available(iOS 10.0, *) {
            if needleY != 15
            {
                consSvTopY.constant = 64
            }
            else
            {
                 consSvTopY.constant = 0
            }
        } else {
           
        }
        if needleY == 15
        {
         btnNextDone.setTitle("Next", for: UIControlState.normal)
            
        }
        else
        {
          btnNextDone.setTitle("Done", for: UIControlState.normal)
        }
        
        let degrees = Double(-90);
        let radians = CGFloat(degrees * Double.pi / 180);
        needleView.transform = CGAffineTransform(rotationAngle:radians);

        // -90 to 90
       let degrees1 = Double(-20);
      let  radians1 = CGFloat(degrees1 * Double.pi / 180);
        UIView.animate(withDuration: 0.7) {
            self.needleView.transform = CGAffineTransform(rotationAngle:radians1);
        }
    }
    
    @objc func moveBack()
    {
       self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews()
    {
        svMain.contentSize = CGSize(width: self.view.frame.size.width, height: 380)
    }
    
    //MARK: Set Up Drop Downs
//    func setupDropDowns()
//    {
//        self.setMonthDropDown()
//    }
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.selectMonthDropDown,
            self.selectTimePeriodDropDown
        ]
    }()
    
    //MARK: Set Up Cat Type Drop Down
    func setMonthDropDown()
    {
        selectMonthDropDown.anchorView = btnSelectMonth
        selectMonthDropDown.bottomOffset = CGPoint(x: 0, y: btnSelectMonth.bounds.height)
        
        selectMonthDropDown.dataSource = self.aryMonth
        selectMonthDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectMonth.setTitle(item, for: UIControlState.normal)
//            self.SelectedCatID = self.arrIdsForCat[index]
//            print(self.SelectedCatID)
        }
    }
    
    func setTimePeriodDropDown()
    {
        selectTimePeriodDropDown.anchorView = btnSelectTimePeriod
        selectTimePeriodDropDown.bottomOffset = CGPoint(x: 0, y: btnSelectTimePeriod.bounds.height)
        
        selectTimePeriodDropDown.dataSource = self.aryTimePeriod
        selectTimePeriodDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectTimePeriod.setTitle(item, for: UIControlState.normal)
            //            self.SelectedCatID = self.arrIdsForCat[index]
            //            print(self.SelectedCatID)
        }
    }
    
    @IBAction func selectTimePeriod(_ sender: Any)
    {
        self.selectTimePeriodDropDown.show()
    }
    
    
    @IBAction func selectMonth(_ sender: Any)
    {
         self.selectMonthDropDown.show()
    }
    
    
    @IBAction func moveToNextView(_ sender: Any)
    {
        if btnNextDone.titleLabel?.text == "Done"
        {
            self.navigationController?.popViewController(animated: false)

        }
        else
        {
            if btnSelectMonth.titleLabel?.text == "Select Month" ||  btnSelectTimePeriod.titleLabel?.text == "Select Week" || tfAmount.text!.lengthOfBytes(using: String.Encoding.utf8) == 0
            {
                ivWhiteView.isHidden = false
                let alert = UIAlertController(title: "Cannot set your Goal", message: "First set your account then set your Goal.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        self.ivWhiteView.isHidden = true
                        
                        
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
                NotificationCenter.default.post(name: Notification.Name("changePage"), object: "1")
            }
        }
    }
    
}
