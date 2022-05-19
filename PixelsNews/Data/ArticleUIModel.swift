//
//  ArticleDetailUIModel.swift
//  PixelsNews
//
//  Created by Berkay Sancar on 19.05.2022.
//

import Foundation


struct ArticleUIModel {
    
    //let source: SourceUIModel?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init() {
        //self.source = nil
        self.author = nil
        self.title = nil
        self.description = nil
        self.url = nil
        self.urlToImage = nil
        self.publishedAt = nil
        self.content = nil
    }
    
    init(
        //source: SourceUIModel,
        author: String?,
        title: String?,
        description: String?,
        url: String?,
        urlToImage: String?,
        publishedAt: String?,
        content: String?
    ) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
}

struct SourceUIModel {
    
    let name: String? = nil
    
}


