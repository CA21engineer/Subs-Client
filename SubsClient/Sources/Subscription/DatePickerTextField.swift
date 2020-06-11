//
//  DatePickerTextField.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import SwiftUI

struct DatePickerTextField: View {
    let label: String
    let placeholder: String
    let binding: Binding<Date>

    @State var textfieldText = ""
    @State var showsDatePicker = false

    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Spacer()
                Text(dateFormatter.string(from: binding.wrappedValue))
                    .onTapGesture {
                        withAnimation {
                            self.showsDatePicker.toggle()
                        }
                    }
            }
            if showsDatePicker {
                DatePicker(
                    selection: binding,
                    displayedComponents: .date) {
                        Text(label)
                }
                .labelsHidden()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct DatePickerTextField_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerTextField(
            label: "Sample",
            placeholder: "This is placeholder",
            binding: Binding<Date>.init(
                get: { Date() },
                set: { _ in }
            )
        )
    }
}
