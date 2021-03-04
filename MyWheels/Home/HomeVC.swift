//
//  HomeVC.swift
//  MyWheels
//
//  Created by deep chandan on 23/02/21.
//

import UIKit

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
  //MARK:- Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Wheels"
        self.setupNavigation()
        tableView.delegate = self
        tableView.dataSource = self
      getVehicleData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupnavbarButtons()
    }
  override func viewDidAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
    if let view = self.view.window {
          view.addSubview(faButton)
          setupButton()
      }
  }

  override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
    if let view = self.view.window, faButton.isDescendant(of: view) {
          faButton.removeFromSuperview()
      }
  }
  
  //MARK:- CoreData Methods
  func getVehicleData()
  {
    self.vehicleList = CoreDataManager.shared.loadVehiclesData()
    self.tableViewDataSource = self.vehicleList
    tableView.reloadData()
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
    vc.modalPresentationStyle = .overCurrentContext
    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    vc.definesPresentationContext = false
    vc.modalTransitionStyle = .crossDissolve
    vc.completion = { [unowned self](success) in
      self.getVehicleData()
    }
    present(vc, animated: true, completion: nil)
  }
    func setupnavbarButtons(){
        let searchImage  = UIImage(named: "export")!
        let sidemenuImage = UIImage(named: "menu")
        let selectAllButton = UIBarButtonItem(title: "Select all", style: .plain, target: nil, action: nil)
        selectAllButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        let shareButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: Selector(("didTapShareButton:")))
        shareButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        let menuButton = UIBarButtonItem(image: sidemenuImage,  style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItems =  [shareButton,selectAllButton]
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        

    }
    @objc func didTapSelectallButton(){
        
    }
    @objc func didTapShareButton(){
        
    }
    @objc func didTapMenuButton(){
        print("yiushgisifhjid")
       sideMenuController?.revealMenu()
    }
  
}

//MARK:- TableViewDelegate & DataSource
extension HomeVC : UITableViewDelegate , UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //self.list.count
      return tableViewDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
      cell.vehicleDetails = tableViewDataSource?[indexPath.row]
      cell.vehicleImgView.tag = indexPath.row
      cell.vehicleImgView.parentViewController = self
      cell.vehicleImgView.imagePickeredDelegate = self
        return cell
    }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDetailsVC") as! VehicleDetailsVC
    vc.vehicle = tableViewDataSource?[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
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
