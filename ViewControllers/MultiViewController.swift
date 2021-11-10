//
//  MultiViewController.swift
//
//  Created by Daniel Tartaglia on 8/16/21.
//

import UIKit

class MultiController: UIViewController {

	var viewControllers: [UIViewController] = [] {
		didSet {
			children.forEach {
				removeChild($0)
			}
			currentActive = nil
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
		if oldVC != newVC {
			addChild(newVC)
			newVC.view.frame = view.bounds
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
				completion: { _ in
					oldVC.removeFromParent()
					newVC.didMove(toParent: self)
				}
			)
			currentActive = newVC
		}
	}

	private func connectChild(_ controller: UIViewController) {
		addChild(controller)
		controller.didMove(toParent: self)
		controller.view.frame = view.bounds
		controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(controller.view)
	}

	private func removeChild(_ controller: UIViewController) {
		controller.view.removeFromSuperview()
		controller.willMove(toParent: nil)
		controller.removeFromParent()
	}
}
