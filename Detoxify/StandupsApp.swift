//
//  StandupsApp.swift
//  Standups
//
//  Created by David De Groot on 2/18/25.
//

import SwiftUI

@main
struct StandupsApp: App {
  var body: some Scene {
    WindowGroup {
      StandupsList(model: StandupsListModel())
    }
  }
}
