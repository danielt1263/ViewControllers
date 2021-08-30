//
//  MultiViewController.swift
//  M3 Labor
//
//  Created by Daniel Tartaglia on 8/16/21.
//  Copyright © 2021 Haneke Design. All rights reserved.
//

import UIKit

class MultiController: UIViewController {

	var viewControllers: [UIViewController] = [] {
		didSet {
			children.forEach {
				removeChild($0)
			}
			if let controller = viewControllers.first {
				connectChild(controller, to: view)
				currentActive = controller
			}
		}
	}

	private (set) var currentActive: UIViewController?

	func selectIndex(_ index: Int, animated: Bool) {
		let oldVC = currentActive!
		let newVC = viewControllers[index]
		print("oldVC", oldVC)
		print("newVC", newVC)
		if oldVC != newVC {
			self.currentActive = newVC
			connectChild(newVC, to: view)
			newVC.view.alpha = 0
			transition(
				from: oldVC,
				to: newVC,
				duration: animated ? 0.5 : 0.0,
				options: [],
				animations: {
					oldVC.view.alpha = 0
					newVC.view.alpha = 1
				},
				completion: { [self] _ in
					removeChild(oldVC)
				}
			)
		}
	}

	private func connectChild(_ controller: UIViewController, to childView: UIView) {
		addChild(controller)
		controller.didMove(toParent: self)
		controller.view.frame = childView.bounds
		controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		childView.addSubview(controller.view)
	}
	
	private func removeChild(_ controller: UIViewController) {
		controller.willMove(toParent: nil)
		controller.removeFromParent()
		controller.view.removeFromSuperview()
	}
}
