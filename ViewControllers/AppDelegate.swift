//
//  AppDelegate.swift
//  ViewControllers
//
//  Created by Daniel Tartaglia on 8/29/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	let multiController = MultiController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = multiController
        window?.makeKeyAndVisible()

		let main = ViewController(nibName: nil, bundle: nil)
		main.backgroundColor = .red
		main.title = "Main"
		let drawer = ViewController(nibName: nil, bundle: nil)
		drawer.backgroundColor = .green
		drawer.title = "Drawer"

		multiController.viewControllers = [main, drawer]

		main.button.addTarget(self, action: #selector(mainTap), for: .touchUpInside)
		drawer.button.addTarget(self, action: #selector(secondTap), for: .touchUpInside)
		
		return true
    }

	@objc func mainTap() {
		multiController.selectIndex(1, animated: true)
	}
	
	@objc func secondTap() {
		multiController.selectIndex(0, animated: false)
	}
}

class ViewController: UIViewController {
	var backgroundColor: UIColor = .white
	var button = UIButton()
	override func loadView() {
		super.loadView()
		button.frame = view.bounds
		button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		view.addSubview(button)
		view.backgroundColor = backgroundColor
	}

	override func willMove(toParent parent: UIViewController?) {
		super.willMove(toParent: parent)
		print("\(title!) willMoveToParent: \(parent as Any)")
	}

	override func didMove(toParent parent: UIViewController?) {
		print("\(title!) didMoveToParent: \(parent as Any)")
		super.didMove(toParent: parent)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("\(title!) viewWillAppear: \(animated)")
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("\(title!) viewDidAppear: \(animated)")
	}

	override func viewWillDisappear(_ animated: Bool) {
		print("\(title!) viewWillDisappear: \(animated)")
		super.viewWillDisappear(animated)
	}

	override func viewDidDisappear(_ animated: Bool) {
		print("\(title!) viewDidDisappear: \(animated)")
		super.viewDidDisappear(animated)
	}
}
