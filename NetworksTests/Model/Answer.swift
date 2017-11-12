//
//  Answer.swift
//  NetworksTests
//
//  Created by bestK1ng on 02/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class Answer {

    let id: Int
    let title: String
    let isRight: Bool
    let questionID: Int
    
    init(id: Int, title: String, isRight: Bool, questionID: Int) {
        self.id = id
        self.title = title
        self.isRight = isRight
        self.questionID = questionID
    }
}
