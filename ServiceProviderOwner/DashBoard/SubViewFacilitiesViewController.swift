//
//  SubViewFacilitiesViewController.swift
//  ServiceProvider
//
//  Created by Amar Patil on 04/05/21.
//

import UIKit

class SubViewFacilitiesViewController: UIViewController {

    @IBOutlet weak var noFound: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
//    var facilitesArray:facilitiesList?
//    var spaceList = [spaceListDis]()
//    var searchList = [spaceListDis]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        noFound.isHidden = true
//        lblName.text = facilitesArray!.name!
        self.tableView.tableFooterView = UIView()
//        getFacilitiesSubView()
    }
    

    
}


//MARKS: Back Button Pressed
extension SubViewFacilitiesViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "sw") as! SWRevealViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARKS: TableVIew DataSource
extension SubViewFacilitiesViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyFaciltySubTableViewCell
      
        return cell
    }
}


//MARKS: TableView Delegate
extension SubViewFacilitiesViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARKS: Get Data
extension SubViewFacilitiesViewController
{
    func  getFacilitiesSubView()
    {
//        var param = [String:Any]()
//        param = ["businessID":facilitesArray!.id!]
//        var header = [String:String]()
//        header = ["Content-Type":"application/json"]
//
//        Api.facilitiesSpace(param,header)
//        {  (res, err)  in
//
//            if err != nil
//            {
//                self.removeSpinner()
//                self.tableView.isHidden = true
//                self.noFound.isHidden = false
//            }
//            else
//            {
//                if res!["success"] != nil, res!["success"] as? Bool == true
//                {
//                    self.tableView.isHidden = false
//                    self.noFound.isHidden = true
//                    self.spaceList.removeAll()
//                   let cleint_List = res!["spaceList"] as! Array<Dictionary<String,Any>>
//                    if cleint_List != nil
//                    {
//                        for i in cleint_List
//                        {
//                        let objec = spaceListDis(object: i)
//                        self.spaceList.append(objec)
//                        }
//                    }
//                    self.searchList = self.spaceList
//                    self.removeSpinner()
//                    self.tableView.reloadData()
//                }
//                else
//                {
//                    self.removeSpinner()
//                    self.tableView.isHidden = true
//                    self.noFound.isHidden = false
//
//                }
//            }
//    }
    }
}


//MARKS: Search Bar delegate
extension SubViewFacilitiesViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        spaceList = searchList.filter()
//        { lead in
//        
//  return (lead.name!.lowercased().localizedCaseInsensitiveContains(searchText.lowercased()) == true)
//        }
//        if searchText.isEmpty{
//            self.view.endEditing(true)
//            getFacilitiesSubView()
//        }
//      
//        tableView.reloadData()
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


//MARKS: Assign Space
extension SubViewFacilitiesViewController
{
    @IBAction func btnAddSpacePressed (_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "AddAvailabiltyViewController") as! AddAvailabiltyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

