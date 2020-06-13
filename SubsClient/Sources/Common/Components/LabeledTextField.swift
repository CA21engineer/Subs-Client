//
//  LabeledTextField.swift
//  SubsClient
//
//  Created by 伊藤凌也 on 2020/06/11.
//

import SwiftUI

struct LabeledTextField<T>: View {
    let label: String
    let placeholder: String
    let binding: Binding<T>

    private var formatter: Formatter {
        switch T.self {
        case is String.Type:
            return NothingFormatter()
        case is Int.Type:
            return NumberFormatter()
        default:
            return NothingFormatter()
        }
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                TextField(
                    placeholder,
                    value: binding,
                    formatter: formatter
                )
                .multilineTextAlignment(.trailing)
            }
            .padding(.vertical, 8)
        }
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabeledTextField(
                label: "Sample",
                placeholder: "This is placeholder",
                binding: Binding<String>.init(
                    get: { "" },
                    set: { _ in }
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Only placeholder")
            LabeledTextField(
                label: "Sample",
                placeholder: "This is placeholder",
                binding: Binding<String>.init(
                    get: { "This is not placeholder" },
                    set: { _ in }
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Input text")
            LabeledTextField(
                label: "Sample",
                placeholder: "This is placeholder",
                binding: Binding<Int>.init(
                    get: { 9 },
                    set: { _ in }
                )
            )
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Int")
        }
    }
}
