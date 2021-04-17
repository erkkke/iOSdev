//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Erkebulan on 06.04.2021.
//

import Foundation
import FirebaseDatabase

struct Tweet {
    var content: String?
    var author: String?
    var fullName: String?
    var date: String?
    var hashtag: String?
    var uid: String?
    
    var dict: [String: String] {
        return ["content": content!, "author": author!, "fullName": fullName!, "date": date!, "hashtag": hashtag!, "uid": uid!]
    }
    
    init(content: String, author: String, fullName: String, date: String, hashtag: String, uid: String) {
        self.content = content
        self.author = author
        self.fullName = fullName
        self.date = date
        self.hashtag = hashtag
        self.uid = uid
    }
    
    init(snapshot: DataSnapshot) {
        if let value = snapshot.value as? [String: String] {
            content = value["content"]!
            author = value["author"]!
            fullName = value["fullName"]!
            date = value["date"]!
            hashtag = value["hashtag"]!
            uid = value["uid"]
        }
    }
}
