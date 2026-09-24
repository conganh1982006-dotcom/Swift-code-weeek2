
import SwiftUI

struct EditStudentView: View {

    var student: Student
    @Binding var students: [Student]

    // Stores the edited values
    @State private var name = ""
    @State private var gpa = ""
    @State private var isActive = true

    // Controls the alert
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 15) {

            Text("Edit Student")
                .font(.largeTitle.bold())

            // ID is used to identify the student
            Text("Student ID: \(student.id)")
                .foregroundStyle(.secondary)

            TextField("Student Name", text: $name)
                .textFieldStyle(.roundedBorder)

            TextField("GPA", text: $gpa)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)

            Toggle("Active", isOn: $isActive)

            Button("Save Changes") {
                editStudent()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle("Edit Student")

        // Load the old student information
        .onAppear {
            name = student.name
            gpa = String(student.gpa)
            isActive = student.isActive
        }

        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                if alertTitle == "Success" {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    // Updates the selected student
    func editStudent() {

        let cleanName = name.trimmingCharacters(in: .whitespaces)

        // Check empty name
        if cleanName.isEmpty {
            alertTitle = "Invalid Name"
            alertMessage = "Student name cannot be empty."
            showAlert = true
            return
        }

        // Convert GPA from String to Double
        guard let gpaValue = Double(gpa) else {
            alertTitle = "Invalid GPA"
            alertMessage = "Please enter a valid GPA."
            showAlert = true
            return
        }

        // Check GPA range
        if gpaValue < 0 || gpaValue > 10 {
            alertTitle = "Invalid GPA"
            alertMessage = "GPA must be between 0 and 10."
            showAlert = true
            return
        }

        // Find the student position in the array
        if let index = students.firstIndex(where: { item in
            item.id == student.id
        }) {

            // Update the student
            students[index].name = cleanName
            students[index].gpa = gpaValue
            students[index].isActive = isActive

            alertTitle = "Success"
            alertMessage = "Student information was updated successfully."
            showAlert = true
        }
    }
}
