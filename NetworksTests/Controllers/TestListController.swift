//
//  TestListController.swift
//  NetworksTests
//
//  Created by a.belkov on 12/11/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class TestListController: UICollectionViewController {

    let tests = TestManager.tests
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tests.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.titleLabel.text = tests[indexPath.row].title

        return cell
    }

    // MARK: Seque

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tapOnTest" {
            
            let cell = sender as! UICollectionViewCell
            let index = self.collectionView!.indexPath(for: cell)!.row
            
            let vc = segue.destination as! TestViewController
            
            vc.testSession = TestSession(test: tests[index])
        }
    }

}
