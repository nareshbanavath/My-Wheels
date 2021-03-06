//
//  ViewController.swift
//  MyWheels
//
//  Created by naresh banavath on 03/03/21.
//

import UIKit
import CoreData
class VehicleDetailsVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var vehicle : VehicleDetails!
  var tableViewDataSource : [[NSManagedObject]] = []
  override func viewDidLoad() {
        super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.separatorColor = .none
    getAllData(for: vehicle)
        // Do any additional setup after loading the view.
    }
  func getAllData(for vehicle : VehicleDetails)
  {
    if let insuranceData = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicle, entityName: .insuranceDetails) as? [InsuranceTable] , insuranceData.count > 0
    {
      tableViewDataSource.append(insuranceData)
    }
    if let pollutionData = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicle, entityName: .pollutionDetails) as? [PollutionTable] , pollutionData.count > 0
    {
      tableViewDataSource.append(pollutionData)
    }
    if let servicingData = CoreDataManager.shared.getManagedObjectsForVehicle(vehicleEntity: vehicle, entityName: .servicingDetails) as? [ServicingTable] , servicingData.count > 0
    {
      tableViewDataSource.append(servicingData)
    }
//    print(tableViewDataSource)
    tableView.reloadData()
  }
  func titleForManagedObject(obj : NSManagedObject) -> String
  {
    switch obj {
    case is InsuranceTable:
      return "Insurance Details"
    case is PollutionTable:
      return "Pollution Details"
    case is ServicingTable:
      return "Servicing Details"
    default:
      return ""
    }
  }

}
extension VehicleDetailsVC : UITableViewDataSource , UITableViewDelegate
{
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewDataSource.count
  }
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableViewDataSource[section].count
  }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width, height: 40))
    //view.backgroundColor = UIColor(named: "appColor")
    view.backgroundColor = UIColor.systemGray6
    view.layer.cornerRadius = 2.0
    let titleLabel = UILabel(frame: .zero)
    //titleLabel.textColor = UIColor.white
    titleLabel.textColor = UIColor(named: "appColor")
    titleLabel.font = UIFont.systemFont(ofSize: 17.0 ,weight: .semibold)
    if let obje = tableViewDataSource[section].first
    {
      titleLabel.text = titleForManagedObject(obj: obje)
    }
   
    view.addSubview(titleLabel)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
          titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
          titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
          titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
          
    ])
    return view
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //return UITableViewCell()
    let sectionItem = tableViewDataSource[indexPath.section]
    switch titleForManagedObject(obj: sectionItem[0]){
    case "Insurance Details":
      let cell = tableView.dequeueReusableCell(withIdentifier: InsuranceCell.identifier) as! InsuranceCell
      cell.insuranceDetails = (sectionItem[indexPath.row] as! InsuranceTable)
      return cell
    case "Pollution Details":
      let cell = tableView.dequeueReusableCell(withIdentifier: PollutionCell.identifier) as! PollutionCell
      cell.pollutionDetails = (sectionItem[indexPath.row] as! PollutionTable)
      return cell
    case "Servicing Details":
      let cell = tableView.dequeueReusableCell(withIdentifier: ServicingDetailsCell.identifier) as! ServicingDetailsCell
      cell.servicingDetails = (sectionItem[indexPath.row] as! ServicingTable)
      return cell
      
    default:
      return UITableViewCell()
    }
  }
  
  
}
