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
	
	@Field(key: "duration")
	var duration: TimeInterval
	
	@Field(key: "length")
	var length: Double
	
	@Field(key: "calories")
	var calories: Int
	
	@Field(key: "meanHR")
	var meanHR: Int
	
	@Parent(key: "ring_id")
	var dayRing: DayRing
	
	init() { }
	init(id: UUID? = nil, duration: TimeInterval, length: Double, calories: Int, meanHR: Int, ringID: UUID) {
		self.id = id
		self.duration = duration
		self.length = length
		self.calories = calories
		self.meanHR = meanHR
		self.$dayRing.id = ringID
	}
	
	var velocity: Double {
		if duration == 0 {
			return 0.0
		}
		return length / duration * 60
	}
}