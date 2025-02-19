//
//  StandupList.swift
//  Standups
//
//  Created by David De Groot on 2/18/25.
//

import SwiftUINavigation
import SwiftUI

final class StandupsListModel: ObservableObject {
    @Published var destination: Destination?
    @Published var standups: [Standup]
    
    @CasePathable
    enum Destination {
        case add(Standup)
    }

    init(
        // Remove the .mock - just for testing
        standups: [Standup] = [.mock],
        destination: Destination? = nil
    ) {
      self.destination = destination
      self.standups = standups
    }
    
    func addStandupButtonTapped() {
        self.destination = .add(Standup(id: UUID()))
    }
}

struct StandupsList: View {
    @ObservedObject var model: StandupsListModel
  var body: some View {
    NavigationStack {
      List {
          ForEach(self.model.standups) { standup in
              CardView(standup: standup).listRowBackground(standup.theme.mainColor)
          }
      }
      .toolbar {
          Button {
              self.model.addStandupButtonTapped()
          } label: {
              Image(systemName: "plus")
          }
      }
      .navigationTitle("Detox Sessions")
      .sheet(item: self.$model.destination.add) { $standupModel in
          NavigationStack {
              EditStandupView(standup: $standupModel)
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

struct StandupsList_Previews: PreviewProvider {
  static var previews: some View {
      StandupsList(model: StandupsListModel(
        standups: [
            .mock,
        ]
      ))
  }
}
