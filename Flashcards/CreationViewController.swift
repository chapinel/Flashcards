//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Elizabeth Bakewell on 3/6/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var topChoiceTextField: UITextField!
    
    @IBOutlet weak var middleChoiceTextField: UITextField!
    
    @IBOutlet weak var bottomChoiceTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var topSelection: String?
    var middleSelection: String?
    var bottomSelection: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        
        topChoiceTextField.text = topSelection
        middleChoiceTextField.text = middleSelection
        bottomChoiceTextField.text = bottomSelection
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let choiceTop = topChoiceTextField.text
        
        let choiceMiddle = middleChoiceTextField.text
        
        let choiceBottom = bottomChoiceTextField.text
        
        if questionText == nil || questionText!.isEmpty || answerText == nil || answerText!.isEmpty || choiceTop == nil || choiceTop!.isEmpty || choiceMiddle == nil || choiceMiddle!.isEmpty || choiceBottom == nil || choiceBottom!.isEmpty {
            let okAction = UIAlertAction(title: "Go Back", style: .default)
            
            let alert = UIAlertController(title: "Oops! Something's missing...", message: "You need to complete all fields before you can finish making your card.", preferredStyle: .alert)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }
        
        else {
            
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, topChoice: choiceTop!, middleChoice: choiceMiddle!, bottomChoice: choiceBottom!)
            
            dismiss(animated: true)
            
        }
        
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
