//
//  ViewController.swift
//  FBPage
//
//  Created by Sierra 2 on 06/10/17.
//  Copyright © 2017 SandsHellCreations. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import SwiftyJSON

class ViewController: UIViewController {
    
    var data : FBModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnFBAction(_ sender: Any) {
        FBSDKLoginManager().logOut()
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("failed to start graph request: \(String(describing: error))")
                return
            }
            self.getPosts()
        }
    }

//    func graphData() {
//        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name , email, picture.width(480).height(480)"]).start { (connection, result, err) -> Void in
//            if err != nil {
//                print("failed to start graph request: \(String(describing: err))")
//                return
//            }
//            print(result ?? "")
//        }
//        
//    }
    
    func getPosts() {
        var request: FBSDKGraphRequest?
        let accessToken = FBSDKAccessToken.current().tokenString
        let params = ["access_token" : accessToken ?? ""]
        request = FBSDKGraphRequest.init(graphPath: "/171994119827578/posts/", parameters: params, httpMethod: "GET")
        
        request?.start(completionHandler: { (_, result, _) in
            let json = JSON.init(result ?? "")
            self.data = FBModel(attributes: json.dictionaryValue)
            print(json)
            if let _ = self.data?.paging?.next {
                self.getNext()
            }
        })
    }
    
    func getNext() {
        var request: FBSDKGraphRequest?
        let pageDict = FBSDKUtility.dictionary(withQueryString: /self.data?.paging?.next)
        request = FBSDKGraphRequest.init(graphPath: "/171994119827578/posts", parameters: pageDict, httpMethod: "GET")
        request?.start(completionHandler: { (_ , result, _) in
            let json = JSON.init(result ?? "")
            let newPosts = FBModel.init(attributes: json.dictionaryValue)
            let obj = self.data
            obj?.paging = newPosts.paging
            newPosts.posts?.forEach({ (post) in
                obj?.posts?.append(post)
            })
            self.data = obj
            print(json)
            if let _ = self.data?.paging?.next {
                self.getNext()
            }
            self.postDetail()
        })
    }
    
    func postDetail() {
        var request: FBSDKGraphRequest?
        let accessToken = FBSDKAccessToken.current().tokenString
        let params = ["access_token" : accessToken ?? ""]
        request = FBSDKGraphRequest.init(graphPath: "/" + /self.data?.posts?[31].id + "/attachments", parameters: params, httpMethod: "GET")
        request?.start(completionHandler: { (_, result, _) in
            let json = JSON.init(result ?? "")
            print(json)
        })
    }
}

