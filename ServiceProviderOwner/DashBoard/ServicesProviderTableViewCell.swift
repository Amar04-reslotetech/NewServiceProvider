//
//  ServicesProviderTableViewCell.swift
//  ServiceProvider
//
//  Created by Amar Patil on 16/04/21.
//

import UIKit

class ServicesProviderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSpaceAvailble: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    func setupUI(with ser:serviceProvider) {
        lblName.text = "\(String(describing: ser.firstName!)) \(String(describing: ser.lastName!))"
        lblEmail.text = ser.email
        lblAddress.text = ser.address
//        if ser.currentSpace == ""
//        {
//            lblSpaceAvailble.text = ""
//        }
//        else
//        {
//        lblSpaceAvailble.text = "Current Space : \(ser.currentSpace!)"
//        lblSpaceAvailble.textColor = .green
//            
//        }
        lblPhoneNumber.text = ser.contact!.toString()
    }
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
