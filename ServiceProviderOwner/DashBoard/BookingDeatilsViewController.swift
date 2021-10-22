//
//  BookingDeatilsViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 23/08/21.
//

import UIKit
import AlamofireImage

class BookingDeatilsViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBill: UILabel!
    @IBOutlet weak var lblHourlyRate: UILabel!
    @IBOutlet weak var lblTotalEstimasteHours: UILabel!
    @IBOutlet weak var lblSlots: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblF_Contact: UILabel!
    @IBOutlet weak var lblF_Name: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var imageList:Array<String> = []
    
    var data:MyBooking?
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getDeatils()
    }
    

   

}



//MARKS: Back Button Pressed
extension BookingDeatilsViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Complete Payment Pressed
extension BookingDeatilsViewController
{
    @IBAction func btnCompletePaymentPressed(_ sender:UIButton)
    {
        
    }
}


//MARKS: Get Details
extension BookingDeatilsViewController
{
    func  getDeatils()
    {
        var param = [String:Any]()
        param = ["bookingID":data!.id! as Any]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.viewFacilities(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.tableView.isHidden = true
//                self.noFacilitiesOwner.isHidden = false
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
//                    self.tableView.isHidden = false
//                    self.noFacilitiesOwner.isHidden = true
//                    self.facilitiesArray.removeAll()
                   let cleint_List = res!["Booking"] as! Dictionary<String,Any>
                    if cleint_List != nil
                    {
                        self.lblName.text = cleint_List["businessName"] as? String ?? ""
                        self.lblF_Name.text = "facility Owner: \(cleint_List["foName"]  as! String)"
                        var conatct = String(cleint_List["foContact"]  as! Int)
                        self.lblF_Contact.text = "Contact no: \(conatct) "
                        self.lblAddress.text = "\(cleint_List["spaceAddress"]  as! String)"
                        self.lblDate.text = " \(cleint_List["startDate"]  as! String)"
                           + " to " +  "\(cleint_List["endDate"]   as! String)"
                        self.lblSlots.text = " Slots : \(cleint_List["slotArray"]   as! String)"
                        var estHours = String(cleint_List["estHours"]  as! Int)
                        self.lblTotalEstimasteHours.text = "Total Est Hours: \(estHours)"
                        var hourRate = String(cleint_List["hourlyRate"]  as! Int)
                        self.lblHourlyRate.text = "Hourly Rate: \(hourRate)"
                        var bill = String(cleint_List["amount"]  as! Int)
                  
                        self.lblBill.text = "Est Bill: \(bill)"
                        
                        self.lblStatus.text = "Status:\(cleint_List["status"]  as! String)"
                        var imagelist = cleint_List["imageList"] as? Array<String>
//                        for i in 0...imagelist!.count
//                        {
                        self.imageList = imagelist!
//                        }
                        self.collectionView.reloadData()
                        
                    }
//
//                    self.Search_facilitiesArray = self.facilitiesArray
//                    self.tableView.reloadData()
                    self.removeSpinner()
                    
                }
                else
                {
                    self.removeSpinner()
//                    self.tableView.isHidden = true
//                    self.noFacilitiesOwner.isHidden = false
//                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
               
        
            }
    }
    }
}


//MARKS: Collection view datasource
extension BookingDeatilsViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookingDeatilsCollectionViewCell
        var index = imageList[indexPath.item]
        var imeUrl = index
        let rep1 = imeUrl.replacingOccurrences(of: " ", with: "%20")
        let rep2 = rep1.replacingOccurrences(of: "~/", with: "")
        let url  = NSURL(string:rep2)
        cell.imageView.af_setImage(withURL: url! as URL, placeholderImage: #imageLiteral(resourceName: "circle"), filter: nil, progress: nil,imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        cell.imageView.contentMode = .scaleToFill
//        cell.imageView.image = UIImage
        
        return cell
    }
}


//MARKS: Flow layout delegate
extension BookingDeatilsViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 200)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

