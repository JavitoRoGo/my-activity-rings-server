//
//  TrainingController.swift
//  
//
//  Created by Javier Rodríguez Gómez on 8/12/23.
//

import ActivityRingsSharedDTO
import Foundation
import Fluent
import Vapor

final class TrainingController: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
		let api = routes.grouped("api", "trainings")
		
		// get all the trainings: /all
		api.get("all", use: fetchAllTrainings)
		
		// get the training by dayRing id: /:ring_id
		api.get(":ring_id", use: fetchTrainingById)
		
		// post new training: /:ring_id/new
		api.post(":ring_id", "new", use: createNewTraining)
	}
	
	
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
		let training = Training(date: request.date, duration: request.duration, length: request.length, calories: request.calories, meanHR: request.meanHR, trainingType: request.trainingType, ringID: ringId)
		
		try await training.save(on: req.db)
		
		guard let response = TrainingResponse(training) else { throw Abort(.internalServerError) }
		
		return response
	}
}
