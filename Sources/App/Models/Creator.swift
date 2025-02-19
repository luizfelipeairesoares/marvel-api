//
//  Creator.swift
//  portfolio
//
//

import Vapor

struct Creator: Content {

    let name: String
    let role: String

}

struct Creators: Content {

    let available: Int
    let returned: Int
    let items: [Creator]

}
