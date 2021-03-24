//
//  ViewModelContentView.swift
//  TestDefferedLink
//
//  Created by Julio Cesar on 3/24/21.
//

import Foundation
import FacebookCore
import FacebookLogin
import Combine

final class ViewModelContentView: ObservableObject {
    
    @Published var facebookResultString: String = ""
    
    func fbLogginButton() {
        guard  AccessToken.current == nil else  {
            self.facebookResultString = "ACCESS TOKEN NOT NIL"
            return
        }

        let login = LoginManager()
        login.logIn(permissions: ["public_profile","email"], from: nil) { (result, error) in
            if error != nil
            {
                let err = error! as NSError
                let alertaMessage = (err.userInfo[ErrorLocalizedDescriptionKey] ?? "UNKNOWN ERROR" ) as! String

                self.facebookResultString = alertaMessage
            }
            else if result!.isCancelled
            {
            }
            else if result!.token?.userID != nil
            {
                if result!.declinedPermissions.contains("email")
                {
                    let str = "EMAIL DECLINED"
                    self.facebookResultString = str
                    print(str)
                    
                } else if result!.grantedPermissions.contains("email")  {
                    let str = "EMAIL GRANTED"
                    self.facebookResultString = str
                    print(str)
                } else {
                    let str = "LOGIN UNKNOWN ERROR"
                    self.facebookResultString = str
                    print(str)
                }
                
            }
        
        }

    }
}
