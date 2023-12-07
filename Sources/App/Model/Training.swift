//
//  Training.swift
//
//
//  Created by Javier Rodríguez Gómez on 4/12/23.
//

import Foundation
import Fluent
import Vapor

final class Training: Content, Model {
	static var schema: String = "trainings"
	
	@ID(key: .id)
	var id: UUID?
	
	@Field(key: "date")
	var date: Date
	
	@Field(key: "duration")
	var duration: TimeInterval
	
	@Field(key: "length")
	var length: Double
	
	@Field(key: "calories")
	var calories: Int
	
	@Field(key: "meanHR")
	var meanHR: Int
	
	@Enum(key: "trainingType")
	var trainingType: TrainingType
	
	@Parent(key: "ring_id")
	var dayRing: DayRing
	
	init() { }
	init(id: UUID? = nil, date: Date, duration: TimeInterval, length: Double, calories: Int, meanHR: Int, trainingType: TrainingType = .running, ringID: UUID) {
		self.id = id
		self.date = date
		self.duration = duration
		self.length = length
		self.calories = calories
		self.meanHR = meanHR
		self.trainingType = trainingType
		self.$dayRing.id = ringID
	}
}
