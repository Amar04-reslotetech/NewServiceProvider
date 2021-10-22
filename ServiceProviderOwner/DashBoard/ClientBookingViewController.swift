//
//  ClientBookingViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit

class ClientBookingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var history = [ClientList]()
    var search_History = [ClientList]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.tableFooterView = UIView()
        getData()
    }
    

  

}


//MARKS: Back Button Pressed
extension ClientBookingViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}



//MARKS: Add ClientBooking Pressed
extension ClientBookingViewController
{
    @IBAction func btnAddClientBookingPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "AddClassAndProgramViewController") as! AddClassAndProgramViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARKS: Get Data
extension ClientBookingViewController
{
    func getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"type": ""]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.getClientBookingList(param,header)
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
//                    self.serviceeProviderList.removeAll()
                   let cleint_List = res!["bookingList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                            let objec = ClientList(obj: i)
                        self.history.append(objec)
                        }
                    }
//
                    self.search_History = self.history
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


//MARKS: Tableview DataSource
extension ClientBookingViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = history[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientBookingTableViewCell
        cell.setupUI(with: index)
        return cell
    }
}


//MARKS: TableView Delegate
extension ClientBookingViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
        var index = history[indexPath.row]
       
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
         
            let index = self.history[indexPath.item]
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "AddClassAndProgramViewController") as! AddClassAndProgramViewController
            vc.history = index
            vc.isCOming = true
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Deleted")
            
           
            
            var param = [String:Any]()
            param = ["bookingID":index.id!]
            
            var header = [String:String]()
            header = ["Content-Type":"application/json"]
            
            Api.deleteClientBooking(param,header)
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
                    if res!["success"] != nil, res!["success"] as? Bool == true
                    {
                        self.history.remove(at: indexPath.row)
                      
    //                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    //                        self.tableView.deleteRows(at: index, with: .fade)
//                        self.getList()
    //                        self.getEventListData()
                        self.getData()
                        
                        
                    }
                    else
                    {
    //                    self.txtEmail.text = ""
                        self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                        
                    }
            
                }
            }
           
        })
        deleteAction.backgroundColor = UIColor.red

        return [editAction, deleteAction]
        }
    
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
      
        return UITableViewCell.EditingStyle.none
    }
    
    
}



//MARKS: Searbar delegate
extension ClientBookingViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        history = search_History.filter()
        { lead in

  return (lead.class_Name!.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) == true)
        }
        if searchText.isEmpty{
            self.view.endEditing(true)
           getData()
        }

        tableView.reloadData()
    }
    
  
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        if searchBar.text?.isEmpty == true
        {

        }
        else
        {
            
        }
        
        searchBar.resignFirstResponder()
    }
}
