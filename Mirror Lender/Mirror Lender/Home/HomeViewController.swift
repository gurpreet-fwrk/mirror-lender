//
//  HomeViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 04/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import PieCharts

class HomeViewController: UIViewController , PieChartDelegate
{
    func onSelected(slice: PieSlice, selected: Bool)
    {
         print("Selected: \(selected), slice: \(slice)")
    }
    
   
    @IBOutlet var chartView: PieChart!
    @IBOutlet var viewFinal: UIView!
    @IBOutlet var ivFour: UIImageView!
    @IBOutlet var ivThree: UIImageView!
    @IBOutlet var ivOne: UIImageView!
    @IBOutlet var ivTwo: UIImageView!
    @IBOutlet var pcDots: UIPageControl!
    @IBOutlet var ivSelected: UIImageView!
    var btnBack = UIButton()

    var homePageViewController: HomePageViewController?
    {
        didSet
        {
            homePageViewController?.homePageDelegate = self
        }
    }
    
    override func viewDidLoad()
    {
        self.title = "Home"
        
         NotificationCenter.default.addObserver(self, selector: #selector(moveToFinalView(notification:)), name: Notification.Name("homeFinal"), object: nil)
//        self.tabBarController?.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(HomeViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
        btnBack.isHidden = true
    }
    
    @objc func moveBack()
    {
        NotificationCenter.default.post(name: Notification.Name("changePage"), object: "2")
        if viewFinal.isHidden == false
        {
            btnBack.isHidden = true
        }
        
        self.viewFinal.isHidden = true
        //        btnMenu.isHidden = true
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveLinear, animations: {
            self.ivSelected.frame.origin.x = 0
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        chartView.layers = [createCustomViewsLayer(), createTextLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }
    
    @IBAction func EditLoan(_ sender: Any)
    {
        let cntrHome = self.storyboard?.instantiateViewController(withIdentifier: "oneViewController") as! HomeGoalViewController
        cntrHome.needleY = 16
        self.navigationController?.pushViewController(cntrHome, animated: true)
    }
    
    
    // MARK: - Models
    fileprivate func createModels() -> [PieSliceModel]
    {
        return [
            PieSliceModel(value: 7, color: UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 112.0/255.0, alpha: 1.0)),
            PieSliceModel(value: 3, color:  UIColor(red: 60.0/255.0, green: 203.0/255.0, blue: 62.0/255.0, alpha: 1.0)),
        ]
    }
    
    // MARK: - Layers
    fileprivate func createCustomViewsLayer() -> PieCustomViewsLayer
    {
        let viewLayer = PieCustomViewsLayer()
        
        let settings = PieCustomViewsLayerSettings()
        settings.viewRadius = 100
        settings.hideOnOverflow = false
        viewLayer.settings = settings
        
        return viewLayer
    }
    
    fileprivate func createTextLayer() -> PiePlainTextLayer
    {
        let textLayerSettings = PiePlainTextLayerSettings()
        textLayerSettings.viewRadius = 40
        textLayerSettings.hideOnOverflow = true
        textLayerSettings.label.font = UIFont.systemFont(ofSize: 12)
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        textLayerSettings.label.textGenerator = {slice in
            return formatter.string(from: slice.data.percentage * 100 as NSNumber).map{"\($0)%"} ?? ""
        }
        
        let textLayer = PiePlainTextLayer()
        textLayer.settings = textLayerSettings
        return textLayer
    }
    
    @objc func moveToFinalView(notification: Notification)
    {
        btnBack.isHidden = false
        self.viewFinal.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let homePageViewController = segue.destination as? HomePageViewController
        {
            self.homePageViewController = homePageViewController
        }
    }
}

extension HomeViewController: HomePageViewControllerDelegate
{
    func homePageViewController(homePageViewController: HomePageViewController, didUpdatePageCount count: Int)
    {
//        pcDots.numberOfPages = count
    }
    
    func homePageViewController(homePageViewController: HomePageViewController, didUpdatePageIndex index: Int)
    {
        var x : CGFloat! = 0.0
  
        if index == 0
        {
            x = 0
        }
        else if index == 1
        {
            x = 83
        }
        else if index == 2
        {
            x = 167
        }
        else if index == 3
        {
            x = 250
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.ivSelected.frame.origin.x = x
        }, completion: { (value: Bool) in
            if index == 0
            {
                if self.viewFinal.isHidden == true
                {
                    self.btnBack.isHidden = true
                }
                self.navigationItem.title = "Home"
                self.tabBarController?.tabBarItem.title = "Home"
                
                self.ivOne.image = UIImage(named: "green")
                self.ivTwo.image = UIImage(named: "blue")
                self.ivThree.image = UIImage(named: "blue")
                self.ivFour.image = UIImage(named: "blue")
                
            }
            else if index == 1
            {
                self.btnBack.isHidden = false
                self.navigationItem.title = "Select Date"
                self.tabBarController?.tabBarItem.title = "Home"
                
                self.ivOne.image = UIImage(named: "green")
                self.ivTwo.image = UIImage(named: "green")
                self.ivThree.image = UIImage(named: "blue")
                self.ivFour.image = UIImage(named: "blue")
            }
            else if index == 2
            {
                self.btnBack.isHidden = false
                self.navigationItem.title = "Loan Achievement"
                self.tabBarController?.tabBarItem.title = "Home"
                
                self.ivOne.image = UIImage(named: "green")
                self.ivTwo.image = UIImage(named: "green")
                self.ivThree.image = UIImage(named: "green")
                self.ivFour.image = UIImage(named: "blue")
            }
            else if index == 3
            {
                self.btnBack.isHidden = false
             
                self.navigationItem.title = "Add Account"
                self.tabBarController?.tabBarItem.title = "Home"
                self.ivOne.image = UIImage(named: "green")
                self.ivTwo.image = UIImage(named: "green")
                self.ivThree.image = UIImage(named: "green")
                self.ivFour.image = UIImage(named: "green")
                
                //            self.viewFinal.isHidden = false
            }
        })
  
       
    }
}
