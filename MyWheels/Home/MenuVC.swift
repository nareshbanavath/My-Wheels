//
//  MenuVC.swift
//  MyWheels
//
//  Created by deep chandan on 23/02/21.
//

import UIKit

class MenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var menuItem = ["Driving Licence","App Info"]
    var menuIcons = ["drivingLicenceIcon" , "infoIcon"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.menuItem.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.menuitemLb.text = menuItem[indexPath.row]
        cell.imageIcon.image = UIImage(named: menuIcons[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DrivingLicenceVC") as! DrivingLicenceVC
            let navVc = UINavigationController(rootViewController: vc)
            self.sideMenuController?.setContentViewController(to: navVc)
        
        }
        else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutAppViewController") as! AboutAppViewController
            let navVc = UINavigationController(rootViewController: vc)
            self.sideMenuController?.setContentViewController(to: navVc)
        }
        sideMenuController?.hideMenu()
        
    }
}
