//
//  DayRingController.swift
//  
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import ActivityRingsSharedDTO
import Foundation
import Fluent
import Vapor

final class DayRingController: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
		let api = routes.grouped("api", "rings")
		
		// get all the rings: /all
		api.get("all", use: fetchAllRings)
		
		// post new ring: /new
		api.post("new", use: createNewDayRing)
	}
	
	
	// get all the rings
	func fetchAllRings(req: Request) async throws -> [DayRingResponse] {
		return try await DayRing.query(on: req.db)
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
}
