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
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
    //tapGesture.delegate = self
    //self.view.addGestureRecognizer(tapGesture)
  }
  @objc func handleTapGesture()
  {
    dismiss(animated: true, completion: nil)
  }
}
