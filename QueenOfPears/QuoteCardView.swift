import SwiftUI

struct QuoteListView: View {

    let quotes: [Quote] = makeQuotes().shuffled()

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: -30) {
                ForEach(Array(zip(quotes.indices, quotes)), id: \.0) { index, quote in
                    QuoteCardView(quote: quote)
                        .visualEffect { content, proxy in
                            let frame = proxy.frame(in: .scrollView)
                            let screenWidth = proxy.frame(in: .global).width
                            let distanceToMidX = screenWidth / 2 - frame.midX

                            let hue: Double = Double(index.hashValue / 360)
                            return content
                                .hueRotation(.degrees(hue))
                                .blur(radius: -distanceToMidX / 100)
                                .rotation3DEffect(
                                    .degrees(30),
                                    axis: (x: 0, y: 1, z: 0),
                                    perspective: distanceToMidX / screenWidth)
                        }
                }
            }
        }
    }
}

struct QuoteCardView: View {

    @State private var isRevealed: Bool

    let quote: Quote

    init(quote: Quote) {
        self.quote = quote
        self.isRevealed = false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(quote.line)
                .foregroundStyle(.white)
                .font(.system(.largeTitle, design: .serif, weight: .semibold))

            let source = Text(quote.source)
                .foregroundStyle(.white)
                .font(.system(.title, design: .rounded, weight: .semibold))

            if isRevealed {
                source
                    .customAttribute(QuoteTextAttribute())
                    .transition(QuoteTextTransition())
            } else {
                source
                    .customAttribute(BlurAttribute())
                    .textRenderer(BlurTextRenderer())
            }

            Button(action: {
                isRevealed.toggle()
            }, label: {
                Text(isRevealed ? "Hide" : "Reveal")
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(isRevealed ? .blue : .green)
                    )
            })
        }
        .frame(width: 320, alignment: .leading)
        .padding(24)
        .background(content: {
            RoundedRectangle(cornerRadius: 24)
                .fill(.purple)
        })
    }
}

#Preview {
    QuoteListView()
}
