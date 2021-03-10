//
//  UIViewController + Extensions.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit
extension UIViewController
{
  func addTapGestureToView()
  {
    //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
    //tapGesture.delegate = self
    //self.view.addGestureRecognizer(tapGesture)
  }
  @objc func handleTapGesture()
  {
    dismiss(animated: true, completion: nil)
  }
  func showAlert(message : String , okAction : (()->())? = nil)
  {
    let alertController = UIAlertController(title: "My Wheels", message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      okAction?()
    }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}
