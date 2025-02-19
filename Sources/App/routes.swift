import Vapor

func routes(_ app: Application) throws {

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: CharactersController())

}
