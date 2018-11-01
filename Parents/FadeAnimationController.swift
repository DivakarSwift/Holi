//
//  FadeAnimationController.swift
//  Holi
//
//  Created by Кирилл on 10/1/18.
//  Copyright © 2018 Kirill Esin. All rights reserved.
//

import UIKit

class FadeAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let presenting: Bool

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let container = transitionContext.containerView
        if presenting {
            container.addSubview(toView)
            toView.alpha = 0.0
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if self.presenting {
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0.0
            }
        }) { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }

    init(presenting: Bool) {
        self.presenting = presenting
    }
}

