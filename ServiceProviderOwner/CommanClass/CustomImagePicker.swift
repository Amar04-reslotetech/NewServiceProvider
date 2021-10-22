
/**
 This class is of image picker with custom cropper
 */
import UIKit
import AVFoundation

protocol CustomImagePickerProtocol {
    func didFinishPickingImage(image:UIImage)
}

class CustomImagePicker: NSObject {
    
    var viewController:UIViewController?
    var delegate:CustomImagePickerProtocol!
    
    func openImagePicker(controller:UIViewController) {
        
        self.viewController = controller
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select a option", message: nil, preferredStyle: .actionSheet)
        
  //    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      
            let cameraBtn = UIAlertAction(title: "Open Camera", style: .default) { (action) in
                
                if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                    //already authorized
                    DispatchQueue.main.async {
                    self.openCamera()
                    }
                } else {
                    AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                        if granted {
                            DispatchQueue.main.async {
                            self.openCamera()
                            }
                        } else {
                            DispatchQueue.main.async {
                            self.showAlertWithSetting()
                            }
                        }
                    })
                }
            }

        
        let galleryBtn = UIAlertAction(title:  "Open Gallery", style: .default) { (action) in
            DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.viewController?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        let cancelBtn = UIAlertAction(title:  "Cancel", style: .cancel) { (action) in
            
            actionSheetController.dismiss(animated: true, completion: nil)
        }
        
        actionSheetController.addAction(cameraBtn)
        actionSheetController.addAction(galleryBtn)
        actionSheetController.addAction(cancelBtn)
        actionSheetController.modalPresentationStyle = .popover
        
    
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = self.viewController?.view
            popoverController.sourceRect = CGRect(x: (self.viewController?.view.bounds.midX)!, y: (self.viewController?.view.bounds.midY)!, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        
        self.viewController?.present(actionSheetController, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.viewController?.present(imagePicker, animated: true, completion: nil)
        }  else {
            AlertFunctions.showAlert(message: "Camera not available")
        }
    }
    
    func showAlertWithSetting() {
        
        AlertFunctions.showAlert(message: "Camera usage permission debied, go to Settings to allow.") {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
    }
}

extension CustomImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Not Origanal")
            return
        }
        let controller = CropViewController()
        controller.delegate = self
        controller.image = pickedImage
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("error in image -- ")
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CustomImagePicker: CropViewControllerDelegate {
    
    func cropViewController(_ controller: CropViewController, didFinishCroppingImage image: UIImage, transform: CGAffineTransform, cropRect: CGRect) {
        delegate.didFinishPickingImage(image: image)
        controller.navigationController?.popViewController(animated: true)
    }
    
    func cropViewControllerDidCancel(_ controller: CropViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
}
