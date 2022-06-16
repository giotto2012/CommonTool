//
//  BlockingActivityIndicator.swift
//  CommonTool
//
//  Created by 張宇樑 on 2022/6/13.
//

import Foundation
import NVActivityIndicatorView
import UIKit

final class BlockingActivityIndicator: UIView {
  private let activityIndicator: NVActivityIndicatorView

  override init(frame: CGRect) {
    self.activityIndicator = NVActivityIndicatorView(
      frame: CGRect(
        origin: .zero,
        size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
      )
    )
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    super.init(frame: frame)
    backgroundColor = UIColor.black.withAlphaComponent(0.6)
    addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension UIViewController {
  public func startBlockingActivityIndicator() {
      guard !self.view.subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
      return
    }

    let activityIndicator = BlockingActivityIndicator()
    activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      activityIndicator.frame = view.bounds

    UIView.transition(
        with: self.view,
      duration: 0.3,
      options: .transitionCrossDissolve,
      animations: {
          self.view.addSubview(activityIndicator)
      }
    )
  }
    
public func finishBlockingActivityIndicator()
{
    view.subviews.filter { $0 is BlockingActivityIndicator }.forEach { view in
        view.removeFromSuperview()
    }
}
}
