
import SwiftUI

struct StudentDetailView: View {

    var student: Student
    @Binding var students: [Student]

    @State private var showDeleteAlert = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text(student.name)
                .font(.largeTitle.bold())

            Text("ID: \(student.id)")
            Text("GPA: \(student.gpa, specifier: "%.1f")")

            Text(student.isActive ? "Active" : "Inactive")
                .foregroundStyle(student.isActive ? .green : .red)

            Spacer()

            // Open the Edit Student screen
            NavigationLink {
                EditStudentView(student: student, students: $students)
            } label: {
                Text("Edit Student")
            }
            .buttonStyle(.borderedProminent)

            // Ask before deleting the student
            Button("Delete Student", role: .destructive) {
                showDeleteAlert = true
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle("Student Detail")

        // Delete confirmation popup
        .alert("Delete Student?", isPresented: $showDeleteAlert) {

            Button("Cancel", role: .cancel) { }

            Button("Delete", role: .destructive) {
                deleteStudent()
            }

        } message: {
            Text("Are you sure you want to delete \(student.name)?")
        }
    }

    // Remove the selected student from the array
    func deleteStudent() {
        students.removeAll { item in
            item.id == student.id
        }

        dismiss()
    }
}
