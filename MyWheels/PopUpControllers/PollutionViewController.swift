//
//  PollutionViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit

class PollutionViewController: UIViewController {

  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var pollution_Fill_ImgView: ImagePickeredView!
  
  @IBOutlet weak var validFromTxt: DatePickeredTextField!
  {
    didSet
    {
      validFromTxt.datepicker.maximumDate = Date()
    }
  }
  @IBOutlet weak var validUptoTxt: DatePickeredTextField!
  {
    didSet
    {
      validUptoTxt.datepicker.minimumDate = Date()
    }
  }
  
  @IBOutlet weak var pollution_Show_ImgView: UIImageView!
  @IBOutlet weak var validFromLb: UILabel!
  
  @IBOutlet weak var validUptoLb: UILabel!
  
  @IBOutlet weak var pollution_Show_View: UIView!
  {
    didSet{
      pollution_Show_View.isHidden = true
    }
  }
  @IBOutlet weak var pollution_Fill_View: UIView!
  var parentVehicle : VehicleDetails?
  var completion : ((Bool)->())?
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.addTapGestureToView()
    pollution_Fill_ImgView.parentViewController = self
    setupPollutionView()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func addBtnClicked(_ sender: UIButton) {
    addBtn.isHidden = true
    pollution_Show_View.isHidden = true
    pollution_Fill_View.isHidden = false
  }
  
  @IBAction func closeBtnClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  func setupPollutionView()
  {
    guard let pollutionResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: parentVehicle,entityName: .pollutionDetails) as? [PollutionTable] else {return}
    if pollutionResults.count > 0
    {//When data is present
      addBtn.isHidden = false
      pollution_Show_View.isHidden = false
      pollution_Fill_View.isHidden = true
      validUptoLb.text = pollutionResults.last?.validUpto
      validFromLb.text = pollutionResults.last?.validFrom
      if let data = pollutionResults.last?.pollutionImg
      {
        pollution_Show_ImgView.image = UIImage(data: data)
      }
    }
    else { // when data not present need to add
      addBtn.isHidden = true
      pollution_Show_View.isHidden = true
     pollution_Fill_View.isHidden = false
      
    }
  }
  @IBAction func saveBtnClicked(_ sender: UIButton) {
    guard validation() else {return}
    guard let selectedVehicle = parentVehicle else { return }
    let pollutionDetails = PollutionTable(context: CoreDataManager.shared.persistentContainer.viewContext)
   
    pollutionDetails.vehicle = selectedVehicle
    pollutionDetails.validFrom = validFromTxt.text
    pollutionDetails.validUpto = validUptoTxt.text
    pollutionDetails.pollutionImg = pollution_Fill_ImgView.image?.pngData()
    CoreDataManager.shared.saveContext()
    dismiss(animated: true) {
      self.completion?(true)
    }
  }
  func validation() -> Bool
  {
    guard pollution_Fill_ImgView.isImagePicked else {self.showAlert(message: "Please Capture Pollution Certificate Image");return false}
    guard validFromTxt.text?.count != 0 else {self.showAlert(message: "Please Enter valid from");return false}
    guard validUptoTxt.text?.count != 0 else {self.showAlert(message: "Please Enter valid Upto");return false}
    
    return true
  }
}
