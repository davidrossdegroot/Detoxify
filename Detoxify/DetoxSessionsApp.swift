//
//  DetoxSessionsApp.swift
//  DetoxSessions
//
//  Created by David De Groot on 2/18/25.
//

import SwiftUI

@main
struct DetoxSessionsApp: App {
  var body: some Scene {
    WindowGroup {
      DetoxSessionsList(model: DetoxSessionsListModel())
    }
  }
}
