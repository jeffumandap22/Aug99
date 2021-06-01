//
//  ProfileImageController.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import UIKit

class ProfileImageController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var user: User?
    var parser: Parser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setData(data: user!)
    }
    
    func setData(data: User) {
        self.user = data
        if parser.verifyUrl(urlString: data.avatar_url) {
            self.profileImage.imageFromServerURL(urlString: data.avatar_url)
        }
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
