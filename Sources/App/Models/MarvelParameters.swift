//
//  MarvelParameters.swift
//  marvel
//
//

import Vapor

struct MarvelParameters: Content {

    // MARK: - Public

    static func generateAPIParameters() async throws -> [String: String] {
        guard let privateKey = Environment.get("PRIVATE_KEY") else {
            throw Abort(.internalServerError)
        }
        guard let publicKey = Environment.get("PUBLIC_KEY") else {
            throw Abort(.internalServerError)
        }
        let timestamp = "\(Date().timeIntervalSince1970)"
        guard let apiKey = md5ApiKey(
            timestamp: timestamp,
            privateKey: privateKey,
            publicKey: publicKey
        ) else { return [:] }
        return [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": apiKey
        ]
    }

    // MARK: - Private

    private static func md5ApiKey(
        timestamp: String,
        privateKey: String,
        publicKey: String
    ) -> String? {
        let hash = "\(timestamp)\(privateKey)\(publicKey)"
        guard let data = hash.data(using: .utf8) else { return nil }
        let digest = Insecure.MD5.hash(data: data)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

}
