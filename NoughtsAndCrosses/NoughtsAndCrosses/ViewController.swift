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
    var game = XOGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func boardDidRotate(sender: UIRotationGestureRecognizer) {
        
        print (sender.rotation)
        
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
        
        
        var state = game.state()
        print (state)
        if (state == OXGameState.inProgress)   {
            //lets execute the move
            
            let move = game.playMove(sender.tag)
            
            if let moveToPrint = move   {
                sender.setTitle("\(moveToPrint)", forState: UIControlState.Normal)
            }
            
            state = game.state()
            
            if (state == OXGameState.complete_someone_won) {
//                let winner = game.whosTurn()
                let winner = move
                let message = "\(winner) won the game"
                let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) in
                         self.restartGame()
                        }
                ))
            }

            
        }   else if (state == OXGameState.complete_someone_won)  {
            
            print("Game ended")
        }
        
        
        
    }
    
    @IBAction func newGameTapped(sender: UIButton) {
        
        self.restartGame()
        
    }
    
    //
    func restartGame()  {
        
        //reset model
        game.reset()
        //reset UI
        for view in boardView.subviews  {
            
            if let button = view as? UIButton   {
                button.setTitle("", forState: UIControlState.Normal)
            }
        }
        
    }
    
}

