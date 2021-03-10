//
//  BatteryViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit
import CoreData

class BatteryViewController: UIViewController {

  @IBOutlet weak var addBtn: UIButton!
  {
    didSet{
      addBtn.isHidden = true

    }
  }
  var completion : ((Bool)->())?
  @IBOutlet weak var battery_Show_View: UIView!
  {
    didSet
    {
      battery_Show_View.isHidden = true
    }
  }
  @IBOutlet weak var bill_Fill_ImgView: ImagePickeredView!
  
  @IBOutlet weak var battery_Fill_ImgView: ImagePickeredView!
  
  @IBOutlet weak var battery_Fill_View: UIView!
  {
    didSet
    {
      battery_Fill_View.isHidden = true
    }
  }
  @IBOutlet weak var makeTxt: UITextField!
  @IBOutlet weak var purchasedTxt: DatePickeredTextField!
  {
    didSet
    {
      purchasedTxt.datepicker.maximumDate = Date()
    }
  }
  @IBOutlet weak var warrantyEndDate: DatePickeredTextField!
  {
    didSet
    {
      warrantyEndDate.datepicker.minimumDate = Date()
    }
  }
  
  @IBOutlet weak var bill_Show_ImgView: UIImageView!
  
  @IBOutlet weak var battery_Show_ImgView: UIImageView!
  @IBOutlet weak var makeLb: UILabel!
  @IBOutlet weak var purchasedOnLb: UILabel!
  @IBOutlet weak var warrantyEndDateLb: UILabel!
  var parentVehicle : VehicleDetails?
  
  override func viewDidLoad() {
        super.viewDidLoad()
  
    bill_Fill_ImgView.parentViewController = self
    battery_Fill_ImgView.parentViewController = self
    //setupBatterView()
 
        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupBatterView()
  }
    
  @IBAction func saveBtnAction(_ sender: UIButton) {
    guard validation() else {return}
    let batteryDetails = BatteryTable(context: CoreDataManager.shared.persistentContainer.viewContext)
    guard let selectedVehicle = parentVehicle else { return }
    batteryDetails.vehicle = selectedVehicle
    batteryDetails.make = makeTxt.text
    batteryDetails.purchasedOn = purchasedTxt.text
    batteryDetails.warrantyDate = warrantyEndDate.text
    batteryDetails.batteryImg = battery_Fill_ImgView.image?.pngData()
    batteryDetails.warantyImg = bill_Fill_ImgView.image?.pngData()
    DispatchQueue.main.async {
      self.dismiss(animated: true) {
        self.completion?(true)
      }
    }
    DispatchQueue.global(qos: .userInteractive).async {
      CoreDataManager.shared.saveContext()
    }
 
  }
  func validation() -> Bool
  {
    guard bill_Fill_ImgView.isImagePicked else {self.showAlert(message: "Please Capture Bill/Warranty Image");return false}
    guard battery_Fill_ImgView.isImagePicked else {self.showAlert(message: "Please Capture Battery Image");return false}
    guard warrantyEndDate.text?.count != 0 else {self.showAlert(message: "Please Enter Warranty End Date");return false}
    return true
  }
  func setupBatterView(){
    guard parentVehicle != nil else {return}
    DispatchQueue.global(qos: .userInteractive).async { [self] in
      guard let batteryResult = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: parentVehicle,entityName: .bateryDetails) as? [BatteryTable] else {return}
    //  print(writeCoreDataObjectToCSV(objects: batteryResult, named: "battery"))
      DispatchQueue.main.async {
        if batteryResult.count > 0 //When have data need show rcDetails_Show_View
        {
          //
          makeLb.text = batteryResult.last?.make
          if let warrantyImgData = batteryResult.last?.warantyImg
          {
            self.bill_Show_ImgView.image = UIImage(data: warrantyImgData)
          }
          if let batteryImgData = batteryResult.last?.batteryImg
          {
            self.battery_Show_ImgView.image = UIImage(data: batteryImgData)
          }
          battery_Fill_View.isHidden = true
          battery_Show_View.isHidden = false
          purchasedOnLb.text = batteryResult.last?.purchasedOn
          warrantyEndDateLb.text = batteryResult.last?.warrantyDate
          addBtn.isHidden = false
          UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
          }
        }else {
          battery_Fill_View.isHidden = false
          battery_Show_View.isHidden = true
          addBtn.isHidden = true
        }
  

      }
  
    }

  }
  
  func writeCoreDataObjectToCSV(objects: [NSManagedObject], named: String) -> String? {
      /* We assume that all objects are of the same type */
      guard objects.count > 0 else {
          return nil
      }
      let firstObject = objects[0]
     /////////////// let arr = Array(firstObject.entity.attributesByName.keys)
      let attribs = Array(firstObject.entity.attributesByName.keys)
    let csvHeaderString = (attribs.reduce("",{($0 as String) + "," + $1 }) as NSString).substring(from: 1) + "\n"

      let csvArray = objects.map({object in
        (attribs.map({((object.value(forKey: $0) ?? "NIL") as AnyObject).description}).reduce("",{$0 + "," + $1}) as NSString).substring(from: 1) + "\n"
      })
    let csvString = csvArray.reduce("", +)

      return csvHeaderString+csvString
  }
  
  @IBAction func closeBtnClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func addBtnClicked(_ sender: UIButton) {
    addBtn.isHidden = true
    battery_Show_View.isHidden = true
    battery_Fill_View.isHidden = false
  }

}
