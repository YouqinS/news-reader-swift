////
////  NewsFetcher.swift
////  NewsReader
////
////  Created by Andrei Vasilev on 11/04/2019.
////  Copyright © 2019 Andrei Vasilev. All rights reserved.
////
//
//import Foundation
//
//class NewFetcher {
//
//    let apiUrl = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=2cda9e9005464b6987b4799fe7311336"
//
//    func fetchData () {
//
//        guard let url = URL(string: apiUrl) else {
//            fatalError("Failed to create URL")
//        }
//
//        let task = URLSession.shared.downloadTask(with: url) {data, response, error in
//            if let error = error {
//                print("Client error \(error)")
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//                    return
//
//            }
//
//            if let data = data, let string = String(data: data, encoding: .utf8) {
//
//
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//
//                let articles = json!["aritlces"] as! [Any]
//
//            }
//
//
//
//        }
//
//        task.resume()
//    }
//
//}
//
//
//
