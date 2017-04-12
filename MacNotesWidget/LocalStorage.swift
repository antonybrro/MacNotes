//
//  LocalStorage.swift
//  MacNotes
//
//  Created by Antony Yurchenko on 12/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa
import os.log

class LocalStorage {
	
	var notes = [Note]()
	
	init() {
		load()
	}
	
	func load() {
		if let savedNotes = NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note] {
			notes = savedNotes
		}
//		
//		if notes.isEmpty {
//			notes = [Note(title: "Note", text: "Text note")]
//		}
	}
	
	func add(index : Int, note: Note) {
		notes.append(note)
		
		save()
	}
	
	func update(index : Int, note : Note) {
		notes[index] = note
		
		save()
	}
	
	func delete(index: Int) {
		notes.remove(at: index)
		
		save()
	}
	
	private func save() {
		let isSuccessfullSave = NSKeyedArchiver.archiveRootObject(notes, toFile: Note.ArchiveURL.path)
		
		UserDefaults.standard.set(isSuccessfullSave, forKey: "notes_changed")
		
		if isSuccessfullSave {
			os_log("Notes successfully saved.", log: OSLog.default, type: .debug)
		} else {
			os_log("Failed to save note...", log: OSLog.default, type: .error)
		}
	}
}
