//
//  ViewController.swift
//  ViewControllerLifecycle
//
//  Created by Cristi Habliuc on 15.05.2022.
//

import UIKit

class ViewController: UIViewController {
	private static var counter = 1
	var id: Int
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		id = Self.counter
		Self.counter += 1
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		print("[\(id)] init")
	}

	required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("[\(id)] viewDidLoad; view.frame=\(view.frame)")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print("[\(id)] viewWillAppear; animated=\(animated); view.frame=\(view.frame); view.safeAreaInsets=\(view.safeAreaInsets); view.layoutMargins=\(view.layoutMargins)")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print("[\(id)] viewDidAppear; animated=\(animated); view.frame=\(view.frame); view.safeAreaInsets=\(view.safeAreaInsets); view.layoutMargins=\(view.layoutMargins)")
	}
	
	/// useful when transitioning on rotation
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		print("[\(id)] viewWillTransition; to=\(size); coordinator.transitionDuration=\(coordinator.transitionDuration)")
		coordinator.animate { context in
			self.view.backgroundColor = size.width > size.height ? .darkGray : .white
		}
	}
	
	/// Tells you that the bounds are about to change for the view
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		print("[\(id)] viewWillLayoutSubviews; view.frame=\(view.frame)")
	}
	
	/// Tells you that the bounds where changed for the view
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		print("[\(id)] viewDidLayoutSubviews; view.frame=\(view.frame)")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		print("[\(id)] viewWillDisappear;")
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		print("[\(id)] viewDidDisappear;")
	}
	
	override func viewSafeAreaInsetsDidChange() {
		super.viewSafeAreaInsetsDidChange()
		print("[\(id)] viewSafeAreaInsetsDidChange; view.safeAreaInsets=\(view.safeAreaInsets)")
	}
	
	override func viewLayoutMarginsDidChange() {
		super.viewLayoutMarginsDidChange()
		print("[\(id)] viewLayoutMarginsDidChange; view.layoutMargins=\(view.directionalLayoutMargins)")
	}
	
	// MARK: - Actions
	
	@IBAction func handleModalButtonAction(_ sender: UIButton) {
		let clone = ViewController()
		clone.modalPresentationStyle = .fullScreen // completely covers the screen
		present(clone, animated: true)
	}

	@IBAction func handlePushButtonAction(_ sender: UIButton) {
		let clone = ViewController()
		navigationController?.pushViewController(clone, animated: true)
	}
	
	@IBAction func handleAlertButtonAction(_ sender: UIButton) {
		let alert = UIAlertController(title: "Alert", message: "This is a modally presented alert", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
		present(alert, animated: true)
	}
}

