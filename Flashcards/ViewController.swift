//
//  ViewController.swift
//  Flashcards
//
//  Created by Elizabeth Bakewell on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardContainer: UIView!
    
    @IBOutlet weak var questionCard: UILabel!
    
    @IBOutlet weak var answerCard: UILabel!
    
    @IBOutlet weak var answerTop: UIButton!
    
    @IBOutlet weak var answerMiddle: UIButton!
    
    @IBOutlet weak var answerBottom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardContainer.layer.cornerRadius = 20.0
        cardContainer.layer.shadowRadius = 15.0
        cardContainer.layer.shadowOpacity = 0.2
        questionCard.clipsToBounds = true
        questionCard.layer.cornerRadius = 20.0
        answerCard.layer.cornerRadius = 20.0
        answerCard.clipsToBounds = true
        
        answerTop.layer.cornerRadius = 20.0
        answerTop.layer.borderWidth = 3.0
        answerTop.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        answerMiddle.layer.cornerRadius = 20.0
        answerMiddle.layer.borderWidth = 3.0
        answerMiddle.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        answerBottom.layer.cornerRadius = 20.0
        answerBottom.layer.borderWidth = 3.0
        answerBottom.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if questionCard.isHidden {
            questionCard.isHidden = false
        }
        else {
            questionCard.isHidden = true
        }
        cardContainer.layer.shadowRadius = 0.0
        cardContainer.layer.shadowOpacity = 0.0
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        answerTop.isHidden = true
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        questionCard.isHidden = true
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        answerBottom.isHidden = true
    }
}

