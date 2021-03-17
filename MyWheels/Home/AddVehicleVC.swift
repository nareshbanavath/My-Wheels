//
//  AddVehicleVC.swift
//  MyWheels
//
//  Created by naresh banavath on 26/02/21.
//

import UIKit
import DropDown
class AddVehicleVC: UIViewController {

  //MARK:- Properties
  @IBOutlet weak var vehicleNoTxt: UITextField!
  @IBOutlet weak var makeTxt: UITextField!
  @IBOutlet weak var modelTxt: UITextField!
  @IBOutlet weak var yearTxt: UITextField!
  @IBOutlet weak var fuelTypeTxt: UITextField!
  var completion : ((Bool)->())?
  let dropDown = DropDown()
  let dropDownDatasource : [String] = ["Fuel Type" , "Petrol" , "Diesel" , "Gas" , "Electric"]
  
  @IBOutlet weak var saveBtn: UIButton!
  {
    didSet
    {
      saveBtn.layer.cornerRadius = saveBtn.bounds.height / 2
      saveBtn.layer.shadowColor = UIColor.gray.cgColor
      saveBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
      saveBtn.layer.shadowRadius = 5.0
      saveBtn.layer.shadowOpacity = 0.7
    }
  }
  override func viewDidLoad() {
        super.viewDidLoad()
    self.addTapGestureToView()
    vehicleNoTxt.addTarget(self, action: #selector(handleTextChangeInTF), for: .editingChanged)
    vehicleNoTxt.delegate = self
    yearTxt.delegate = self
    setupDropDownForFuelType()
    vehicleNoTxt.autocapitalizationType = .allCharacters
    vehicleNoTxt.clearButtonMode = .whileEditing
    fuelTypeTxt.text = dropDownDatasource[0]
        // Do any additional setup after loading the view.
    }
  
  @IBAction func closeBtnClicked(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
 //MARK:- Helper Methods
  func setupDropDownForFuelType()
  {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlefuelTypeTxtClicked))
    fuelTypeTxt.addGestureRecognizer(tapGesture)
    fuelTypeTxt.tintColor = .clear
    fuelTypeTxt.inputView = UIView()
    dropDown.anchorView = fuelTypeTxt
    dropDown.dataSource = dropDownDatasource
   // dropDown.show()
    dropDown.selectionAction = {[weak self] (index , item) in
      self?.fuelTypeTxt.text = item
      self?.dropDown.hide()
      self?.fuelTypeTxt.endEditing(true)
    }
  }
  @objc func handlefuelTypeTxtClicked()
  {
    dropDown.show()
  }
  @IBAction func saveBtnAction(_ sender: UIButton) {
    
    guard validation() else {
      return
    }
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let vehicleData = VehicleDetails(context: context)
    vehicleData.make = makeTxt.text
    vehicleData.model = modelTxt.text
    vehicleData.vehicleNo = vehicleNoTxt.text
    vehicleData.year = yearTxt.text
    vehicleData.fuel = fuelTypeTxt.text
    CoreDataManager.shared.saveContext()
    dismiss(animated: true) { [unowned self] in
      completion?(true)
    }
    
  }
   func validation() -> Bool
   {
    guard vehicleNoTxt.text?.count != 0 else{self.showAlert(message: "Please Enter Vehicle No");return false}
    guard makeTxt.text?.count != 0 else {self.showAlert(message: "Please Enter Vehicle Make");return false}
    guard modelTxt.text?.count != 0 else {self.showAlert(message: "Please Enter Vehicle Model");return false}
    guard yearTxt.text?.count != 0 else {self.showAlert(message: "Please Enter Year");return false}
    guard fuelTypeTxt.text != "Fuel Type" else {self.showAlert(message: "Please Select FuelType");return false}
    return true
   }
  
  
  @objc func handleTextChangeInTF(_ textField : UITextField)
  {
    print(textField.text?.count ?? 0)
    if textField.text?.count == 0
    {
      vehicleNoTxt.keyboardType = .default
      vehicleNoTxt.autocapitalizationType = .allCharacters
      vehicleNoTxt.reloadInputViews()
    }
    if textField.text?.count == 2
    {
      vehicleNoTxt.text?.append(" ")
      vehicleNoTxt.keyboardType = .phonePad
      vehicleNoTxt.reloadInputViews()
    }
    if textField.text?.count == 5
    {
      vehicleNoTxt.text?.append(" ")
      vehicleNoTxt.keyboardType = .default
      vehicleNoTxt.autocapitalizationType = .allCharacters
      vehicleNoTxt.reloadInputViews()
    }
    if textField.text?.count == 8
    {
      //vehicleNoTxt.text?.remove(at: 8)
    
      vehicleNoTxt.text?.append(" ")
      vehicleNoTxt.keyboardType = .phonePad
  
      vehicleNoTxt.reloadInputViews()
    }
 
    //vehicleNoTxt.reloadInputViews()
    
  }

}
extension AddVehicleVC : UITextFieldDelegate
{
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var maxLength = 13
    if textField == yearTxt
    {
      maxLength = 4
    }
    
    let currentString: NSString = textField.text! as NSString
    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
    return newString.length <= maxLength
    
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    if textField == vehicleNoTxt
    {
      print(textField.text?.count ?? 0)
    }
    return true
  }
  
}
