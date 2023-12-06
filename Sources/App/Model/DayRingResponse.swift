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
	let date: Date
	let movement: Int
	let exercise: Int
	let standUp: Int
	let training: TrainingResponse?
}

extension DayRingResponse: Content {
	init?(_ dayRing: DayRing) {
		guard let id = dayRing.id else { return nil }
		guard let dayTraining = dayRing.training,
			  let training = TrainingResponse(dayTraining) else { return nil }
		
		self.init(id: id, date: dayRing.date, movement: dayRing.movement, exercise: dayRing.exercise, standUp: dayRing.standUp, training: training)
	}
}
