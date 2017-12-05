//
//  authViewController.swift
//  ToDoList
//
//  Created by Sean Kearney on 04/12/2017.
//  Copyright © 2017 Sean Kearney. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {

    /*
    @IBAction func BioAuthButton(_ sender: Any) {
        self.performSegue(withIdentifier: "bioAuth", sender: self)
    }
    //userAuthenticationRequired()
    //print("ran 1")
    */

    
    @IBAction func bioAuthButton(_ sender: Any) {
        userAuthenticationRequired()
    }
    
    //touchID/FaceID
    func userAuthenticationRequired(){
        let context: LAContext = LAContext()
        var error: NSError?
        let description = "Authenticate To View ToDo List"
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: { (success, error) in
                
                if success {
                    self.performSegue(withIdentifier: "bioAuth", sender: self)
                } else {
                    print("error")
                }
            })
        }
        
        if error != nil {
            print("error")
        }
    }
}
