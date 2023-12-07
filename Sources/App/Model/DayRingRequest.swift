//
//  DayRingRequest.swift
//
//
//  Created by Javier Rodríguez Gómez on 6/12/23.
//

import Foundation

struct DayRingRequest: Codable {
	let date: String
	let movement: Int
	let exercise: Int
	let standUp: Int
}
