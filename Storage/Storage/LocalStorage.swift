//
//  LocalStorage.swift
//  MacNotes
//
//  Created by Antony Yurchenko on 12/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa
import os.log

public class LocalStorage {
	
	public var notes = [Note]()
	
	public init() {
		load()
	}
	
	public func load() {
		if let savedNotes = NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note] {
			notes = savedNotes
		}
	}
	
	public func add(index : Int, note: Note) {
		notes.append(note)
		
		save()
	}
	
	public func update(index : Int, note : Note) {
		notes[index] = note
		
		save()
	}
	
	public func delete(index: Int) {
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
