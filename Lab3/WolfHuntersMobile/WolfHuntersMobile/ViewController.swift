//
//  ViewController.swift
//  WolfHuntersMobile
//
//  Created by user252252 on 12/19/23.
//

import UIKit


class ViewController: UIViewController {
    @IBAction func playButton(_ sender: UIButton) {
        textView.text="New Game"
        let game = WolfAndHunters()
        game.delegate = WolfAndHuntersTracker()
        game.board.delegate=self

        game.join(player: WolfAndHuntersPlayer(name: "Hunters", side: Side.white, achievedCells: 0))
        game.join(player: WolfAndHuntersPlayer(name: "Wolf", side: Side.black, achievedCells: 0))
        textView.text.append("\n Hunters has joined the game \n Wolf has joined the game \n ================= \n")
        game.tracker.delegate=self
        game.play()
 
        //print(textView.text)
        textView.text.append("\n Wolf wins!")
        

    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
extension ViewController:ChangeTextViewTextDelegate{
    func changeTextViewText(text: String) {
        textView.text.append(text)
    }
    
}
