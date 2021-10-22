//
//  MyFaciltySubTableViewCell.swift
//  ServiceProvider
//
//  Created by Amar Patil on 04/05/21.
//

import UIKit

class MyFaciltySubTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSpaceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setupUI( with spc:spaceListDis)
//    {
//        lblSpaceName.text = spc.name!
//        lblAddress.text = spc.address!
//    }

}
