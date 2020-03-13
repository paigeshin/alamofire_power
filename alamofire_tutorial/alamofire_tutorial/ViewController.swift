//
//  ViewController.swift
//  alamofire_tutorial
//
//  Created by shin seunghyun on 2020/03/13.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    
    let baseURL = "http://192.168.0.15:5544";
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func getButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
//            self.getRequest()
            self.getRequestWithHeader()
        }
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.postRequestWithAuthentication()
        }
    }
    
    @IBAction func putButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.putRequest()
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.deleteRequest()
        }
    }
    
}

//Network 관련
extension ViewController {
    //Get Request
    func getRequest(){
        let request = AF.request(baseURL)
        request.responseJSON {(response) in
            if let value = response.value as? [String: Any]{
                let message = Message(JSON: value)
                
                self.textLabel.text = message!.message
            }
            
        }
    }
    
    //With Header, authentication
    func getRequestWithHeader(){
        
        let headers: HTTPHeaders = [
            HTTPHeader.authorization(username: "user1@gmail.com", password: "testPassword"),
            HTTPHeader.accept("application/json")
        ]
        
        let request = AF.request("\(baseURL)/header", headers: headers)
    
        request.responseJSON {(response) in
            if let value = response.value as? [String: Any]{
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
        
        }
    }
    
    //with Authentication
    func postRequestWithAuthentication(){
        let user = "test1@gamil.com"
        let password = "123123"
//        let parameters = ["user": user, "password": password]
        
        let request = AF.request("\(baseURL)/auth", method: .post)
        request.authenticate(username: user, password: password)
        request.responseJSON { (response) in
            if let value = response.value as? [String: Any] {
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
            debugPrint(response)
            
        }
        print(request)
    }
    
    //Authentication using URLCredential
    func postURLCredentialAuthentication(){
        let user = "test1@gamil.com"
        let password = "123123"
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        let request = AF.request("\(baseURL)/credential", method: .post)
        request.authenticate(with: credential)
        request.responseJSON { (response) in
            if let value = response.value as? [String: Any] {
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
            debugPrint(response)
        }
        print(request)
    }
    
    //Post Request
    func postRequest(){
        let parameters: [String: Any] = ["user": "user1", "message": "anything"]
        print("Values to be sent \(parameters)")
        let request = AF.request(baseURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON{(response) in
            if let value = response.value as? [String: Any] {
                debugPrint(response)
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
        }
        
    }
    
    
    //Put Request
    func putRequest(){
        let parameters: [String: Any] = ["user": "user1", "message": "anything"]
        print("Values to be sent \(parameters)")
        let request = AF.request(baseURL, method: .put, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON{(response) in
            if let value = response.value as? [String: Any] {
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
        }
    }
    
    //Delete Request
    func deleteRequest(){
        let parameters: [String: Any] = ["user": "user1"]
        print("Values to be sent \(parameters)")
        let request = AF.request(baseURL, method: .delete, parameters: parameters, encoding: JSONEncoding.default)
        request.responseJSON{(response) in
            if let value = response.value as? [String: Any] {
                let message = Message(JSON: value)
                self.textLabel.text = message!.message
            }
        }
        
    }
    
}

