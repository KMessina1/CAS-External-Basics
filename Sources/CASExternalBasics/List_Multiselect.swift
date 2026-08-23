/*-------------------------------------------------------------------------------------------------------------------------
     File: List_Multiselect.swift
   Author: Kevin Messina
  Created: 6/27/24
 Modified: 08/23/2026 09:20 AM EDT
  Version: 7
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
///            MultiSelectPickerView(
///                title: "Inventory Items",
///                allItems: multi_allItems,
///                selectedItems: $multi_selectedItems
///            )
///            .navigationTitle("Choose Your Related Items")
///    }, label: {
///        HStack {
///            Text("Select Related Inventory Items:")
///            Spacer()
///            Image(systemName: "\(multi_selectedItems.count).circle")
///               .foregroundStyle(CT.info.accentColor)
///               .font(.title2)
///        }
///    }
///    )//End NavLink
///    .tint(CT.lightest)
///
///    Text(multi_selectedItems.joined(separator: "\n"))
///        .foregroundStyle(CT.info.textColor_Fair.opacity(0.5))
///        .padding(.leading,20)
///
///     -or-
///
///     let temp:String = multi_selectedItems.joined(separator: ",")
///     let tempItems = temp.components(separatedBy: ",")
///
///     ForEach(0...tempItems.count - 1, id: \.self) { indx in
///     ...
///     }
///
/// Params:
///
///     title = Title shown atop screen for what picker items are a list of.
///     allItems = The entire list of Strings of each item.
///     selectedItems = An array of \n seperated Strings
///     
public struct MultiSelectPickerView: View {
    let CT = CurrentTheme().getThemeFromUserStds()
    let backgroundView: AnyView
    
    @State var isSearching: Bool = false

    public enum ClrBtnPos { case pos_bottomCenter,pos_topTrailing }
    public enum StatusVals { case deselected,nothingChanged,changes }

    var title: String
    @Binding var allItems: [String]
    @Binding var selectedItems: [String]
    @Binding var selectedStatus: StatusVals
    @State var showClearButton: Bool = true
    @State var showSearch: Bool = true
    @State var ClearButtonPosition: ClrBtnPos = .pos_bottomCenter
    @State var isInsetView: Bool = false
    @State var containsIDs: Bool = false

    public init(
        title: String,
        allItems: Binding<[String]>,
        selectedItems: Binding<[String]>,
        selectedStatus: Binding<StatusVals>,
        showClearButton: Bool = true,
        showSearch: Bool = true,
        ClearButtonPosition: ClrBtnPos = .pos_bottomCenter,
        isInsetView: Bool = false,
        containsIDs: Bool = false
    ) {
        self.title = title
        self._allItems = allItems
        self._selectedItems = selectedItems
        self._selectedStatus = selectedStatus
        self._showClearButton = State(initialValue: showClearButton)
        self._showSearch = State(initialValue: showSearch)
        self._ClearButtonPosition = State(initialValue: ClearButtonPosition)
        self._isInsetView = State(initialValue: isInsetView)
        self._containsIDs = State(initialValue: containsIDs)
        self.backgroundView = AnyView(EmptyView())
    }

    public init<BackgroundView: View>(
        title: String,
        allItems: Binding<[String]>,
        selectedItems: Binding<[String]>,
        selectedStatus: Binding<StatusVals>,
        showClearButton: Bool = true,
        showSearch: Bool = true,
        ClearButtonPosition: ClrBtnPos = .pos_bottomCenter,
        isInsetView: Bool = false,
        containsIDs: Bool = false,
        @ViewBuilder backgroundView: () -> BackgroundView
    ) {
        self.title = title
        self._allItems = allItems
        self._selectedItems = selectedItems
        self._selectedStatus = selectedStatus
        self._showClearButton = State(initialValue: showClearButton)
        self._showSearch = State(initialValue: showSearch)
        self._ClearButtonPosition = State(initialValue: ClearButtonPosition)
        self._isInsetView = State(initialValue: isInsetView)
        self._containsIDs = State(initialValue: containsIDs)
        self.backgroundView = AnyView(backgroundView())
    }

    @State private var searchText: String = ""
    @State private var originalSelectedItems: [String] = []
    var searchResults: [String] {
        searchText.isEmpty
        ? allItems
        : allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var selectedItemsCount: Int { return selectedItems.count }
    
    func linetItemView(item: String) -> some View {
        let isSelected = self.selectedItems.contains(item)

        return HStack(spacing: 5) {
            Image(systemName: "checkmark")
                .foregroundStyle(CT.accent)
                .opacity(isSelected ? 1.0 : 0.0)
                .padding(.leading,5)
            
            if containsIDs {
                let val = item.beforeChar(":")
                let txt = item.afterChar(":").trim(.ends)
                DL().recordID(title: txt, id: Int64(val).orInvalidDbId, padLeading: false)
                    .padding(.vertical,10)
                    .padding(.trailing,-7)
            }else{
                Text(item)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(CT.lightest)
            }
            
            Spacer()
        }
        .font(.body)
        .bold()
        .background(
            CT.accent
                .opacity(isSelected ?0.3 :0.0)
                .cornerRadius(isSelected ?10 :0)
        )
    }
    
    var searchingFor: String {
        searchText.isEmpty
            ?"Showing all items (\(allItems.count) of \(allItems.count))"
            :"Showing items Filtered by '\(searchText)' (\(searchResults.count) of \(allItems.count))"
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Text(selectedItemsCount > 0 ?"\( title ) (\( selectedItemsCount ))" :"\( title )")
                .font(isInsetView ?.title2 :.largeTitle)
                .bold()
                .foregroundStyle(CT.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            if showSearch {
                Text(searchingFor)
                    .font(isInsetView ?.callout :.title2)
                    .italic()
                    .padding(.bottom, 10)
                    .foregroundStyle(CT.fair)
            }
        }
    }

    var noItemsFound: some View {
        VStack{
            Spacer()
            ContentUnavailableView("No Items Found.", systemImage: "list.bullet.rectangle.fill")
                .scaleEffect(deviceIs.Pad ?1.25 :1)
                .frame(height: deviceIs.Pad ?210 :175)
            Spacer()
        }
        .foregroundStyle(CT.lightest)
    }
    
    var searchResultsView: some View{
        ScrollViewReader { scrollViewer in
            ScrollView {
                ForEach(searchResults, id: \.self) { item in
                    let isSelected = self.selectedItems.contains(item)
                    
                    Button(action: {
                        withAnimation {
                            if isSelected {
                                self.selectedItems.removeAll(where: { $0 == item })
                            } else {
                                self.selectedItems.append(item)
                            }
                        }
                    }) {
                        linetItemView(item: item)
                    }
                    .foregroundStyle(CT.lightest)
                    
                    Divider().frame(height: 1.5).overlay(CT.fair.opacity(0.2))
                }//End ForEach
            }//End Scrollview
            .scrollContentBackground(.hidden)
            .padding(.horizontal, -20)
            .onChange(of: isSearching) {
                if selectedItemsCount > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        scrollViewer.scrollTo(selectedItems[0], anchor: .center)
                    }
                }
            }
            .onAppear {
                if selectedItemsCount > 0 {
                    scrollViewer.scrollTo(selectedItems[0], anchor: .center)
                }
            }
        }//End ScrollView Reader
        .conditionalSearchable(if: showSearch, text: $searchText, prompt: "Search For...")
        .textInputAutocapitalization(.never)
        .tint(CT.lightest)
        .preferredColorScheme(CT.colorsForMode().mode)
        .padding(.vertical, isInsetView ?0 :containsIDs ?0 :20)
        .padding(.horizontal, isInsetView ?10 :containsIDs ?5 :20)
        .onChange(of: selectedItems){
            if selectedItemsCount < 1 {
                selectedStatus = .deselected
            }else if selectedItems == originalSelectedItems {
                selectedStatus = .nothingChanged
            }else if selectedItems != originalSelectedItems {
                selectedStatus = .changes
            }
        }
        .onChange(of: allItems){
            searchText = ""
            originalSelectedItems = selectedItems
            selectedStatus = .nothingChanged
            originalSelectedItems = selectedItems
        }
    }
    
    var clearButtonView: some View {
        Button {
            withAnimation {
                selectedItems = []
            }
        } label: {
            Group {
                if ClearButtonPosition == .pos_bottomCenter {
                    HStack {
                        Image.get("Clear_All").scaledToFit()
                        Text("Unselect all items")
                    }
                } else {
                    Image.get("Clear_All")
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 14).padding(.vertical, 10)
        }
        .foregroundStyle(.white)
        .background(
            Capsule()
                .fill(.red.opacity(0.66))
        )
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            if !isInsetView {
                backgroundView
            }

            VStack(alignment: .leading) {
                header
                    .padding(.horizontal, isInsetView ? 20 : 0)

                if searchResults.count > 0 {
                    searchResultsView
                }else{
                    noItemsFound
                }
                
                Spacer()
            }//End VStack
            .padding(.horizontal, isInsetView ? -5 : 20)
            .toolbar {
                if showClearButton && searchResults.count > 0 {
                    ToolbarItem(placement: ClearButtonPosition == .pos_bottomCenter ?.bottomBar :.topBarTrailing) {
                        clearButtonView
                    }
                }
            }//End Toolbar
            .foregroundStyle(CT.lightest)
            .onAppear {
                #if canImport(UIKit)
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(CT.lightest)]
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
                #endif
                
                selectedStatus = .nothingChanged
                originalSelectedItems = selectedItems
            }
        }//End ZStack
    }
}

// MARK: - *** Preview ***
#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var multi_selectedItems: [String] = ["Item C"]
    @Previewable @State var multi_allItems: [String] = ["Item A", "Item B", "Item C"]
    @Previewable @State var changeStatus: MultiSelectPickerView.StatusVals = .nothingChanged

    MultiSelectPickerView(
        title: "Accessories",
        allItems: $multi_allItems,
        selectedItems: $multi_selectedItems,
        selectedStatus: $changeStatus,
        showClearButton: true,
        isInsetView: false,
        containsIDs: true,
        backgroundView: { Color.black.ignoresSafeArea() }
    )
}


