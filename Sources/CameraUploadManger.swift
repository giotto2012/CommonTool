//
//  CameraUploadManger.swift
//  LiveMap
//
//  Created by 張宇樑 on 2022/1/24.
//

import Foundation
import AVFoundation
import UIKit


public class CameraUploadManger:NSObject
{
    public var delegate:UIViewController
        
    public var selectImageDataFinish : ((Data) -> Void)?

    public init(d:UIViewController) {
        
        delegate = d
    }
    
    func takePicture()
    {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        
        if authStatus == .authorized
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                let  cameraPicker = UIImagePickerController()
                
                cameraPicker.delegate = self
                                
                cameraPicker.sourceType = .camera
                
                delegate.present(cameraPicker, animated: true, completion: nil)
                
            } else {
                
                
                delegate.showAlear(message: LocalString(key: "NoCamera_Message"))
            }
        }
        else if authStatus == .denied
        {
            delegate.showAlear(message: LocalString(key: "CameraNoPermission_Message"))
        }
        else if authStatus == .notDetermined
        {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [self] (statusFirst) in
                
                if statusFirst {
                    
                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                        
                        let  cameraPicker = UIImagePickerController()
                        
                        cameraPicker.delegate = self
                                                
                        cameraPicker.sourceType = .camera
                        
                        delegate.present(cameraPicker, animated: true, completion: nil)
                        
                    } else {
                        
                        
                        delegate.showAlear(message: LocalString(key: "NoCamera_Message"))
                    }
                    
                    
                    
                } else {
                    
                    delegate.showAlear(message: LocalString(key: "CameraNoPermission_Message"))
                                                            
                }
            })
        }
        else
        {
            
            delegate.showAlear(message: LocalString(key: "CameraNoPermission_Message"))
                        
        }
    }
    
    
    public func photoActionSheet()
    {
        DispatchQueue.main.async { [self] in
            
            let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        
            let screenShotAction = UIAlertAction(title:LocalString(key: "PhotoAdd_Camera"), style: .default) { (alear) in
                
                
                self.takePicture()
                
            }
            
            controller.addAction(screenShotAction)
            
            
            let photoAlbumAction = UIAlertAction(title:LocalString(key: "PhotoAdd_PhotoAlbum"), style: .default) { (alear) in
                
                DispatchQueue.main.async { [self] in
                    
                    selectPhoto()

                }
            }
            
            controller.addAction(photoAlbumAction)
            
            
            
            let cancelAction = UIAlertAction(title: LocalString(key: "Cancel"), style: .cancel, handler: nil)
            
            controller.addAction(cancelAction)
            
            
            delegate.present(controller, animated: true, completion: nil)
            
        }
        
    }
    
    
    func selectPhoto()
    {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        
        if authStatus == .authorized
        {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                let imagePicker = UIImagePickerController()
//                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
//                imagePicker.allowsEditing = true

                imagePicker.modalPresentationStyle = .currentContext
                
                imagePicker.modalPresentationStyle = .overFullScreen

                
                delegate.present(imagePicker, animated: true, completion: nil)
                
            }
            else
            {
                delegate.showAlear(message: LocalString(key: "NoPhotoAlbum_Message"))
            }
            
        }
        else if authStatus == .denied
        {
            delegate.showAlear(message: LocalString(key: "PhotoAlbumNoPermission_Message"))
        }
        else if authStatus == .notDetermined
        {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { [self] (statusFirst) in
                
                if statusFirst {
                    
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        
                        let imagePicker = UIImagePickerController()
//                        imagePicker.allowsEditing = true
                        imagePicker.sourceType = .photoLibrary
                        imagePicker.delegate = self
                        imagePicker.modalPresentationStyle = .overFullScreen
//                        imagePicker.allowsEditing = true

                        delegate.present(imagePicker, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        delegate.showAlear(message:LocalString(key: "NoPhotoAlbum_Message"))
                    }
                    
                    
                } else {
                    
                    delegate.showAlear(message: LocalString(key: "PhotoAlbumNoPermission_Message"))

                    
                }
            })
        }
        else
        {
            delegate.showAlear(message: LocalString(key: "PhotoAlbumNoPermission_Message"))
        }
    }
}
extension CameraUploadManger:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    public func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        {
            
            if let jpgImageData = selectedImage.jpegData(compressionQuality: 0.2)
            {
                self.selectImageDataFinish?(jpgImageData)
            }
                       
            
//            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
        delegate.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //        isEditPhoto = false
        //
        //
        //        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        
        
        picker.dismiss(animated: true, completion: nil)
        
    }
}
