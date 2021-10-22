//
//  ViewServicesProviderViewController.swift
//  ServiceProvider
//
//  Created by Amar Patil on 16/04/21.
//

import UIKit

class ViewServicesProviderViewController: UIViewController {

    @IBOutlet weak var noServicesProvider: UIView!
    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblCurrent: UILabel!
    @IBOutlet weak var myFilterView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var serviceeProviderList = [serviceProvider]()
    var searchServiceProvider = [serviceProvider]()
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    }
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       noServicesProvider.isHidden = true
    type = "Current"
        getList()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewServicesProviderViewController.tapFunction))
                lblCurrent.isUserInteractionEnabled = true
                lblCurrent.addGestureRecognizer(tap)
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(ViewServicesProviderViewController.tapFunction1))
                lblAll.isUserInteractionEnabled = true
        lblAll.addGestureRecognizer(tap1)
        myFilterView.isHidden = true
    }
    

    @objc
       func tapFunction(sender:UITapGestureRecognizer) {
        
        self.type = "Current"
        getList()
//        let sort = searchServiceProvider.sort { $0.id! > $1.id!
//
//         }
//         self.serviceeProviderList = searchServiceProvider
//         self.tableView.reloadData()
        myFilterView.isHidden = true
       }
    @objc
       func tapFunction1(sender:UITapGestureRecognizer) {
        self.type = "All"
        getList()
//        getList()
        myFilterView.isHidden = true
       }

}


//MARKS: Filter Provider Pressed
extension ViewServicesProviderViewController
{
    @IBAction func btnFilterPressed(_ sender:UIButton)
    {
        myFilterView.isHidden = false
    }
}

//MARKS: Back Button Pressed
extension ViewServicesProviderViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "sw") as! SWRevealViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARKS: TableView DataSource
extension ViewServicesProviderViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceeProviderList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = serviceeProviderList[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ServicesProviderTableViewCell
        cell.setupUI(with: index)
        return cell
    }
}

//MARKS: Tableview delegate
extension ViewServicesProviderViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
        var index = serviceeProviderList[indexPath.row]
       
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
         
            let index = self.serviceeProviderList[indexPath.item]
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "AddClientViewController") as! AddClientViewController
            vc.ServiceProvder = index
            vc.isComigFrom = true
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.backgroundColor = UIColor.blue

        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Deleted")
            
           
            
            var param = [String:Any]()
            param = ["clientID":index.id!]
            
            var header = [String:String]()
            header = ["Content-Type":"application/json"]
            
            Api.deleteClient(param,header)
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
                        self.serviceeProviderList.remove(at: indexPath.row)
                      
    //                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    //                        self.tableView.deleteRows(at: index, with: .fade)
                        self.getList()
    //                        self.getEventListData()
                        
                        
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



//MARKS: Add Services Provider Pressed
extension ViewServicesProviderViewController
{
    @IBAction func btnAddPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "AddClientViewController") as! AddClientViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARKS: Get List
extension ViewServicesProviderViewController
{
    func getList()
    {
       
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"type":self.type]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
        
        Api.getServicesProviderList(param,header)
        {  (res, err)  in
//            print(res!)
            if err != nil
            {
                self.removeSpinner()
                self.tableView.isHidden = true
                self.noServicesProvider.isHidden = false
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                    self.tableView.isHidden = false
                    self.noServicesProvider.isHidden = true
                    self.serviceeProviderList.removeAll()
                   let cleint_List = res!["clientList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = serviceProvider(object: i)
                        self.serviceeProviderList.append(objec)
                        }
                    }
                    
                    self.searchServiceProvider = self.serviceeProviderList
                    
                    self.removeSpinner()
                    self.tableView.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
                    self.tableView.isHidden = true
                    self.noServicesProvider.isHidden = false
//                    self.txtEmail.text = ""
//                    self.showNotification(title: "App name", message: res!["Message"] as? String ?? "")
                    
                }
               
        
            }
    }
    }
}





//MARKS: Search Bar delegate
extension ViewServicesProviderViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        serviceeProviderList = searchServiceProvider.filter(){ lead in

            return (lead.firstName!.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) == true)
         
        }
        if searchText.isEmpty{
            self.view.endEditing(true)
          getList()
        }
        tableView.reloadData()
    }
    
  
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        if searchBar.text?.isEmpty == true
        {
        }
        else
        {
            self.view.endEditing(true)
          getList()
        }
        
        searchBar.resignFirstResponder()
    }
    
   
}

