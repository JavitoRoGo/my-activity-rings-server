import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	
	app.databases.use(.sqlite(.file("myringsdb.sqlite")), as: .sqlite)
	
	app.migrations.add(CreateDayRingMigration())
	app.migrations.add(CreateTrainingMigration())
	
    // register routes
    try routes(app)
}
