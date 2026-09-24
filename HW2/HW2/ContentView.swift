import SwiftUI

struct Student: Identifiable {
    var id: String
    var name: String
    var gpa: Double
    var isActive: Bool
}

struct ContentView: View {

    @State private var students: [Student] = []
    @State private var searchText = ""

    var filteredStudents: [Student] {
        if searchText.isEmpty {
            return students
        }

        return students.filter { student in
            student.name.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Text("Student Manager")
                    .font(.largeTitle.bold())

                Text("Total Students: \(students.count)")
                    .foregroundStyle(.secondary)

                // Search student by name
                TextField("Search student by name", text: $searchText)
                    .textFieldStyle(.roundedBorder)

                List(filteredStudents) { student in
                    NavigationLink {
                        StudentDetailView(
                            student: student,
                            students: $students
                        )
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(student.name)

                                Text(student.id)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            Text("\(student.gpa, specifier: "%.1f")")
                        }
                    }
                }

                NavigationLink {
                    AddStudentView(students: $students)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Student")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}
