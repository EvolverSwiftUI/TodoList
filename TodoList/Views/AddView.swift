//
//  AddView.swift
//  TodoList
//
//  Created by Sivaram Yadav on 11/10/21.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false

    var body: some View {
        VStack {
            TextField("Type text here...", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            
            Button(action: saveButtonTapped, label: {
                Text("Save".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)

            })
                
            Spacer()
        }
        .padding(14)
        .navigationTitle("Add an item ✍️")
        .alert(isPresented: $showAlert) {
            getAlert()
        }
    }
    
    func saveButtonTapped() {
        
        if !textIsAppropriate() {
            alertTitle = "Your New todo item must be 3 characters!!!!!!  😨😰😱"
            showAlert.toggle()
            return
        }
        
        listViewModel.addItem(title: textFieldText)
        textFieldText = ""
        presentationMode.wrappedValue.dismiss()
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ListViewModel())
            
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ListViewModel())
        }
    }
}
