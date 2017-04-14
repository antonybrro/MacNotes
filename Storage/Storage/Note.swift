//
//  Note.swift
//  MacNotes
//
//  Created by Antony Yurchenko on 12/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa

public class Note : NSObject, NSCoding {
	
	// MARK: Properties
	public var title: String
	public var text: String
	
	static let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.antonybrro.macnotes")!
	static let ArchiveURL = containerURL.appendingPathComponent("notes")

	public init(title: String, text: String) {
		self.title = title
		self.text = text
	}
	
	struct PropertyKey {
		static let title = "title"
		static let text = "text"
	}
	
	//MARK: NSCoding
	public func encode(with aCoder: NSCoder) {
		aCoder.encode(title, forKey: PropertyKey.title)
		aCoder.encode(text, forKey: PropertyKey.text)
	}
	
	public required convenience init?(coder aDecoder: NSCoder) {
		guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
			return nil
		}
		guard let text = aDecoder.decodeObject(forKey: PropertyKey.text) as? String else {
			return nil
		}
		
		self.init(title: title, text: text)
	}
}

