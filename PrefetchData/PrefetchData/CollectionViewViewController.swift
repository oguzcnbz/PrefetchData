//
//  CollectionViewViewController.swift
//  PrefetchData
//
//  Created by Oğuz Canbaz on 17.06.2024.
//

import UIKit

class CollectionViewViewController: UIViewController {
    
    // MARK: -- Components
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: -- Properties
    
    var numberofRows:Int = 5
    var allData: [String] = []
    var data: [String] = []
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllData()
        prepareCollectionView()
        fetchData(5)
    }
    
    // MARK: -- Functions
    
    private func prepareCollectionView() {
        let nibFirstCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibFirstCell, forCellWithReuseIdentifier: "CollectionViewCell")
        
        let nibLoadingCell = UINib(nibName: "LoadingIndicatorCollectionViewCell", bundle: nil)
        collectionView.register(nibLoadingCell, forCellWithReuseIdentifier: "LoadingIndicatorCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
    }
    
    func getAllData() {
        for i in stride(from: 1, to: 80, by: 1) {
            let string:String = "\(i).Hücre"
            allData.append(string)
        }
    }
    
    func fetchData(_ count: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let endIndex = min(self.data.count + count, self.allData.count)
            self.data.append(contentsOf: self.allData[self.data.count..<endIndex])
            self.numberofRows = self.data.count + 2
            self.collectionView.reloadData()
        }
    }
}

// MARK: -- Extensions

extension CollectionViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= self.data.count - 1 }) {
            fetchData(2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberofRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if data.indices.contains(indexPath.row) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.label.text = "\(data[indexPath.row])"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingIndicatorCollectionViewCell", for: indexPath) as! LoadingIndicatorCollectionViewCell
            cell.startAnimating()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth
        let cellHeight = cellWidth / 2 - 30
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
