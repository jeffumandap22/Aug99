//
//  UserCell.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import UIKit

class UserCell: UITableViewCell {

    weak var vcDelegate: ViewControllerDelegate?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var data: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func imageTapped(_ sender: Any) {
        if let data = self.data {
            vcDelegate?.imageViewTapped(data: data)
        }
    }
    @IBAction func nameTapped(_ sender: Any) {
        if let data = self.data {
            vcDelegate?.nameTapped(data: data)
        }
    }
    
}
