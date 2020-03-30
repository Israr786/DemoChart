//
//  CameraHelper.swift
//  DemoChart
//
//  Created by Israrul on 3/30/20.
//  Copyright © 2020 iOSTemplates. All rights reserved.
//

import Foundation
import UIKit

protocol CameraHelperProtocol: class {
    func camera(navController: UIViewController)
}

class CameraHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?
    var cameraImageView: UIImageView?
    weak var delegate: CameraHelperProtocol?
    
    init(imagePicker: UIImagePickerController?, cameraImageView: UIImageView?) {
        self.imagePicker = imagePicker
        self.cameraImageView = cameraImageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCamera(navController: UIViewController) {
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
        imagePicker =  UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .camera
        imagePicker?.allowsEditing = true
        navController.present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var image : UIImage!

        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            image = img
        }
        imagePicker?.dismiss(animated: true, completion: nil)
        cameraImageView?.image = image
    }
}
