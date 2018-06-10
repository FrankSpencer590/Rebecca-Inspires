//
//  LoginViewController.swift
//  Rebecca Inspires
//
//  Created by Samuel Miller on 15/05/2018.
//  Copyright © 2018 Samuel Miller. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UITextFieldDelegate {
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var emailaddress: ShakingTextField!
    @IBOutlet weak var password: ShakingTextField!
    @IBOutlet weak var IncorrectLabel: UILabel!
    let transition = CircularTransition()
    
    
    let serviceName = "com.sam.keychain"
    var userName = "sam"
    var serverName = "keychain"
    //var useMemoryOnly = true
    
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        LoginButton.layer.cornerRadius = LoginButton.frame.size.width / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 2
    }
    override func viewDidAppear(_ animated: Bool) {
        LoginButton.layer.cornerRadius = LoginButton.frame.size.width / 2
        SignUpButton.layer.cornerRadius = SignUpButton.frame.size.width / 2
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = LoginButton.center
        transition.circleColor = LoginButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = LoginButton.center
        transition.circleColor = LoginButton.backgroundColor!
        
        return transition
    }
    
    
    
    
    
    
    
    
    
    
    
    
    public func readCredentialsFromKeychain(_ reason:String, onComplete: @escaping (_ success:Bool, _ error:NSError?) -> Void) {
            #if ( arch(i386) || arch(x86_64) )
            let context = LAContext()
            self.readValues(context)
            onComplete(true, nil)
            #else
            guard let flags = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                              kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                              SecAccessControlCreateFlags.userPresence,
                                                              nil)
                else{
                    return
            }
            
            let context = LAContext()
            context.evaluateAccessControl(flags, operation: LAAccessControlOperation.useItem, localizedReason: reason) { succ, err in
                
                guard succ && err == nil else {
                    SDLog("Could not evaluate the access control -> \(String(describing: err))")
                    let error = err! as NSError
                    if error.code == LAError.Code.userCancel.rawValue {
                        //                            self.uniqueId = "NoKeychain \(UUID().uuidString.replacingOccurrences(of: "-", with: ""))"
                        self.readValues(nil)
                        onComplete(true,error)
                    }
                    else {
                        onComplete(false, error)
                    }
                    return
                }
                self.readValues(context)
                onComplete(true, nil)
            }
            #endif
        }
    
    
    //end of READ
    
    
    func deleteKey(_ key:String) -> Bool
    {
        let account = "\(self.serviceName):\(key)"
        let keychainQuery = [
            (kSecClass as String)              : kSecClassGenericPassword,
            (kSecAttrAccount as String)        : account,
            (kSecAttrService as String)        : self.serviceName
            ] as [String : Any]
        
        return SecItemDelete(keychainQuery as CFDictionary) == noErr
    }
    
    public func removeAll() -> Bool
    {
        var allOk = true
        let secItemClasses = [ kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity ]
        for secItemClass in secItemClasses {
            let spec = [ (kSecClass as String) : secItemClass]
            if SecItemDelete(spec as CFDictionary) != noErr {
                allOk = false
            }
        }
        self.password = nil
        self.userName = ""
        self.serverName = ""
        return allOk
    }
    
    
    
    fileprivate func get(_ key: String, context:LAContext?) -> AnyObject?
    {
        NSLog("Reading value for \(key)")
        let account = "\(self.serviceName):\(key)"
        
        var keychainQuery = [
            (kSecClass as String)                   : kSecClassGenericPassword,
            (kSecReturnData as String)              : kCFBooleanTrue,
            (kSecMatchLimit as String)              : kSecMatchLimitOne,
            (kSecAttrAccount as String)             : account,
            (kSecAttrService as String)             : self.serviceName
            ] as [String : Any]
        var value:AnyObject? = nil
        if key == "Password", let context = context {
            keychainQuery[(kSecUseAuthenticationContext as String)] =  context
        }
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        
        if status == noErr && dataTypeRef != nil
        {
            if let data =  dataTypeRef as? Data
            {
                value = NSKeyedUnarchiver.unarchiveObject(with: data) as AnyObject?
            }
        }
        else
        {
            print("Failed to get \(key). Error = \(status)")
        }
        return value
    }
    
    
    fileprivate func set(_ key:String, value:AnyObject) -> Bool
    {
        var success = false
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        let account = "\(self.serviceName):\(key)"
        let accessControlError:UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
        #if ( arch(i386) || arch(x86_64) )
        let keychainQuery = [
            (kSecClass as String)              : kSecClassGenericPassword,
            (kSecAttrAccount as String)        : account,
            (kSecAttrService as String)        : self.serviceName,
            (kSecValueData as String)          : data,
            (kSecAttrAccessible as String)     : kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            ] as [String : Any]
        #else
        var keychainQuery = [
            (kSecClass as String)              : kSecClassGenericPassword,
            (kSecAttrAccount as String)        : account,
            (kSecAttrService as String)        : self.serviceName,
            (kSecValueData as String)          : data,
            (kSecUseAuthenticationUI as String): kSecUseAuthenticationUIFail
            
            
            ] as [String : Any]
        if key == kKeychain.Password {
            let accessControlRef = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .userPresence, accessControlError)
            keychainQuery[(kSecAttrAccessControl as String)] =  accessControlRef!
        }
        #endif
        SecItemDelete(keychainQuery as CFDictionary)
        let result = SecItemAdd(keychainQuery as CFDictionary, nil)
        success = (result == noErr)
        if !success {
            print("Failed to save \(key) to keychain. Result=\(result)")
        }
        return success
    }
    
    
    
    
    func readValues(_ context: LAContext) {
        self.get("test",context)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func login() {
        if ((MyData.sharedInstance.logindetails[emailaddress.text!]) != nil) {
            MyData.sharedInstance.correctemail = true
            let expectedpassword = (MyData.sharedInstance.logindetails[emailaddress.text!])
            if expectedpassword == password.text! {
                IncorrectLabel.isHidden = true
                UserDefaults.standard.set("true", forKey: "isLoggedin")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! ViewController
                present(vc, animated: true, completion: nil)
                UserDefaults.standard.set(true, forKey: "loggedIn")
            }
            else{
                IncorrectLabel.isHidden = false
                password.shake()
            }
        }
        else{
            MyData.sharedInstance.correctemail = false
            IncorrectLabel.isHidden = false
            emailaddress.shake()
        }
    }
    
    @IBAction func Login(_ sender: Any) {
        login()
    }
    
    private func textFieldShouldReturn(_ textField: ShakingTextField) -> Bool {
        print("return")
        login()
        textField.resignFirstResponder()
        return true
    }

}

