//
//  TodayViewController.swift
//  MacNotesWidget
//
//  Created by Antony Yurchenko on 11/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

	@IBOutlet var mainViewController: MainViewController!
	@IBOutlet weak var height: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		mainViewController.view.translatesAutoresizingMaskIntoConstraints = false
		self.view.translatesAutoresizingMaskIntoConstraints = false
		
		switchFromViewController(nil, toViewController: mainViewController)
	}
	
	var widgetAllowsEditing: Bool {
		return true
	}
	
	func widgetDidBeginEditing() {
		height.constant = 300
	}
	
	func widgetDidEndEditing() {
		height.constant = 100
	}
	
	func switchFromViewController(_ fromViewController: NSViewController?, toViewController: NSViewController?) {
		if fromViewController != nil {
			fromViewController?.removeFromParentViewController()
			fromViewController?.view.removeFromSuperview()
		}
		
		if toViewController != nil {
			self.addChildViewController(toViewController!)
			let view = toViewController!.view
			self.view.addSubview(view)
			let views: [String:AnyObject] = ["view" : view]
			self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: views))
			self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: views))
		}
		
		self.view.layoutSubtreeIfNeeded()
	}
}
