//
//  CreditViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 31/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class CreditViewController: UIViewController, UITableViewDataSource , UITableViewDelegate
{
    override func viewDidLoad()
    {
        self.title = "Credit Progress"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(CreditViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "credit") as! creditTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cntrCredit = self.storyboard?.instantiateViewController(withIdentifier: "creditdetail") as! CreditProgressDetailViewController
        self.navigationController?.pushViewController(cntrCredit, animated: true)
    }
}

class creditTableViewCell: UITableViewCell
{
    
}

