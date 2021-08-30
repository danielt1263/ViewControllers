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
				connectChild(controller)
				currentActive = controller
			}
		}
	}

	private (set) var currentActive: UIViewController?

	func selectIndex(_ index: Int, animated: Bool) {
		let oldVC = currentActive!
		let newVC = viewControllers[index]
		newVC.view.alpha = 0
		connectChild(newVC)

		if oldVC != newVC {
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
					self.currentActive = newVC
					removeChild(oldVC)
				}
			)
		}
	}

	private func connectChild(_ controller: UIViewController) {
		controller.willMove(toParent: self)
		addChild(controller)
		controller.view.frame = view.bounds
		controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(controller.view)
		controller.didMove(toParent: self)
	}

	private func removeChild(_ controller: UIViewController) {
		controller.willMove(toParent: nil)
		controller.view.removeFromSuperview()
		controller.removeFromParent()
		controller.didMove(toParent: nil)

	}
}
