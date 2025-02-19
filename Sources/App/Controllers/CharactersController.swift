//
//  CharactersController.swift
//  marvel
//
//

import Vapor

struct CharactersController: RouteCollection {

    private var domain: String {
        guard let env = Environment.get("DOMAIN") else {
            return "https://gateway.marvel.com/v1/public"
        }
        return env
    }

    func boot(routes: any Vapor.RoutesBuilder) throws {
        let characters = routes.grouped("characters")
        characters.get(use: list)

        characters.group(":id") { character in
            character.get(use: show)
            character.get("comics", use: comics)
        }
    }

    func list(req: Request) async throws -> MarvelResponse<Characters> {
        var parameters = try await MarvelParameters.generateAPIParameters()
        let urlToRequest = "\(domain)/characters"
        if let decodedQuery = try? req.query.decode([String: String].self) {
            for key in decodedQuery.keys {
                parameters[key] = decodedQuery[key]
            }
        }
        let response = try await req.client.get("\(urlToRequest)") { req in
            try req.query.encode(parameters)
        }
        guard let json = try? response.content.decode(MarvelResponse<Characters>.self) else {
            throw Abort(.unprocessableEntity)
        }
        return json
    }

    func show(req: Request) async throws -> MarvelResponse<Characters> {
        guard let characterId = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }
        let parameters = try await MarvelParameters.generateAPIParameters()
        let response = try await req.client.get("\(domain)/characters/\(characterId)") { req in
            try req.query.encode(parameters)
        }
        guard let json = try? response.content.decode(MarvelResponse<Characters>.self) else {
            throw Abort(.unprocessableEntity)
        }
        return json
    }

    func comics(req: Request) async throws -> MarvelResponse<Comic> {
        guard let characterId = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }
        var parameters = try await MarvelParameters.generateAPIParameters()
        if let decodedQuery = try? req.query.decode([String: String].self) {
            for key in decodedQuery.keys {
                parameters[key] = decodedQuery[key]
            }
        }
        let response = try await req.client.get("\(domain)/characters/\(characterId)/comics") { req in
            try req.query.encode(parameters)
        }
        guard let json = try? response.content.decode(MarvelResponse<Comic>.self) else {
            throw Abort(.unprocessableEntity)
        }
        return json
    }

}
