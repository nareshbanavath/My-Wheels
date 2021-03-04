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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.addTapGestureToView()
    //vehicleNoTxt.addTarget(self, action: #selector(handleTextChangeInTF), for: .editingChanged)
    vehicleNoTxt.delegate = self
    yearTxt.delegate = self
    setupDropDownForFuelType()
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
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let vehicleData = VehicleDetails(context: context)
    vehicleData.make = makeTxt.text
    vehicleData.model = modelTxt.text
    vehicleData.vehicleNo = vehicleNoTxt.text
    vehicleData.year = yearTxt.text
    vehicleData.fuel = "petrol"
    CoreDataManager.shared.saveContext()
    dismiss(animated: true) { [unowned self] in
      completion?(true)
    }
    
  }
  @objc func handleTextChangeInTF(_ textField : UITextField)
  {
    //print(textField.text?.count)
    if textField.text?.count == 2
    {
    
      textField.keyboardType = .phonePad
      textField.reloadInputViews()
    }
    if textField.text?.count == 4
    {
      
      textField.keyboardType = .default
      textField.reloadInputViews()
    }
    if textField.text?.count == 6
    {
    
      textField.keyboardType = .phonePad
      textField.reloadInputViews()
    }
    textField.reloadInputViews()
    
  }

}
extension AddVehicleVC : UITextFieldDelegate
{
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var maxLength = 10
    if textField == yearTxt
    {
      maxLength = 4
    }
    
    let currentString: NSString = textField.text! as NSString
    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
    return newString.length <= maxLength
    
  }
}
