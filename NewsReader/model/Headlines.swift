//
//  Headlines.swift
//  NewsReader
//
//  Created by Andrei Vasilev on 14/04/2019.
//  Copyright © 2019 Andrei Vasilev. All rights reserved.
//

import Foundation

struct Headlines: Codable {
   
    
   
    
    let status: String;
    let totalResults: Int;
    let articles: [Article]
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable {
    let source: Source?;
    let author: String?;
    let title: String?;
    let description: String?;
    let url: String?;
    let urlToImage: String?;
    let publishedAt: String?;
    let content: String?;
}
