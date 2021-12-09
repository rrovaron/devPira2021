//
//  ViewController.swift
//  DemoDevPira
//
//  Created by Rodrigo Rovaron on 04/12/21.
//

import UIKit

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        
        collision.collisionDelegate = self
        collision.translatesReferenceBoundsIntoBoundary = true
        
        addSquareOnTap()
        addBarrier()
    }
    
    func addBarrier() {
        
        let barrier = UIView(frame: CGRect(x: .zero,
                                           y: UIScreen.main.bounds.height / 2,
                                           width: UIScreen.main.bounds.width / 3,
                                           height: 50))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
        
        addCollisionFor(collisionView: barrier)
    }
    
    func addCollisionFor(collisionView: UIView) {
        
        collision.addBoundary(withIdentifier: "barrier" as NSCopying,
                              for: UIBezierPath(rect: collisionView.frame))
        animator.addBehavior(collision)
    }
    
    func addSquareOnTap() {
        
        let tapGesture = UITapGestureRecognizer.init(target: self,
                                                     action: #selector(addSquare))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func addSquare(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        
        let square = UIView(frame: CGRect(x: location.x - 50,
                                          y: location.y - 50,
                                          width: 100,
                                          height: 100))
        square.backgroundColor = UIColor.blue
        view.addSubview(square)
        
        gravity.addItem(square)
        gravity.magnitude = CGFloat.random(in: 0...5)
        animator.addBehavior(gravity)

        collision.addItem(square)
    }

}

extension ViewController: UICollisionBehaviorDelegate {
    
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at p: CGPoint) {
        
        let collidingView = item as! UIView
        
        collidingView.backgroundColor = UIColor.yellow
        
        UIView.animate(withDuration: 1) {
            collidingView.backgroundColor = UIColor.gray
        }
    }
}
