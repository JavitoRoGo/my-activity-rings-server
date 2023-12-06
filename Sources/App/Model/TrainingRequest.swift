//
//  TrainingRequest.swift
//  
//
//  Created by Javier Rodríguez Gómez on 6/12/23.
//

import Foundation

struct TrainingRequest: Codable {
	let duration: TimeInterval
	let length: Double
	let calories: Int
	let meanHR: Int
	let trainingType: TrainingType
}
