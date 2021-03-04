//
//  InsuranceViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit

class InsuranceViewController: UIViewController {

  @IBOutlet weak var insurance_Fill_ImgView: ImagePickeredView!
  @IBOutlet weak var closeBtn: UIButton!
  @IBOutlet weak var validFromTxt: UITextField!
  @IBOutlet weak var addBtn: UIButton!
  {
    didSet
    {
      //initially addBtn is hidden
      addBtn.isHidden = true
    }
  }
  @IBOutlet weak var validUptoTxt: UITextField!
  @IBOutlet weak var agencyTxt: UITextField!
  @IBOutlet weak var amountPaidTxt: UITextField!
  
  @IBOutlet weak var insurance_Show_imgView: UIImageView!
  @IBOutlet weak var validFromLb: UILabel!
  @IBOutlet weak var validUptoLb: UILabel!
  @IBOutlet weak var agencyLb: UILabel!
  @IBOutlet weak var amountPaidLb: UILabel!
  
  @IBOutlet weak var insurance_Show_View: UIView!
  {
    didSet
    {
      insurance_Show_View.isHidden = true
    }
  }
  
  @IBOutlet weak var insurance_Fill_View: UIView!
  var parentVehicle : VehicleDetails?
  var completion : ((Bool)->())?
  override func viewDidLoad() {
        super.viewDidLoad()
    self.addTapGestureToView()
    insurance_Fill_ImgView.parentViewController = self
    setupInsuranceView()
        // Do any additional setup after loading the view.
    }
    

  @IBAction func closeBtnClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addBtnClicked(_ sender: UIButton) {
    addBtn.isHidden = true
    insurance_Show_View.isHidden = true
    insurance_Fill_View.isHidden = false
  }
  func setupInsuranceView()
  {
    guard let insuranceResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: parentVehicle,entityName: .insuranceDetails) as? [InsuranceTable] else {return}
    if insuranceResults.count > 0
    {//When data is present
      addBtn.isHidden = false
      insurance_Show_View.isHidden = false
      insurance_Fill_View.isHidden = true
      validUptoLb.text = insuranceResults.last?.validUpto
      validFromLb.text = insuranceResults.last?.validFrom
      agencyLb.text = insuranceResults.last?.agency
      amountPaidLb.text = insuranceResults.last?.amountPaid
      if let data = insuranceResults.last?.insuranceImg
      {
        insurance_Show_imgView.image = UIImage(data: data)
      }
    }
    else { // when data not present need to add
      addBtn.isHidden = true
      insurance_Show_View.isHidden = true
      insurance_Fill_View.isHidden = false
      
    }
  }
  @IBAction func saveBtnAction(_ sender: UIButton) {
    guard let selectedVehicle = parentVehicle else { return }
    let insuranceDetails = InsuranceTable(context: CoreDataManager.shared.persistentContainer.viewContext)
   
    insuranceDetails.vehicle = selectedVehicle
    insuranceDetails.validFrom = validFromTxt.text
    insuranceDetails.validUpto = validUptoTxt.text
    insuranceDetails.agency = agencyTxt.text
    insuranceDetails.amountPaid = amountPaidTxt.text
    insuranceDetails.insuranceImg = insurance_Fill_ImgView.image?.pngData()
    CoreDataManager.shared.saveContext()
    dismiss(animated: true) {
      self.completion?(true)
    }
  }
}
