//
//  TableViewViewController.swift
//  PrefetchData
//
//  Created by Oğuz Canbaz on 17.06.2024.
//

import UIKit

class TableViewViewController: UIViewController {
    
    // MARK: -- Components
    
    @IBOutlet weak var tableView: UITableView!
    
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
        let nibFirstCell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibFirstCell, forCellReuseIdentifier: "TableViewCell")
        
        let nibLoadingCell = UINib(nibName: "LoadingIndicatorTableViewCell", bundle: nil)
        tableView.register(nibLoadingCell, forCellReuseIdentifier: "LoadingIndicatorTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
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
            self.tableView.reloadData()
        }
    }
}

// MARK: -- Extensions

extension TableViewViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.row >= self.data.count - 1 }) {
            fetchData(2)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberofRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if data.indices.contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.label.text = "\(data[indexPath.row])"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingIndicatorTableViewCell", for: indexPath) as! LoadingIndicatorTableViewCell
            cell.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width / 2
    }
}
