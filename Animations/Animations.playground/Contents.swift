import PlaygroundSupport
import SwiftUI

struct ContentView: View {
    @State private var isFirstButtonEnabled = false
    @State private var isSecondButtonEnabled = false

    var body: some View {
        VStack(spacing: 40) {
            Text("The order of the modifiers matter for the animations too!")
                .font(.headline)

            Text("1. The animation is placed before applying corner radius:")
                .font(.body)

            Button("Tap me") {
                self.isFirstButtonEnabled.toggle()
            }
            .frame(width: 120, height: 120)
            .background(isFirstButtonEnabled ? Color.purple : Color.blue)
            .foregroundColor(Color.white)
            .animation(.default)
            .clipShape(RoundedRectangle(cornerRadius: isFirstButtonEnabled ? 60 : 0))

            Text("Notice that the corner radius of the button changes abruptly")
                .font(.footnote)

            Text("2. The animation is placed after applying corner radius:")
                .font(.body)

            Button("Tap me") {
                self.isSecondButtonEnabled.toggle()
            }
            .frame(width: 120, height: 120)
            .background(isSecondButtonEnabled ? Color.purple : Color.blue)
            .foregroundColor(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: isSecondButtonEnabled ? 60 : 0))
            .animation(.default)

            Spacer()
        }
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())
