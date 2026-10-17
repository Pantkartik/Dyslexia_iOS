
import SwiftUI

struct WriteView: View {
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init)

    @State private var currentIndex = 0
    @State private var points: [CGPoint] = []
    @State private var strokes: [[CGPoint]] = []
    @State private var currentStroke: [CGPoint] = []
    @State private var isCorrect = false
    @State private var showConfetti = false
    @State private var attempts = 0

    private var currentLetter: String {
        letters[currentIndex]
    }

    var body: some View {
        GeometryReader { geometry in
            let isWide = geometry.size.width > 700

            ZStack {
                DyslexiaTheme.background
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    header

                    ScrollView {
                        VStack(spacing: 22) {
                            progressSection

                            if isWide {
                                HStack(alignment: .center, spacing: 28) {
                                    tracingBoard
                                        .frame(maxWidth: .infinity)
                                        .frame(height: min(
                                            geometry.size.height * 0.53,
                                            470
                                        ))

                                    sidePanel
                                        .frame(width: 235)
                                }
                            } else {
                                tracingBoard
                                    .frame(height: min(
                                        geometry.size.height * 0.43,
                                        390
                                    ))

                                sidePanel
                            }

                            alphabetPicker
                        }
                        .padding(.horizontal, isWide ? 32 : 18)
                        .padding(.vertical, 20)
                        .frame(maxWidth: 1100)
                        .frame(maxWidth: .infinity)
                    }
                }

                if showConfetti {
                    ConfettiOverlay()
                        .allowsHitTesting(false)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.25), value: currentIndex)
            .animation(.easeInOut(duration: 0.25), value: isCorrect)
        }
    }

    // MARK: Header

    private var header: some View {
        HStack(spacing: 14) {
            Image(systemName: "pencil.and.outline")
                .font(.system(size: 25, weight: .semibold))
                .foregroundStyle(DyslexiaTheme.green)
                .frame(width: 52, height: 52)
                .background(.white.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 4) {
                Text("Letter Adventures")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.text)

                Text("One letter at a time. You're doing great!")
                    .font(.system(size: 15, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.muted)
            }

            Spacer()

            Text("\(currentIndex + 1) / 26")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundStyle(DyslexiaTheme.green)
                .padding(.horizontal, 16)
                .padding(.vertical, 11)
                .background(DyslexiaTheme.lightGreen)
                .clipShape(Capsule())
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 14)
        .background(DyslexiaTheme.card)
    }

    // MARK: Progress

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Let's trace the letter")
                    .font(.system(size: 19, weight: .semibold, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.text)

                Spacer()

                Text("\(Int(Double(currentIndex + 1) / 26.0 * 100))%")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.green)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(DyslexiaTheme.lightGreen)

                    Capsule()
                        .fill(DyslexiaTheme.green)
                        .frame(
                            width: geo.size.width *
                            CGFloat(currentIndex + 1) / 26
                        )
                }
            }
            .frame(height: 9)
        }
    }

    // MARK: Tracing board

    private var tracingBoard: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(DyslexiaTheme.card)

                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        DyslexiaTheme.lightGreen,
                        style: StrokeStyle(lineWidth: 2, dash: [8, 6])
                    )

                // Letter guide. This is a visual guide, not a
                // stroke-by-stroke outline.
                Text(currentLetter)
                    .font(.system(
                        size: min(geo.size.width * 0.66,
                                  geo.size.height * 0.77),
                        weight: .black,
                        design: .rounded
                    ))
                    .foregroundStyle(
                        isCorrect
                        ? DyslexiaTheme.green.opacity(0.15)
                        : DyslexiaTheme.lightGreen.opacity(0.85)
                    )
                    .blur(radius: isCorrect ? 0 : 1.1)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)

                // Gentle center guides.
                Path { path in
                    path.move(to: CGPoint(x: geo.size.width / 2, y: 20))
                    path.addLine(to: CGPoint(
                        x: geo.size.width / 2,
                        y: geo.size.height - 20
                    ))
                }
                .stroke(
                    DyslexiaTheme.lightGreen.opacity(0.45),
                    style: StrokeStyle(lineWidth: 1, dash: [4, 7])
                )

                // Child's drawing.
                Canvas { context, _ in
                    for stroke in strokes {
                        drawStroke(stroke, in: &context)
                    }

                    drawStroke(currentStroke, in: &context)
                }
                .allowsHitTesting(false)

                // Touch input.
                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                guard !isCorrect else { return }

                                currentStroke.append(value.location)
                            }
                            .onEnded { _ in
                                if !currentStroke.isEmpty {
                                    strokes.append(currentStroke)
                                    points.append(contentsOf: currentStroke)
                                    currentStroke = []
                                }
                            }
                    )

                VStack {
                    HStack {
                        Label(
                            "TRACE HERE",
                            systemImage: "hand.draw"
                        )
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .tracking(1)
                        .foregroundStyle(DyslexiaTheme.muted)

                        Spacer()

                        Image(systemName: "sparkles")
                            .foregroundStyle(DyslexiaTheme.coral)
                    }

                    Spacer()

                    if isCorrect {
                        Label("Beautiful work!", systemImage: "checkmark.seal.fill")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(DyslexiaTheme.green)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.white.opacity(0.94))
                            .clipShape(Capsule())
                    }
                }
                .padding(18)
                .allowsHitTesting(false)
            }
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }

    private func drawStroke(
        _ stroke: [CGPoint],
        in context: inout GraphicsContext
    ) {
        guard let first = stroke.first else { return }

        var path = Path()
        path.move(to: first)

        for point in stroke.dropFirst() {
            path.addLine(to: point)
        }

        context.stroke(
            path,
            with: .color(DyslexiaTheme.coral),
            style: StrokeStyle(
                lineWidth: 11,
                lineCap: .round,
                lineJoin: .round
            )
        )
    }

    // MARK: Instructions and controls

    private var sidePanel: some View {
        VStack(spacing: 16) {
            VStack(spacing: 7) {
                Text(isCorrect ? "Amazing!" : "Your turn!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.green)

                Text(
                    isCorrect
                    ? "You completed this letter. Keep shining!"
                    : "Follow the big letter with your finger or Apple Pencil."
                )
                .font(.system(size: 16, design: .rounded))
                .foregroundStyle(DyslexiaTheme.muted)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            }

            if isCorrect {
                Button(action: nextLetter) {
                    Label(
                        currentIndex == 25 ? "Finish A–Z" : "Next Letter",
                        systemImage: "arrow.right"
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .background(DyslexiaTheme.green)
                    .clipShape(RoundedRectangle(cornerRadius: 17))
                }
            } else {
                Button(action: checkTracing) {
                    Label("Check My Letter", systemImage: "checkmark.circle.fill")
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .background(DyslexiaTheme.green)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                }
                .disabled(points.isEmpty)
                .opacity(points.isEmpty ? 0.55 : 1)
            }

            Button(action: retry) {
                Label("Try Again", systemImage: "arrow.counterclockwise")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(DyslexiaTheme.green)
                    .background(DyslexiaTheme.lightGreen.opacity(0.55))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }

            Text("Every try helps you grow 🌱")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(DyslexiaTheme.muted)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(DyslexiaTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    // MARK: Alphabet

    private var alphabetPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your alphabet journey")
                .font(.system(size: 19, weight: .bold, design: .rounded))
                .foregroundStyle(DyslexiaTheme.text)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 48), spacing: 9)],
                spacing: 9
            ) {
                ForEach(letters.indices, id: \.self) { index in
                    Button {
                        // Only allow the current letter or completed letters.
                        if index <= currentIndex {
                            currentIndex = index
                            retry()
                        }
                    } label: {
                        Text(letters[index])
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundStyle(
                                index == currentIndex
                                ? .white
                                : index < currentIndex
                                    ? DyslexiaTheme.green
                                    : DyslexiaTheme.muted
                            )
                            .background(
                                index == currentIndex
                                ? DyslexiaTheme.green
                                : index < currentIndex
                                    ? DyslexiaTheme.lightGreen
                                    : .white.opacity(0.7)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .buttonStyle(.plain)
                    .disabled(index > currentIndex)
                }
            }
        }
    }

    // MARK: Actions

    private func checkTracing() {
        attempts += 1

        // Basic prototype heuristic only. It checks that the child
        // drew a reasonably long, spread-out trace. It does NOT verify
        // that the drawn points follow the shape of the letter.
        let totalLength = strokes.reduce(0.0) { total, stroke in
            total + strokeLength(stroke)
        }

        let xs = points.map(\.x)
        let ys = points.map(\.y)

        guard let minX = xs.min(),
              let maxX = xs.max(),
              let minY = ys.min(),
              let maxY = ys.max() else {
            return
        }

        let width = maxX - minX
        let height = maxY - minY

        if totalLength > 100 && width > 25 && height > 25 {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.65)) {
                isCorrect = true
                showConfetti = true
            }
        } else {
            withAnimation(.easeInOut(duration: 0.2)) {
                isCorrect = false
                showConfetti = false
            }
        }
    }

    private func strokeLength(_ stroke: [CGPoint]) -> CGFloat {
        guard stroke.count > 1 else { return 0 }

        return zip(stroke, stroke.dropFirst()).reduce(CGFloat.zero) {
            total, pair in
            total + hypot(
                pair.1.x - pair.0.x,
                pair.1.y - pair.0.y
            )
        }
    }

    private func retry() {
        points = []
        strokes = []
        currentStroke = []
        isCorrect = false
        showConfetti = false
        attempts = 0
    }

    private func nextLetter() {
        guard currentIndex < letters.count - 1 else {
            retry()
            currentIndex = 0
            return
        }

        currentIndex += 1
        retry()
    }
}

// MARK: Simple confetti celebration

private struct ConfettiOverlay: View {
    private let colors: [Color] = [
        DyslexiaTheme.green,
        DyslexiaTheme.coral,
        .yellow,
        .mint,
        .orange
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<65, id: \.self) { index in
                    let x = CGFloat((index * 47 + 19) % 100) / 100
                    let y = CGFloat((index * 31 + 13) % 100) / 100

                    RoundedRectangle(cornerRadius: 3)
                        .fill(colors[index % colors.count])
                        .frame(
                            width: index.isMultiple(of: 2) ? 8 : 5,
                            height: index.isMultiple(of: 2) ? 13 : 8
                        )
                        .rotationEffect(.degrees(Double(index * 29)))
                        .position(
                            x: x * geo.size.width,
                            y: y * geo.size.height
                        )
                }
            }
            .accessibilityHidden(true)
        }
    }
}

#Preview {
    WriteView()
}
