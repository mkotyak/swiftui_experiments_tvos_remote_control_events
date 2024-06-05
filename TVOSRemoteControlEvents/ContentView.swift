import GameController
import SwiftUI

struct ContentView: View {
    @State private var text: String = "Hello, world!"

    var body: some View {
        Group {
            Color.yellow.ignoresSafeArea().overlay {
                ZStack {
                    Text(text)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.black)

                    VStack {
                        Spacer()

                        /// The remote control button must be tapped at least once to add the remote to the GCController.controllers(), otherwise, the array will be empty.
                        Button("Enable Controller") {
                            setUpDirectionalPad()
                        }
                    }
                }
            }
        }
        .onExitCommand {
            text = "Exit"
        }
        /// It is used for tracking arrows tap on the remote control
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

    /// It is used for tracking swipe on the remote control
    private func setUpDirectionalPad() {
        debugPrint(GCController.controllers())
        guard let microGamepad = GCController.controllers().first?.microGamepad else {
            debugPrint("No microGamepad")
            return
        }

        microGamepad.reportsAbsoluteDpadValues = false
        microGamepad.dpad.valueChangedHandler = { [self] _, x, _ in
            if x > 0 {
                text = "Swiping Right"
            } else if x < 0 {
                text = "Swiping Left"
            } else {
                text = "Center"
            }
        }
    }
}
