//
//  ViewController.swift
//  touchbar_santa
//
//  Created by Steve Smith on 29/11/2016.
//  Copyright © 2016 Airbyte. All rights reserved.
//

import Cocoa
import AVFoundation

class SantaViewController: NSViewController, NSTouchBarDelegate {
  
    var audio_player: AVAudioPlayer?
    
    var sound: Bool = true {
        didSet {
            if sound {
                audio_player?.play()
                sound_btn.image = sound_btn_image_on
            } else {
                audio_player?.pause()
                sound_btn.image = sound_btn_image_off
            }
        }
    }
    
    var sound_btn_image_on: NSImage? {
        return NSImage(named: NSImage.Name("ic_volume_up_3x.png"))
    }
    var sound_btn_image_off: NSImage? {
        return NSImage(named: NSImage.Name("ic_volume_off_3x.png"))
    }
    
    @IBOutlet weak var sound_btn: NSButtonCell!
    @IBOutlet weak var bkg: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
    }
    
    @IBAction func toggle_sound(_ sender: Any) {
        sound = !sound
    }
    
    override func viewWillAppear() {
        bkg.layer?.backgroundColor = NSColor(red: 0.08, green: 0.31, blue: 0.55, alpha: 1.00).cgColor
        
        guard let santa_music_path = Bundle.main.path(forResource: "santa_music", ofType: "mp3") else {
            print("Failed to find path for santa_music.mp3")
            return
        }
        
        let santa_music = URL(fileURLWithPath: santa_music_path)
        
        do {
            try audio_player = AVAudioPlayer(contentsOf: santa_music)
            audio_player?.numberOfLoops = -1
            audio_player?.prepareToPlay()
        } catch let error {
            print("Failed to initialize AVAudioPlayer: \(error)")
        }
        
        sound = true
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
