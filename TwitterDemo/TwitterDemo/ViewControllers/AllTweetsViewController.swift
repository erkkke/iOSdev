//
//  AllTweetsViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 16.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class AllTweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileButton: UIButton!
    
    var displayingTweets: [Tweet] = []
    var tweets : [Tweet] = []
    var currentUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        displayingTweets = tweets
        searchBar.delegate = self
        profileButton.layer.cornerRadius = profileButton.frame.height/2
//        loadAvatar()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingTweets.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allTweetsCell", for: indexPath) as? CustomCell
        cell?.tweetText.text = displayingTweets[indexPath.row].content
        cell?.email.text = displayingTweets[indexPath.row].author
        cell?.name.text = displayingTweets[indexPath.row].fullName
        cell?.date.text = displayingTweets[indexPath.row].date
        cell?.hashtag.text = displayingTweets[indexPath.row].hashtag
        
        let islandRef = Storage.storage().reference().child("avatars/\(displayingTweets[indexPath.row].uid!)/avatar.png")
        islandRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil {
                let image = UIImage(data: data!)
                cell?.userImage.image = image
            }
        }
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            displayingTweets = tweets
        }
        else {
            displayingTweets = tweets.filter{ ($0.hashtag?.lowercased().contains(searchText.lowercased()))!}
        }
//        searchingTweets = tweets.filter{ ($0.hashtag?.lowercased().contains(searchText.lowercased()))!}
//        isSearching = (searchText == "") ? false : true
        myTableView.reloadData()
    }
    
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func loadTweets() {
        currentUser = Auth.auth().currentUser
        let parent =  Database.database().reference().child("tweets")
        parent.observe(.value) { [weak self](snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let tweet = Tweet(snapshot: snap)
                    self?.tweets.append(tweet)
                }
            }
            self?.tweets.reverse()
            self?.displayingTweets = self!.tweets
            self?.myTableView.reloadData()
        }
    }
    
    func loadAvatar() {
        let islandRef = Storage.storage().reference().child("avatars/\(currentUser!.uid)/avatar.png")
        islandRef.getData(maxSize: 5 * 1024 * 1024) { [weak self] data, error in
            if error == nil {
                let image = UIImage(data: data!)
                self?.profileButton.setImage(image, for: .normal)
            } else {
                print(error!)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
