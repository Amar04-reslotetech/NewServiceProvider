//
//  Api.swift
//  Resolutek_Agent
//
//  Created by Amar Patil on 08/12/20.
//

import Foundation
import Alamofire

typealias Complete = ((_ x: Bool) -> (Void))
typealias ApiResponse = ((_ response: [String:Any]?, _ message: String?) -> (Void))
typealias jsonArrayResponse = ((_ response: [[String:Any]]?, _ message: String?) -> (Void))



//MARK: -- Login Module --
class Api {
    
  
    static func verifyEmail(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.verifyEmail)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.verifyEmail, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func loginAPI(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.login)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.login, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getServicesProviderList(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.servicesProviderList)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.servicesProviderList, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getBookingDate(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getBookingDate)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getBookingDate, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func addClientBooking(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.addClientBooking)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.addClientBooking, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func EditClientBooking(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.editClientBooking)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.editClientBooking, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    static func getSpBooking(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getSpBooking)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getSpBooking, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getTimeSlots(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getTimeSlots)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getTimeSlots, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func postNewSpClass(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.postNewSPClass)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.postNewSPClass, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func EditNewSpClass(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.editNewSPClass)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.editNewSPClass, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    static func getServicesProviderHistoryList(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.servicesProviderHistory)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.servicesProviderHistory, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getServicesProviderHistoryDetails(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.servicesProviderDeatils)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.servicesProviderDeatils, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func addServicesProvider(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.addServicesProvider)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.addServicesProvider, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func EditServicesProvider(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.editCLient)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.editCLient, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
  
    static func ClientHistoryList(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.clientHistoryList)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.clientHistoryList, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getClientBookingList(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getClientBookingList)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getClientBookingList, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func getClassProgram(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getClassProgrma)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getClassProgrma, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    static func HistorySP(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.historySp)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.historySp, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func MakePayment(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.MakePayment)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.MakePayment, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func generatedClientHistoryInvoice(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.MakePayment)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.MakePayment, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    static func postSPSpaceBooking(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.postSPSpaceBooking)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.postSPSpaceBooking, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    static func getSPAvailableSpaceList(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getSPAvailableSpaceList)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getSPAvailableSpaceList, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    static func ClientHistoryDetails(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.clientHistoryDetails)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.clientHistoryDetails, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
  
    
    static func addBusiness(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.addBusiness)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.addBusiness, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    static func getDashBoard(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getDashBoard)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getDashBoard, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    static func addSpace(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.addSpace)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.addSpace, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func viewFacilities(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.viewFacilities)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.viewFacilities, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func deleteClient(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.deleteCLient)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.deleteCLient, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    static func deleteClientBooking(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.deleteClientBooking)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.deleteClientBooking, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    static func facilitiesSpace(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.facilitiesSpace)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.facilitiesSpace, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    
    static func getProfileDetails(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.getProfileDetails)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.getProfileDetails, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    static func updateProfile(_ param: [String:Any],_ header:[String:String], apiResponse:@escaping(ApiResponse)) {
        
        ManageHudder.sharedInstance.startActivityIndicator()
       //  showLoader()
        print("Email Url -- \(Configurator.baseURL+ApiEndPoints.updateProfile)")
        APIMaster.sharedInstance.apiRequestWithObject(urlString: ApiEndPoints.updateProfile, httpMethod: .post, info: param, requestHeaders: header, parmEncodingType: URLEncoding.default) { (response, error) -> (Void) in
        
            ManageHudder.sharedInstance.stopActivityIndicator()
       //   hideLoader()
            if nil != error
            {
                AlertFunctions.showAlert(message: (error?.localizedDescription)!)
            } else {
                if  let response = response as? [String:Any] {
                    print("Verify  Res -- \(response)")
                    if  (response["success"] as? Int) == 0  {
                        apiResponse(nil, response["message"] as? String ?? "" )
                    } else {
                        apiResponse(response, nil)
                    }
                } else {
                    apiResponse(nil, "Error in json format")
                }
            }
        }
    }
    
    
    
  
   
    }


