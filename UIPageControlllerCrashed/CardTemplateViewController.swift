//
//  CardTemplateViewController.swift
//  SwiftyIbon
//
//  Created by Retso Huang on 03/09/2017.
//  Copyright © 2017 JOU-HSUAN WU. All rights reserved.
//

import UIKit

class CardTemplateViewController: UIViewController {
  
  // MARK: - Outlets
  private lazy var remarkView: RemarkView = self.makeRemarkView()
  
  // MARK: - Makers
  private func makeRemarkView() -> RemarkView {
    let remarkView = RemarkView.instantiateFromNamesakeNib()
    remarkView.frame = self.view.frame
    remarkView.layoutIfNeeded()
    return remarkView
  }
  
  @IBAction func showRemarkButtonTapped() {
    UIView.transition(from: view, to: remarkView, duration: 1, options: .transitionFlipFromRight, completion: nil)
  }
  
}
