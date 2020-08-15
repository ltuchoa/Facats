//
//  Fact.swift
//  Facats
//
//  Created by Larissa Uchoa on 15/08/20.
//  Copyright © 2020 Larissa Uchoa. All rights reserved.
//

import Foundation

struct Facts: Codable {
    var all: [Fact]
}

struct Fact: Codable {
    let _id: String?
    let text: String?
    let type: String?
    let user: User?
    let upvotes: Int?
    let userUpvoted: Int?
}

struct User: Codable {
    let _id: String?
    let name: Name?
}

struct Name: Codable {
    let first: String?
    let last: String?
}
