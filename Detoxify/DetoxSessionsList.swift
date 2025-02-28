//
//  DetoxList.swift
//  DetoxSessions
//
//  Created by David De Groot on 2/18/25.
//

import SwiftUINavigation
import SwiftUI

final class DetoxSessionsListModel: ObservableObject {
    @Published var destination: Destination?
    @Published var standups: [Detox]
    
    @CasePathable
    enum Destination {
        case add(Detox)
    }

    init(
        // Remove the .mock - just for testing
        standups: [Detox] = [.mock],
        destination: Destination? = nil
    ) {
      self.destination = destination
      self.standups = standups
    }
    
    func addDetoxButtonTapped() {
        self.destination = .add(Detox(id: UUID()))
    }
}

struct DetoxSessionsList: View {
    @ObservedObject var model: DetoxSessionsListModel
  var body: some View {
    NavigationStack {
      List {
          ForEach(self.model.standups) { standup in
              CardView(standup: standup).listRowBackground(standup.theme.mainColor)
          }
      }
      .toolbar {
          Button {
              self.model.addDetoxButtonTapped()
          } label: {
              Image(systemName: "plus")
          }
      }
      .navigationTitle("Detox Sessions")
      .sheet(item: self.$model.destination.add) { $standupModel in
          NavigationStack {
              EditDetoxView(standup: $standupModel)
                  .navigationTitle("New Detox Session")
                  .toolbar {
                      ToolbarItem(placement: .cancellationAction) {
                          Button("Dismiss") {
                          }
                      }
                      ToolbarItem(placement: .confirmationAction) {
                          Button("Add") {
                          }
                      }
                   }
                }
        }
    }
  }
}

struct DetoxSessionsList_Previews: PreviewProvider {
  static var previews: some View {
      DetoxSessionsList(model: DetoxSessionsListModel(
        standups: [
            .mock,
        ]
      ))
  }
}
