//
//  SantaCanvas.swift
//  touchbar_santa
//
//  Created by Steve Smith on 29/11/2016.
//  Copyright © 2016 Airbyte. All rights reserved.
//

import Cocoa

class SantaCanvas: NSImageView {

    var xPosition: CGFloat = 0 {
        didSet {
            self.frame = CGRect(x: xPosition, y: 0, width: 685, height: 30)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
      
        self.animates = true
        self.image = NSImage(named: NSImage.Name("santa_long@2x.gif"))!
        self.canDrawSubviewsIntoLayer = true
        self.frame = CGRect(x: xPosition, y: 0, width: 685, height: 30)
    }
    
    override func touchesBegan(with event: NSEvent) {
        // Calling super causes santa to jump back to its original position 🤔
        //super.touchesBegan(with: event)
    }
    
    override func touchesMoved(with event: NSEvent) {
        if #available(OSX 10.12.2, *) {
            let current = event.allTouches().first?.location(in: self).x ?? 0
            let previous = event.allTouches().first?.previousLocation(in: self).x ?? 0
        
            let dX = (current - previous)
            
            xPosition += dX
        } else {
            // Fallback on earlier versions
        }
    }
    
}
