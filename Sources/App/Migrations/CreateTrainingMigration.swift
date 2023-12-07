//
//  CreateTrainingMigration.swift
//
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Fluent

struct CreateTrainingMigration: AsyncMigration {
	func prepare(on database: Database) async throws {
		let trainingType = try await database.enum("training_type")
			.case("running")
			.case("walking")
			.create()
		
		try await database.schema("trainings")
			.id()
			.field("date", .date, .required)
			.field("duration", .double, .required)
			.field("length", .double, .required)
			.field("calories", .int, .required)
			.field("meanHR", .int, .required)
			.field("trainingType", trainingType, .required)
			.field("ring_id", .uuid, .required, .references("dayrings", "id", onDelete: .cascade))
			.unique(on: "ring_id")
			.create()
	}
	
	func revert(on database: Database) async throws {
		try await database.enum("training_type").delete()
		try await database.schema("trainings").delete()
	}
}
