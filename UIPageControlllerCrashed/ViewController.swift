//
//  ViewController.swift
//  UIPageControlllerCrashed
//
//  Created by Retso Huang on 20/10/2017.
//  Copyright © 2017 Retso Huang. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, ViewControllerEmbeddable {
  
  // MARK: - ViewControllerEmbeddable
  @IBOutlet var containerView: UIView!
  var previousViewController: UIViewController?
  
  // MARK: - Data Source
  fileprivate var orderedViewControllers = [CardTemplateViewController]()
  
  private lazy var cardPageViewController: UIPageViewController = {
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    pageViewController.dataSource = self
    return pageViewController
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setCurrentEmbededViewControllerTo(cardPageViewController)
    configureCardDeck()
  }
  
  // MARK: - Configurations
  private func configureCardDeck() {
    for _ in 0...10 {
      let cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardTemplateViewController") as! CardTemplateViewController
      orderedViewControllers.append(cardViewController)
    }
    cardPageViewController.setViewControllers([orderedViewControllers.first!], direction: .forward, animated: false)
  }

}

// MARK: - UIPageViewControllerDataSource
extension ViewController: UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let cardTemplateViewController = viewController as? CardTemplateViewController,
      let viewControllerIndex = orderedViewControllers.index(of: cardTemplateViewController) else {
        return nil
    }
    
    let previousIndex = viewControllerIndex + 1
    
    return orderedViewControllers[safe: previousIndex]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let cardTemplateViewController = viewController as? CardTemplateViewController,
      let viewControllerIndex = orderedViewControllers.index(of: cardTemplateViewController) else {
        return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    return orderedViewControllers[safe: previousIndex]
  }
}

extension Array {
  subscript (safe index: Int) -> Element? {
    guard index >= 0 else {
      return nil
    }
    return index < count ? self[index]: nil
  }
}

