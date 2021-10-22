//
//  ClientHistoryTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class ClientHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI( with objec:ClientHistory)
    {
        lblName.text = objec.name!
    }

}
