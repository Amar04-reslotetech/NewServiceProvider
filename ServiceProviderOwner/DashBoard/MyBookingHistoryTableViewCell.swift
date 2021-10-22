//
//  MyBookingHistoryTableViewCell.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

protocol HistorySP:AnyObject {
    func makePayment(cell:MyBookingHistoryTableViewCell)
}

class MyBookingHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
  
    @IBOutlet weak var btnViewPaymentReceipt: UIButton!
    @IBOutlet weak var btnMakePayment: UIButton!
    @IBOutlet weak var btnInvoice: UIButton!
    @IBOutlet weak var lblEstBill: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblSlot: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblBill: UILabel!
    @IBOutlet weak var lblName: UILabel!
    weak var delegate:HistorySP?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUI(with obj:MyBookingHistory)
    {
        lblName.text = obj.name
        lblSlot.text = obj.slots
        lblBill.text = "$" + obj.bill!.toString()
        lblEstBill.text = "$" + obj.bill!.toString()
        lblHours.text = obj.hours!.toString()
        lblDate.text = obj.date! + "  to  " + obj.endDate!
        lblStatus.text = obj.status!
        
        if obj.status == "Invoice Not Generated"
        {
            btnInvoice.isHidden = true
            btnMakePayment.isHidden = true
            btnViewPaymentReceipt.isHidden = true
        }
        else if obj.status == "Invoice Generated"
        {
            btnViewPaymentReceipt.isHidden = true
        }
        else if obj.status == "Payment Completed"
        {
            btnMakePayment.isHidden = true
        }
        else if obj.status == "Appointment Completed"
        {
          
            btnMakePayment.isHidden = true
        }
    }
    
    
    @IBAction func btnMakePaymentPressed(_ sender: UIButton) {
        
        delegate?.makePayment(cell: self)
    }
    
   

}
