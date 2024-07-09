//
// From SwiftUI by Example by Paul Hudson (@twostraws)
// https://www.hackingwithswift.com/quick-start/swiftui
// License: https://www.hackingwithswift.com/license
//

import SwiftUI

struct BoxedRenderer: TextRenderer {
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        for line in layout {
            for run in line {
                for glyph in run {
                    context.stroke(
                        Rectangle()
                            .path(
                                in: glyph.typographicBounds.rect),
                                with: .color(.blue),
                                lineWidth: 2)
                }

                context.stroke(
                    Rectangle()
                        .path(
                            in: run.typographicBounds.rect),
                            with: .color(.green),
                            lineWidth: 2)
            }
            context.stroke(
                Rectangle()
                    .path(
                        in: line.typographicBounds.rect),
                        with: .color(.red),
                lineWidth: 2)

            context.draw(line)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            (
                Text("This is a **very** important string") +
                Text(" with lots of text inside.")
                    .foregroundStyle(.secondary)
            )
            .font(.largeTitle)
            .textRenderer(BoxedRenderer())
        }

        Spacer()
    }
}

#Preview {
    ContentView()
}
