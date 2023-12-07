//
//  DayRing.swift
//
//
//  Created by Javier Rodríguez Gómez on 4/12/23.
//

import Foundation
import Fluent
import Vapor

final class DayRing: Content, Model, Validatable {
	static var schema: String = "dayrings"
	
	@ID(key: .id)
	var id: UUID?
	
	@Field(key: "date")
	var date: String
	
	@Field(key: "movement")
	var movement: Int
	
	@Field(key: "exercise")
	var exercise: Int
	
	@Field(key: "standUp")
	var standUp: Int
	
	init() { }
	init(id: UUID? = nil, date: String, movement: Int, exercise: Int, standUp: Int) {
		self.id = id
		self.date = date
		self.movement = movement
		self.exercise = exercise
		self.standUp = standUp
	}
	
	static func validations(_ validations: inout Validations) {
		validations.add("movement", as: Int.self, is: .range(1...), customFailureDescription: "Movement cannot be empty.")
		validations.add("exercise", as: Int.self, is: .range(0...), customFailureDescription: "Movement cannot be empty.")
		validations.add("standUp", as: Int.self, is: .range(0..<25), customFailureDescription: "Movement cannot be empty.")
	}
}
