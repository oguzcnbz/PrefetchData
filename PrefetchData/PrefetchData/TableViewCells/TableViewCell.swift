//
//  TableViewCell.swift
//  PrefetchData
//
//  Created by Oğuz Canbaz on 17.06.2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: -- Components
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: -- Life Cycles
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
