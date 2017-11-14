//
//  ViewController.swift
//  NetworksTests
//
//  Created by bestK1ng on 02/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var testSession = TestSession(test: TestManager.tests[0])
    var showAnswers = false
    var questionNumber: Int = 1
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial preparation
        self.actionButton.isEnabled = false
        self.showAnswers = false
        self.navigationItem.title = testSession.title
        
        if let currentQuestion = testSession.currentQuestion {
            self.questionNumberLabel.text = "Вопрос №\(questionNumber)"
            self.countLabel.text = ""
            self.questionLabel.text = currentQuestion.title
            self.answers = currentQuestion.answers.shuffled()
            self.tableView.reloadData()
        }
}
    
    func showQuestion() {
        
        if let currentQuestion = testSession.currentQuestion {
            
            // Preparation for showing
            self.questionNumber += 1
            self.actionButton.isEnabled = false
            self.showAnswers = false
            self.tableView.allowsSelection = true
            
            // Update right answers count
            self.countLabel.text = "\(testSession.rightAnswersCount)"
            
            // Set question
            self.questionNumberLabel.text = "Вопрос №\(questionNumber)"
            self.questionLabel.text = currentQuestion.title
            
            // Update answers
            self.answers = currentQuestion.answers.shuffled()
            self.tableView.reloadData()
            
            // Set button
            if self.testSession.action == .end {
                self.actionButton.setTitle("Завершить", for: .normal)
            } else {
                self.actionButton.setTitle("Следующий", for: .normal)
            }
            
        } else {
            testSession.next()
            showQuestion()
        }
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let answer = answers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        cell.titleLabel.text = answer.title
        
        if showAnswers {
            if answer.isRight {
                cell.setState(.right)
            } else {
                cell.setState(.wrong)
            }
        } else {
            cell.setState(.undefined)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAnswers = true
        tableView.allowsSelection = false
        
        let answer = answers[indexPath.row]
        testSession.answer(isRight: answer.isRight)

        var answersIndexes = [indexPath]
        if !answer.isRight {
            for (index, currentAnswer) in answers.enumerated() {
                if currentAnswer.isRight {
                    answersIndexes.append(IndexPath(row: index, section: 0))
                }
            }
            actionButton.isEnabled = true
        }
        
        tableView.reloadRows(at: answersIndexes, with: .automatic)
        
        if answer.isRight {
            let time = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.action(tableView)
            })
        }
    }
    
    // MARK: Actions
    
    @IBAction func action(_ sender: Any) {
        
        if self.testSession.action == .end {
            // present result vc
        } else {
            testSession.next()
            showQuestion()
        }
    }
}

