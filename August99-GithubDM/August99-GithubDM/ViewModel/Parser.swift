//
//  Parser.swift
//  August99-GithubDM
//
//  Created by Jeff Umandap on 5/20/21.
//

import Foundation
import UIKit

struct Parser {
    
    func parse(completion: @escaping ([User]) -> Void, onFail:((_ message:String)->())?) {
        let api = URL(string: "https://api.github.com/users")
        URLSession.shared.dataTask(with: api!) { data, _, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Unknown error")
                onFail?(error?.localizedDescription ?? "Unknown error")
                return
            } else {
                if let result: [User] = try? JSONDecoder().decode([User].self, from: data!) {
                    print(result)
                    completion(result)
                } else {
                    if let error: Error = try? JSONDecoder().decode(Error.self, from: data!) {
                        onFail?(error.message)
                    }
                }

            }
            
        }.resume()
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
}
