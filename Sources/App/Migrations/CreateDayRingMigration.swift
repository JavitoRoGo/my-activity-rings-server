//
//  CreateDayRingMigration.swift
//  
//
//  Created by Javier Rodríguez Gómez on 5/12/23.
//

import Foundation
import Fluent

struct CreateDayRingMigration: AsyncMigration {
	func prepare(on database: Database) async throws {
		try await database.schema("dayrings")
			.id()
			.field("date", .string, .required)
			.field("movement", .int, .required)
			.field("exercise", .int, .required)
			.field("standUp", .int, .required)
			.unique(on: "date")
			.create()
	}
	
	func revert(on database: Database) async throws {
		try await database.schema("dayrings").delete()
	}
}
