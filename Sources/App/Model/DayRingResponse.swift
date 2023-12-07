//
//  DayRingResponse.swift
//
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Vapor

struct DayRingResponse: Codable {
	let id: UUID
	let date: String
	let movement: Int
	let exercise: Int
	let standUp: Int
}

extension DayRingResponse: Content {
	init?(_ dayRing: DayRing) {
		guard let id = dayRing.id else { return nil }
		
		self.init(id: id, date: dayRing.date, movement: dayRing.movement, exercise: dayRing.exercise, standUp: dayRing.standUp)
	}
}
