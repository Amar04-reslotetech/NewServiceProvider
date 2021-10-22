//
//  AddBookignSecondViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 26/08/21.
//

import UIKit
import iOSDropDown

class AddBookignSecondViewController: UIViewController {
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var txtBillingType: DropDown!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    var timeArray = [String]()
    var startDate = ""
    var endDate = ""
    var spaceArray:SpaceList?
    var selectedTimeArray = [String]()
    var billingTypeArray = ["Onilne","Creadit Card"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeArray = spaceArray?.slotArray as! [String]
        collectionView.reloadData()
        

        // Do any additional setup after loading the view.
        
        txtBillingType.optionArray = billingTypeArray
        txtBillingType.didSelect{(selectedText , index ,id) in
            self.txtBillingType.text = "\(selectedText)"
        }
      
    }
    
    func uniqueElementsFrom(array: [String]) -> [String] {
      //Create an empty Set to track unique items
      var set = Set<String>()
      let result = array.filter {
        guard !set.contains($0) else {
          //If the set already contains this object, return false
          //so we skip it
          return false
        }
        //Add this item to the set since it will now be in the array
        set.insert($0)
        //Return true so that filtered array will contain this item.
        return true
      }
      return result
    }
    
  
}


//MARKS: B ack Button Pressed
extension AddBookignSecondViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARKS: Book Space Pressed
extension AddBookignSecondViewController
{
    @IBAction func btnBookSpacePressed(_ sender:UIButton)
    {
        if selectedTimeArray.count == 0
        {
            
        }
        else if txtBillingType.text?.isEmpty == true
        {
            
        }
        else
        {
            addBookingAPi()
        }
    }
}

//MARKS: COllecction View Data SOurece
extension AddBookignSecondViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddBookingSecondCollectionViewCell
        cell.lblTime.text = timeArray[indexPath.row]
        cell.lblTime.backgroundColor = selectedTimeArray.contains(timeArray[indexPath.item]) ? .green : .white
        return cell
      
    }
    
}



//MARKS: Collection View Delegate
extension AddBookignSecondViewController:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let index = timeArray[indexPath.item]
        
        if cell?.isSelected == true
        {
            selectedTimeArray.append(index)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        let index = timeArray[indexPath.item]
       if cell?.isSelected == false
        {
        selectedTimeArray = uniqueElementsFrom(array: selectedTimeArray)
        if let index = selectedTimeArray.firstIndex(of: index) {
            
            
         
            selectedTimeArray.remove(at: index)
        }
        }
        
       
    }
}


//MARKS: Collection VIew flow Layout delegate
extension AddBookignSecondViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: (width)/3.2, height: 60)
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



//MARKS: Add Boking Space APi
extension AddBookignSecondViewController
{
    func  addBookingAPi()
    {
        var param = [String:Any]()
        param = ["spID":UserDefaults.standard.value(forKey: "ID")!,"spaceID":spaceArray?.id,"billingType":txtBillingType.text!,"startDate":startDate,"endDate":endDate,"slots":selectedTimeArray]
        var header = [String:String]()
        header = ["Content-Type":"application/json"]
    Api.postSPSpaceBooking(param,header)
        {  (res, err)  in
            print(res!)
            if err != nil
            {
                self.removeSpinner()
//                self.noHistory.isHidden = false
             
//                AlertFunctions.showAlert(message: err!)
//                self.txtEmail.text = ""
                
//                self.showNotification(title: "App name", message: err!)
            }
            else
            {
                if res!["success"] != nil, res!["success"] as? Bool == true
                {
                  
//                    self.noHistory.isHidden = true
                   
                    
                }
                else
                {
                    self.removeSpinner()
                   

                    
                }
               
        
            }
    }
    }
}


