//
//  DayRing.swift
//
//
//  Created by Javier Rodríguez Gómez on 4/12/23.
//

import Foundation
import Fluent
import Vapor

final class DayRing: Content, Model {
	static var schema: String = "dayrings"
	
	@ID(key: .id)
	var id: UUID?
	
	@Field(key: "date")
	var date: Date
	
	@Field(key: "movement")
	var movement: Int
	
	@Field(key: "exercise")
	var exercise: Int
	
	@Field(key: "standUp")
	var standUp: Int
	
	init() { }
	init(id: UUID? = nil, date: Date, movement: Int, exercise: Int, standUp: Int) {
		self.id = id
		self.date = date
		self.movement = movement
		self.exercise = exercise
		self.standUp = standUp
	}
}
