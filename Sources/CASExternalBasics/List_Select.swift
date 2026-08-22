/*-------------------------------------------------------------------------------------------------------------------------
     File: List_Select.swift
   Author: Kevin Messina
  Created: 12/01/24
 Modified: 08/22/2026 10:02 PM EDT
  Version: 8
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import CASExternalFoundations
import CASThemeSupport

/// Usage:
///
///    NavigationLink(
///        destination: {
///            SelectPickerView(
///                title: "Inventory Items",
///                allItems: allItems,
///                selectedItems: $SelectedItem
///            )
///            .navigationTitle("Choose Your Related Items")
///    }, label: {
///        HStack {
///            Text("Select Inventory Item:")
///            Spacer()
///            Image(systemName: "\($SelectedItems.count).circle")
///               .foregroundStyle(CT.info.accentColor)
///               .font(.title2)
///        }
///    }
///    )//End NavLink
///    .tint(CT.lightest)
///
/// Params:
///
///     title = Title shown atop screen for what picker items are a list of.
///     allItems = The entire list of Strings of each item.
///     selectedItem = Selected String
///
public struct SelectPickerView<BackgroundView: View>: View {
    let CT = CurrentTheme().getThemeFromUserStds()
    let backgroundView: BackgroundView

    @State var isSearching: Bool = false
    
    public enum ClrBtnPos { case pos_bottomCenter,pos_topTrailing }

    @State var title: String
    @State var subTitle: String = ""
    @Binding var allItems: [String]
    @Binding var selectedItem: String
    @State var showClearButton: Bool = true
    @State var ClearButtonPosition: ClrBtnPos = .pos_bottomCenter
    @State var monospaced: Bool = false
    @State var CSV: Bool = false
    @State var CSVarr: [CSVStruct] = []

    public struct CSVStruct {
        public var id: UUID
        public var title: String
        public var items: [(key: String, value: String)]//Array of tuples.

        public init(
            id: UUID = UUID(),
            title: String,
            items: [(key: String, value: String)]
        ) {
            self.id = id
            self.title = title
            self.items = items
        }
    }

    public init(
        title: String,
        subTitle: String = "",
        allItems: Binding<[String]>,
        selectedItem: Binding<String>,
        showClearButton: Bool = true,
        ClearButtonPosition: ClrBtnPos = .pos_bottomCenter,
        monospaced: Bool = false,
        CSV: Bool = false,
        CSVarr: [CSVStruct] = [],
        @ViewBuilder backgroundView: () -> BackgroundView
    ) {
        self._title = State(initialValue: title)
        self._subTitle = State(initialValue: subTitle)
        self._allItems = allItems
        self._selectedItem = selectedItem
        self._showClearButton = State(initialValue: showClearButton)
        self._ClearButtonPosition = State(initialValue: ClearButtonPosition)
        self._monospaced = State(initialValue: monospaced)
        self._CSV = State(initialValue: CSV)
        self._CSVarr = State(initialValue: CSVarr)
        self.backgroundView = backgroundView()
    }

    @State private var searchText: String = ""
    var searchResults: [String] {
        searchText.isEmpty
        ? allItems
        : allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    func displayView() -> some View {
        ForEach(Array(searchResults.enumerated()), id: \.element) { index, item in
            let isSelected = (self.selectedItem == item)
            
            HStack {
                Image(systemName: "checkmark")
                    .foregroundStyle(CT.accent)
                    .opacity(isSelected ? 1.0 : 0.0)
                
                Button(action: {
                    withAnimation {
                        self.selectedItem = isSelected ?"" :item
                    }
                }) {
                    if CSV {
                        let CSVItem = CSVarr[index]
                        
                        VStack(alignment: .leading, spacing: 1) {
                            Text(CSVItem.title.uppercased()).multilineTextAlignment(.leading)
                                .foregroundStyle(CT.lightest)
                                .font(.body)
                                .fontWidth(.condensed)

                            listDivider(pad: false, color: CT.dark)
                            
                            ForEach(CSVItem.items, id: \.key) { pair in
                                LabeledContent(pair.key, value: pair.value).padding(.leading,20)
                                    .font(.callout)
                                    .foregroundStyle(CT.fair)
                            }//End For
                        }//End VStack
                    }else{
                        Text(item).multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                }
                .foregroundStyle(CT.lightest)
                
                Divider().frame(height: 1.5).overlay(CT.fair.opacity(0.2))
                    .padding(.top,-5)
            }//End HStack
            .font(.body)
            .bold()
            .monospaced(monospaced)
            .padding(.vertical,isSelected ?5 :3)
            .background(
                CT.accent
                    .opacity(isSelected ?0.2 :0.0)
                    .cornerRadius(isSelected ?10 :0)
            )
        }//End ForEach
    }
    
    func titleView() -> some View {
        let searchingFor = searchText.isEmpty
            ?"Showing all items (\(allItems.count) of \(allItems.count))"
            :"Showing items Filtered by '\(searchText)' (\(searchResults.count) of \(allItems.count))"
        
        return VStack(alignment: .leading) {
            Text("\( title ) (\( selectedItem.isEmpty ?"0" :"1" ))")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(CT.accent)
            
            if !subTitle.isEmpty {
                Text("\( subTitle )")
                    .font(.title3)
                    .fontWidth(.compressed)
                    .foregroundStyle(CT.dark)
            }
            
            Text(searchingFor)
                .font(.headline)
                .italic()
                .padding(.bottom, 10)
                .foregroundStyle(CT.fair)
        }
    }
    
    func noItemsView() -> some View {
        VStack {
            Spacer()
            ContentUnavailableView("No Items Found.", systemImage: "list.bullet.rectangle.fill")
                .scaleEffect(deviceIs.Pad ?1.25 :1)
                .frame(height: deviceIs.Pad ?210 :175)
            Spacer()
        }
    }
    
    func listDivider(
        pad: Bool = true,
        color: Color
    ) -> some View {
        Divider()
            .frame(height: 1.0)
            .overlay(color)
            .padding(.top, pad ?4 :0)
            .padding(.bottom, pad ?2 :0)
    }

    public var body: some View {
        ZStack {
            backgroundView
            
            VStack(alignment: .leading) {
                titleView()

                if searchResults.count > 0 {
                    ScrollViewReader { scrollViewer in
                        ScrollView {
                            displayView()
                        }//End Scrollview
                        .scrollContentBackground(.hidden)
                        .onChange(of: isSearching) {
                            if !selectedItem.isEmpty {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    scrollViewer.scrollTo(selectedItem, anchor: .center)
                                }
                            }
                        }
                        .onAppear {
                            if !selectedItem.isEmpty {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    scrollViewer.scrollTo(selectedItem, anchor: .center)
                                }
                            }
                        }
                    }//End ScrollView Reader
                }else{
                    noItemsView()
                }

                Spacer()
            }//End VStack
            .searchable(text: $searchText, isPresented: $isSearching, prompt: "Search For...")
            .textInputAutocapitalization(.never)
            .tint(CT.lightest)
            .preferredColorScheme(CT.colorsForMode().mode)
            .padding(.vertical,20)
            .padding(.horizontal,20)
            .toolbar {
                if showClearButton && searchResults.count > 0 {
                    ToolbarItem(placement: ClearButtonPosition == .pos_bottomCenter ?.bottomBar :.topBarTrailing) {
                        Button {
                            withAnimation {
                                selectedItem = ""
                            }
                        } label: {
                            if ClearButtonPosition == .pos_bottomCenter {
                                HStack {
                                    Image.get("Clear_All").scaledToFit()
                                    Text("Unselect all items")
                                }
                            }else{
                                Image.get("Clear_All").scaledToFit().frame(width:20,height:20)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }//End If
                }
            }//End Toolbar
            .onAppear {
                #if canImport(UIKit)
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(CT.lightest)]
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                #endif

                SimPrint.Info("SelectPickerView", action: .viewAppear, log: LFFL())
            }
            .onDisappear{
                SimPrint.Info("SelectPickerView",action: .viewDisappear, log: LFFL())
            }
        }//End ZStack
    }
}


