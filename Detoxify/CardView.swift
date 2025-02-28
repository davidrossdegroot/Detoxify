//
//  CardView.swift
//  DetoxSessions
//
//  Created by David De Groot on 2/18/25.
//
import SwiftUI

struct CardView: View {
  let detoxSession: Detox

  var body: some View {
    VStack(alignment: .leading) {
      Text(self.detoxSession.title)
        .font(.headline)
      Spacer()
      HStack {
        Label(
          "\(self.detoxSession.attendees.count)",
          systemImage: "person.3"
        )
        Spacer()
        Label(
          self.detoxSession.duration.formatted(.units()),
          systemImage: "clock"
        )
        .labelStyle(.trailingIcon)
      }
      .font(.caption)
    }
    .padding()
    .foregroundColor(self.detoxSession.theme.accentColor)
  }
}

struct TrailingIconLabelStyle: LabelStyle {
  func makeBody(
    configuration: Configuration
  ) -> some View {
    HStack {
      configuration.title
      configuration.icon
    }
  }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
  static var trailingIcon: Self { Self() }
}
