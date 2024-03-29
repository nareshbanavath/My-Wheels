//
//  LoadingOverLay.swift
//  MyWheels
//
//  Created by naresh banavath on 16/03/21.
//

import UIKit
public class LoadingOverlay{
var overlayView = UIView()
var activityIndicator = UIActivityIndicatorView()

class var shared: LoadingOverlay {
    struct Static {
        static let instance: LoadingOverlay = LoadingOverlay()
    }
    return Static.instance
}

  public func showOverlay(view: UIView) {
    
    overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    overlayView.center = view.center
    overlayView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    overlayView.clipsToBounds = true
    overlayView.layer.cornerRadius = 10
    
    activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    activityIndicator.style = .medium
    activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
    
    overlayView.addSubview(activityIndicator)
    view.addSubview(overlayView)
    
    activityIndicator.startAnimating()
  }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
