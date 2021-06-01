//
//  ViewController.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import UIKit
import Foundation

protocol ViewControllerDelegate: class {
    func imageViewTapped(data: User)
    func nameTapped(data: User)
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    let parser = Parser()
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loading.startAnimating()
        parser.parse { (user) in
            self.user = user
            if user.count != 0 {
                self.loadTableView(isSuccess: true, message: "")
            } else {
                print("Error")
            }
        } onFail: { message in
            print(message)
            self.loadTableView(isSuccess: false, message: message)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
    
    func loadTableView(isSuccess: Bool, message: String?) {
        if isSuccess {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loading.stopAnimating()
                self.loading.isHidden = true
            }
        } else {
            DispatchQueue.main.async {
                self.loading.stopAnimating()
                self.loading.isHidden = true
                self.errorMessage.isHidden = false
                self.errorMessage.text = message
            }
        }
    }
    
    func imageViewTapped(data: User) {
        let view =  ProfileImageController()
        view.user = data
        view.parser = parser
        view.modalPresentationStyle = .fullScreen
        view.modalTransitionStyle = .coverVertical
        self.present(view, animated: true, completion: nil)
    }
    
    func nameTapped(data: User) {
        let view = GitHubWebViewController()
        view.user = data
        view.modalPresentationStyle = .fullScreen
        view.modalTransitionStyle = .coverVertical
        self.present(view, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell {
            let userData = user[indexPath.row]
            cell.data = userData
            cell.nameLabel.text = userData.login
            cell.userImageView.imageFromServerURL(urlString: userData.avatar_url)
            cell.vcDelegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.user = []
        self.loading.isHidden = false
        loading.startAnimating()
        
        parser.parse { (user) in
            self.user = user
            if user.count != 0 {
                self.loadTableView(isSuccess: false, message: "")
            }
        } onFail: { message in
            print(message)
            self.loadTableView(isSuccess: false, message: message)
        }
    }
    
}

