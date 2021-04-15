//
//  HomeVC.swift
//  MyWheels
//
//  Created by deep chandan on 23/02/21.
//

import UIKit
import CoreData
class HomeVC: UIViewController {
  //MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
  var tableViewDataSource : [VehicleDetails]?
  var vehicleList : [VehicleDetails]?
  lazy var faButton: UIButton = {
      let button = UIButton(frame: .zero)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.backgroundColor = .systemPink
      button.addTarget(self, action: #selector(fabTapped(_:)), for: .touchUpInside)
      return button
  }()
//  var dataSource = UITableViewDiffableDataSource<Int,VehicleDetails>()
  //MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Wheels"
        self.setupNavigation()
        tableView.delegate = self
        tableView.dataSource = self
        getVehicleData()
     // debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.setupnavbarButtons()
      let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(fabTapped(_:)))
      self.navigationItem.setRightBarButtonItems([addBtn], animated: true)
      self.navigationController?.navigationBar.tintColor = .white
    }
  override func viewDidAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    setupnavbarButtons()
//    if let view = self.view.window {
//          view.addSubview(faButton)
//          setupButton()
//      }
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
//    if let view = self.view.window, faButton.isDescendant(of: view) {
//          faButton.removeFromSuperview()
//      }
  }
  //MARK:- Diffable DataSource methods
//  func makeDataSource()
//  {
//    let dataSource = UITableViewDiffableDataSource<Int , VehicleDetails>(tableView: tableView) { [self](tableView, indexPath, vehicleDetails) -> UITableViewCell? in
//      let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
//    cell.vehicleDetails = tableViewDataSource?[indexPath.row]
//    cell.vehicleImgView.tag = indexPath.row
//    cell.vehicleImgView.parentViewController = self
//    cell.vehicleImgView.imagePickeredDelegate = self
//      return cell
//    }
//  }
  //MARK:- CoreData Methods
  func getVehicleData()
  {
    self.vehicleList = CoreDataManager.shared.loadVehiclesData()
    self.tableViewDataSource = self.vehicleList
    tableView.reloadData()
  //  let lastIndex = tableView.numberOfRows(inSection: 0) - 1
    //let indexPath = IndexPath(row: lastIndex, section: 0)
    
   // tableView.scrollToRow(at: indexPath, at: .none, animated: true)
  }
  //MARK:- Helper Methods
  func setupButton() {
    NSLayoutConstraint.activate([
      faButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
      faButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
      faButton.heightAnchor.constraint(equalToConstant: 60),
      faButton.widthAnchor.constraint(equalToConstant: 60)
    ])
    faButton.layer.cornerRadius = 30
    faButton.setImage(#imageLiteral(resourceName: "plusIcon"), for: .normal)
    faButton.tintColor = .white
    faButton.layer.masksToBounds = true
    // faButton.layer.borderColor = UIColor.lightGray.cgColor
    // faButton.layer.borderWidth = 4
  }
  
  
  @objc func fabTapped(_ button: UIButton) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVehicleVC") as! AddVehicleVC
    vc.modalPresentationStyle = .automatic
    vc.view.backgroundColor = UIColor.clear
    vc.definesPresentationContext = false
    vc.modalTransitionStyle = .coverVertical
    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    vc.completion = { [unowned self](success) in
      self.getVehicleData()
    }
    present(vc, animated: true, completion: nil)
  }
    func setupnavbarButtons(){
       // let searchImage  = UIImage(named: "export")!
        let menuImg = UIImage(named: "menu")
        let menuButton = UIBarButtonItem(image: menuImg,  style: .plain, target: self, action: #selector(didTapMenuButton))
    //  menuButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: -5)
       // navigationItem.rightBarButtonItems =  [shareButton,selectAllButton]
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        

    }

    @objc func didTapMenuButton(){
        //print("yiushgisifhjid")
       sideMenuController?.revealMenu()
    }
    @objc func editBtnClicked(_ sender : UIButton)
    {
        let row = sender.tag
        let vehicleDetailss = tableViewDataSource?[row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVehicleVC") as! AddVehicleVC
        vc.modalPresentationStyle = .automatic
        vc.view.backgroundColor = UIColor.clear
        vc.definesPresentationContext = false
        vc.modalTransitionStyle = .coverVertical
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        vc.vehicleDetail = vehicleDetailss
        vc.completion = { [unowned self](success) in
          self.getVehicleData()
        }
        present(vc, animated: true, completion: nil)
        
    }
  
}

//MARK:- TableViewDelegate & DataSource
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.list.count
        if tableViewDataSource?.count == 0 {
             self.tableView.setEmptyMessage("No Records Found")
         } else {
             self.tableView.restore()
         }
        return tableViewDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  print(indexPath.row)
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell" , for: indexPath) as! HomeTableViewCell
        cell.vehicleDetails = tableViewDataSource?[indexPath.row]
        cell.vehicleImgView.tag = indexPath.row
        cell.vehicleImgView.parentViewController = self
        cell.vehicleImgView.imagePickeredDelegate = self
        cell.editIcon.tag = indexPath.row
        cell.editIcon.addTarget(self, action: #selector(editBtnClicked(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
        vc.vehicle = tableViewDataSource?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.3, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }
    }
    
}
extension HomeVC : ImagePickeredViewDelegate
{
  func didFinishPicking(_ image: UIImage, imageView: UIImageView?) {
        guard let rowNo = imageView?.tag else { return }
    self.vehicleList?[rowNo].vehiclePhoto = image.pngData()
    CoreDataManager.shared.saveContext()
  }
  
 
  
  
}
