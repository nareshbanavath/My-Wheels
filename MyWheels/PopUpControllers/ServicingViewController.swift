//
//  ServicingViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 27/02/21.
//

import UIKit

class ServicingViewController: UIViewController {
  //MARK:- Properties
  
  @IBOutlet weak var others_Show_Btn: UIButton!
  @IBOutlet weak var gs_Show_Btn: UIButton!
  @IBOutlet weak var others_Fill_Btn: UIButton!
  @IBOutlet weak var gs_Fill_Btn: UIButton!
  @IBOutlet weak var closeBtn: UIButton!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var servicing_Fill_View: UIView!
  @IBOutlet weak var servicingDateTxt: UITextField!
  
  @IBOutlet weak var netServicingDateTxt: UITextField!
  
  @IBOutlet weak var servicingAtKmTxt: UITextField!
  @IBOutlet weak var nextServicingAtKmTxt: UITextField!
  @IBOutlet weak var gsAmountTxt: UITextField!
  {
    didSet{
      //initially hidden
      gsAmountTxt.isHidden = true
    }
  }
  
  @IBOutlet weak var osAmountTxt: UITextField!
  {
    didSet{
      //initially hidden
      osAmountTxt.isHidden = true
    }
  }
  
  @IBOutlet weak var servicesTxtView: UITextView!
  {
    didSet{
      //initially hidden
      servicesTxtView.isHidden = true
      servicesTxtView.layer.cornerRadius = 5.0
      servicesTxtView.layer.borderWidth = 1.0
      servicesTxtView.layer.borderColor = UIColor.gray.cgColor
    }
  }
  //ShowView
  @IBOutlet weak var servicing_show_view: UIView!
  {
    didSet
    {
      servicing_show_view.isHidden = true
    }
  }
  
  @IBOutlet weak var servicingDateLb: UILabel!
  @IBOutlet weak var nextServicingDateLb: UILabel!
  
  @IBOutlet weak var services_Fill_Lb: UILabel!
  @IBOutlet weak var servicesLb: UILabel!
  @IBOutlet weak var osAmountLb: UILabel!
  @IBOutlet weak var gsAmountLb: UILabel!
  @IBOutlet weak var nextServicingAtKmLb: UILabel!
  @IBOutlet weak var servicingAtKmLb: UILabel!
  
  var parentVehicle : VehicleDetails?
  var completion : ((Bool) -> ())?
  
  override func viewDidLoad() {
        super.viewDidLoad()
   
    services_Fill_Lb.isHidden = true
    self.addTapGestureToView()
    setupServicingView()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func saveBtnClicked(_ sender: UIButton) {
    guard let selectedVehicle = parentVehicle else { return }
    let servicingDetails = ServicingTable(context: CoreDataManager.shared.persistentContainer.viewContext)
   
    servicingDetails.vehicle = selectedVehicle
    servicingDetails.servicingDate = servicingDateTxt.text
    servicingDetails.nextServicingDate = netServicingDateTxt.text
    servicingDetails.servicingAtKm = servicingAtKmTxt.text
    servicingDetails.nextServicingAtKm = nextServicingAtKmTxt.text
    servicingDetails.generalServiceFlag = gs_Fill_Btn.isSelected
    servicingDetails.othersFlag = others_Fill_Btn.isSelected
    servicingDetails.gsAmount = gsAmountTxt.text
    servicingDetails.osAmount = osAmountTxt.text
    servicingDetails.services = servicesTxtView.text
   // servicingDetails.
    CoreDataManager.shared.saveContext()
    dismiss(animated: true) {
      self.completion?(true)
    }

  }
  func setupServicingView()
  {
    guard let servicingResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: parentVehicle,entityName: .servicingDetails) as? [ServicingTable] else {return}
    if servicingResults.count > 0
    {//When data is present
      addBtn.isHidden = false
      servicing_show_view.isHidden = false
      servicing_Fill_View.isHidden = true
      //
      servicingDateLb.text = servicingResults.last?.servicingDate
      nextServicingDateLb.text = servicingResults.last?.nextServicingDate
      servicingAtKmLb.text = servicingResults.last?.servicingAtKm
      nextServicingAtKmLb.text = servicingResults.last?.nextServicingAtKm
     
      gs_Show_Btn.isSelected = servicingResults.last?.generalServiceFlag ?? false
      others_Show_Btn.isSelected = servicingResults.last?.othersFlag ?? false
    
      gsAmountLb.superview?.isHidden = !gs_Show_Btn.isSelected //hide gsAmountStackView
      servicesLb.superview?.isHidden = !others_Show_Btn.isSelected // hide servicesLb superview when othersBtn not selected
      osAmountLb.superview?.isHidden = !others_Show_Btn.isSelected
      gsAmountLb.text = servicingResults.last?.gsAmount
      osAmountLb.text = servicingResults.last?.osAmount
      servicesLb.text = servicingResults.last?.services
      if gs_Show_Btn.isSelected == false && others_Show_Btn.isSelected == false
      {
        gs_Show_Btn.superview?.isHidden = true
      }
    
    }
    else { // when data not present need to add
      addBtn.isHidden = true
      servicing_show_view.isHidden = true
      servicing_Fill_View.isHidden = false
      
    }
  }
  @IBAction func closeBtnClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func gsBtnClicked(_ sender: UIButton) {
    sender.isSelected.toggle()
    //if generalService is selected then gsAmountTxt hidden = false else true
    gsAmountTxt.isHidden = sender.isSelected ? false : true
    UIView.animate(withDuration: 0.250, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
   
  }
  @IBAction func othersBtnClicked(_ sender: UIButton) {
    sender.isSelected.toggle()
    servicesTxtView.isHidden = sender.isSelected ? false : true
    osAmountTxt.isHidden = sender.isSelected ? false : true
    services_Fill_Lb.isHidden = sender.isSelected ? false : true
    UIView.animate(withDuration: 0.250, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: nil)
    
  }
  @IBAction func addBtnClicked(_ sender: UIButton) {
    addBtn.isHidden = true
    servicing_Fill_View.isHidden = false
    servicing_show_view.isHidden = true
  }
}
