//
//  Question.swift
//  NetworksTests
//
//  Created by bestK1ng on 02/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class Question {

    let id: Int
    let number: Int
    let title: String
    let complexity: Int
    let answers: [Answer]
    
    init(id: Int, number: Int, title: String, complexity: Int, answers: [Answer]) {
        self.id = id
        self.number = number
        self.title = title
        self.complexity = complexity
        self.answers = answers
    }
}
