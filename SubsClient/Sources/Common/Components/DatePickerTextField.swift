//
//  DatePickerTextField.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import SwiftUI

struct DatePickerTextField: View {
    private let label: String
    private let binding: Binding<Date>

    init(label: String, binding: Binding<Date>) {
        self.label = label
        self.binding = binding
    }

    @State private var showsDatePicker = false

    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                Spacer()
                Text(self.dateFormatter.string(from: binding.wrappedValue))
                    .onTapGesture {
                        withAnimation {
                            UIApplication.shared.endEditing()
                            self.showsDatePicker.toggle()
                        }
                    }
            }
            if self.showsDatePicker {
                DatePicker(
                    selection: self.binding,
                    displayedComponents: .date
                ) {
                    Text(label)
                }
                .labelsHidden()
            }
        }
        .padding(.vertical, 8)
    }
}

struct DatePickerTextField_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerTextField(
            label: "Sample",
            binding: Binding<Date>.init(
                get: { Date() },
                set: { _ in }
            )
        )
    }
}
