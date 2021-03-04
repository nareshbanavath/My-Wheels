//
//  PollutionCell.swift
//  MyWheels
//
//  Created by naresh banavath on 03/03/21.
//

import UIKit

class PollutionCell: UITableViewCell {
  
  static let identifier = "PollutionCell"
  @IBOutlet weak var validFromLb: UILabel!
  @IBOutlet weak var validUptoLb: UILabel!
  @IBOutlet weak var pollutionImg: UIImageView!
  var pollutionDetails : PollutionTable?
  {
    didSet
    {
      setupPollutionDetails()
    }
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func setupPollutionDetails() {
    self.validFromLb.text = pollutionDetails?.validFrom
    self.validUptoLb.text = pollutionDetails?.validUpto
   // self.agencyLb.text = insuranceDetails?.agency
    if let data = pollutionDetails?.pollutionImg
    {
      self.pollutionImg.image = UIImage(data: data)
    }
    
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
