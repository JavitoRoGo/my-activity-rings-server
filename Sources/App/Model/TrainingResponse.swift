//
//  TrainingResponse.swift
//
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Vapor

struct TrainingResponse: Codable {
	let id: UUID
	let duration: TimeInterval
	let length: Double
	let calories: Int
	let meanHR: Int
	let trainingType: TrainingType
}

extension TrainingResponse: Content {
	init?(_ training: Training) {
		guard let id = training.id else { return nil }
		
		self.init(id: id, duration: training.duration, length: training.length, calories: training.calories, meanHR: training.meanHR, trainingType: training.trainingType)
	}
}
