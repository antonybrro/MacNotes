//
//  TodayViewController.swift
//  MacNotesWidget
//
//  Created by Antony Yurchenko on 11/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa
import NotificationCenter
import Storage

class TodayViewController: NSViewController, NCWidgetProviding {
	
	@IBOutlet weak var popUp: NSPopUpButtonCell!
	@IBOutlet weak var horizontalLine: NSBox!
	@IBOutlet weak var textField: NSTextField!
	@IBOutlet var textView: NSTextView!
	@IBOutlet weak var addBtn: NSButton!
	@IBOutlet weak var removeBtn: NSButton!
	@IBOutlet weak var height: NSLayoutConstraint!
	@IBOutlet weak var textViewHeight: NSLayoutConstraint!
	
	let key = "com.antonybrro.macnoteswidget.indexOfSelectedNote";
	let suiteName = "group.com.antonybrro.macnotes"
	
	var storage = LocalStorage()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textField.delegate = self
		textView.delegate = self
		
		addBtn.isEnabled = false
		
		hideSettings(isHidden: true)
		self.view.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func viewWillAppear() {
		super.viewWillAppear()
		
		storage.load()
		for note in storage.notes {
			popUp.addItem(withTitle: note.title)
		}
		
		checkEmptyNotes()
		
		if let index = UserDefaults(suiteName: suiteName)?.integer(forKey: key) {
			popUp.selectItem(at: index)
			onPopUpClick(popUp)
		}
	}
	
	@IBAction func onPopUpClick(_ sender: NSPopUpButtonCell) {
		textView.textStorage?.mutableString.setString("")
		
		for note in storage.notes where note.title == sender.title {
			textView.textStorage?.mutableString.append(note.text)
		}
		
		UserDefaults(suiteName: suiteName)?.set(popUp.indexOfSelectedItem, forKey: key)
	}
	
	@IBAction func onAddBtnClick(_ sender: NSButton) {
		let title = textField.stringValue
		storage.add(index: popUp.indexOfSelectedItem, note: Note(title: title, text: ""))
		popUp.addItem(withTitle: title)
		
		popUp.selectItem(at: storage.notes.count - 1)
		textView.textStorage?.mutableString.setString("")
		
		textField.stringValue.removeAll()
		addBtn.isEnabled = false
		
		checkEmptyNotes()
	}
	
	@IBAction func onRemoveBtnClick(_ sender: NSButton) {
		let index = popUp.indexOfSelectedItem
		
		if storage.notes[index].title == popUp.title {
			storage.delete(index: index)
			popUp.removeItem(at: index)
			
			onPopUpClick(popUp)
			
			checkEmptyNotes()
		}
	}
	
	@IBAction func onUpDownBtnClick(_ sender: NSButton) {
		if (textViewHeight.constant != 100) {
			textViewHeight.constant = 100
			sender.image = NSImage(named: "down")
		} else {
			textViewHeight.constant = 500
			sender.image = NSImage(named: "up")
		}
	}

	// MARK: - Editing
	
	var widgetAllowsEditing: Bool {
		return true
	}
	
	func widgetDidBeginEditing() {
		hideSettings(isHidden: false)
	}
	
	func widgetDidEndEditing() {
		hideSettings(isHidden: true)
	}
	
	func hideSettings(isHidden: Bool) {
		textField.isHidden = isHidden
		addBtn.isHidden = isHidden
		removeBtn.isHidden = isHidden
		horizontalLine.isHidden = isHidden
		if isHidden { height.constant = 0 } else { height.constant = 40 }
	}
	
	func checkEmptyNotes() {
		textView.isEditable = !storage.notes.isEmpty
		removeBtn.isEnabled = !storage.notes.isEmpty
	}
}

extension TodayViewController : NSTextFieldDelegate, NSTextViewDelegate {
	override func controlTextDidChange(_ obj: Notification) {
		let text = textField.stringValue
		addBtn.isEnabled = !text.isEmpty
	}
	
	func textDidChange(_ notification: Notification) {
		let text = textView.attributedString().string
		
		storage.update(index: popUp.indexOfSelectedItem, note: Note(title: popUp.title, text: text))
	}
}
