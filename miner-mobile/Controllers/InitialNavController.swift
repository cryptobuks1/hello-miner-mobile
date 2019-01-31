//
//  ViewController.swift
//  miner-mobile
//
//  Created by Frank Caron on 1/31/19.
//  Copyright © 2019 Frank Caron. All rights reserved.
//

import UIKit
import AVFoundation

class InitialNavController: UINavigationController {
    
    //Video
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        avPlayer.play()
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        unloadVideo()
    }
    
    private func loadVideo() {
        
        let theURL = Bundle.main.url(forResource:"Forest_15_3b_Videvo", withExtension: "mov")
        avPlayer = AVPlayer(url: theURL!)
        
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayerLayer.frame = view.layer.bounds
        
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none
        view.backgroundColor = UIColor.clear
        view.alpha = 0.7
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        
    }
    
    private func unloadVideo() {
        NSLog("Unloading video...")
        avPlayerLayer.removeFromSuperlayer()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero)
    }


}

