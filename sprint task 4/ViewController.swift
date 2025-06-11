//
//  ViewController.swift
//  sprint task 4
//
//  Created by Матвей Симонов on 10.06.2025.
//
import UIKit

class ViewController: UIViewController {
    

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
  
    
    private var correctAnswers = 0
    private var currentQuestionIndex = 0
    private let font = UIFont(name: "YSDisplay-Medium", size: 20)
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = font {
            questionLabel?.font = font
            indexLabel?.font = font
        }
        questionTitleLabel?.font = UIFont(name: "YSDisplay-Bold", size: 23)
        questionTitleLabel?.text = "Рейтинг этого фильма меньше чем 5?"
    }
    
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        shownswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        let currentQuestion = questions[currentQuestionIndex] // 1
        let givenAnswer = false
        
        shownswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer) // 3
    }
    
    
    func shownswerResult(isCorrect: Bool){
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    
    
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let a = QuizStepViewModel(
            image: UIImage(
                named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)\(questions.count)")
        return a
    }
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        questionTitleLabel.text = step.question
        indexLabel.text = step.questionNumber
    }
    
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            
        } else {
            currentQuestionIndex += 1
            let nextQuestion = questions[currentQuestionIndex]
            let viewModel = convert(model: nextQuestion)
            
            show(quiz: viewModel)
        }
    }
    private func alertAndAction() {
        let alert = UIAlertController(
            title: "My Alert",
            message: "This is an alert.",
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button is clicked!")
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        let alertAction = UIAlertAction(title: "Сыграть ещё раз", style: .default){_ in
            self.currentQuestionIndex = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex] // 2
            let viewModel = self.convert(model: firstQuestion)
            self.show(quiz: viewModel)
        }
    }
}


