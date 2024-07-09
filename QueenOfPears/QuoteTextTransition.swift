import SwiftUI

struct QuoteTextTransition: Transition {

    static var properties: TransitionProperties {
        TransitionProperties(hasMotion: true)
    }

    func body(content: Content, phase: TransitionPhase) -> some View {
        let duration: TimeInterval = 0.9
        let elapsedTime = phase.isIdentity ? duration : 0
        let renderer = QuoteTextRenderer(
            elapsedTime: elapsedTime,
            totalDuration: duration)

        content.transaction { transaction in
            if !transaction.disablesAnimations {
                transaction.animation = .linear(duration: duration)
            }
        } body: { view in
            view.textRenderer(renderer)
        }
    }
}

struct QuoteTextAttribute: TextAttribute {}

struct QuoteTextRenderer: TextRenderer, Animatable {

    var elapsedTime: TimeInterval
    var elementDuration: TimeInterval
    var totalDuration: TimeInterval

    var animatableData: Double {
        get { elapsedTime }
        set { elapsedTime = newValue }
    }

    var spring: Spring {
        .snappy(duration: elementDuration - 0.05, extraBounce: 0.4)
    }

    init(
        elapsedTime: TimeInterval,
        elementDuration: TimeInterval = 0.4,
        totalDuration: TimeInterval)
    {
        self.elapsedTime = min(elapsedTime, totalDuration)
        self.elementDuration = min(elementDuration, totalDuration)
        self.totalDuration = totalDuration
    }

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        for run in layout.flattenedRuns {
            if run[QuoteTextAttribute.self] != nil {
                let delay = elementDelay(count: run.count)

                for (index, slice) in run.enumerated() {
                    // The time that the current element starts animating,
                    // relative to the start of the animation.
                    let timeOffset = TimeInterval(index) * delay

                    // The amount of time that passes for the current element.
                    let elementTime = max(0, min(elapsedTime - timeOffset, elementDuration))

                    // Make a copy of the context so that individual slices
                    // don't affect each other.
                    var copy = ctx
                    draw(slice, at: elementTime, in: &copy)
                }
            }
        }
    }

    func draw( _ slice: Text.Layout.RunSlice, at time: TimeInterval, in context: inout GraphicsContext) {
        let progress = time / elementDuration
        let opacity = UnitCurve.easeIn.value(at: 1.4 * progress)
        let blurRadius = slice.typographicBounds.rect.height / 16 * UnitCurve.easeIn.value(at: 1 - progress)

        let translationY = spring.value(
            fromValue: -slice.typographicBounds.descent,
            toValue: 0,
            initialVelocity: 0,
            time: time)

        context.translateBy(x: 0, y: translationY)
        context.addFilter(.blur(radius: blurRadius))
        context.opacity = opacity

        context.draw(slice, options: .disablesSubpixelQuantization)
    }

    /// Calculates how much time passes between the start of two consecutive
    /// element animations.
    ///
    /// For example, if there's a total duration of 1 s and an element
    /// duration of 0.5 s, the delay for two elements is 0.5 s.
    /// The first element starts at 0 s, and the second element starts at 0.5 s
    /// and finishes at 1 s.
    ///
    /// However, to animate three elements in the same duration,
    /// the delay is 0.25 s, with the elements starting at 0.0 s, 0.25 s,
    /// and 0.5 s, respectively.
    func elementDelay(count: Int) -> TimeInterval {
        let count = TimeInterval(count)
        let remainingTime = totalDuration - count * elementDuration

        return max(remainingTime / (count + 1), (totalDuration - elementDuration) / count)
    }
}

extension Text.Layout {
    /// A helper function for easier access to all runs in a layout.
    var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
        self.flatMap { line in
            line
        }
    }

    /// A helper function for easier access to all run slices in a layout.
    var flattenedRunSlices: some RandomAccessCollection<Text.Layout.RunSlice> {
        flattenedRuns.flatMap(\.self)
    }
}
