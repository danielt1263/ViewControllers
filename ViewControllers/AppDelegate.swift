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
	let drawerController = DrawerController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()

		let main = ViewController()
		main.backgroundColor = .red
		main.title = "Main"
		let drawer = ViewController()
		drawer.backgroundColor = .green
		drawer.title = "Drawer"

		drawerController.viewControllers = [main, drawer]

		main.button.addTarget(self, action: #selector(mainTap), for: .touchUpInside)

		return true
    }

	@objc func mainTap() {
		drawerController.open()
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
		print("\(title!) will move to \(parent)")
	}

	override func didMove(toParent parent: UIViewController?) {
		print("\(title!) did Move to \(parent)")
		super.didMove(toParent: parent)
	}
}
