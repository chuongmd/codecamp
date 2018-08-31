//
//  ViewController.swift
//  codecamp.techmaster
//
//  Created by chuongmd on 8/19/18.
//  Copyright © 2018 chuongmd. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBAction func buttonMusicFilter(_ sender: UIButton) {
        if let text = searchBar.text, !text.isEmpty {
            search(text)
        }
    }
    
    @IBAction func buttonVideoFilter(_ sender: UIButton) {
        if let text = searchBar.text, !text.isEmpty {
            search(text)
        }
    }
    
    
    var items: [Item] = []
    var isloading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
        searchCollectionView.register(UINib(nibName: "resultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "resultCollectionViewCell")
        
        searchBar.delegate = self
    }
    
    //    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    //        let newText = (searchBar.text! as NSString).replacingCharacters(in: range, with: text)
    //        if newText.count > 0 {
    //            search(newText)
    //        } else {
    //            items = []
    //            searchCollectionView.reloadData()
    //        }
    //        return true
    //    }
    
    
    func search(_ searchKey: String) {
        
        let baseURLString = "https://itunes.apple.com/search"
        
        let parameter: Parameters =
            
            [ "media" : "all",
              "lang" : "en_us",
              "limit" : "20",
              "term" : searchKey ]
        
        Alamofire.request(baseURLString, method: .get, parameters: parameter).responseData { (response) in
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let results = try jsonDecoder.decode(Result.self, from: data)
                    self.items = results.results
                    
                    self.searchCollectionView.reloadData()
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        //        let urlString = String(format: "https://itunes.apple.com/search?term=%@", searchKey)
        //        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
        //            let url = URL(string: encodedUrlString)  else {
        //                return
        //            }
        //
        //
        //        isloading = true
        //        searchCollectionView.reloadData()
        //
        //        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {(reponse) in
        //            self.isloading = false
        //            guard let data = reponse.data
        //                else {
        //                return
        //            }
        //
        //            self.items = self.parse(data: data)
        //            print(self.items)
        //            DispatchQueue.main.async {
        //                self.searchCollectionView.reloadData()
        //            }
        //
        //        }
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            search(text)
        }
    }
}


extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let witdth = (collectionView.bounds.width - 20 - 40) / 2
        
        return CGSize(width: witdth, height: 200)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCollectionViewCell", for: indexPath) as? resultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.row]
        
        cell.layer.cornerRadius = 9.0
        cell.backgroundColor = UIColor.brown
        cell.trackNameLabel.text = item.trackName
        cell.artistNameLabel.text = item.artistName
        cell.imageView.af_setImage(withURL: item.artworkUrl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        let item = items[indexPath.row]
        
        detailVC.item = item
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

