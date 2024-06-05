import SwiftUI
import GameController

struct ContentView: View {
    @State private var text: String = "Hello, world!"
    
    init() {
        debugPrint(GCController.controllers())
    }
    
    
    func setUpDirectionalPad() {
        debugPrint(GCController.controllers())
        guard let microGamepad = GCController.controllers().first?.microGamepad else {
            debugPrint("No microGamepad")
            return
        }
        
        microGamepad.reportsAbsoluteDpadValues = true
        microGamepad.dpad.valueChangedHandler = { [self] (pad, x, y) in
            self.text = "\(x):\(y)"
        }
    }

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
                                
                                Button("Enable Controllers") {
                                    setUpDirectionalPad()
                                }
                                
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
            .onAppear {
                setUpDirectionalPad()
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
