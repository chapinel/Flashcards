//
//  ViewController.swift
//  Flashcards
//
//  Created by Elizabeth Bakewell on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var top: String
    var middle: String
    var bottom: String
}

class ViewController: UIViewController {

    @IBOutlet weak var cardContainer: UIView!
    
    @IBOutlet weak var questionCard: UILabel!
    
    @IBOutlet weak var answerCard: UILabel!
    
    @IBOutlet weak var answerTop: UIButton!
    
    @IBOutlet weak var answerMiddle: UIButton!
    
    @IBOutlet weak var answerBottom: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
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
        
        readSavedFlashcards()

        if flashcards.count == 0 {
            updateFlashcard(question: "What dice do you roll for initiative?", answer: "D20", topChoice: "D8", middleChoice: "D20", bottomChoice: "D12", isExisting: false)
        } else {
            updateLabels()
            updateNextPreviousButtons()
        }
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPreviousButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        
        updateLabels()
        
        updateNextPreviousButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
                
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
            }
                
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
                
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard() {
            
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPreviousButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
    }
    
    func updateNextPreviousButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateFlashcard(question: String, answer: String, topChoice: String, middleChoice: String, bottomChoice: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, top: topChoice, middle: middleChoice, bottom: bottomChoice)
        
        if isExisting {
            
            flashcards[currentIndex] = flashcard
            
        } else {
            
            flashcards.append(flashcard)
            currentIndex = flashcards.count - 1
            
            print("added new flashcard!")
            print("We now have \(flashcards.count) flashcards")
            print("Our current index is \(currentIndex)")
            
            
        }
        
        updateLabels()
        updateNextPreviousButtons()
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels() {
        
        let currentFlashcard = flashcards[currentIndex]
        
        questionCard.text = currentFlashcard.question
        answerCard.text = currentFlashcard.answer
        
        answerTop.setTitle(currentFlashcard.top, for: .normal)
        answerMiddle.setTitle(currentFlashcard.middle, for: .normal)
        answerBottom.setTitle(currentFlashcard.bottom, for: .normal)
        
    }
    
    func saveAllFlashcardsToDisk() {
            
            let dictionaryArray = flashcards.map { (card) -> [String: String] in
                return ["question": card.question, "answer": card.answer, "top": card.top, "middle": card.middle, "bottom": card.bottom]
            }
            
            UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
            
            print("Flashcards saved to UserDefaults")
        }
    
    func readSavedFlashcards() {
            if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
                
                let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, top: dictionary["top"]!, middle: dictionary["middle"]!, bottom: dictionary["bottom"]!)
                }
                
                flashcards.append(contentsOf: savedCards)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionCard.text
            creationController.initialAnswer = answerCard.text
            
            creationController.topSelection = answerTop.title(for: .normal)
            creationController.middleSelection = answerMiddle.title(for: .normal)
            creationController.bottomSelection = answerBottom.title(for: .normal)
        }
    }
}

