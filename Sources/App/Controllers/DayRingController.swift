//
//  DayRingController.swift
//  
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Fluent
import Vapor

final class DayRingController: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
		let api = routes.grouped("api", "rings")
		
		// DAY RINGS
		
		// get all the rings: /all
		api.get("all", use: fetchAllRings)
		
		// post new ring: /new
		api.post("new", use: createNewDayRing)
		
		
		// TRAININGS
		
		// get all the trainings: /trainings/all
		api.get("trainings", "all", use: fetchAllTrainings)
		
		// get the training by dayRing id: /trainings/:ring_id
		api.get("trainings", ":ring_id", use: fetchTrainingById)
		
		// post new training: /trainings/:ring_id/new
		api.post("training", ":ring_id", "new", use: createNewTraining)
	}
	
	// DAY RINGS
	
	// get all the rings
	func fetchAllRings(req: Request) async throws -> [DayRingResponse] {
		return try await DayRing.query(on: req.db)
			.with(\.$training)
			.all()
			.compactMap(DayRingResponse.init)
	}
	
	// post new ring
	func createNewDayRing(req: Request) async throws -> DayRingResponse {
		let ringRequest = try req.content.decode(DayRingRequest.self)
		let dayRing = DayRing(date: ringRequest.date, movement: ringRequest.movement, exercise: ringRequest.exercise, standUp: ringRequest.standUp)
		
		try await dayRing.save(on: req.db)
		
		guard let ringResponse = DayRingResponse(dayRing) else { throw Abort(.internalServerError) }
		
		return ringResponse
	}
	
	
	// TRAININGS
	
	// get all the trainings
	func fetchAllTrainings(req: Request) async throws -> [TrainingResponse] {
		return try await Training.query(on: req.db)
			.all()
			.compactMap(TrainingResponse.init)
	}
	
	// get the training by dayRing id
	func fetchTrainingById(req: Request) async throws -> TrainingResponse {
		guard let ringId = req.parameters.get("ring_id", as: UUID.self) else {
			throw Abort(.badRequest)
		}
		guard let training = try await Training.query(on: req.db)
			.filter(\.$dayRing.$id == ringId)
			.first() else {
			throw Abort(.notFound)
		}
		guard let response = TrainingResponse(training) else {
			throw Abort(.internalServerError)
		}
		
		return response
	}
	
	// post new training
	func createNewTraining(req: Request) async throws -> TrainingResponse {
		guard let ringId = req.parameters.get("ring_id", as: UUID.self) else {
			throw Abort(.badRequest)
		}
		let request = try req.content.decode(TrainingRequest.self)
		let training = Training(duration: request.duration, length: request.length, calories: request.calories, meanHR: request.meanHR, trainingType: request.trainingType, ringID: ringId)
		
		try await training.save(on: req.db)
		
		guard let response = TrainingResponse(training) else { throw Abort(.internalServerError) }
		
		return response
	}
}
