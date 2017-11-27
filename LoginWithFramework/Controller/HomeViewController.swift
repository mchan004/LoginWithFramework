//
//  HomeViewController.swift
//  LoginWithFramework
//
//  Created by Administrator on 11/27/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageAvata: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkFBLogin()
    }

    var user: User? {
        didSet {
            if let dt = user?.name {
                labelName.text = dt
            }
            if let dt = user?.age {
                labelAge.text = dt
            }
            if let dt = user?.email {
                labelEmail.text = dt
            }
            if let dt = user?.email {
                labelEmail.text = dt
            }
            if let dt = user?.avata, let u = URL(string: dt) {
                
                let session = URLSession(configuration: .default)
                // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
                let downloadPicTask = session.dataTask(with: u) { (data, response, error) in
                    // The download has finished.
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        // No errors found.
                        // It would be weird if we didn't have a response, so check for that too.
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded cat picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                let image = UIImage(data: imageData)
                                // Do something with your image.
                                DispatchQueue.main.async(execute: {
                                    self.imageAvata.image = image
                                })
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }
                downloadPicTask.resume()
            }
        }
    }
    
    func checkFBLogin() {
        if FBSDKAccessToken.current() == nil {
            return
        }
        
        let parameters = ["fields": "email, name, birthday, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start { (connection, result, error) in
            if error != nil {
                print(error!)
                return
            }
            guard let data = result as? [String:Any] else { return }
            
            var u = User()
            print(data)
            if let dt = data["name"] as? String {
                u.name = dt
            }
            
            if let dt = data["birthday"] as? String {
                u.age = dt
            }
            
            if let picture = data["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary, let url = data["url"] as? String {
                u.avata = url
            }
            self.user = u
        }
    }
}
