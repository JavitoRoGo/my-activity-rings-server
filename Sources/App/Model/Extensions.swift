//
//  Extensions.swift
//
//
//  Created by Javier Rodríguez Gómez on 7/12/23.
//

import ActivityRingsSharedDTO
import Foundation
import Vapor

extension DayRingResponse: Content {
	init?(_ dayRing: DayRing) {
		guard let id = dayRing.id else { return nil }
		
		self.init(id: id, date: dayRing.date, movement: dayRing.movement, exercise: dayRing.exercise, standUp: dayRing.standUp)
	}
}

extension TrainingResponse: Content {
	init?(_ training: Training) {
		guard let id = training.id else { return nil }
		
		self.init(id: id, date: training.date, duration: training.duration, length: training.length, calories: training.calories, meanHR: training.meanHR, trainingType: training.trainingType)
	}
}
