//
//  AlertViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 06/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class AlertViewController: UIViewController, UITableViewDataSource
{
    var timerAlert : Timer!
    
    @IBOutlet var tvAlert: UITableView!
    
    override func viewDidLoad()
    {
      self.title = "Alert"
        
        timerAlert = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(showAlert), userInfo: nil, repeats: false)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alert") as! alertTableViewCell
       cell.selectionStyle = .none
        
        return cell
    }
    
    @objc func showAlert()
    {
        self.timerAlert.invalidate()
        if currentReachabilityStatus != .notReachable
        {
        }
        else
        {
            let cntr = self.storyboard?.instantiateViewController(withIdentifier: "comonalert") as! CommonAlertViewController
            cntr.strImage = "internet"
            cntr.strText1 = "Sorry!"
            cntr.strText2 = "Internet Connection Lost!"
            self.navigationController?.pushViewController(cntr, animated: false)
        }
    }
    
}

class alertTableViewCell: UITableViewCell
{
    
}
