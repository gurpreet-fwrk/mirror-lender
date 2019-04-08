//
//  EditProfileViewController.swift
//  Mirror Lender
//
//  Created by Waheguru on 31/08/18.
//  Copyright © 2018 Pollysys. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate
{
    @IBOutlet var ivUser: UIImageView!
    override func viewDidLoad()
    {
        self.title = "Edit Profile"
        
        let btnBack = UIButton()
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        
        btnBack.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        btnBack.addTarget(self, action: #selector(EditProfileViewController.moveBack), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnBack
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func moveBack()
    {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func EditProfilePic(_ sender: Any)
    {
        self.view.endEditing(true)
        
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .custom
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .alert)
        
        // 2
     
        let openCamera = UIAlertAction(title: "Take Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                self.tabBarController?.tabBar.isHidden=true;
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        //
        let openLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            {
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self.tabBarController?.tabBar.isHidden=true;
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        //
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        // 4
        optionMenu.addAction(openCamera)
        optionMenu.addAction(openLibrary)
        optionMenu.addAction(cancel)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
       let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        ivUser.image = tempImage
        
//        btnAtachPicture.setImage(nil, for: UIControlState())
//        btnAtachPicture.setImage(tempImageCat, for: UIControlState())
        self.tabBarController?.tabBar.isHidden=false;
        self.dismiss(animated: true, completion: nil)
    }
    
}
