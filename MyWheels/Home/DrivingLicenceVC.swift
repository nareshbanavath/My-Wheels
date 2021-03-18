//
//  DrivingLicenceVC.swift
//  MyWheels
//
//  Created by deep chandan on 17/03/21.
//

import UIKit
import CoreData

class DrivingLicenceVC: UIViewController {

    @IBOutlet weak var licence_Show_View: UIView!
    @IBOutlet weak var licence_Fill_View: UIView!
    
    @IBOutlet weak var licence_Front_img: ImagePickeredView!
    {
        didSet
        {
            licence_Front_img.parentViewController = self
        }
    }
    @IBOutlet weak var licence_Back_Img: ImagePickeredView!
    {
        didSet
        {
            licence_Back_Img.parentViewController = self
        }
    }
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var validUptoLb: UILabel!
    @IBOutlet weak var licenceNolb: UILabel!
    @IBOutlet weak var licenceback_show_img: UIImageView!
    @IBOutlet weak var licencefront_show_Img: UIImageView!
    @IBOutlet weak var validuptoTxt: DatePickeredTextField!
    {
        didSet
        {
            validuptoTxt.datepicker.minimumDate = Date()
        }
    }
    @IBOutlet weak var licenceNotxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        title = "Driving Licence"
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        // guard validation() else {return}
        guard validation() else {return}
        let drivingLicence = DrivingLicenceTable(context : CoreDataManager.shared.persistentContainer.viewContext)
        drivingLicence.licenceBackImg = licence_Back_Img.image?.pngData()
        drivingLicence.licenceFrontImg = licence_Front_img.image?.pngData()
        drivingLicence.licenceNo = licenceNotxt.text
        drivingLicence.validUpto = validuptoTxt.text
        
        CoreDataManager.shared.saveContext()
        
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.scheduleLocalNotification(title: "Driving Licence", body: "driving licence validity date", date: validuptoTxt.completeDate ?? "")
        setupView()
 
        //
    }
    func validation() -> Bool {
      guard licence_Front_img.isImagePicked == true else {self.showAlert(message: "Please Capture Licence Front Image");return false}
      guard licence_Back_Img.isImagePicked == true else {self.showAlert(message: "Please Capture Licence Back Image");return false}
      guard licenceNotxt.text?.count != 0 else {self.showAlert(message: "Please Enter Licence No");return false}
    guard validuptoTxt.text?.count != 0 else {self.showAlert(message: "Please Enter valid upto");return false}
      return true
    }

    func setupView()
    {
        let licenceData = CoreDataManager.shared.getManagedObjects(fetchRequest: DrivingLicenceTable.fetchRequest())
        if let data = licenceData?.first
        {
            licence_Fill_View.isHidden = true
            licence_Show_View.isHidden = false
            licencefront_show_Img.image = UIImage(data: data.licenceFrontImg!)
            licenceback_show_img.image = UIImage(data: data.licenceBackImg!)
            licenceNolb.text = data.licenceNo
            validUptoLb.text = data.validUpto
        }
        else
        {
            licence_Fill_View.isHidden = false
            licence_Show_View.isHidden = true
        }
    }


}
