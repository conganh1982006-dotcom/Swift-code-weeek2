import SwiftUI

struct AddStudentView: View {

    @Binding var students: [Student]

    @State var id = ""
    @State var name = ""
    @State var gpa = ""
    @State var isActive = true

    // Controls the popup message
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""

    // Prevents adding the same form multiple times
    @State var didAddStudent = false

    // Used to return to the previous screen
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 15) {

            TextField("Student ID", text: $id)
                .textFieldStyle(.roundedBorder)

            TextField("Student Name", text: $name)
                .textFieldStyle(.roundedBorder)

            TextField("GPA", text: $gpa)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)

            Toggle("Active", isOn: $isActive)

            Button("Add Student") {
                addStudent()
            }
            .buttonStyle(.borderedProminent)
            .disabled(didAddStudent)

            Spacer()
        }
        .padding()
        .navigationTitle("Add Student")

        // Shows success or error message
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                if didAddStudent {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    // Validates input and adds one new student
    func addStudent() {

        // Stops the function if a student was already added
        guard !didAddStudent else {
            return
        }

        // Removes unnecessary spaces
        let cleanID = id.trimmingCharacters(in: .whitespaces)
        let cleanName = name.trimmingCharacters(in: .whitespaces)

        // Checks empty ID or name
        if cleanID.isEmpty || cleanName.isEmpty {
            alertTitle = "Invalid Input"
            alertMessage = "Student ID and name cannot be empty."
            showAlert = true
            return
        }

        // Checks if GPA is a valid number
        guard let gpaValue = Double(gpa) else {
            alertTitle = "Invalid GPA"
            alertMessage = "Please enter a valid GPA."
            showAlert = true
            return
        }

        // Checks if GPA is between 0 and 10
        if gpaValue < 0 || gpaValue > 10 {
            alertTitle = "Invalid GPA"
            alertMessage = "GPA must be between 0 and 10."
            showAlert = true
            return
        }

        // Checks if the student ID already exists
        let duplicateID = students.contains { student in
            student.id.lowercased() == cleanID.lowercased()
        }

        if duplicateID {
            alertTitle = "Duplicate ID"
            alertMessage = "Student ID \(cleanID) already exists."
            showAlert = true
            return
        }

        // Creates a new student
        let newStudent = Student(
            id: cleanID,
            name: cleanName,
            gpa: gpaValue,
            isActive: isActive
        )

        // Adds the student to the array
        students.append(newStudent)

        // Prevents the button from adding again
        didAddStudent = true

        // Shows success message
        alertTitle = "Success"
        alertMessage = "\(cleanName) was added successfully."
        showAlert = true
    }
}
