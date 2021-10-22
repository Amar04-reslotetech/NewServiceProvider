//
//  ListOfSpaceTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class ListOfSpaceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNsme: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI( with objec:SpaceList)
    {
        lblNsme.text = objec.name
        lblAddress.text = objec.address
    }

  
    

}
