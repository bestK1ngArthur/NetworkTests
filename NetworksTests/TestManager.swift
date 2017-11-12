//
//  TestManager.swift
//  NetworksTests
//
//  Created by bestK1ng on 02/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TestManager {
    
    static let tests = [Test(title: "РК №1", startQuestion: 1, endQuestion: 258),
                        Test(title: "РК №2", startQuestion: 259, endQuestion: 474)]
    
    private var questions: [Question] = []
    private var answers: [Answer] = []
    
    init() {
        loadAnswers()
        loadQuestions()
    }
    
    func question(number: Int) -> Question? {
        
        let rightQuestions = self.questions.filter { (question) -> Bool in
            return question.number == number
        }
        
        return rightQuestions.first
    }
    
    func answersForQuestion(questionID: Int) -> [Answer] {
        
        let answers = self.answers.filter { (answer) -> Bool in
            return answer.questionID == questionID
        }
        
        return answers
    }
    
    private func loadQuestions() {
        
        if let json = json(from: "questions") {
            for questionJSON in json {
                
                let id = questionJSON["QuestionID"] as! Int
                let answers = answersForQuestion(questionID: id)
                
                let question = Question(id: id,
                                        number: questionJSON["Order"] as! Int,
                                        title: questionJSON["Question"] as! String,
                                        complexity: questionJSON["Complicating"] as! Int,
                                        answers: answers)
                
                questions.append(question)
            }
        }
    }
    
    private func loadAnswers() {
        
        if let json = json(from: "answers") {
            for answerJSON in json {
                
                let answer = Answer(id: answerJSON["AnswerID"] as! Int,
                                    title: answerJSON["Answer"] as! String,
                                    isRight: (answerJSON["IsGood"] as! Int) == 1,
                                    questionID: answerJSON["QuestionID"] as! Int)
                
                answers.append(answer)
            }
        }
    }
    
    private func json(from file: String) -> [[String: Any]]? {
        
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let json = json as? [[String: Any]] {
                    return json
                }
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
