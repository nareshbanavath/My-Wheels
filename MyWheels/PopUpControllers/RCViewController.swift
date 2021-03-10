//
//  RCViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 26/02/21.
//

import UIKit
import CoreData
class RCViewController: UIViewController {

  
  //rcDetailsFillView
  @IBOutlet weak var rcValidUpto: DatePickeredTextField!
  {
    didSet
    {
      rcValidUpto.datepicker.minimumDate = Date()
    }
  }
  @IBOutlet weak var rcBack_Fill_ImgView: ImagePickeredView!
  @IBOutlet weak var rcFront_Fill_ImgView: ImagePickeredView!
  @IBOutlet weak var closeBtn: UIButton!
  @IBOutlet weak var addBtn: UIButton!
  {
    didSet
    {
      addBtn.isHidden = true
    }
  }

  @IBOutlet weak var rcBack_Show_ImageView: UIImageView!
  @IBOutlet weak var rcFront_Show_ImageView: UIImageView!
  @IBOutlet weak var rcDetailsFillView: UIView!
  var parentVehicle : VehicleDetails?
  var completion : ((Bool)->())?
  //rcDetailShowView Properties
  @IBOutlet weak var rcDetailsShowView: UIView!
  {
    didSet
    {
      rcDetailsShowView.isHidden = true
    }
  }
  @IBOutlet weak var rcFront_Show_ImgView: UIImageView!
  
  @IBOutlet weak var rcBack_Show_ImgView: UIImageView!
  
  @IBOutlet weak var rcValidUptoLb: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    self.addTapGestureToView()
    rcFront_Fill_ImgView.parentViewController = self
    rcBack_Fill_ImgView.parentViewController = self
    setupView()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func saveBtnClicked(_ sender: UIButton) {
   // if rcBack_Fill_ImgView.
//    NSEntityDescription.entity(forEntityName: "", in: ""
    guard validation() else {return}
    let rcDetails = RCDetailsTable(context: CoreDataManager.shared.persistentContainer.viewContext)
    guard let selectedVehicle = parentVehicle else { return }
    rcDetails.vehicle = selectedVehicle
    rcDetails.rcValidUpto = rcValidUpto.text
    rcDetails.rcFrontImg = rcBack_Fill_ImgView.image?.pngData()
    rcDetails.rcBackImg = rcFront_Fill_ImgView.image?.pngData()
    DispatchQueue.global(qos: .userInteractive).async {
      CoreDataManager.shared.saveContext()
    }
   
    let delegate = UIApplication.shared.delegate as? AppDelegate
    delegate?.scheduleLocalNotification(title: "RC Details", body: "Last Date for RC", date: rcValidUpto.completeDate ?? "")
  
    DispatchQueue.main.async {
      self.dismiss(animated: true)
    }
    self.completion?(true)

    
  }
  func validation() -> Bool {
    guard rcFront_Fill_ImgView.isImagePicked == true else {self.showAlert(message: "Please Capture RC Front Image");return false}
    guard rcBack_Fill_ImgView.isImagePicked == true else {self.showAlert(message: "Please Capture RC Back Image");return false}
    guard rcValidUpto.text?.count != 0 else {self.showAlert(message: "Please Capture RC Back Image");return false}
    return true
  }

  func setupView(){
    guard let rcResults = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: parentVehicle,entityName: .rcDetails) as? [RCDetailsTable] else {return}
    if rcResults.count > 0 //When have data need show rcDetails_Show_View
    {
      //
      rcValidUptoLb.text = rcResults.last?.rcValidUpto
      if let imgDataBack = rcResults.last?.rcBackImg
      {
        self.rcBack_Show_ImgView.image = UIImage(data: imgDataBack)
      }
      if let imgDataFront = rcResults.last?.rcFrontImg
      {
        self.rcFront_Show_ImgView.image = UIImage(data: imgDataFront)
      }
      rcDetailsFillView.isHidden = true
      rcDetailsShowView.isHidden = false
      addBtn.isHidden = false
    }else {
      rcDetailsFillView.isHidden = false
      rcDetailsShowView.isHidden = true
      addBtn.isHidden = true
    }
  }
  
  @IBAction func closeBtnClicked(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func addBtnClicked(_ sender: UIButton) {
    addBtn.isHidden = true
    rcDetailsShowView.isHidden = true
    rcDetailsFillView.isHidden = false    
  }
}
