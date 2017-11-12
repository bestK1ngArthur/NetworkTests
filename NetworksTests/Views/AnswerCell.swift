//
//  AnswerCell.swift
//  NetworksTests
//
//  Created by bestK1ng on 02/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    enum State {
        case undefined
        case right
        case wrong
    }
    
    private(set) var state: State = .undefined
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleView.backgroundColor = UIColor.groupTableViewBackground
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            self.titleView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        } else {
            //self.titleView.backgroundColor = UIColor.groupTableViewBackground
        }
    }
    
    func setState(_ state: State) {
        
        switch state {
        case .undefined:
            self.titleView.backgroundColor = UIColor.groupTableViewBackground
        case .right:
            self.titleView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        case .wrong:
            self.titleView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
    }
}
