import SwiftUI

struct BlurAttribute: TextAttribute {}

struct BlurTextRenderer: TextRenderer, Animatable {

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for run in layout.flatMap(\.self) {
            if run[BlurAttribute.self] != nil {
                blurIt(run, ctx)
            } else {
                ctx.draw(run)
            }
        }
    }

    private func blurIt(_ run: Text.Layout.Line.Element, _ context: GraphicsContext) {
        var copy = context
        let blurFilter = GraphicsContext.Filter.blur(radius: 10.0)
        copy.addFilter(blurFilter)
        copy.draw(run)
    }
}
