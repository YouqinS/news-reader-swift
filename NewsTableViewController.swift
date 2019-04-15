//
//  NewsTableViewController.swift
//  NewsReader
//
//  Created by Andrei Vasilev on 14/04/2019.
//  Copyright © 2019 Andrei Vasilev. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    
    private var articles =  [Article]()
    private var newsUrl: String?
    private var newsTitle: String?
    
    var searchController: UISearchController!
    var filteredResultArray = [Article]()
    
    
    func filterContentFor(serachText text: String) {
        filteredResultArray = articles.filter { (article) -> Bool in
            return (article.title!.lowercased().contains(text.lowercased()))
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        navigationController?.isToolbarHidden = true
        navigationController?.navigationBar.isHidden = true
        
        definesPresentationContext = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    func fetchData() {
        //        let jsonUrlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2cda9e9005464b6987b4799fe7311336"
        
        let jsonUrlString = "https://newsapi.org/v2/everything?q=apple&from=2019-04-13&to=2019-04-13&sortBy=popularity&apiKey=2cda9e9005464b6987b4799fe7311336"
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            print(data)
            
            do {
                
                let headlines: Headlines = try JSONDecoder().decode(Headlines.self, from: data)
                print(headlines.articles )
                self.articles = headlines.articles
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch let error {
                print("Error serialization json", error)
            }
            }.resume()
        
        
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResultArray.count
        } else {
            return articles.count
            
        }
        
        
    }
    
    func articleToDisplayAt(indexPath: IndexPath) -> Article {
        let article: Article
        if searchController.isActive && searchController.searchBar.text != "" {
            article = filteredResultArray[indexPath.row]
        } else {
            article = articles[indexPath.row]
        }
        
        return article
    }
    
    
    private func configureCell(cell: NewTableViewCell, for indexPath: IndexPath) {
        
        let article = articleToDisplayAt(indexPath: indexPath)
        
        if let articleTitle = article.title {
            cell.titleLabel.text = articleTitle
        }
        if let articleTitle = article.title {
            cell.titleLabel.text = articleTitle
        }
        
        DispatchQueue.global().async {
            guard let url = article.urlToImage, let imgUrl = URL(string: url) else {return}
            guard let imageData = try? Data(contentsOf: imgUrl) else {return}
            DispatchQueue.main.async {
                cell.thumbView.image = UIImage(data: imageData)
                
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! NewTableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articleToDisplayAt(indexPath: indexPath)
        
        if let title = article.title {
            newsTitle = title
        }
        if let url = article.url {
            newsUrl = url
        }
        
        performSegue(withIdentifier: "Details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        
        if let url = newsUrl {
            webViewController.url = url
        }
    }
    
}


extension NewsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(serachText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}

extension NewsTableViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
}
