//
//  ContentView.swift
//  Week2_array
//
//  Created by MAY 02 on 21/9/26.
//

import SwiftUI

struct PC: Identifiable {
    var id: UUID = UUID()
    var name: String
    var location: String
    var isAvailable: Bool
}

struct ContentView: View {

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
                Image(systemName: "desktopcomputer").font(.system(size: 50, weight: .bold)).foregroundStyle(.gray)
                Text("PC LAB").font(.largeTitle.bold())
                Text("Hello user").foregroundStyle(.gray)

                List(pc) { pc in
                    HStack {
                        Image(systemName: "desktopcomputer").foregroundStyle(.gray)

                        VStack(alignment: .leading) {
                            Text(pc.name).font(.headline)
                            Text(pc.location).font(.subheadline).foregroundStyle(.secondary)
                        }

                        Spacer()

                        HStack(spacing: 6) {
                            Circle().fill(pc.isAvailable ? .green : .red).frame(width: 10, height: 10)
                            Text(pc.isAvailable ? "Available" : "In Use").foregroundStyle(pc.isAvailable ? .green : .red)
                        }
                    }
                }

                Button(action: {
                    // add PC here
                }) {
                    HStack {
                        Image(systemName: "plus").foregroundStyle(.white)
                        Text("Add PC")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                Text("Total computer: \(pc.count)")
            }
            .padding()
            .navigationTitle("")
        }
    }
}

#Preview {
    ContentView()
}
