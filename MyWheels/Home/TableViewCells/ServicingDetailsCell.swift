//
//  ServicingDetailsCell.swift
//  MyWheels
//
//  Created by naresh banavath on 03/03/21.
//

import UIKit

class ServicingDetailsCell: UITableViewCell {

  static let identifier = "ServicingDetailsCell"
  
  @IBOutlet weak var servicesLb: UILabel!
  @IBOutlet weak var osAmountLb: UILabel!
  @IBOutlet weak var gsAmountLb: UILabel!
  @IBOutlet weak var nextServicingAtKmLb: UILabel!
  @IBOutlet weak var servicingAtKmLb: UILabel!
  @IBOutlet weak var nextServicingDateLb: UILabel!
  @IBOutlet weak var servicingDateLb: UILabel!
  var servicingDetails : ServicingTable?
  {
    didSet
    {
      setupServicingDetails()
    }
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func setupServicingDetails()
  {
    servicingDateLb.text = servicingDetails?.servicingDate
    nextServicingDateLb.text = servicingDetails?.nextServicingDate
    servicingAtKmLb.text = servicingDetails?.servicingAtKm
    nextServicingAtKmLb.text = servicingDetails?.nextServicingAtKm
    gsAmountLb.superview?.isHidden = !(servicingDetails?.generalServiceFlag ?? false)
    osAmountLb.superview?.isHidden = !(servicingDetails?.othersFlag ?? false)
    servicesLb.superview?.isHidden = !(servicingDetails?.othersFlag ?? false)
    gsAmountLb.text = servicingDetails?.gsAmount
    osAmountLb.text = servicingDetails?.osAmount
    servicesLb.text = servicingDetails?.services
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
