//
//  PastInvitationsViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 31/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class PastInvitationsViewController: UIViewController, UITableViewDataSource
{
    override func viewDidLoad()
    {
        self.title = "Past Invitations"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(PastInvitationsViewController.moveBack), for: .touchUpInside)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "pastInvite") as! PastInvitationsTableViewCell
        cell.selectionStyle = .none
        
        if indexPath.row == 0
        {
            cell.btnAccept.isHidden = true
            cell.btnDelete.setTitleColor(UIColor(red: 25/255, green: 25/255, blue: 112/255, alpha: 1.0), for: UIControlState.normal)
            cell.btnDelete.setTitle("Accepted", for: UIControlState.normal)
        }
        else
        {
            cell.btnAccept.isHidden = false
            cell.btnDelete.setTitleColor(UIColor.red, for: UIControlState.normal)
            cell.btnDelete.setTitle("Delete", for: UIControlState.normal)
        }
        
        return cell
    }
}

class PastInvitationsTableViewCell: UITableViewCell
{
    @IBOutlet var btnAccept: UIButton!
    @IBOutlet var btnDelete: UIButton!
    
}
