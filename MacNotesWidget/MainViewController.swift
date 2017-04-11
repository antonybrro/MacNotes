//
//  MainViewController.swift
//  MacNotes
//
//  Created by Antony Yurchenko on 11/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
	
	@IBOutlet var textView: NSTextView!
	let key = "com.antonybrro.macnoteswidget.attrString";
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let text = UserDefaults.standard.string(forKey: key) {
			textView.textStorage?.append(NSAttributedString(string: text))
		}
	}
	
	override func viewWillDisappear() {
		let text = textView.attributedString().string
		UserDefaults.standard.set(text, forKey: key)
	}
}
