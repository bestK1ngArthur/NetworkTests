//
//  TestSession.swift
//  NetworksTests
//
//  Created by bestK1ng on 04/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TestSession {

    enum Action {
        case next
        case end
    }
    
    var currentQuestion: Question? {
        return manager.question(id: currentQuestionNumber)
    }
    
    var nextQuestion: Question? {
        return manager.question(id: nextQuestionNumber)
    }
    
    var title: String {
        return test.title
    }
    
    private(set) var action: Action = .next
    private(set) var rightAnswersCount = 0
    
    private(set) var currentQuestionNumber: Int = 0
    private(set) var nextQuestionNumber: Int = 0

    private let test: Test
    private let manager: TestManager
    
    init(test: Test) {
        self.test = test
        self.manager = TestManager()

        currentQuestionNumber = test.startQuestion
        
        if currentQuestionNumber < test.endQuestion {
            action = .next
        } else {
            action = .end
        }
    }
    
    func next() {
        
        if currentQuestionNumber < test.endQuestion {
            action = .next
            currentQuestionNumber += 1
        } else {
            action = .end
        }
    }
    
    func answer(isRight: Bool) {
        if isRight {
            self.rightAnswersCount = rightAnswersCount + 1
        }
    }
}
