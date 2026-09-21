import SwiftUI

struct ContentView: View {

    // Main PC array of the application
    @State private var pc: [PC] = [
        PC(name: "PC01", location: "Lab A", isAvailable: true),
        PC(name: "PC02", location: "Lab B", isAvailable: false),
        PC(name: "PC03", location: "Lab D", isAvailable: true),
        PC(name: "PC04", location: "Lab C", isAvailable: false),
        PC(name: "PC05", location: "Lab E", isAvailable: true)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Application header
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundStyle(.gray)

                Text("PC LAB").font(.largeTitle.bold())

                Text("Hello user")
                    .foregroundStyle(.gray)
                // Displays every PC stored in the array
                List {
                    ForEach(pc) { item in
                        HStack {
                            Image(systemName: "desktopcomputer")
                                .foregroundStyle(.gray)

                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.location).font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                            // Shows the current PC status
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(item.isAvailable ? .green : .red)
                                    .frame(width: 10, height: 10)

                                Text(item.isAvailable ? "Available" : "In Use")
                                    .foregroundStyle(item.isAvailable ? .green : .red)
                            }
                        }
                    }
                    .onDelete(perform: deletePC) // Optional: swipe to delete a PC
                }

                // Opens the Add PC screen
                NavigationLink {
                    AddPCView(pc: $pc)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add PC")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                // Opens the Check PC screen
                NavigationLink {
                    CheckPCView(pc: pc)
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Check PC")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                // Opens the Statistics screen
                NavigationLink {
                    StatisticsView(pc: pc)
                } label: {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Statistics")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                // Displays the current number of computers
                Text("Total computer: \(pc.count)")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("")
        }
    }

    // Removes selected PCs from the array
    private func deletePC(at offsets: IndexSet) {
        pc.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
