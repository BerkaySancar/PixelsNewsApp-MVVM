//
//  BaseResponse.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 12.05.2022.
//

import Foundation


struct BaseResponse: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [ArticleResponse]
    
}

struct ArticleResponse: Decodable {
    
    let source: SourceResponse?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
}

struct SourceResponse: Decodable {
    
    let name: String?
    
}

struct Test {
    let name: String?
    
    
}
