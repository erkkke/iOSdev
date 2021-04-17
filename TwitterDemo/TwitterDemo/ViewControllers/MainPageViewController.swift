//
//  MainPageViewController.swift
//  TwitterDemo
//
//  Created by Erkebulan on 04.04.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    
    var tweets: [Tweet] = []
    var currentUser: User?
    var name: String?
    var surname: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        myTableView.separatorStyle = .none

        
        currentUser = Auth.auth().currentUser
        
        Database.database().reference().child("users/\(currentUser!.uid)").observeSingleEvent(of: .value) {    [weak self] (snapshot) in
            let value = snapshot.value as? NSDictionary
            self?.name = (value!["name"] as! String)
            self?.surname = (value!["surname"] as! String)
            self?.date = (value!["birthday"] as! String)
            self?.fullName.text = "\(self?.name ?? "") \(self?.surname ?? "")"
            self?.birthday.text = "Born \(value!["birthday"] as! String)"
        }
        
        loadTweets()
        loadAvatar()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! CustomCell
        cell.email.text = currentUser?.email
        cell.date.text = tweets[indexPath.row].date
        cell.name.text = tweets[indexPath.row].fullName
        cell.hashtag.text = tweets[indexPath.row].hashtag
        cell.tweetText.text = tweets[indexPath.row].content
        
        let islandRef = Storage.storage().reference().child("avatars/\(currentUser!.uid)/avatar.png")
        islandRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil {
                let image = UIImage(data: data!)
                cell.userImage.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        
        let ref = Database.database().reference()
        let usersRef = ref.child("tweets")
        let queryRef = usersRef.queryOrdered(byChild: "content").queryEqual(toValue: self.tweets[indexPath.row].content)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key
                    ref.child("tweets/\(uid)").removeValue()
                }
            })
            self.tweets.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .fade)
            self.myTableView.reloadData()

        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            let alert = UIAlertController(title: "Edit tweet", message: "Enter a text", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = self?.tweets[indexPath.row].content
            }
            
            alert.addTextField { (textField) in
                textField.text = self?.tweets[indexPath.row].hashtag
            }
            
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak alert] (_) in
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy HH:mm"
                let result = formatter.string(from: date)
                let content = alert?.textFields![0]
                let hashtag = alert?.textFields![1]
                
                queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        let uid = userSnap.key

                        ref.child("tweets/\(uid)/content").setValue(content?.text)
                        ref.child("tweets/\(uid)/date").setValue(result)
                        ref.child("tweets/\(uid)/hashtag").setValue(hashtag?.text)
                    }
                })
                
                self?.myTableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
                alert?.dismiss(animated: true, completion: nil)
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .systemRed
        editAction.backgroundColor = .systemGreen
            
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return configuration
    }
    
    
    @IBAction func signOutButtonClicked(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("sign out error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func allTweetsButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let page = storyboard.instantiateViewController(identifier: "AllTweetsViewController") as? AllTweetsViewController {
            page.modalPresentationStyle = .fullScreen
            present(page, animated: true, completion: nil)
        }
    }
    
    @IBAction func createTweetButtonClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "What's new?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "hashtags"
        }
        
        let time = Date()
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        let date = df.string(from: time)


        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: { [weak self, weak alert] (_) in
            let content = alert?.textFields![0]
            let hashtag = alert?.textFields![1]
            let tweet = Tweet(content: (content!.text)!, author: (self?.currentUser?.email)!, fullName: (self?.fullName.text)!, date: date, hashtag: (hashtag?.text)!, uid: (self?.currentUser!.uid)!)
            
            Database.database().reference().child("tweets").childByAutoId().setValue(tweet.dict)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditPersonalInfo" {
            let destination = segue.destination as! EditViewController
            destination.userName = name
            destination.userSurname = surname
            destination.date = date
            destination.updateDelegate = self
        }
    }
    
    func loadTweets() {
        currentUser = Auth.auth().currentUser
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let tweet = Tweet(snapshot: snap)
                    if tweet.author == self?.currentUser!.email {
                        self?.tweets.append(tweet)
                    }
                }
            }
            self?.tweets.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    func loadAvatar() {
        let myRef = Storage.storage().reference().child("avatars/\(currentUser!.uid)/avatar.png")
        myRef.getData(maxSize: 5 * 1024 * 1024) { [weak self] data, error in
            if error == nil {
                let image = UIImage(data: data!)
                self?.userImage.image = image
                self?.userImage.layer.cornerRadius = (self?.userImage.frame.height)!/2
            } else {
                print(error!)
            }
        }
    }
    

}

extension MainPageViewController: UpadateProfileInfoDelegate {
    func updateInfo(name: String, surname: String, date: String) {
        fullName.text = name + " " + surname
        birthday.text = "Born " + date
        self.name = name
        self.surname = surname
        self.date = date
        let ref = Database.database().reference()
        let myUser = ref.child("users/\(self.currentUser!.uid)")
        myUser.child("name").setValue(name)
        myUser.child("surname").setValue(surname)
        myUser.child("date").setValue(date)
        loadAvatar()
        loadTweets()
        myTableView.reloadData()
    }
    
}
