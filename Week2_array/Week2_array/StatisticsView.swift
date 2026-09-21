import SwiftUI

struct StatisticsView: View {

    // Receives the PC array from ContentView
    let pc: [PC]

    // Calculates the total number of computers
    var totalComputer: Int {
        pc.count
    }

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "chart.bar.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Statistics")
                .font(.title.bold())

            // Displays the total number of computers
            HStack {
                Image(systemName: "desktopcomputer")
                    .font(.title)
                    .foregroundStyle(.blue)

                VStack(alignment: .leading) {
                    Text("Total Computers")
                        .foregroundStyle(.secondary)

                    Text("\(totalComputer)")
                        .font(.largeTitle.bold())
                }

                Spacer()
            }
            .padding()

            Text("Computer List")
                .font(.headline)

            // Displays all computers in the lab
            List(pc) { item in
                HStack {
                    Image(systemName: "desktopcomputer")

                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        Text(item.location).font(.subheadline).foregroundStyle(.secondary)
                    }

                    Spacer()

                    Circle()
                        .fill(item.isAvailable ? .green : .red)
                        .frame(width: 10, height: 10)

                    Text(item.isAvailable ? "Available" : "In Use")
                        .foregroundStyle(item.isAvailable ? .green : .red)
                }
            }
        }
        .padding()
        .navigationTitle("Statistics")
    }
}
