//
//  HomeTableViewCell.swift
//  MyWheels
//
//  Created by deep chandan on 26/02/21.
//

import UIKit
import CoreData

class HomeTableViewCell: UITableViewCell {
  
  //MARK:- Properties
  
  @IBOutlet weak var vehicleImgView: ImagePickeredView!

  @IBOutlet weak var servicingPlusIcon: UIImageView!
  @IBOutlet weak var pollutionPlusIcon: UIImageView!
  @IBOutlet weak var insurancePlusIcon: UIImageView!
  @IBOutlet weak var rcPlusIcon: UIImageView!
  @IBOutlet weak var vehicleNoLb: UILabel!
  @IBOutlet weak var servicingAddLb: UILabel!
  @IBOutlet weak var pollutionAddLb: UILabel!
  @IBOutlet weak var insuranceAddLb: UILabel!
  @IBOutlet weak var rcAddLb: UILabel!
  @IBOutlet weak var makeLb: UILabel!
  @IBOutlet weak var modelLb: UILabel!
  @IBOutlet weak var yearLb: UILabel!
  @IBOutlet weak var fuelLb: UILabel!
  @IBOutlet weak var rcView: UIView!
  @IBOutlet weak var insuranceView: UIView!
  @IBOutlet weak var pollutionView: UIView!
  @IBOutlet weak var servicingView: UIView!
  var vehicleDetails : VehicleDetails?
  {
    didSet{
      setupVehicleDetails()
    }
  }
  //MARK:- Override Func
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(rcViewTapped(_:)))
    rcView.addGestureRecognizer(tapGesture1)
    let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(insuranceViewTapped(_:)))
    insuranceView.addGestureRecognizer(tapGesture2)
    let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(pollutionViewTapped(_:)))
    pollutionView.addGestureRecognizer(tapGesture3)
    let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(servicingViewTapped(_:)))
    servicingView.addGestureRecognizer(tapGesture4)
  }
  //MARK:- ViewTapActions
  @objc func rcViewTapped(_ tapGesture : UITapGestureRecognizer)
  {
    print(#function)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RCViewController") as! RCViewController
    vc.parentVehicle = vehicleDetails
    vc.completion = { [weak self] (success)in
      if success
      {
        self?.setupRcDetails()
      }

    }
    vc.definesPresentationContext = true
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    
    //    vc.view.backgroundColor =
    let rootViewController = window?.rootViewController
    rootViewController?.present(vc, animated: true, completion: nil)
  }
  @objc func insuranceViewTapped(_ tapGesture : UITapGestureRecognizer)
  {
    print(#function)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InsuranceViewController") as! InsuranceViewController
    vc.parentVehicle = vehicleDetails
    vc.completion = { [weak self] (success)in
      if success
      {
        self?.setupInsuranceDetails()
      }

    }
    vc.definesPresentationContext = true
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    //    vc.view.backgroundColor =
    let rootViewController = window?.rootViewController
    rootViewController?.present(vc, animated: true, completion: nil)
  }
  @objc func pollutionViewTapped(_ tapGesture : UITapGestureRecognizer)
  {
    print(#function)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PollutionViewController") as! PollutionViewController
    vc.parentVehicle = vehicleDetails
    vc.completion = { [weak self] (success)in
      if success
      {
        self?.setupPollutionDetails()
      }

    }
    vc.definesPresentationContext = true
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    //    vc.view.backgroundColor =
    let rootViewController = window?.rootViewController
    rootViewController?.present(vc, animated: true, completion: nil)
  }
  @objc func servicingViewTapped(_ tapGesture : UITapGestureRecognizer)
  {
   // ServicingViewController
    print(#function)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServicingViewController") as! ServicingViewController
    vc.parentVehicle = vehicleDetails
    vc.completion = { [weak self] (success)in
      if success
      {
        self?.setupServicingDetails()
      }

    }
    vc.definesPresentationContext = true
    vc.modalPresentationStyle = .overCurrentContext
    vc.modalTransitionStyle = .crossDissolve
    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    //    vc.view.backgroundColor =
    let rootViewController = window?.rootViewController
    rootViewController?.present(vc, animated: true, completion: nil)
  }
  //MARK:- Helper Methods
  func setupVehicleDetails()
  {
    if let data = vehicleDetails?.vehiclePhoto
    {
      self.vehicleImgView.image = UIImage(data: data)
    }
    
    self.vehicleNoLb.text = vehicleDetails?.vehicleNo
    self.makeLb.text = vehicleDetails?.make
    self.modelLb.text = vehicleDetails?.model
    self.yearLb.text = vehicleDetails?.year
    self.fuelLb.text = vehicleDetails?.fuel
    setupRcDetails()
    setupInsuranceDetails()
    setupPollutionDetails()
    setupServicingDetails()
  }
  //returns color and no.Of days validity fro views in vehicle cell
  func getColorAndDays(for date : String) -> (UIColor , String)?
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    guard let date = dateFormatter.date(from: date) else { return nil}
    let currentDateStr = dateFormatter.string(from: Date())
    guard let currentDate = dateFormatter.date(from: currentDateStr) else {return nil}
    guard let count = Calendar.current.dateComponents([.day], from: currentDate, to: date).day else {return nil}
    switch count {
    case 0..<7:
      return (UIColor.red , String(count))
    case 7..<15:
      return (UIColor.orange , String(count))
    case 15... :
      return (UIColor.green , String(count))
    default:
      return nil
    }
   // print(count)
   
    
    
    
  }
  //MARK:- Coredata funcs
  func setupRcDetails(){
    guard let rcResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicleDetails,entityName: .rcDetails) as? [RCDetailsTable] else {return}
    if rcResults.count > 0
    {
      //getting last component (latest one) from array
      guard let rcValidUpto = rcResults.last?.rcValidUpto else {return}
      guard let colorAndDays = getColorAndDays(for: rcValidUpto) else {return}
      rcPlusIcon.isHidden = true
      rcAddLb.textColor = .black
      rcAddLb.text = "\(colorAndDays.1) days" //colorAndDays.1 //no.Of days count
      rcView.backgroundColor = colorAndDays.0 // color
      
    }
  }
  func setupInsuranceDetails()
  {
    guard let insuranceResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicleDetails,entityName: .insuranceDetails) as? [InsuranceTable] else {return}
    if insuranceResults.count > 0
    {
      //getting last component (latest one) from array
      guard let validUpto = insuranceResults.last?.validUpto else {return}
      guard let colorAndDays = getColorAndDays(for: validUpto) else {return}
      insurancePlusIcon.isHidden = true
      insuranceAddLb.textColor = .black
      insuranceAddLb.text = "\(colorAndDays.1) days"
      insuranceView.backgroundColor = colorAndDays.0 // color
      
    }
  }
  func setupPollutionDetails(){
    guard let pollutionResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicleDetails,entityName: .pollutionDetails) as? [PollutionTable] else {return}
    if pollutionResults.count > 0
    {
      //getting last component (latest one) from array
      guard let validUpto = pollutionResults.last?.validUpto else {return}
      guard let colorAndDays = getColorAndDays(for: validUpto) else {return}
      pollutionPlusIcon.isHidden = true
      pollutionAddLb.textColor = .black
      pollutionAddLb.text = "\(colorAndDays.1) days"
      pollutionView.backgroundColor = colorAndDays.0 // color
      
    }
  }
  
  func setupServicingDetails(){
    guard let servicingResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicleDetails,entityName: .servicingDetails) as? [ServicingTable] else {return}
    if servicingResults.count > 0
    {
      //getting last component (latest one) from array
      guard let validUpto = servicingResults.last?.nextServicingDate else {return}
      guard let colorAndDays = getColorAndDays(for: validUpto) else {return}
      servicingPlusIcon.isHidden = true
      servicingAddLb.textColor = .black
      servicingAddLb.text = "\(colorAndDays.1) days"
      servicingView.backgroundColor = colorAndDays.0 // color
      
    }
  }

  
  
}
