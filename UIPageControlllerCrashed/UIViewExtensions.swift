//
//  UIViewExtensions.swift
//  SwiftyIbon
//
//  Created by HuangRetso on 11/07/2017.
//  Copyright © 2017 JOU-HSUAN WU. All rights reserved.
//

import UIKit

public extension UIView {
  
  // MARK: - Mask
  func mask(withRect rect: CGRect, inverse: Bool = false) {
    let path = UIBezierPath(rect: rect)
    let maskLayer = CAShapeLayer()
    
    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    maskLayer.path = path.cgPath
    
    self.layer.mask = maskLayer
  }
  
  func mask(withPath path: UIBezierPath, inverse: Bool = false) {
    let path = path
    let maskLayer = CAShapeLayer()
    
    if inverse {
      path.append(UIBezierPath(rect: self.bounds))
      maskLayer.fillRule = kCAFillRuleEvenOdd
    }
    
    maskLayer.path = path.cgPath
    
    self.layer.mask = maskLayer
  }
  
  public func animatedView(toHidden hidden: Bool) {
    UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
      if hidden {
        self.alpha = 0
      } else {
        self.alpha = 1
      }
      self.isHidden = hidden
    }, completion: nil)
  }
  
  public class func namesakeNib(from bundle: Bundle = Bundle.main) -> UINib {
    return UINib(nibName: className, bundle: bundle)
  }
  
  public class var className: String {
    return String(describing: self)
  }
  
  public class func instantiateFromNamesakeNib(in bundle: Bundle = Bundle.main) -> Self {
    return __instantiateFromNamesakeNib(in: bundle)
  }
  
  private class  func __instantiateFromNamesakeNib<T>(in bundle: Bundle) -> T where T: UIView {
    
    for object in namesakeNib(from: bundle).instantiate(withOwner: nil, options: nil) {
      if let view = object as? T {
        return view
      }
    }
    
    fatalError()
  }
}
