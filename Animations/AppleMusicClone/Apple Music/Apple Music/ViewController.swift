//
//  ViewController.swift
//  Apple Music
//
//  Created by Berkay DEMİR on 15.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var reverseBackgroundView: UIImageView!
    @IBOutlet var playPauseBackgroundView: UIImageView!
    @IBOutlet var forwardBackgroundView: UIImageView!
    
    @IBOutlet var reverseButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var playPauseButton: UIButton!
    
    // MARK: - Properties
    var isPlaying: Bool = true {
        didSet {
            
            if isPlaying{
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            }else{
                playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reverseBackgroundView.layer.cornerRadius = 35
        reverseBackgroundView.clipsToBounds = true
        reverseBackgroundView.alpha = 0
        
        playPauseBackgroundView.layer.cornerRadius = 35
        playPauseBackgroundView.clipsToBounds = true
        playPauseBackgroundView.alpha = 0
        
        forwardBackgroundView.layer.cornerRadius = 35
        forwardBackgroundView.clipsToBounds = true
        forwardBackgroundView.alpha = 0
    }
    // MARK: - Actions
    @IBAction func touchDown(_ button: UIButton){
        
        let buttonBackgorundView: UIView
        switch button {
        case reverseButton:
            buttonBackgorundView = reverseBackgroundView
        case playPauseButton:
            buttonBackgorundView = playPauseBackgroundView
        case forwardButton:
            buttonBackgorundView = forwardBackgroundView
        default:
            return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackgorundView.alpha = 0.3
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @IBAction func touchUpInside(_ button: UIButton){
        let buttonBackgorundView: UIView
        switch button {
        case reverseButton:
            buttonBackgorundView = reverseBackgroundView
        case playPauseButton:
            buttonBackgorundView = playPauseBackgroundView
        case forwardButton:
            buttonBackgorundView = forwardBackgroundView
        default:
            return
        }
        UIView.animate(withDuration: 0.25) {
            buttonBackgorundView.alpha = 0
            button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            button.transform = .identity
            
        }
    }
    @IBAction func playPauseButtonTapped(_ button: UIButton) {
        
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
            
        }else{
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = .identity
            }
            
        }
        // true -> false
        // false -> true
        isPlaying.toggle()
    }
    
}




