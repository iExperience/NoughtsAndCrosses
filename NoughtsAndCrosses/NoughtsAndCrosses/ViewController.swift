//
//  ViewController.swift
//  NoughtsAndCrosses
//
//  Created by Julian Hulme on 2016/05/02.
//  Copyright © 2016 Julian Hulme. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    var gameObject = XOGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boardDidRotate(sender: UIRotationGestureRecognizer) {
        
//        print (sender.rotation)
        self.boardView.transform = CGAffineTransformMakeRotation(sender.rotation);
        
        //determine
        if (sender.state == UIGestureRecognizerState.Ended)   {
            UIView.animateWithDuration(NSTimeInterval(2), animations: {
                self.boardView.transform = CGAffineTransformMakeRotation(0)
            })
        }
        
    }

    @IBAction func boardWasTapped(sender: UIButton) {
        
        print("boardWasTapped")
        
        var state = gameObject.state()
        print (state)
        if (state == OXGameState.inProgress)   {
            //lets execute the move
            
            let move = gameObject.playMove(sender.tag)
            
            if let moveToPrint = move   {
                sender.setTitle("\(moveToPrint)", forState: UIControlState.Normal)
            }
            
            state = gameObject.state()
            
            if (state == OXGameState.complete_someone_won) {
//                let winner = game.whosTurn()
                let winner = move
                let message = "\(winner) won the game"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                         self.restartGame()
                }))
            }

        }   else if (state == OXGameState.complete_someone_won)  {
            print("Game ended")
        }
        
    }
    
    @IBAction func newGameTapped(sender: UIButton) {
        
        self.restartGame()
        
    }
    
    func restartGame()  {
        
        //reset model
        gameObject.reset()
        //reset UI
        for view in boardView.subviews  {
            if let button = view as? UIButton   {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
        
    }
    
}

