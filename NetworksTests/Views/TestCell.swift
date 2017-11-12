//
//  TestCell.swift
//  NetworksTests
//
//  Created by a.belkov on 12/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override var isHighlighted: Bool {
        didSet {
            self.backView.backgroundColor = isHighlighted ? UIColor.gray.withAlphaComponent(0.5) : UIColor.groupTableViewBackground
        }
    }
}
