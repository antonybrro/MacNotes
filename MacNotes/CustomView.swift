//
//  CustomView.swift
//  MacNotes
//
//  Created by Antony Yurchenko on 13/4/17.
//  Copyright © 2017 Antony Yurchenko. All rights reserved.
//

import Cocoa

class CustomView: NSView {

    override func draw(_ dirtyRect: NSRect) {
		NSColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0).setFill()
		NSRectFill(dirtyRect)
        super.draw(dirtyRect)
    }
}
