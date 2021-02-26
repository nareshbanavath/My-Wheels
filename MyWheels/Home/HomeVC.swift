//
//  HomeVC.swift
//  MyWheels
//
//  Created by deep chandan on 23/02/21.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var list = ["Home","Home","Home","Home"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Wheels"
        self.setupNavigation()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupnavbarButtons()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        return cell
    }
}
