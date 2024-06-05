import SwiftUI

struct ContentView: View {
    @State private var text: String = "Hello, world!"

    var body: some View {
        Group {
            Color.yellow.opacity(0.5).ignoresSafeArea()
                .overlay {
                    Text(text)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)
                }
        }
        .focusable()
        .onExitCommand {
            text = "Exit"
        }
        .onMoveCommand { moveCommandDirection in
            switch moveCommandDirection {
            case .down:
                text = "Tap down"
            case .up:
                text = "Tap up"
            case .left:
                text = "Tap left"
            case .right:
                text = "Tap right"
            @unknown default:
                assertionFailure("Unknown Command Direction")
            }
        }
    }
}
