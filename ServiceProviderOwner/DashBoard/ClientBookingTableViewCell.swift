//
//  ClientBookingTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit

class ClientBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSlots: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSpace: UILabel!
    @IBOutlet weak var lblProgram: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI( with objec:ClientList)
    {
        lblDate.text = objec.date!
        lblSlots.text = "Slot: \(objec.time!)"
        lblProgram.text = objec.class_Name
        lblSpace.text = objec.space_Name
        lblName.text = objec.client_Name
    }

}
