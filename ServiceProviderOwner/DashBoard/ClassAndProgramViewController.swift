//
//  ClassAndProgramViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 07/09/21.
//

import UIKit

class ClassAndProgramViewController: UIViewController {

    @IBOutlet weak var lblAll: UILabel!
    @IBOutlet weak var lblActive: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var myHideShowView: UIView!
    @IBOutlet weak var btnHide: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var classAndProgrma_Array = [ClassAndProgram]()
    var search_Array = [ClassAndProgram]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
        myHideShowView.isHidden = true
    }
    

   

}


//MARKS: Back Button Presssed
extension ClassAndProgramViewController
{
    @IBAction func btnBackPresssed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARKS: Button Hide Pressed
extension ClassAndProgramViewController
{
    @IBAction func btnHidePressed(_ sender:UIButton)
    {
       
    }
}


//MARKS: Add Classes Pressed
extension ClassAndProgramViewController
{
    @IBAction func btnAddClassPressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "AddClassesViewController") as! AddClassesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARKS: Get Data
extension ClassAndProgramViewController
{
    func getData()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"type": ""]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.getClassProgram(param,header)
        {  (res, err)  in
            print(res)
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
                   let cleint_List = res!["classList"] as! Array<Dictionary<String,Any>>
                    if cleint_List != nil
                    {
                        for i in cleint_List
                        {
                            let objec = ClassAndProgram(object: i)
                        self.classAndProgrma_Array.append(objec)
                        }
                    }
//
                    self.search_Array = self.classAndProgrma_Array
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




//MARKS: TableView DataSource
extension ClassAndProgramViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classAndProgrma_Array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var index = classAndProgrma_Array[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassAndProgramTableViewCell
        cell.setupUI(with:index)
        return cell
    }
    
}


//MARKS: TABLEVIEW DELEgate
extension ClassAndProgramViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
      
        var index = classAndProgrma_Array[indexPath.row]
       
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
         
            let index = self.classAndProgrma_Array[indexPath.item]
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(identifier: "AddClassesViewController") as! AddClassesViewController
            vc.eidtHistory = index
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
                        self.classAndProgrma_Array.remove(at: indexPath.row)
                      
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
