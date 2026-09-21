import SwiftUI

struct AddPCView: View {

    // Receives the PC array from ContentView and allows modification
    @Binding var pc: [PC]

    // Stores user input
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var isAvailable: Bool = true

    // Allows this screen to return to the previous screen
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "desktopcomputer")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Add New PC")
                .font(.title.bold())

            // Gets the PC name from the user
            TextField("PC name (Example: PC06)", text: $name)
                .textFieldStyle(.roundedBorder)

            // Gets the PC location from the user
            TextField("Location (Example: Lab F)", text: $location)
                .textFieldStyle(.roundedBorder)

            // Gets the availability status
            Toggle("Available", isOn: $isAvailable)

            Button("Add PC") {
                addPC()
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty || location.isEmpty)

            Spacer()
        }
        .padding()
        .navigationTitle("Add PC")
    }

    // Creates a new PC and adds it to the array
    private func addPC() {
        let newPC = PC(name: name, location: location, isAvailable: isAvailable)
        pc.append(newPC)
        dismiss()
    }
}
