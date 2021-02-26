//
//  InfoVC.swift
//  WebApp
//
//  Created by Erkebulan on 25.02.2021.
//

import UIKit
import WebKit

protocol DetailViewDelegate {
    func updateTableViewController()
}

class InfoVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var webPage: Site?
    var index: Int?
    var delegate: DetailViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findIndex()
        openWebPage()
        addingFavorite()
        setBackColor()
    }
    

    func openWebPage() {
        if let ind = index {
            let curUrl = URL(string: (Main.list[ind].url!))
            let request = URLRequest(url: curUrl!)
            webView.load(request)
        }
    }
 
    
    func addingFavorite() {
        if index != nil {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
            tap.numberOfTapsRequired = 3
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func tripleTapped() {
        Main.list[index!].isFavorite = !Main.list[index!].isFavorite
        setBackColor()
        delegate?.updateTableViewController()
    }
    

    func setBackColor() {
        if let ind = index {
            if Main.list[ind].isFavorite {
                navigationController?.navigationBar.backgroundColor = .yellow
            }
            else {
                navigationController?.navigationBar.backgroundColor = .white
            }
        }
    }
    
    func findIndex() {
        for i in 0...Main.list.count - 1 {
            if webPage?.name == Main.list[i].name && webPage?.url == Main.list[i].url {
                index = i
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
