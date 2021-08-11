//
//  NewsFeed.swift
//  NewsApp
//
//  Created by Carmen on 2/10/2020.
//  Copyright © 2020 Carmen. All rights reserved.
//


import Foundation

struct NewsFeed : Codable {
    var status:String = ""
    var totalResults:Int = 0
    var articles: [Article]?
  
}
struct Article : Codable {
  
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
}
