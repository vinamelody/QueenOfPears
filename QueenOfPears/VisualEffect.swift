import SwiftUI

#Preview {
    QuoteListView1()
}

struct QuoteListView1: View {

    let quotes: Set<Quote> = makeQuotes()

    var body: some View {
        ScrollView(.vertical) {
            ForEach(quotes.shuffled()) { quote in
                QuoteCardView(quote: quote)
                    .visualEffect { content, proxy in
                        let frame = proxy.frame(in: .scrollView(axis: .vertical))

                        let distance = min(0, frame.minY)
                        return content
                            .hueRotation(.degrees(frame.origin.y / 10))
                            .scaleEffect(1 + distance / 700)
                            .offset(y: -distance / 1.25)
                            .brightness(-distance / 400)
                            .blur(radius: -distance / 50)
                            .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                    }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct QuoteCardView1: View {

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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(content: {
            RoundedRectangle(cornerRadius: 24)
                .fill(.purple)
        })
    }
}

