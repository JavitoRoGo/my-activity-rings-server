//
//  TrainingResponse.swift
//
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Vapor

enum TrainingType: String, Codable {
	case running, walking
}

struct TrainingResponse: Codable {
	let id: UUID
	let date: String
	let duration: TimeInterval
	let length: Double
	let calories: Int
	let meanHR: Int
	let trainingType: TrainingType
}

extension TrainingResponse: Content {
	init?(_ training: Training) {
		guard let id = training.id else { return nil }
		
		self.init(id: id, date: training.date, duration: training.duration, length: training.length, calories: training.calories, meanHR: training.meanHR, trainingType: training.trainingType)
	}
}
