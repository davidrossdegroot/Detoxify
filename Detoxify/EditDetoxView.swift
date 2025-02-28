//
//  SwiftUIView.swift
//  DetoxSessions
//
//  Created by David De Groot on 2/19/25.
//
import SwiftUI

struct EditDetoxView: View {
  @Binding var standup: Detox

  var body: some View {
    Form {
      Section {
        TextField("Title", text: self.$standup.title)
        HStack {
          Slider(
            value: self.$standup.duration.seconds,
            in: 5...30, step: 1
          ) {
            Text("Length")
          }
          Spacer()
          Text(self.standup.duration.formatted(.units()))
        }
        ThemePicker(selection: self.$standup.theme)
      } header: {
        Text("Detox Info")
      }
      Section {
        ForEach(self.$standup.attendees) { $attendee in
          TextField("Name", text: $attendee.name)
        }
        .onDelete { indices in
          self.standup.attendees.remove(
            atOffsets: indices
          )
          if self.standup.attendees.isEmpty {
            self.standup.attendees.append(
                Attendee(id: UUID(), name: "")
            )
          }
        }

        Button("New attendee") {
          self.standup.attendees.append(
            Attendee(id: UUID(), name: "")
          )
        }
      } header: {
        Text("Attendees")
      }
    }
    .onAppear {
      if self.standup.attendees.isEmpty {
        self.standup.attendees.append(
            Attendee(id: UUID(), name: "")
        )
      }
    }
  }
}

struct ThemePicker: View {
  @Binding var selection: Theme

  var body: some View {
    Picker("Theme", selection: $selection) {
      ForEach(Theme.allCases) { theme in
        ZStack {
          RoundedRectangle(cornerRadius: 4)
            .fill(theme.mainColor)
          Label(theme.name, systemImage: "paintpalette")
            .padding(4)
        }
        .foregroundColor(theme.accentColor)
        .fixedSize(horizontal: false, vertical: true)
        .tag(theme)
      }
    }
  }
}

extension Duration {
  fileprivate var seconds: Double {
    get { Double(self.components.seconds / 60) }
    set { self = .seconds(newValue * 60) }
  }
}
