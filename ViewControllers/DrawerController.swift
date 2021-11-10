//
//  DrawerController.swift
//  ViewControllers
//
//  Created by Daniel Tartaglia on 8/29/21.
//

import UIKit

class DrawerController: UIViewController {

	var viewControllers: [UIViewController] = [] {
		didSet {
			children.forEach {
				removeChild($0)
			}
			mainChild = viewControllers.first
			drawerChild = viewControllers.dropFirst().first
			if let mainView = mainView {
				connectChild(mainChild!, to: mainView)
			}
			setClosed()
		}
	}

	private (set) var isOpen: Bool = false

	private var mainView: UIView!
	private var drawerView: UIView!
	private var blurView: UIVisualEffectView!
	private var mainChild: UIViewController?
	private var drawerChild: UIViewController?

	func open() {
		if !isOpen {
			connectChild(drawerChild!, to: drawerView)
			UIView.animate(
				withDuration: 0.25,
				animations: { [mainView, view, blurView] in
					if let view = view {
						mainView?.frame = view.bounds.offsetBy(dx: view.bounds.width - 44, dy: 0)
					}
					blurView?.alpha = 1
					blurView?.isHidden = false
				}
			)
			isOpen = true
		}
	}

	func close() {
		if isOpen {
			UIView.animate(
				withDuration: 0.25,
				animations: { [self] in
					setClosed()
				},
				completion: { [weak self, drawerChild] _ in
					self?.removeChild(drawerChild!)
				}
			)
			isOpen = false
		}
	}

	override func loadView() {
		super.loadView()
		mainView = UIView(frame: view.bounds)
		drawerView = UIView(frame: view.bounds.insetBy(dx: 22, dy: 0).offsetBy(dx: -22, dy: 0))
		blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
		blurView.frame = view.bounds
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurView.alpha = 0
		blurView.isHidden = true
		view.addSubview(drawerView)
		view.addSubview(mainView)
		isOpen = false
		if let main = mainChild {
			connectChild(main, to: mainView)
		}
		mainView.addSubview(blurView)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
		swipe.direction = .left
		view.addGestureRecognizer(swipe)
	}

	@objc private func swipeLeft(sender: UIGestureRecognizer) {
		if sender.state == .ended && isOpen {
			close()
		}
	}

	private func setClosed() {
		mainView?.frame = view.bounds
		blurView?.alpha = 0
		blurView?.isHidden = true
	}

	private func connectChild(_ controller: UIViewController, to childView: UIView) {
		addChild(controller)
		controller.didMove(toParent: self)
		controller.view.frame = childView.bounds
		controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		childView.addSubview(controller.view)
	}

	private func removeChild(_ controller: UIViewController) {
		controller.view.removeFromSuperview()
		controller.willMove(toParent: nil)
		controller.removeFromParent()
	}
}
