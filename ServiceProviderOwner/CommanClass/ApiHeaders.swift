/**
 This class generates custom headers to send in api's
 */
import UIKit

class ApiHeaders {
  
  static func headerWithAuthAndContentType() -> [String: String] {
    //let accessToken = kAppDelegateObj.currentUser?.accessToken ?? ""
    let accessToken = ""
    let headerWithAuth = [
      "Authorization": "Bearer \(accessToken)"
    ]
    return headerWithAuth
  }
}
