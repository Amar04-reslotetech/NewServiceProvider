
//

import UIKit
import Alamofire

typealias handler = ((_ response: Any?, _ error: Error?) -> (Void))


/// This is a api common class for generating request.

class APIMaster: NSObject {
    
    static let sharedInstance = APIMaster()
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
       let manager = Alamofire.SessionManager.default

    /**
     This function is made for checking internet connectivity.
     */
    
    //MARK:- Network Rechability
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager!.isReachable
    }
    
    
    /**
     This function is made for generating an api request using get method.
     
     - Parameters:  api, httpmethod, httpheaders, parameters encoding type and a completion block
     
     ### Usage Example: ###
     ````
     APIMaster.sharedInstance.apiRequestWith(urlString: loginURLRequest, httpMethod: .get, requestHeaders: APIHeaders.headers(contentTypeKey: JSONFormKey), parmEncodingType: URLEncoding(JSONEncoding.default)) { (response, error) -> (Void) in
     }
     
     ````
     
     */
    
    //MARK:- API Call
    
    func apiRequestWith(urlString: String,httpMethod: HTTPMethod, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
        
        apiRequestWith(urlString: urlString, httpMethod: httpMethod, info: nil, requestHeaders: nil, parmEncodingType: parmEncodingType, completion: completion)
    }
    
    /**
     This function is made for generating an api request for post method
     
     - Parameters:  api, httpmethod, httpheaders, parameters encoding type and a completion block
     
     ### Usage Example: ###
     ````
     APIMaster.sharedInstance.apiRequestWith(urlString: loginURLRequest, httpMethod: .post, info: loginParam , requestHeaders: APIHeaders.headers(contentTypeKey: JSONFormKey), parmEncodingType: URLEncoding(destination: .queryString)) { (response, error) -> (Void) in
     
     }
     ````
     */
    func apiRequestWithObject(urlString: String,httpMethod: HTTPMethod ,info: [String:Any], requestHeaders: HTTPHeaders?, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
        
        if isConnectedToInternet()
        {
            var urlStr = Configurator.baseURL + urlString
         //   print(urlStr)
//            if (urlString == ApiEndPoints.currency || urlString == ApiEndPoints.getBustList) {
//
//                urlStr = Configurator.baseURL2 + urlString
//            }
            let apiName = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
            AppCommon.PrintLogs(printStatement:"Url1: ---- \(apiName ?? "")")
                 AppCommon.PrintLogs(printStatement:"Param: ---- \(info )")
            do
            {
                var request = try URLRequest(url: urlStr, method: httpMethod, headers: requestHeaders)
                do
                {
                    request.httpBody = try JSONSerialization.data(withJSONObject: info, options: [])
               // print(request.httpBody!)
                    manager.request(request).responseJSON
                        { (response) in
                            AppCommon.PrintLogs(printStatement:"Response: ---- \(response)")
                        if nil != response.result.value
                        {
                            DispatchQueue.main.async { completion(response.result.value, nil)}
                        }
                        else
                        {
                            ManageHudder.sharedInstance.stopActivityIndicator()
                           // AlertFunctions.showAlert(message: "Server Error")
                            print("----------------------------   Server Error  ----------------------------")
                               // DispatchQueue.main.async { completion(nil, "Server Error")}
                        }
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        else
        {
            ManageHudder.sharedInstance.stopActivityIndicator()
            AlertFunctions.showAlert(message: "No Internet Connection")
        }
    }

    func apiRequestWith(urlString: String,httpMethod: HTTPMethod ,info: [String:Any]?, requestHeaders: HTTPHeaders?, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
        
        if isConnectedToInternet()
        {
            var urlStr = Configurator.baseURL + urlString
         //   print(urlStr)
//            if (urlString == ApiEndPoints.currency || urlString == ApiEndPoints.getBustList) {
//
//                urlStr = Configurator.baseURL2 + urlString
//            }
            let apiName = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

            manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
           // AppCommon.PrintLogs(printStatement:"Url: ---- \(apiName ?? "")")
           // AppCommon.PrintLogs(printStatement:"Param: ---- \(info ?? [:])")

            manager.request(apiName!, method:
                httpMethod, parameters: info, encoding: parmEncodingType, headers: requestHeaders).responseJSON { (response) in
                    
                    if nil != response.result.value {
                        DispatchQueue.main.async { completion(response.result.value, nil)}
                    } else {
                        ManageHudder.sharedInstance.stopActivityIndicator()
                    //    AlertFunctions.showAlert(message: "Server Error")
                        print("----------------------------   Server Error  ----------------------------")
                    }
            }
        }
        else {
            ManageHudder.sharedInstance.stopActivityIndicator()
            AlertFunctions.showAlert(message: "No Internet Connection")
        }
    }

    /**
     This function is made for generating an api request when we have to send data(i.e json or image) in encoded format
     
     - Parameters:  api, httpmethod, httpheaders, parameters encoding type and a completion block
     
     ### Usage Example: ###
     ````
     APIMaster.sharedInstance.apiRequestWith(urlString: loginURLRequest, httpMethod: .post, info: loginParam , requestHeaders: APIHeaders.headers(contentTypeKey: JSONFormKey), parmEncodingType: URLEncoding(destination: .queryString)) { (response, error) -> (Void) in
     
     }
     
     ````
     
     */
    
    func multiPartAPIRequestWith(urlString: String, parametersInfo: [String:Any]?,data: [String:Data]?, fileName: String, fileExt: String, requestHeaders: HTTPHeaders?, completion: @escaping handler)
    {
        if isConnectedToInternet()
        {
            manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
            
            manager.upload(
                multipartFormData: { multipartFormData in
                    
                    //Image
                    
                    if data != nil
                    {
                        for (key, value) in data! {
                            multipartFormData.append(value, withName: key, fileName: fileName, mimeType: fileExt)
                        }
                    } else {
                        
                        AppCommon.PrintLogs(printStatement:"Empty_Image >>>>>>>>>>>>>>> Don't worry not an issue")
                    }
                    
                    //Parameters
                    
                    if parametersInfo != nil
                    {
                        for (key, value) in parametersInfo! {
                            
                            if key == "studentIds" {
                                let arrData =  try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                                multipartFormData.append(arrData, withName: key as String)
                            } else {
                                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                            }
                            
                        }
                        
                    } else {
                        
                        AppCommon.PrintLogs(printStatement:"Empty_Info>>>>>>>>>>>>>>> Don't worry not an issue")
                    }
            },
                to: Configurator.baseURL2 + urlString,
                method:.post,
                headers: requestHeaders,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            if nil != response.result.value {
                                DispatchQueue.main.async { completion(response.result.value, nil)}
                            } else {
                                ManageHudder.sharedInstance.stopActivityIndicator()
                                AlertFunctions.showAlert(message: (response.error?.localizedDescription)!)
                            }
                        }
                    case .failure(let encodingError):
                        DispatchQueue.main.async {
                            completion(nil, encodingError)
                        }
                    }
            })
        } else {
            ManageHudder.sharedInstance.stopActivityIndicator()
            AlertFunctions.showAlert(message: "No Internet Connection")
        }
    }
    
    
    
    func apiRequestWithJsonString(urlString: String,httpMethod: HTTPMethod ,info: [String:Any]?, requestHeaders: HTTPHeaders, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
        
        if isConnectedToInternet()
        {
            let apiName = Configurator.baseURL + urlString
            
            manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
            
            manager.request(apiName, method:
                httpMethod, parameters: info, encoding: parmEncodingType, headers: requestHeaders).responseString { (response) in
                    
                    // AppCommon.PrintLogs(printStatement:"PARAMETERS >>>>>>>>>>> \(info ?? ["":""])")
                    
                    if nil != response.result.value {
                        DispatchQueue.main.async { completion(response.result.value, nil)}
                    } else {
                        DispatchQueue.main.async { completion(nil, response.result.error)}
                    }
            }
        }
            
        else {
            ManageHudder.sharedInstance.stopActivityIndicator()
            AlertFunctions.showAlert(message: "No Internet Connection")
        }
    }
 

//
func savemisccharge(urlString: String,httpMethod: HTTPMethod ,info:  [String:Any] , requestHeaders: HTTPHeaders?, parmEncodingType: ParameterEncoding, completion: @escaping handler) {
    
    if isConnectedToInternet()
    {
        var urlStr = Configurator.baseURL + urlString
        print(urlStr)
//        if (urlString == ApiEndPoints.currency || urlString == ApiEndPoints.getBustList) {
//
//            urlStr = Configurator.baseURL2 + urlString
//        }
        let apiName = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        manager.session.configuration.timeoutIntervalForRequest = Configurator.requsetTimeOut
        //AppCommon.PrintLogs(printStatement:"Url1: ---- \(apiName ?? "")")
        //     AppCommon.PrintLogs(printStatement:"Param: ---- \(info )")
        
        do
        {
            var request = try URLRequest(url: urlStr, method: httpMethod, headers: requestHeaders)
            do
            {
                request.httpBody = try JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
                // print(request.httpBody!)
                manager.request(request).responseJSON
                    { (response) in
                        
                        if nil != response.result
                        {
                            DispatchQueue.main.async { completion(response.result.value, nil)}
                        }
                        else
                        {
                            ManageHudder.sharedInstance.stopActivityIndicator()
                           // AlertFunctions.showAlert(message: "Server Error")
                            print("----------------------------   Server Error  ----------------------------")
                        }
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
    else
    {
        ManageHudder.sharedInstance.stopActivityIndicator()
        AlertFunctions.showAlert(message: "No Internet Connection")
    }
}

//    func apiRequestForRawData(urlString: String, isBaseUrl2: Bool, httpMethod: HTTPMethod ,info: [String:Any]?, requestHeaders: HTTPHeaders?, completion: @escaping handler) {
//
//        if isConnectedToInternet() {
//
//            print("Url: --- \(urlString)")
//            print("Param: --- \(info!)")
//
//            let headers = [
//                "cache-control": "no-cache",
//                "Postman-Token": "06d85934-5ea1-40b1-aa47-8b2e5ca4c8e0"
//            ]
//            let postData = try! JSONSerialization.data(withJSONObject: info!, options: .prettyPrinted)
//
//            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
//                                              cachePolicy: .useProtocolCachePolicy,
//                                              timeoutInterval: 10.0)
//            request.httpMethod = httpMethod.rawValue
//            request.allHTTPHeaderFields = requestHeaders == nil ? headers : requestHeaders
//            request.httpBody = postData as Data
//
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//                if (error != nil) {
//                    ManageHudder.sharedInstance.stopActivityIndicator()
//                    AlertFunctions.showAlert(message: (error?.localizedDescription)!)
//                } else {
//                    guard let dataResponse = data, error == nil else {
//                        print(error?.localizedDescription ?? "Response Error")
//                        return }
//                    if let stringData = String(data: dataResponse, encoding: String.Encoding.utf8) {
//                        print("Response -- \(stringData)")
//                        let data = stringData.data(using: .utf8)!
//                        if let res = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any]{
//                            DispatchQueue.main.async { completion(res, nil)}
//                        } else {
//                            ManageHudder.sharedInstance.stopActivityIndicator()
//                            DispatchQueue.main.async {
//                                AlertFunctions.showAlert(message: "Json Error !!!")
//                            }
//                        }
//                    }
//                }
//            })
//            dataTask.resume()
//        } else {
//            ManageHudder.sharedInstance.stopActivityIndicator()
//            AlertFunctions.showAlert(message: "No Internet Connection")
//        }
//    }

}
//
