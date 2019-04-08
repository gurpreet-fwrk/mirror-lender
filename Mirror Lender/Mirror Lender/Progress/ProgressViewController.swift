//
//  ProgressViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit
import PieCharts

class ProgressViewController: UIViewController, PieChartDelegate
{
    
    @IBOutlet var btnSavingProgress: UIButton!
    @IBOutlet var btnCredit: UIButton!
    
    @IBOutlet var viewTarget: UIView!
    @IBOutlet var viewGoal: UIView!
   
    var goal : Float! = 80.0
    
    override func viewDidLoad()
    {
        self.title = "Progress"
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        btnSavingProgress.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btnCredit.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        
        let chartViewGoal: PieChart = PieChart(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        chartViewGoal.delegate = self
        chartViewGoal.models = self.createModelsGoal()
        self.viewGoal.addSubview(chartViewGoal)
        
        let chartViewTarget: PieChart = PieChart(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        chartViewTarget.delegate = self
        chartViewTarget.models = self.createModelsTarget()
        self.viewTarget.addSubview(chartViewTarget)
    }
    
    func onSelected(slice: PieSlice, selected: Bool)
    {
         print("Selected: \(selected), slice: \(slice)")
    }
    
    fileprivate func createModelsGoal() -> [PieSliceModel]
    {
        // Goal circle colors
        return [
            PieSliceModel(value: Double(goal!), color: UIColor(red: 60/255, green: 203/255, blue: 62/255, alpha: 1.0)),
            PieSliceModel(value: 100.0 - Double(goal!), color: UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0))
        ]
    }
    
    fileprivate func createModelsTarget() -> [PieSliceModel]
    {
        // Target circle colors
        return [
            PieSliceModel(value: 100.0 - Double(goal!), color: UIColor(red: 60/255, green: 203/255, blue: 62/255, alpha: 1.0)),
            PieSliceModel(value: Double(goal!) , color: UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0))
        ]
    }
    
   
}
