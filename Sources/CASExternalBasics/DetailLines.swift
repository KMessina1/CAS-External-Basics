/*-------------------------------------------------------------------------------------------------------------------------
     File: DetailLines.swift
   Author: Kevin Messina
  Created: 9/8/25
 Modified: 09/05/2026 05:31 AM EDT
  Version: 15
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.

©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import SwiftUI
import CASExternalFoundations
import CASThemeSupport

public typealias DL = DetailLine
public struct DetailLine {
    public init() {}
    
    public enum Orientations { case vertical,horizontal }
    
    public func divider(
        vertical: Bool = false,
        pad: Bool = true,
        lineWidth: CGFloat = 1.0,
        color: Color = .clear
    ) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        let dividerColor = color == .clear ?CT.fair :color

        return Group {
            if vertical {
                Divider()
                    .frame(width: lineWidth)
                    .overlay(dividerColor)
            }else{
                Divider()
                    .frame(height: lineWidth)
                    .overlay(dividerColor)
                    .padding(.top, pad ?4 :0)
                    .padding(.bottom, pad ?2 :0)
            }
        }
    }

    
    public func title(_ title: String,font:Font? = nil) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()

        var fontSize: Font {
            if font != nil {
                return font!
            }else{
                return deviceIs.Pad ?.title3 :.headline
            }
        }

        return VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .foregroundStyle(CT.fair)
                .lineLimit(1)
        }
        .font(fontSize)
        .fontWidth(.condensed)
    }
    
    public func notes(_ title: String = "Notes:", value: String) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return VStack {
            if value.isEmpty {
                DL().titleValue(title, value: "--")
            }else{
                VStack(alignment: .leading, spacing: 5) {
                    Label {
                        Text(title)
                            .font(deviceIs.Pad ?.title3 :.headline)
                            .foregroundStyle(CT.fair)
                    } icon: {
                        Image.getResizable(value.isEmpty ?"note" :"note.text")
                            .frame(width: deviceIs.Pad ?20 :15,height: deviceIs.Pad ?20 :15)
                            .foregroundStyle(CT.fair)
                    }
                    
                    ScrollView {
                        Text(value)
                            .italic()
                            .font(deviceIs.Pad ?.title3 :.headline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(CT.lightest)
                    }
                    .scrollDismissesKeyboard(.immediately)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.automatic, axes: .vertical)
                    .contentMargins(.horizontal, 20.0)
                    .contentMargins(.top, 0.0)
                    .contentMargins(.bottom, 20.0)
                }//End Scrollview
                .fontWidth(.condensed)
                .frame(maxWidth: .infinity, alignment: .leading)
            }//End If
        }//End VStack
    }
    
    public func capsuleText(_ title:String,titleColor:Color = .clear,backColor:Color = .clear,fontWidth:Font.Width = .standard)  -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return HStack(spacing: 0) {
            Spacer()
            
            Text(title)
                .font(.callout)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.66)
                .fontWidth(fontWidth)
                .foregroundStyle(titleColor == .clear ?CT.darkest :titleColor)
                .padding(.horizontal,12)
                .padding(.vertical,2)
                .background(
                    Capsule().fill(backColor == .clear ?CT.fair :backColor)
                )
                .padding(.horizontal, 10)
            
            Spacer()
        }
        .frame(height:25)
    }
    
    public func dividerText(
        _ title:String,
        value:Int = -1,
        pluralWord:String = "",
        lineWidth:CGFloat = 2.0,
        leading:Bool = false,
        fontSize:CGFloat = 18.0
    )  -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return Rectangle().frame(height: lineWidth)
            .foregroundStyle(CT.lightest.opacity(0.5))
            .overlay( content: {
                HStack {
                    if !leading {
                        Spacer()
                    }
                    
                    Text(pluralWord.isEmpty ?title : "^[\( value ) \( pluralWord )](inflect: true) \(title)")
                        .font(.system(size: fontSize))
                        .foregroundStyle(CT.darkest)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.66)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 1)
                        .background(
                            Capsule()
                                .fill(CT.fair)
                        )
                        .padding(.leading, leading ?12 :0)

                    Spacer()
                }
            })
            .frame(height:30)
            .padding(.horizontal, 10)
            .font(.title2)
    }
    
    public func icon(_ title:String,prefix:String,icon:String,suffix:String,colorOveride:Color = .clear,font:Font? = nil) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        var fontSize: Font {
            if font != nil {
                return font!
            }else{
                return deviceIs.Pad ?.title3 :.headline
            }
        }
        
        return LabeledContent {
            Text("\(prefix)\(Image(systemName: icon))\(suffix)")
                .foregroundStyle(colorOveride != .clear ?colorOveride :CT.lightest)
        } label: {
            Text(title)
                .foregroundStyle(CT.fair)
        }
        .foregroundStyle(CT.fair)
        .font(fontSize)
        .fontWidth(.condensed)
        .lineLimit(1)
        .truncationMode(.tail)
    }
    
    public func recordID(title: String = "Record ID:", id: Int64, padLeading: Bool = true) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return LabeledContent {
            HStack(spacing: 0) {
                Image.get("key.horizontal.fill")
                Text(" \(id)")
                    .font(deviceIs.Pad ?.title3 :.headline)
            }
            .foregroundStyle(.pink)
        } label: {
            Text("\( title )")
                .font(deviceIs.Pad ?.title3 :.headline)
                .foregroundStyle(CT.fair)
                .multilineTextAlignment(.leading)
                .padding(.leading, padLeading ?40 :0)
        }
        .fontWidth(.condensed)
    }
    
    public func link(_ title: String, btnTitle: String, link: String) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return LabeledContent {
            if link.isEmpty {
                Text("--")
                    .font(deviceIs.Pad ?.title3 :.headline)
                    .foregroundStyle(CT.lightest)
                    .multilineTextAlignment(.trailing)
            }else{
                Link(btnTitle, destination: URL(string: link)!)
                    .font(deviceIs.Pad ?.body :.callout)
                    .padding(.vertical,1)
                    .padding(.horizontal,10)
                    .background(CT.title)
                    .cornerRadius(8.0)
                    .foregroundStyle(CT.darkest)
            }
        } label: {
            Text(title.isEmpty ?"--" :title)
                .font(deviceIs.Pad ?.title3 :.headline)
                .foregroundStyle(CT.fair)
        }
        .fontWidth(.condensed)
        .lineLimit(1)
        .truncationMode(.tail)
    }
    
    @ViewBuilder
    public func displayLine(index: Int, element: String, font: Font = .title2.smallCaps()) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()

        HStack(spacing:0){
            Text("\( index + 1 ).")
                .padding(.trailing,5)
            
            if element.contains(":") {
                let val = element.beforeChar(":")
                let txt = element.afterChar(":").trim(.ends)

                DL().recordID(title: txt, id: Int64(val).orInvalidDbId, padLeading: false)
                    .tag("\( element )")
                    .id("\( element )")
                    .padding(.trailing,-12)
            }else{
                Text(element)
                    .tag("\( element )")
                    .id("\( element )")
                    .padding(.trailing,-12)
            }
                
            Spacer()
        }//End HStack
        .font(font)
        .fontWidth(.condensed)
        .foregroundStyle(CT.light)
        .multilineTextAlignment(.leading)
        .padding(.horizontal,-10)
    }

    @ViewBuilder
    public func smallCardCount(_ title: String, img:String, count:Int, layout:Orientations) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()

        if layout == .vertical {
            VStack(spacing: 1) {
                Image.getResizable(img)
                    .frame(width:20,height:20)
                    .foregroundStyle(CT.title)
                
                Text("\(count)")
                    .font(.callout)
                    .bold()
                    .foregroundStyle(CT.fair)
            }
        }else{
            VStack(spacing: 0) {
                HStack(spacing: 2) {
                    Image.getResizable(img)
                        .frame(width:15,height:15)
                        .foregroundStyle(CT.title)
                    
                    Text("\(count)")
                        .font(.headline)
                        .fontWidth(.condensed)
                        .bold()
                        .foregroundStyle(CT.fair)
                }//End HStack

                Text("\(title)")
                    .font(.callout.smallCaps())
                    .fontWidth(.compressed)
                    .foregroundStyle(CT.title)
            }//End VStack
        }
    }
    
    @ViewBuilder
    public func bulletedTitleValue(_ title:String,value:String,maxChars:Int = 0) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        let displayValue = value.isEmpty ? "--" : value
        
        HStack(alignment: .top, spacing: 12) {
            Text("• \(title)")
                .foregroundStyle(CT.fair)
                .lineLimit(1)
            
            Spacer(minLength: 0)
            
            Text(displayValue)
                .foregroundStyle(CT.lightest)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(deviceIs.Pad ?.title3 :.headline)
        .fontWidth(.condensed)
    }

    @ViewBuilder
    public func bulletedValue(_ value:String,maxChars:Int = 0,width:Font.Width = .condensed) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        let displayValue = value.isEmpty ? "--" : value
        
        HStack(alignment: .top, spacing: 1) {
            Text("• ")
                .foregroundStyle(CT.fair)
            
            Text(displayValue)
                .foregroundStyle(CT.lightest)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .font(deviceIs.Pad ?.title3 :.headline)
        .fontWidth(width)
    }

    public func titleValueView(
        _ title:String,
        colorOveride:Color = .clear,
        font:Font? = nil,
        value:some View
    ) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        var fontSize: Font {
            if font != nil {
                return font!
            }else{
                return deviceIs.Pad ?.title3 :.headline
            }
        }
        
        return LabeledContent {
            value
                .foregroundStyle(colorOveride != .clear ?colorOveride :CT.lightest)
        } label: {
            Text(title)
                .foregroundStyle(CT.fair)
        }
        .foregroundStyle(CT.fair)
        .font(fontSize)
        .fontWidth(.condensed)
        .lineLimit(1)
        .truncationMode(.tail)
    }

    public func titleValueMultiLine(_ title:String,colorOveride:Color = .clear,font:Font? = nil,value:String,maxChars:Int = 0) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        let isTxtLengthLimited: Bool = (maxChars > 0)
        
        var fontSize: Font {
            if font != nil {
                return font!
            }else{
                return deviceIs.Pad ?.title3 :.headline
            }
        }

        return HStack(alignment: .top) {
            Text(title)
                .foregroundStyle(CT.fair)

            Spacer()
            
            VStack(alignment: .trailing) {
                if isTxtLengthLimited {
                    Text((value.count > maxChars) ? value.substringFromStart(maxChars) + "…" : value)
                        .foregroundStyle(colorOveride != .clear ?colorOveride :CT.lightest)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }else{
                    Text(value.isEmpty ?"--" :value)
                        .foregroundStyle(colorOveride != .clear ?colorOveride :CT.lightest)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(nil)
                }
            }
        }
        .font(fontSize)
        .fontWidth(.condensed)
    }

    public func titleValueLink(_ title: String, linkTitle: String, colorOveride: Color = .clear, font: Font? = nil, value: String, maxChars: Int = 0) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        let isTxtLengthLimited: Bool = (maxChars > 0)
        
        var fontSize: Font {
            font ?? (deviceIs.Pad ? .title3 : .headline)
        }
        
        // 1. Ensure the value is a valid URL
        let url = URL(string: value) ?? URL(string: "https://")!

        // 2. Wrap the entire row in a Link to make it externally tappable
        return Link(destination: url) {
            LabeledContent {
                if isTxtLengthLimited {
                    Text((value.count > maxChars) ? value.substringFromStart(maxChars) + "…" : value)
                        .foregroundStyle(colorOveride != .clear ? colorOveride : CT.lightest)
                        .lineLimit(1)
                        .truncationMode(.tail)
                } else {
                    Text(value.isEmpty ? "--" : value)
                        .foregroundStyle(colorOveride != .clear ? colorOveride : CT.lightest)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(nil)
                }
            } label: {
                Text(title)
                    .foregroundStyle(CT.fair)
            }
        }
        .font(fontSize)
        .fontWidth(.condensed)
    }

    @ViewBuilder
    public func titleValue(_ title:String,colorOveride:Color = .clear,font:Font? = nil,value:String,maxChars:Int = 0) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        /* Set font or use default */
        var fontSize: Font { (font != nil) ?font! :deviceIs.Pad ?.title3 :.headline }

        /* Trim if MaxChars set and exceeeded */
        var valueTxt: String {
            let enforceMaxLength = (maxChars > 0)
            let needsEnforcedLength = value.count > maxChars
            let enforceTrimming = (enforceMaxLength && needsEnforcedLength)
         
            return enforceTrimming ?String(value.prefix(maxChars)) :value
        }
        
        HStack(alignment: .top, spacing: 12) {
            Text(title)
                .foregroundStyle(CT.fair)
                .lineLimit(1)
                .layoutPriority(1)
            
            Spacer(minLength: 0)
            
            Text(valueTxt.dashesIfEmpty)
                .foregroundStyle(colorOveride != .clear ?colorOveride :CT.lightest)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(fontSize)
        .fontWidth(.condensed)
    }

    public func titleImg(_ title:String,colorOveride:Color = .clear,font:Font? = nil,img:String, imgColor:Color = .clear, fixedSize: Bool = false) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        var fontSize: Font {
            if font != nil {
                return font!
            }else{
                return deviceIs.Pad ?.title3 :.headline
            }
        }
        
        return LabeledContent {
            if fixedSize {
                Image.getResizableNoAspect(img)
                    .frame(width: 640/25, height: 480/25)
                    .foregroundStyle(imgColor == .clear ?CT.lightest :imgColor)
            }else{
                Image.get(img)
                    .foregroundStyle(imgColor == .clear ?CT.lightest :imgColor)
            }
        } label: {
            Text(title)
                .foregroundStyle(colorOveride == .clear ?CT.fair :colorOveride)
        }
        .font(fontSize)
        .fontWidth(.condensed)
        .truncationMode(.tail)
    }

    public func titleIcon(_ title:String, icon:String) -> some View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        return Label {
            Text(title)
                .foregroundStyle(CT.lightest)
        } icon: {
            Image.get(icon)
                .foregroundStyle(CT.accent)
        }
        .fontWidth(.condensed)
        .truncationMode(.tail)
    }

    @ViewBuilder
    public func bulletedsTitle(_ title:String, color: Color = .white) -> some View {
        HStack(spacing:0) {
            Text("・ \(title)")
                .foregroundStyle(color)
                .font(.callout)
                .lineLimit(1)

            Spacer()
        }//End HStack
    }

    public struct disclosure<ViewContent: View>: View {
        let CT = CurrentTheme().getThemeFromUserStds()
        
        var title: String
        var value: String
        var sysIcon: String = ""

        @ViewBuilder let content: ViewContent
        
        public init(
            title: String,
            value: String,
            sysIcon: String = "",
            @ViewBuilder content: () -> ViewContent
        ) {
            self.title = title
            self.value = value
            self.sysIcon = sysIcon
            self.content = content()
        }
        
        var isDisabled: Bool {
            return value.isEmpty || value == "--"
        }
        
        public var body: some View {
            DisclosureGroup {
                content
                    .font(.title3)
                    .fontWidth(.condensed)
                    .padding(.vertical,2)
                    .frame(width: .infinity)
            } label: {
                LabeledContent {
                    Text(value.isEmpty ? "--" : value)
                        .foregroundStyle(CT.lightest)
                } label: {
                    if sysIcon.isEmpty {
                        Text(title.isEmpty ? "--" : title)
                            .foregroundStyle(CT.fair)
                    }else{
                        Label(title.isEmpty ? "--" : title, systemImage: sysIcon)
                            .foregroundStyle(CT.fair)
                    }
                }
            }
            .tint(isDisabled ?.gray :CT.title)
            .fontWidth(.condensed)
            .font(deviceIs.Pad ?.title3 :.headline)
            .disabled(isDisabled)
        }
    }
}
