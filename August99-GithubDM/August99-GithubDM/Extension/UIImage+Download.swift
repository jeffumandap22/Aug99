//
//  UIImage+Download.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import Foundation
import UIKit

extension UIImageView {

    public func imageFromServerURL(urlString: String) {
        self.image = nil

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, _, error) -> Void in
            if error != nil {
                print(error ?? "Unknown error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }

}
