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
    @Published var detoxSessions: [Detox]
    
    @CasePathable
    enum Destination {
        case add(Detox)
    }

    init(
        // Remove the .mock - just for testing
        detoxSessions: [Detox] = [.mock],
        destination: Destination? = nil
    ) {
      self.destination = destination
      self.detoxSessions = detoxSessions
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
          ForEach(self.model.detoxSessions) { detoxSession in
              CardView(detoxSession: detoxSession).listRowBackground(detoxSession.theme.mainColor)
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
      .sheet(item: self.$model.destination.add) { $detoxSessionModel in
          NavigationStack {
              EditDetoxView(detoxSession: $detoxSessionModel)
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
        detoxSessions: [
            .mock,
        ]
      ))
  }
}
