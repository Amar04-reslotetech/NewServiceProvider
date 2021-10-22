//
//  ClientHistoryDeatilsTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

protocol ClientHistoryDelgate:AnyObject {
    func InVoiceGenerate(cell:ClientHistoryDeatilsTableViewCell)
    
    func ViewInvoice(cell:ClientHistoryDeatilsTableViewCell)
    func ViewPayment(cell:ClientHistoryDeatilsTableViewCell)
}

class ClientHistoryDeatilsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnViewPayment: UIButton!
    @IBOutlet weak var btnViewInvoice: UIButton!
    @IBOutlet weak var btnGenerateInvice: UIButton!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBusiness: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    weak var delegate:ClientHistoryDelgate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupUI( with client:ClientHistoryDetails)
    {
        lblTime.text = "Slots: \(String(describing: client.time!))"
        lblPrice.text = "$\(client.bill!.toString())"
        lblDate.text = "Date:\(String(describing: client.date!))"
        lblName.text = client.name
        lblBusiness.text = client.space_Name
        lblStatus.text = "Status:\(client.status ?? "")"
        
        if client.status == "New" || client.status == "Not Invoice Generated"
        {
            btnViewPayment.isHidden = true
            btnViewInvoice.isHidden = true
        }
        else if client.status == "Invoice Generated"
        {
            btnViewPayment.isHidden = true
            btnGenerateInvice.isHidden = true
        }
        else if client.status == "Payment Completed"
        {
            btnGenerateInvice.isHidden = true
          
        }
        else if client.status == "Appointment Completed"
        {
            btnViewPayment.isHidden = false
            btnViewInvoice.isHidden = false
        }
        
    }
    
    @IBAction func btnGenerateInvoicePressed(_ sender: Any) {
  
        delegate?.InVoiceGenerate(cell: self)
        
        
    }
    
    
    @IBAction func btnViewInvoice(_ sender: Any) {
        
        delegate?.ViewInvoice(cell: self)
    }
    
    
    @IBAction func btnViewPayment(_ sender: Any) {
        delegate?.ViewPayment(cell: self)
    }
    
    

}
