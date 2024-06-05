import SwiftUI

struct ContentView: View {
    @State private var text: String = "Hello, world!"

    var body: some View {
        NavigationStack {
            Group {
                Color.yellow.ignoresSafeArea()
                    .overlay {
                        ZStack {
                            Text(text)
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.black)

                            VStack {
                                Spacer()

                                NavigationLink("Tap me") {
                                    Color.blue.ignoresSafeArea()
                                        .overlay {
                                            Text("I am a sheet")
                                                .font(.largeTitle)
                                                .bold()
                                                .foregroundStyle(.white)
                                                .focusable()
                                                .onExitCommand {
                                                    debugPrint("Sheet is exit")
                                                }
                                        }
                                }
                            }
                        }
                    }
            }
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
}
