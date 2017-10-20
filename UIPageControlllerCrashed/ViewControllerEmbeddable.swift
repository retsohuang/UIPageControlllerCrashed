//
//  ViewControllerEmbeddable.swift
//  Business
//
//  Created by Retso on 9/19/16.
//  Copyright © 2016 Fungogo Co., Ltd. All rights reserved.
//

import UIKit
import Foundation

protocol ViewControllerEmbeddable: class {
  var containerView: UIView! { get }
  var previousViewController: UIViewController? { get set }
}

extension ViewControllerEmbeddable where Self: UIViewController {
  
  func setCurrentEmbededViewControllerTo(_ targetViewController: UIViewController) {
    
    addChildViewController(targetViewController)
    targetViewController.view.frame.size = containerView.frame.size
    containerView.addSubview(targetViewController.view)
    targetViewController.didMove(toParentViewController: self)
    
    guard let unwrappedPreviousViewController = previousViewController else {
      previousViewController = targetViewController
      return
    }
    
    unwrappedPreviousViewController.willMove(toParentViewController: nil)
    unwrappedPreviousViewController.view.removeFromSuperview()
    unwrappedPreviousViewController.removeFromParentViewController()
    previousViewController = targetViewController
    
  }
  
}
