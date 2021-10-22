//
//  AddAvailabiltyViewController.swift
//  ServiceProviderOwner
//
//  Created by Amar Patil on 03/06/21.
//

import UIKit

class AddAvailabiltyViewController: UIViewController {
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtHourlRate: UITextField!
    @IBOutlet weak var txtSizeOfSpace: UITextField!
    @IBOutlet weak var txtNameOfSpace: UITextField!
    @IBOutlet weak var btnSpace: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSpace.layer.cornerRadius = 5
        btnSpace.layer.borderWidth = 0.2
        btnSpace.layer.borderColor = UIColor.gray.cgColor
        btnSpace.backgroundColor = UIColor.white
        datePicker.preferredDatePickerStyle = .wheels
        datePicker1.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker1.datePickerMode = .date
        
        self.addDatePicker(datePicker, textfield:txtStartDate , selector: #selector(donePressed))
        self.addDatePicker1(datePicker1, textfield:txtEndDate , selector: #selector(donePressed3))
        // Do any additional setup after loading the view.
    }
    

    func addDatePicker(_ datepicker : UIDatePicker, textfield: UITextField, selector: Selector) {
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:selector)
        let cancleButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        let spaceButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([cancleButton,spaceButton ,doneButton], animated: false)
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker
        
    }
    
    func addDatePicker1(_ datepicker : UIDatePicker, textfield: UITextField, selector: Selector) {
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:selector)
        let cancleButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        let spaceButton =  UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action:nil)
        toolbar.setItems([cancleButton,spaceButton ,doneButton], animated: false)
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker1
        
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = DateFormats.format13.rawValue
        txtStartDate.text = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        
        view.endEditing(true)
       
        
    }
    @objc func donePressed3(){
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateFormat = DateFormats.format13.rawValue
        txtEndDate.text = dateFormatter.string(from: datePicker1.date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
     
        
        view.endEditing(true)
       
        
    }

}


//MARKS: Button Select
extension AddAvailabiltyViewController
{
    @IBAction func btnAddSpace(_ sender:UIButton)
    {
       
    }
}


//MARKS: Save Pressed
extension AddAvailabiltyViewController
{
    @IBAction func btnSavePressed(_ sender:UIButton)
    {
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: "SubViewFacilitiesViewController") as! SubViewFacilitiesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



//MARKS: COLLECTION VIEW DataSource
extension AddAvailabiltyViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AddTimeSlotsCollectionViewCell
        
        return cell
    }
}


//MARKS: Colection View Flow Layout
extension AddAvailabiltyViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                       sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        return CGSize(width:width/3.2,height:50)
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



//MARKS: Back Bautton Pressed
extension AddAvailabiltyViewController
{
    @IBAction func btnBackPressed(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
