//
//  ClientHistoryViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit

class ClientHistoryViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var history = [ClientHistory]()
    var search_History = [ClientHistory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }
    

  

}


//MARKS: Back Button Pressed
extension ClientHistoryViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: TavbleView DataSOurce
extension ClientHistoryViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = history[indexPath.item]
        let cell =  tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClientHistoryTableViewCell
        cell.setupUI(with: index)
        return  cell
    }
}

//MARKS: Tableview delegate
extension ClientHistoryViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = history[indexPath.item]
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "ClientHistoryDetailsViewController") as! ClientHistoryDetailsViewController
        vc.client_History = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARKS: Api Calling
extension ClientHistoryViewController
{
    func getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.ClientHistoryList(param,header)
        {  (res, err)  in
            print(res)
            if err != nil
            {
                self.removeSpinner()
//                self.noHistory.isHidden = false
                self.tableview.isHidden = true
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
//                    self.noHistory.isHidden = true
                    self.tableview.isHidden = false
//                    self.serviceeProviderList.removeAll()
                   let cleint_List = res!["historyList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                        let objec = ClientHistory(object: i)
                        self.history.append(objec)
                        }
                    }
//
                    self.search_History = self.history
//
                    self.removeSpinner()
                    self.tableview.reloadData()
                    
                }
                else
                {
                    self.removeSpinner()
                    self.tableview.isHidden = true

                    
                }
               
        
            }
    }
    }
}


//MARKS: Search Bar delegate
extension ClientHistoryViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        history = search_History.filter()
        { lead in

  return (lead.name!.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) == true)
        }
        if searchText.isEmpty{
            self.view.endEditing(true)
           getData()
        }

        tableview.reloadData()
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
