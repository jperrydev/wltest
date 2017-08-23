//
//  ZoomInteractiveTransition.swift
//  WLTest
//
//  Created by Jordan Perry on 8/22/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation
import UIKit

enum ZoomInteractiveTransitionViewType {
    case Source
    case Destination
}

protocol ZoomInteractiveTransitionProtocol {
    var zoomInteractiveTransitionEnabled: Bool { get set }
    func viewForType(_ type: ZoomInteractiveTransitionViewType) -> UIView
}

class ZoomInteractiveTransition: UIPercentDrivenInteractiveTransition, UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning {
    weak var navigationController: UINavigationController? {
        didSet {
            navigationController?.delegate = self
        }
    }
    
    // MARK: UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if self.navigationController == nil {
            return nil
        }
        
        guard let from = fromVC as? ZoomInteractiveTransitionProtocol,
            let to = toVC as? ZoomInteractiveTransitionProtocol else {
            return nil
        }
        
        guard from.zoomInteractiveTransitionEnabled, to.zoomInteractiveTransitionEnabled else {
            return nil
        }
        
        // force load views
        let _ = fromVC.view
        let _ = toVC.view
        
        return self
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from),
            let fromTransitioner = from as? ZoomInteractiveTransitionProtocol,
            let to = transitionContext.viewController(forKey: .to),
            let toTransitioner = to as? ZoomInteractiveTransitionProtocol else {
            return
        }
        
        let containerView = transitionContext.containerView
        let fromView = from.view!
        let toView = to.view!
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let fromZoomView = fromTransitioner.viewForType(.Source)
        let toZoomView = toTransitioner.viewForType(.Destination)
        
        let transitionView = (fromZoomView.bounds.width > toZoomView.bounds.width) ? fromZoomView : toZoomView
        let transitionImageView = imageView(fromView: transitionView)
        
        if let fromSuperview = fromZoomView.superview {
            transitionImageView.frame = fromSuperview.convert(fromZoomView.frame, to: containerView).integral
        }
        
        fromZoomView.alpha = 0.0
        toZoomView.alpha = 0.0
        
        let backgroundImageView = imageView(fromView: fromView)
        containerView.addSubview(backgroundImageView)
        
        containerView.addSubview(transitionImageView)
        
        UIView.animateKeyframes(withDuration: 0.3,
                                delay: 0.0,
                                options: .calculationModeCubic,
                                animations: {
                                    if let toSuperview = toZoomView.superview {
                                        transitionImageView.frame = toSuperview.convert(toZoomView.frame, to: containerView).integral
                                        backgroundImageView.alpha = 0.0
                                    }
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            
            transitionImageView.removeFromSuperview()
            backgroundImageView.removeFromSuperview()
            
            fromZoomView.alpha = 1.0
            toZoomView.alpha = 1.0
        }
    }
    
    // MARK: Helpers
    
    func imageView(fromView view: UIView) -> UIImageView {
        var image: UIImage?
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}
