//
//  ContentView.swift
//  TaskApp
//
//  Created by Sofo Machurishvili on 08.12.23.
//

import SwiftUI

extension Color {
    static let customBackground = Color(red: 0.12, green: 0.12, blue: 0.12)
}

struct TodoTask: Identifiable {
    let id = UUID()
    let taskName: String
    let dueDate: String
    var isCompleted: Bool
    let taskColor: Int
}

//struct CustomProgressViewStyle: ProgressViewStyle {
//    var innerHeight: CGFloat
//
//    func makeBody(configuration: Configuration) -> some View {
//        VStack(spacing: 0) {
//            configuration.label.frame(height: innerHeight)
//
//            RoundedRectangle(cornerRadius: 8)
//                .frame(width: configuration.fractionCompleted ?? 0, height: 18)
//                .foregroundColor(Color(red: 0.73, green: 0.51, blue: 0.87))
//        }
//    }
//}

struct ContentView: View {
    
    @State private var progress = 0.1
    
    @State private var incompleteTaskList = [
        TodoTask(taskName: "Mobile App Research", dueDate: "4 Oct", isCompleted: false, taskColor: 0xFACBBA),
        TodoTask(taskName: "Prepare Wireframe for Main Flow", dueDate: "4 Oct", isCompleted: false, taskColor: 0xD7F0FF),
        TodoTask(taskName: "Prepare Screens", dueDate: "4 Oct", isCompleted: false, taskColor: 0xFAD9FF),
    ]
    
    @State private var completeTaskList: [TodoTask] = [
        TodoTask(taskName: "Website Research", dueDate: "5 Oct",  isCompleted: true, taskColor: 0xFACBBA),
        TodoTask(taskName: "Prepare Wireframe for Main Flow", dueDate: "5 Oct", isCompleted: true, taskColor: 0xD7F0FF),
        TodoTask(taskName: "Prepare Screens", dueDate: "05 Oct", isCompleted: true, taskColor: 0xFAD9FF)
    ]
    
    var body: some View {
        ScrollView{
            VStack {
                HStack {
                    Text("You have \(incompleteTaskList.count) tasks to complete")
                        .multilineTextAlignment(.leading)
                        .baselineOffset(5)
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .frame(width: 200)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Image("back")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipped()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                        .overlay (
                            Image("profileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipped()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                  )
                    
                        .overlay {
                            GeometryReader { geometry in
                                Text("\(incompleteTaskList.count)")
                                    .font(.system(size: 9))
                                    .frame(width: 15, height: 15)
                                    .offset(x: geometry.size.width - 15, y: geometry.size.height - 15)
                                    .background(
                                        Circle()
                                            .fill(Color(red: 1, green: 0.46, blue: 0.23))
                                            .offset(x: geometry.size.width - 15, y: geometry.size.height - 15)
                                    )
                                    .foregroundColor(.white)
                                
                                
                            }
                            
                        }
                }
                .padding()
                
                Button(action: {
                    completeTaskList += incompleteTaskList.map({
                        TodoTask(taskName: $0.taskName, dueDate: $0.dueDate, isCompleted: true, taskColor: $0.taskColor)
                    })
                    incompleteTaskList = []
                }, label: {
                    Text("Complete All")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient.Stop(color: Color(red: 0.73, green: 0.51, blue: 0.87), location: 0.00),
                                    Gradient.Stop(color: Color(red: 0.87, green: 0.51, blue: 0.69), location: 1.00),
                                ],
                                startPoint: UnitPoint(x: 0, y: 0.49),
                                endPoint: UnitPoint(x: 1.02, y: 0.73)
                            )
                        )
                })
                .cornerRadius(8)
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Daily Task")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.top, 15)
                    
                    Text("\(completeTaskList.count)/ \(completeTaskList.count + incompleteTaskList.count) Task Completed")
                        .foregroundColor(Color(red: 1, green: 1, blue: 1))
                        .font(.system(size: 16))
                        .padding(.horizontal, 15)
                    
                    HStack {
                        Text(dailyTaskSlogan())
                            .foregroundColor(Color(red: 1, green: 1, blue: 1))
                            .font(.system(size: 14))
                            .fontWeight(.ultraLight)
                        Spacer()
                        
                        HStack {
                            Text("\(calculatePercentage())%")
                                .foregroundColor(Color(red: 1, green: 1, blue: 1))
                                .font(.system(size: 14))
                                .fontWeight(.ultraLight)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 6)
                    
                    VStack {
                        ProgressView(value: Float(completeTaskList.count), total: Float(completeTaskList.count + incompleteTaskList.count))
                            .background(Color(red: 0.73, green: 0.51, blue: 0.87).opacity(0.41))
                            .accentColor(Color(red: 0.73, green: 0.51, blue: 0.87))
                            .scaleEffect(x: 1, y: 3, anchor: .center)
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 20)
                    
                }
                .background(Color (red: 0.09, green: 0.09, blue: 0.09))
                .cornerRadius(8)
                .padding(.horizontal, 15)
                    
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Completed Tasks")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(incompleteTaskList, id: \.id) { toDoTask in
                            TaskView(singleTask: toDoTask, moveTask: moveTask)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(completeTaskList, id: \.id) { toDoTask in
                            TaskView(singleTask: toDoTask, moveTask: moveTask)
                        }
                    }
                }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        
    }
    
    func calculatePercentage() -> Int {
        Int(
            (Float(completeTaskList.count) / Float(incompleteTaskList.count + completeTaskList.count) * 100)
        )
    }
    
    func dailyTaskSlogan() -> String {
        incompleteTaskList.count == 0 ? "Mission completed Sofo <3" : "Keep working"
    }
    
    
    func moveTask(singleTask: TodoTask) {
        if singleTask.isCompleted == true {
            if let index = incompleteTaskList.firstIndex(where: {$0.id == singleTask.id}) {
                completeTaskList.append(singleTask)
                incompleteTaskList.remove(at: index)
            }
        } else {
            if let index = completeTaskList.firstIndex(where: {$0.id == singleTask.id}) {
                incompleteTaskList.append(singleTask)
                completeTaskList.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
}
