//
//  ContentView.swift
//  LeftIt
//
//  Created by Emanuele Di Pietro on 20/03/24.
//

import SwiftUI
import MapKit

struct CalendarTypeNumber: Identifiable {
    var id = UUID()
    var iconCalendar: Image
    var type: String
    var number: Int
    var color: Color
}

struct BlockSchedule: View {
    var block: CalendarTypeNumber
    var body: some View {
        ZStack{
            HStack(alignment: .top){
                VStack(alignment: .center){
                    block.iconCalendar
                        .font(.system(size: 30))
                        .foregroundStyle(block.color)
                        .padding(.bottom, 5)
                    Text(block.type)
                        .foregroundStyle(Color.primary)
                        .fontWeight(.medium)
                    
                }
            }.frame(maxWidth: .infinity)
                .frame(height: 100)
            .padding(20)
            
        }
        .background(.paleGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}



class Block: Identifiable {
    
    var calendarTypeNumber = [
        CalendarTypeNumber(iconCalendar: Image(systemName: "briefcase.fill"), type: "Work", number: 0, color: Color.primary),
        CalendarTypeNumber(iconCalendar: Image(systemName:"dumbbell.fill"), type: "Gym", number: 0, color: Color.primary),
        CalendarTypeNumber(iconCalendar: Image(systemName:"heart.text.square.fill"), type: "Doctor", number: 0, color: Color.primary)
    ]
}



struct ContentView: View {
    
    @State private var showMap = false
    
    let gridLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2) // Adjust the spacing value as needed
    var blockObject = Block()
    @State private var searchText = ""
    
    let map = MapKitAuth.shared
    
    @ViewBuilder
    var locationRightNow: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Location").foregroundStyle(.white).opacity(0.8).font(.caption)
                    Text("Home").foregroundStyle(.white).font(.title).fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "mappin.and.ellipse").foregroundStyle(.white).font(.largeTitle)
            }
            .padding(.horizontal, 30)
        }.cornerRadius(10)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading){
                        LazyVGrid(columns: gridLayout, spacing: 20) {
                            ForEach(blockObject.calendarTypeNumber) { blocks in
                                BlockSchedule(block: blocks)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                    }
                } header: {
                    locationRightNow
                }.listRowSeparator(.hidden, edges: .all)
            }
            .navigationTitle("Locations")
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Add location")
                        }
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(50)
                        .padding(.vertical, 10)
                    }.frame(maxWidth: .infinity)
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showMap = true
                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                        }
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(5)
                        .font(.title2)
                        .background(LinearGradient(gradient: Gradient(colors: [.primaryViolet, .secondaryViolet]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(50)
                        .padding(.vertical, 10)
                    }.frame(maxWidth: .infinity)
                        .sheet(isPresented: $showMap, content: {
                            MapView()
                        })
                }
            }
        }.fontDesign(.rounded)
    }
}

#Preview {
    ContentView()
}
