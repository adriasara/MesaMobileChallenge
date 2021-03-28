//
//  FeedModel.swift
//  MesaNewsApp
//
//  Created by Ádria Cardoso on 27/03/21.
//

import UIKit

final class FeedModel: Codable {
    
    var pagination: Pagination?
    var data: [DataModel]?
    
    private enum CodingKeys: String, CodingKey {
        
        case pagination
        case data
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        pagination = try? container.decode(Pagination.self, forKey: .pagination)
        data = try? container.decode([DataModel].self, forKey: .data)
    }
}

final class Pagination: Codable {
    
    var current_page: Int?
    var per_page: Int?
    var total_page: Int?
    var total_items: Int?
    
    private enum CodingKeys: String, CodingKey {
        
        case current_page
        case per_page
        case total_page
        case total_items
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        current_page = try? container.decode(Int.self, forKey: .current_page)
        per_page = try? container.decode(Int.self, forKey: .per_page)
        total_page = try? container.decode(Int.self, forKey: .total_page)
        total_items = try? container.decode(Int.self, forKey: .total_items)
    }
}

final class DataModel: Codable {
    
    var title: String?
    var descriptionHighlights: String?
    var content: String?
    var author: String?
    var published_at: String?
    var highlight: Bool?
    var url: String?
    var image_url: String?
    
    private enum CodingKeys: String, CodingKey {
        
        case title
        case descriptionHighlights = "description"
        case content
        case author
        case published_at
        case highlight
        case url
        case image_url
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try? container.decode(String.self, forKey: .title)
        descriptionHighlights = try? container.decode(String.self, forKey: .descriptionHighlights)
        content = try? container.decode(String.self, forKey: .content)
        author = try? container.decode(String.self, forKey: .author)
        published_at = try? container.decode(String.self, forKey: .published_at)
        highlight = try? container.decode(Bool.self, forKey: .highlight)
        url = try? container.decode(String.self, forKey: .url)
        image_url = try? container.decode(String.self, forKey: .image_url)
    }
}
