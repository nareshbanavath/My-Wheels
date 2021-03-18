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
    func setupBackButton()
    {
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        backButton.setImage(UIImage(named: "backImage"), for: .normal)
        let barBtn = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButton(barBtn, animated: true)
    }
    @objc func backButtonClicked()
    {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuController")
        self.view.window?.rootViewController = vc
    }
}
