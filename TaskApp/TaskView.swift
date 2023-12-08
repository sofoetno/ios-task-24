//
//  TaskView.swift
//  TaskApp
//
//  Created by Sofo Machurishvili on 08.12.23.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(configuration.isOn ? "cheked" : "unchek")
                
                configuration.label
            }
        })
    }
}

struct TaskView: View {
    
    @State var singleTask: TodoTask
    let moveTask: (TodoTask) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(singleTask.taskName)
                    .foregroundColor(.white)
                
                HStack {
                    Image(systemName: "calendar.day.timeline.leading")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                    
                    Text(singleTask.dueDate)
                        .foregroundColor(.white)
                    
                }
            }
            .padding(.leading, 15)
            
            Spacer()
            
            Toggle(isOn: $singleTask.isCompleted) {
            }
            .toggleStyle(iOSCheckboxToggleStyle())
            .onChange(of: singleTask.isCompleted) { oldValue, newValue in
                singleTask.isCompleted = newValue
                
                moveTask(singleTask)
            }
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .cornerRadius(8)
        .background(Color.customBackground)
        .overlay (
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 15, height: geometry.size.height)
                    .background(Color(hex: Int(singleTask.taskColor)))
                    .offset(x: 0, y: 0)
                
                    .clipShape(
                        .rect(topLeadingRadius: 8, bottomLeadingRadius: 8)
                    )
            }
        )
        .clipShape(
            .rect(
                topLeadingRadius: 8,
                bottomLeadingRadius: 8,
                bottomTrailingRadius: 8, 
                topTrailingRadius: 8
            )
        )
        
    }
    
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        self.init(UIColor(hex: hex, alpha: CGFloat(alpha)))
    }
}


#Preview {
    TaskView(
        singleTask: TodoTask(taskName: "Mobile App Research", dueDate: "4 Oct", isCompleted: false, taskColor: 0xFAD9FF)) { _ in }
}
