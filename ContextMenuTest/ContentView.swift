//
//  ContentView.swift
//  ContextMenuTest
//
//  Created by Yong Jin on 2021/8/7.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RowsData()
    var body: some View {
        List {
            ForEach(viewModel.rows) {row in
                HStack {
                    Text(row.name)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .opacity(row.favorite ? 1 : 0)
                }
                .contextMenu{
                    Button(
                        action: {viewModel.toggleFavorite(row: row)},
                        label: {Text(row.favorite ? "Unfavorte" : "Favorte")}
                        ///contextMenu文字根据row内容变化
                    )
                }
            }
        }
    }
}

struct Row: Identifiable{
    var id:UUID = UUID()
    var name: String = "Name"
    var favorite: Bool = false
}

class RowsData: ObservableObject {
    @Published var rows: [Row] = (1...10).map{Row(name: "name\($0)", favorite: Bool.random())}
    
    func toggleFavorite(row: Row) {
        if let index = rows.firstIndex(where: {$0.id == row.id}) {
            rows[index].favorite.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
