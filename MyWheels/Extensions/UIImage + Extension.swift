//
//  UIImage + Extension.swift
//  MyWheels
//
//  Created by naresh banavath on 08/03/21.
//

import UIKit
extension UIImage
{
  var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)! }
  var highQualityJPEGNSData: Data    { return jpegData(compressionQuality: 0.75)!}
  var mediumQualityJPEGNSData: Data  { return jpegData(compressionQuality: 0.5)! }
  var lowQualityJPEGNSData: Data     { return jpegData(compressionQuality: 0.25)!}
  var lowestQualityJPEGNSData: Data  { return jpegData(compressionQuality: 0.0)! }
}
extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.pngData() else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }
}
