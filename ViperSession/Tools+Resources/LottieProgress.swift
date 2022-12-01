//
//  LottieProgress.swift
//  ViperSession
//
//  Created by Natanael Simri Alvarez Guzman on 29/11/22.
//

import UIKit
import Lottie

final class LottieProgress {
    static let animation = LottieProgress()
    let anim = "pokeball"
    private var animationView: LottieAnimationView?
    func show(){
        if animationView != nil {
            self.hide()
        }
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window
          else {
            return
          }
        
        animationView = .init(name: anim)
        let sizeLottieView = 72.0
        animationView!.frame = CGRect(x: window.center.x - (sizeLottieView/2) ,
                                      y: window.center.y - (sizeLottieView/2) ,
                                      width: sizeLottieView,
                                      height: sizeLottieView)
        
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 2
        window.addSubview(animationView!)
        animationView!.play()
        
    }
    
    func hide(){
        animationView?.stop()
        animationView?.removeFromSuperview()
        animationView = nil
    }
}
