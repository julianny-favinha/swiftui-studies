import PlaygroundSupport
import SwiftUI

struct LargeColorfulTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .modifier(LargeColorfulTitle())
    }
}

PlaygroundPage.current.setLiveView(ContentView())
