//
//  HomeModel.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import Foundation
struct HomeModel : Codable {
    let data : Datum?
    let message : String?
    let statusCode : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case statusCode = "status_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Datum.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
    }
    
}
struct Datum : Codable {
    
    let attractions : [ItemModel]?
    let events : [ItemModel]?
    let hotSpots : [ItemModel]?
    
    enum CodingKeys: String, CodingKey {
        case attractions = "attractions"
        case events = "events"
        case hotSpots = "hot_spots"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attractions = try values.decodeIfPresent([ItemModel].self, forKey: .attractions)
        events = try values.decodeIfPresent([ItemModel].self, forKey: .events)
        hotSpots = try values.decodeIfPresent([ItemModel].self, forKey: .hotSpots)
    }
    
}
struct ItemModel : Codable {
    let id : Int?
    let name : String?
    let shortDescription : String?
    let photos : [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case shortDescription = "short_description"
        case photos = "photos"
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        shortDescription = try values.decodeIfPresent(String.self, forKey: .shortDescription)
        photos = try values.decodeIfPresent([String].self, forKey: .photos)
        
    }
    
}
