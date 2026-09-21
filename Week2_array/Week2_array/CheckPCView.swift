import SwiftUI

struct CheckPCView: View {

    // Receives the PC array for searching
    let pc: [PC]

    // Stores the name entered by the user
    @State private var searchName: String = ""

    // Stores the result displayed on the screen
    @State private var resultMessage: String = ""

    // Stores whether the PC was found
    @State private var found: Bool? = nil

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "magnifyingglass.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Check Computer")
                .font(.title.bold())

            // Gets the computer name to search
            TextField("Enter PC name", text: $searchName)
                .textFieldStyle(.roundedBorder)

            Button("Check") {
                checkPC()
            }
            .buttonStyle(.borderedProminent)
            .disabled(searchName.isEmpty)

            // Only displays a result after the Check button is pressed
            if let found = found {
                HStack {
                    Image(systemName: found ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(found ? .green : .red)

                    Text(resultMessage)
                        .foregroundStyle(found ? .green : .red)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Check PC")
    }

    // Searches the array for a PC with the entered name
    private func checkPC() {
        found = pc.contains { item in
            item.name.lowercased() == searchName.lowercased()
        }

        if found == true {
            resultMessage = "\(searchName) is in the lab!"
        } else {
            resultMessage = "\(searchName) is not in the lab!"
        }
    }
}
