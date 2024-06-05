import SwiftUI

struct ContentView: View {
    @State private var text: String = "Hello, world!"

    var body: some View {
        Color.yellow.opacity(0.5).ignoresSafeArea()
            .overlay {
                Text(text)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.black)
            }
    }
}
