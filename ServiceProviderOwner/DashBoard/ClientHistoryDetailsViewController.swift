//
//  ClientHistoryDetailsViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class ClientHistoryDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAaddress: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    var clientHistoryDetailsArray = [ClientHistoryDetails]()
    var client_History:ClientHistory?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.text = client_History?.email
        lblContact.text = client_History?.conatct?.toString()
        lblClientName.text = client_History?.name
        lblAaddress.text = client_History?.address
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    

  
}


//MARKS: Tableview DataSource
extension ClientHistoryDetailsViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientHistoryDetailsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = clientHistoryDetailsArray[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientHistoryDeatilsTableViewCell
        cell.setupUI(with: index)
        cell.delegate = self
        return cell
    }
}


//MARKS: Custom Delegate
extension ClientHistoryDetailsViewController:ClientHistoryDelgate
{
    func ViewInvoice(cell: ClientHistoryDeatilsTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        let data = clientHistoryDetailsArray[indexPath.row]
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "InvoiceDisplayedViewController") as! InvoiceDisplayedViewController
        vc.url = data.invoiceLink!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func ViewPayment(cell: ClientHistoryDeatilsTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        let data = clientHistoryDetailsArray[indexPath.row]
     
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "InvoiceDisplayedViewController") as! InvoiceDisplayedViewController
        vc.url = data.paymentReceipt!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func InVoiceGenerate(cell: ClientHistoryDeatilsTableViewCell) {
        let indexPath = self.tableView.indexPathForRow(at: cell.center)!
        let data = clientHistoryDetailsArray[indexPath.row]
        var param = [String:Any]()
        param = ["bookingID":data.id!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        
        Api.generatedClientHistoryInvoice(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["Success"] != nil, res!["Success"] as? Bool == true
                {
                    
                    self.getData()
                    

                    
                }
                else
                {
//                    self.txtEmail.text = ""
                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
            }
        }
        
    }
    
    
}


//MARKS:Tableview Delegate
extension ClientHistoryDetailsViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARKS: Get Data
extension ClientHistoryDetailsViewController
{
    func getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"clientID":client_History!.id!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.ClientHistoryDetails(param,header)
        {  (res, err)  in
            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.noHistory.isHidden = false
                self.tableView.isHidden = true
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
//                    self.noHistory.isHidden = true
                    self.tableView.isHidden = false
                    self.clientHistoryDetailsArray.removeAll()
                   let cleint_List = res!["bookingList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = ClientHistoryDetails(object: i)
                        self.clientHistoryDetailsArray.append(objec)
                        }
                    }
//
//                    self.search_History = self.history
//
                    self.removeSpinner()
                    self.tableView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
                    self.tableView.isHidden = true

                    
                }
               
        
            }
    }
    }
}
