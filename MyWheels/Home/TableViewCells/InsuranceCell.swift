//
//  InsuranceCell.swift
//  MyWheels
//
//  Created by naresh banavath on 03/03/21.
//

import UIKit

class InsuranceCell: UITableViewCell {

  static let identifier = "InsuranceCell"
  @IBOutlet weak var insuranceImg: UIImageView!
  @IBOutlet weak var agencyLb: UILabel!
  @IBOutlet weak var validUptoLb: UILabel!
  @IBOutlet weak var validFromLb: UILabel!
  var insuranceDetails : InsuranceTable?
  {
    didSet
    {
      setupInsuranceDetails()
    }
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func setupInsuranceDetails() {
    self.validFromLb.text = insuranceDetails?.validFrom
    self.validUptoLb.text = insuranceDetails?.validUpto
    self.agencyLb.text = insuranceDetails?.agency
    if let data = insuranceDetails?.insuranceImg
    {
      self.insuranceImg.image = UIImage(data: data)
    }
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
