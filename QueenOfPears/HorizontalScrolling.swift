import SwiftUI

#Preview {
    QuoteListView2()
}


struct QuoteListView2: View {

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

                            let intIndex = abs(index.distance(to: 0)) + 1
                            let hue: Double = Double(intIndex * 30)
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

struct QuoteCardView2: View {

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

            Text("Line 2")
                .foregroundStyle(.white)
                .font(.system(.title, design: .rounded, weight: .semibold))

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
