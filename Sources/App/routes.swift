import Vapor

func routes(_ app: Application) throws {
	try app.register(collection: DayRingController())
	try app.register(collection: TrainingController())
}
