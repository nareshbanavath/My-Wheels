//
//  CustomImageView.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit
protocol ImagePickeredViewDelegate {
  func didFinishPicking(_ image : UIImage , imageView : UIImageView?)
}

class ImagePickeredView: UIImageView , UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    weak var parentViewController : UIViewController?
    var isImagePicked : Bool = false
    var imagePickeredDelegate : ImagePickeredViewDelegate?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGuesture = UITapGestureRecognizer()
        
        tapGuesture.numberOfTapsRequired = 1
        tapGuesture.addTarget(self, action: #selector(handleClickOnImageview(_:)))
        self.isUserInteractionEnabled = true
       // self.image = self.changeImageColor(color: UIColor(named: "PrimaryColor")!)
        self.addGestureRecognizer(tapGuesture)
    }

    @objc func handleClickOnImageview(_ sender : Any)
    {
         openActionSheet(options: ["Take a Photo", "Choose from Gallery"], imagePicker: UIImagePickerController())
    }
    
    func openActionSheet(options:[String],imagePicker:UIImagePickerController) -> Void {
        let actionSheet = UIAlertController(title: "Please Choose an Option", message: nil, preferredStyle: .actionSheet)
        let takePhotoAction = UIAlertAction(title: options[0], style: .default) { (takePhotoAction) in
            
            self.openCamera(imagePicker: imagePicker)
        }
        let photoGalleryAction = UIAlertAction(title: options[1], style: .default) { (photoGalleryAction) in
            self.openGallery(imagePicker: imagePicker)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(photoGalleryAction)
        actionSheet.addAction(cancelAction)
        parentViewController?.present(actionSheet, animated: true, completion: nil)
    }
    
    func openCamera(imagePicker:UIImagePickerController) -> Void {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            parentViewController?.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Hello,", message: "You don not have permissions to access camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            parentViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery(imagePicker:UIImagePickerController) -> Void {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
      parentViewController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.contentMode = .scaleAspectFit
        //self.presentCropViewController(image: pickedImage)
       // self.image = pickedImage
  
     // print("Original Image Size in MBs :- \(pickedImage.getSizeIn(.megabyte)) MB")
      LoadingOverlay.shared.showOverlay(view: (parentViewController?.view)!)
      DispatchQueue.global(qos: .userInteractive).async {
        let image = UIImage(data: pickedImage.compress(to: 1000))
        DispatchQueue.main.async {
          LoadingOverlay.shared.hideOverlayView()
          self.isImagePicked = true
          self.image = image
        }
      }
      
     //
      //self.image = UIImage(data: pickedImage.compress(to: 1000))
      //print("compressed image size :- \(self.image?.getSizeIn(.megabyte)) MB")
        imagePickeredDelegate?.didFinishPicking(pickedImage , imageView: self)
        picker.dismiss(animated: true, completion: nil)
        
        //self.presentCropViewController(image: pickedImage)
    
    }


}
