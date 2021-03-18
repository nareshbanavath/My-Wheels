//
//  AboutAppViewController.swift
//  MyWheels
//
//  Created by deep chandan on 18/03/21.
//

import UIKit

class AboutAppViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var featuresLb: UILabel!
    @IBOutlet weak var aboutLb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "About App"
        setupBackButton()
        aboutLb.text = """
             You have to carry Registration Certificate, annual insurance paper, pollution certificate copy while driving. You have to remember timely renewals of insurance, Pollution, servicing and battery maintenance. Having more than one vehicle multiplies your problem.

             My Wheels stores and organizes all your vehicle papers in your mobile including battery warranties. No more trouble when inspecting authority asks for it.  You will not miss any renewals now and will able to keep vehicle in perfectly healthy condition. Family sharing is provided for having flexibility to take out any vehicle by any family member or friend without having physical papers. Driving license can also be stored by you.
            """
        
        featuresLb.text = """
            ▪ Important vehicle information – Reg. No, Make n Model, Year, Vehicle photos, Fuel type ▪ Digital Papers – Reg. Certificate, Running Insurance, Pollution certificate, servicing papers ▪ Critical Reminder – Expiry of Insurance, Pollution, Next servicing date, battery replace date
            Shows No. of days remaining for each of the above with green and red colour ▪ Import & Export function for sharing documents with family members, No sharing of data on our servers, full privacy
            ▪ Search function – partial and full search on vehicle number ▪ Offline app- does not depend on Internet ensuring guaranteed working of app
             This organizer is so simple and intuitive, literally no learning curve, just download and have peace of mind on management of your vehicles!

            """
        // Do any additional setup after loading the view.
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
