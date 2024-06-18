//
//  LoadingIndicatorTableViewCell.swift
//  PrefetchData
//
//  Created by Oğuz Canbaz on 17.06.2024.
//

import UIKit

class LoadingIndicatorTableViewCell: UITableViewCell {

    // MARK: -- Components
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: -- Life Cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .black.withAlphaComponent(0.2)
        loadingIndicator.color = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: -- Functions
    
    func startAnimating(){
        loadingIndicator.startAnimating()
    }
}
