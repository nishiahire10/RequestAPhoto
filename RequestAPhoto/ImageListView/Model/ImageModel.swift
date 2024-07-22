//
//  ImageModel.swift
//  RequestAPhoto
//
//  Created by Nishigandha Bhushan Jadhav on 21/07/24.
//

import Foundation


struct Image : Decodable, Identifiable, Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id && lhs.urls == rhs.urls
    }
    
    
    
    var id : String
    var slug : String
    var alternative_slugs : [String:String]?
    var created_at : String?
    var updated_at : String?
    var promoted_at : String?
    var width : Int?
    var height : Int?
    var color : String?
    var blur_hash : String?
    var description : String?
    var alt_description : String?
    var breadcrumbs : [Breadcrumbs]?
    var urls : URLModel?
    var links : [String:String?]?
    var likes : Int?
    var liked_by_user : Bool?
    var current_user_collections : [String]?
    var sponsorship : Sponsorship?
    var topic_submissions : [String:[String:String]?]?
    var asset_type : String?
    var user : Sponsor?
}
struct Breadcrumbs : Decodable {
    var slug : String?
    var title : String?
    var index : Int?
    var type : String?
}
struct URLModel : Decodable, Equatable {
    var raw : String?
    var full : String?
    var regular : String?
    var small : String?
    var thumb : String?
    var small_s3 : String?
}

struct Sponsorship : Decodable {
    var impression_urls : [String]?
    var tagline : String?
    var tagline_url : String?
    var sponsor : Sponsor?
}

struct Sponsor : Decodable {
    var id : String
    var updated_at : String?
    var username : String?
    var name : String?
    var first_name : String?
    var last_name : String?
    var twitter_username : String?
    var portfolio_url : String?
    var bio : String?
    var location : String?
    var links : [String:String]?
    var profile_image : [String:String]?
    var instagram_username : String?
    var total_collections : Int?
    var total_likes : Int?
    var total_photos : Int?
    var total_promoted_photos : Int?
    var total_illustrations : Int?
    var total_promoted_illustrations : Int?
    var accepted_tos : Bool
    var for_hire : Bool
    var social : [String:String?]?
}
