//
//  ViewController.swift
//  Animations
//
//  Created by Berkay DEMİR on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatableView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
         UIView.animate(withDuration: 2) {
         self.animatableView.backgroundColor = .red
         self.animatableView.frame.size = CGSize(width: 100, height: 100)
         self.animatableView.frame = CGRect(x: 100, y: 300, width: 70, height: 40)
         }
         */
        UIView.animate(withDuration: 2, delay: 3, options: [.repeat], animations: {
            self.animatableView.backgroundColor = .red
            self.animatableView.frame.size = CGSize(width: 100, height: 100)
            self.animatableView.frame = CGRect(x: 100, y: 300, width: 70, height: 40)
            
        }, completion: nil)
    }
    
    // Transform: Arayüz elemanları üzerinde; scale, rotate, translate gibi
    // değişiklikler yapılmasını sağlayatn bir property' dir.
    
    func applyScaleTransformation() {
        // Transform uygulanacak arayüz elemanının genişlik ve yükseklik
        //bilgisini iki katına çıkarır
        let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = scaleTransform
        }
        
    }
    func applyRotationTransformation() {
        /* Transform uygulanacak arayüz elemanının saat yönünde
         180 derece dönmesini sağlar.
         90 derece için .pi/2
         -90 derece için ise .-pi/2 kullanılabilir
         */
        let rotationTransform = CGAffineTransform(rotationAngle: .pi)
        
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = rotationTransform
        }
    }
    func applyTranslateTransformation() {
        /* Transform uygulanacak arayüz elemanına x ekseninde 100 birimlik,
         y ekseninde ise 50 birimlik bir değişim uygular. */
        let translationTransform = CGAffineTransform(translationX: 100, y: 50)
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = translationTransform
        }
    }
    func applyComplexTransform(){
        
        let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        let rotationTransform = CGAffineTransform(rotationAngle: .pi)
        let translationTransform = CGAffineTransform(translationX: 100, y: 50)
        let comboTranform = scaleTransform.concatenating(rotationTransform).concatenating(translationTransform)
        UIView.animate(withDuration: 2) {
            self.animatableView.transform = comboTranform
        }
        
        
    }
    func animateWidthConstraintChange(){
        
        self.widthConstraint.constant = 200
        
        /* Bir önceki durum ile şu an arasındaki constraint'lerde bir değişim varsa,
         constraint'leri yeniden hesaplar. (Bu işlem anime edilebilir) */
        
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
        
    }
}

