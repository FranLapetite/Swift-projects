//
//  ContentView.swift
//  TODOapp
//
//  Created by Françoise  Lapetite on 25/02/2024.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}
struct CustomListData: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct ContentView: View {
    
    @State private var isOn = false
    @State var todo: String = ""
    @State var customListData = [
            CustomListData(title: "", isCompleted: false),
            CustomListData(title: "", isCompleted: false)
        ]
    var body: some View {
        
        VStack{
            //navigationstack
            HStack {
                Text("TODO List")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    .padding()
                    .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
                Button(action: {
                    customListData.append(CustomListData(title: "", isCompleted: false))

                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                }
            }
            List {
                ForEach(customListData.indices, id: \.self) { index in
                    Button(action: {
                    }) {
                        TextField("Enter your word", text: $customListData[index].title)
                            .foregroundColor(customListData[index].isCompleted ? .green : .primary)
                            .strikethrough(customListData[index].isCompleted, color: .black)
                    }
                    .swipeActions {
                        Button("Done") {
                            
                            customListData[index].isCompleted.toggle()
                        }
                        .tint(.green)
                        
                        Button(role: .destructive) {
                            customListData.remove(at: index)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
