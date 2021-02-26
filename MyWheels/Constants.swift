//
//  Constants.swift
//  MyWheels
//
//  Created by deep chandan on 22/02/21.
//

import Foundation
import UIKit

struct ConstColors {
    static let appColor = UIColor.init(red: 180/250, green: 220/250, blue: 78/250, alpha: 0.5)
}
extension UIViewController{
    func setupNavigation(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 24.0/255.0, green: 94.0/255.0, blue: 136.0/255.0, alpha: 1)
    }

}
