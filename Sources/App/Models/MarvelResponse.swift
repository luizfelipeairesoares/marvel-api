//
//  MarvelResponse.swift
//  portfolio
//
//

import Vapor

struct MarvelResponse<T: Content>: Content {

    let code: Int
    let status: String
    let data: MarvelData<T>

}

struct MarvelData<T: Content>: Content  {

    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]

}
