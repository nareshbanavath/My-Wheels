//
//  ddd.swift
//  MyWheels
//
//  Created by naresh banavath on 26/02/21.
//

import UIKit
protocol DatePickeredTextFieldDelegate : class {
    func didDoneBtnTapped(date : String , textField : UITextField)
}

class DatePickeredTextField : UITextField , UITextFieldDelegate
{
  var completeDate : String?
  var datepicker = UIDatePicker()
  var formatterStr = "dd/MM/yyyy"
  weak var pickerDelegate : DatePickeredTextFieldDelegate?
  override init(frame: CGRect) {
    super.init(frame : frame)
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.delegate = self
    let imageView = UIImageView(image: UIImage(named: "calendarIcon"))
    imageView.tintColor = .systemGray3
    imageView.frame = CGRect(x: 0.0, y: 0.0, width: imageView.image!.size.width + 20.0, height: imageView.image!.size.height)
    self.rightView = imageView
    self.rightViewMode = .always
    setupDatePicker()
    if #available(iOS 13.4, *) {
      datepicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
      datepicker.backgroundColor = .white
     
      
    } else {
      // Fallback on earlier versions
    }
  }
  
  func setupDatePicker()
  {
    datepicker.datePickerMode = .date
   // datepicker.addTarget(self, action: #selector(doneDatePickerPressed), for: .valueChanged)
   // datepicker.tintColor = .red
    self.inputView = datepicker
    // datepicker toolbar setup
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44.0))
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true

    let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePickerPressed))


    // if you remove the space element, the "done" button will be left aligned
    // you can add more items if you want
    toolBar.setItems([space, doneButton], animated: false)
    // toolBar.isUserInteractionEnabled = true
    toolBar.sizeToFit()
    self.inputAccessoryView = toolBar
  }
  @objc func doneDatePickerPressed()
  {
    let formatter = DateFormatter()
    formatter.dateFormat = formatterStr
    formatter.locale = Locale(identifier: "en_US")
    pickerDelegate?.didDoneBtnTapped(date: formatter.string(from: datepicker.date) ,textField: self )
    self.text = formatter.string(from: datepicker.date)
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    self.completeDate = formatter.string(from: datepicker.date)
    self.resignFirstResponder()
  }
  override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    var textRect = super.rightViewRect(forBounds: bounds)
  //  textRect.origin.x -= 10
    textRect.size.height = 25
    textRect.size.width = 25
    textRect.origin.y = (self.bounds.height/2) - 13.5
    //textRect.width = 25
    return textRect
  }
}

