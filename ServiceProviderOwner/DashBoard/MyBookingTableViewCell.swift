//
//  MyBookingTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 23/08/21.
//

import UIKit

class MyBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTimeSlots: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var myOuterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI( with objc:MyBooking)
    {
        lblName.text = objc.space_Name
        lblAddress.text = objc.address
        lblDate.text = objc.start_Date! + " to " + objc.end_Date!
        lblTimeSlots.text = "Slot: \( String(describing: objc.slotArray!.joined(separator: ",")))"
    }

}
