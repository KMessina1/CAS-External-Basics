/*-------------------------------------------------------------------------------------------------------------------------
     File: FontName.swift
   Author: Kevin Messina
  Created: 4/18/20
 Modified: 08/24/2026 03:26 PM EDT
  Version: 2
   Source: CODEX: (GPT-5) 🤖AI Code a portion or all of this code.
 
©2026 Creative App Solutions, LLC. - All Rights Reserved.
--------------------------------------------------------------------------------------------------------------------------
NOTES:
-------------------------------------------------------------------------------------------------------------------------*/

import Foundation
import CASExternalFoundations
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - *** FONT DEFINITIONS ***
/// FontName
///
/// Usage: .font(Font.custom(FontName.AcademyEngravedLET.regular.rawValue, size: 24))
///
public struct FontName: RawRepresentable {
    public var rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public func printAllNamesToConsole() {
#if canImport(UIKit)
        for family: String in UIFont.familyNames {
            SimPrint.Info("\(family)", action: .info, log: LFFL())
            
            for names: String in UIFont.fontNames(forFamilyName: family) {
                SimPrint.Info("\(names)", action: .detail_1, log: LFFL())
            }
        }
#elseif canImport(AppKit)
        for family in NSFontManager.shared.availableFontFamilies {
            SimPrint.Info("\(family)", action: .info, log: LFFL())

            let members = NSFontManager.shared.availableMembers(ofFontFamily: family) ?? []
            for member in members {
                guard let name = member.first as? String else { continue }
                SimPrint.Info("\(name)", action: .detail_1, log: LFFL())
            }
        }
#endif
    }

    public enum AcademyEngravedLET: String {
        case regular = "AcademyEngravedLetPlain"
    }

    public enum AlNile: String {
        case regular = "AlNile"
        case bold = "AlNile-Bold"
    }
    
    public enum AmericanTypewriter: String {
        case regular = "AmericanTypewriter"
        case bold = "AmericanTypewriter-Bold"
        case light = "AmericanTypewriter-Light"

        public enum Condensed: String {
            case regular = "AmericanTypewriter-Condensed"
            case bold = "AmericanTypewriter-CondensedBold"
            case light = "AmericanTypewriter-CondensedLight"
        }
    }
    
    public enum AppleColorEmoji: String {
        case regular = "AppleColorEmoji"
    }
    
    public enum AppleSDGothicNeo: String {
        case regular = "AppleSDGothicNeo-Regular"
        case medium = "AppleSDGothicNeo-Medium"
        case bold = "AppleSDGothicNeo-Bold"
        case thin = "AppleSDGothicNeo-Thin"
        case light = "AppleSDGothicNeo-Light"
        case ultraLight = "AppleSDGothicNeo-UltraLight"
        case semibold = "AppleSDGothicNeo-SemiBold"
    }
    
    public enum Arial: String {
        case regular = "ArialMT"
        case bold = "Arial-BoldMT"

        public enum Italic: String {
            case regular = "Arial-ItalicMT"
            case bold = "Arial-BoldItalicMT"
        }
    }
    
    public enum ArialHebrew: String {
        case regular = "ArialHebrew"
        case bold = "ArialHebrew-Bold"
        case light = "ArialHebrew-Light"
    }
    
    public enum ArialRoundedMTBold: String {
        case regular = "ArialRoundedMTBold"
    }
    
    public enum Avenir: String {
        case italic = "Avenir-Oblique"
        case regular = "Avenir-Roman"

        public enum Black: String {
            case regular = "Avenir-Black"
            case italic = "Avenir-BlackOblique"
        }

        public enum Book: String {
            case regular = "Avenir-Book"
            case italic = "Avenir-BookOblique"
        }

        public enum Heavy: String {
            case regular = "Avenir-Heavy"
            case italic = "Avenir-HeavyOblique"
        }

        public enum Light: String {
            case regular = "Avenir-Light"
            case italic = "Avenir-LightOblique"
        }

        public enum Medium: String {
            case regular = "Avenir-Medium"
            case italic = "Avenir-MediumOblique"
        }
    }
    
    public enum AvenirNext: String {
        public enum Bold: String {
            case regular = "AvenirNext-Bold"
            case italic = "AvenirNext-BoldItalic"
        }

        public enum DemiBold: String {
            case regular = "AvenirNext-DemiBold"
            case italic = "AvenirNext-DemiBoldItalic"
        }

        public enum Heavy: String {
            case regular = "AvenirNext-Heavy"
            case italic = "AvenirNext-HeavyItalic"
        }

        case italic = "AvenirNext-Italic"
        case regular = "AvenirNext-Regular"

        public enum Medium: String {
            case regular = "AvenirNext-Medium"
            case italic = "AvenirNext-MediumItalic"
        }

        public enum UltraLight: String {
            case regular = "AvenirNext-UltraLight"
            case italic = "AvenirNext-UltraLightItalic"
        }
    }
    
    public enum AvenirNextCondensed: String {
        public enum Bold: String {
            case regular = "AvenirNextCondensed-Bold"
            case italic = "AvenirNextCondensed-BoldItalic"
        }
        
        public enum DemiBold: String {
            case regular = "AvenirNextCondensed-DemiBold"
            case italic = "AvenirNextCondensed-DemiBoldItalic"
        }
        
        public enum Heavy: String {
            case regular = "AvenirNextCondensed-Heavy"
            case italic = "AvenirNextCondensed-HeavyItalic"
        }
        
        case italic = "AvenirNextCondensed-Italic"
        case regular = "AvenirNextCondensed-Regular"
        
        public enum Medium: String {
            case regular = "AvenirNextCondensed-Medium"
            case italic = "AvenirNextCondensed-MediumItalic"
        }
        
        public enum UltraLight: String {
            case regular = "AvenirNextCondensed-UltraLight"
            case italic = "AvenirNextCondensed-UltraLightItalic"
        }
    }
    
    public enum BanglaSangamMN: String {
        case regular = "BanglaSangamMN"
        case bold = "BanglaSangamMN-Bold"
    }
    
    public enum Baskerville: String {
        public enum Bold: String {
            case regular = "Baskerville-Bold"
            case italic = "Baskerville-BoldItalic"
        }
    
        case italic = "Baskerville-Italic"
        
        public enum SemiBold: String {
            case regular = "Baskerville-SemiBold"
            case italic = "Baskerville-SemiBoldItalic"
        }
    }
    
    public enum BodoniOrnaments: String {
        case regular = "BodoniOrnaments"
    }
    
    public enum Bodoni72: String {
        case bold = "BodoniSvtyTwoITCTT-Bold"
        
        public enum Book: String {
            case regular = "BodoniSvtyTwoITCTT-Book"
            case italic = "BodoniSvtyTwoITCTT-BookItalic"
        }
    }
    
    public enum Bodoni72Oldstyle: String {
        case bold = "BodoniSvtyTwoOSITCTT-Bold"
        
        public enum Book: String {
            case regular = "BodoniSvtyTwoOSITCTT-Book"
            case italic = "BodoniSvtyTwoOSITCTT-BookItalic"
        }
    }
    
    public enum Bodoni72Smallcaps: String {
        case regular = "BodoniSvtyTwoSCITCTT-Book"
    }
    
    public enum BradleyHand: String {
        case regular = "BradleyHandITCTT-Bold"
    }
    
    public enum ChalkboardSE: String {
        case regular = "ChalkboardSE-Regular"
        case bold = "ChalkboardSE-Bold"
        case light = "ChalkboardSE-Light"
    }
    
    public enum Chalkduster: String {
        case regular = "Chalkduster"
    }
    
    public enum Cochin: String {
        case regular = "Cochin"
        case italic = "Cochin-Italic"
        
        public enum Bold: String {
            case italic = "Cochin-BoldItalic"
        }
    }
    
    public enum Copperplate: String {
        case regular = "Copperplate"
        case bold = "Copperplate-Bold"
        case light = "Copperplate-Italic"
    }
    
    public enum Courier: String {
        case regular = "Courier"
        case italic = "Courier-Oblique"

        public enum Bold: String {
            case regular = "Courier-Bold"
            case italic = "Courier-BoldOblique"
        }
    }

    public enum CourierNew: String {
        case regular = "CourierNewPSMT"
        case italic = "CourierNewPS-ItalicMT"
        
        public enum Bold: String {
            case regular = "CourierNewPS-BoldMT"
            case italic = "CourierNewPS-ItalicMT"
        }
    }
    
    public enum DIN_Alternate: String {
        case bold = "DINAlternate-Bold"
    }
    
    public enum DIN_Condensed: String {
        case bold = "DINCondensed-Bold"
    }
    
    public enum Damascus: String {
        case regular = "Damascus"
        case bold = "DamascusBold"
        case light = "DamascusLight"
        case medium = "DamascusMedium"
        case semiBold = "DamascusSemiBold"
    }
    
    public enum DevanagariSangamMN: String {
        case regular = "DevanagariSangamMN"
        case bold = "DevanagariSangamMN-Bold"
    }
    
    public enum Didot: String {
        case regular = "Didot"
        case bold = "Didot-Bold"
        case italic = "Didot-Italic"
    }
    
    public enum DiwanMishafi: String {
        case regular = "DiwanMishafi"
    }
    
    public enum EuphemiaUCAS: String {
        case regular = "EuphemiaUCAS"
        case bold = "EuphemiaUCAS-Bold"
        case italic = "EuphemiaUCAS-Italic"
    }
    
    public enum Farah: String {
        case regular = "Farah"
    }
    
    public enum Futura {
        public enum Condensed: String {
            case regular = "Futura-CondensedMedium"
            case italic = "Futura-CondensedExtraBold"
        }
        
        public enum Medium: String {
            case regular = "Futura-Medium"
            case italic = "Futura-MediumItalic"
        }
    }
    
    public enum GeezaPro: String {
        case regular = "GeezaPro"
        case bold = "GeezaPro-Bold"
    }
    
    public enum Georgia: String {
        case regular = "Georgia"
        case bold = "Georgia-Bold"
        
        public enum Italic: String {
            case regular = "Georgia-Italic"
            case bold = "Georgia-BoldItalic"
        }
    }
    
    public enum GilSans: String {
        case regular = "GilSans"
        case italic = "GilSans-Italic"
        
        public enum SemiBold: String {
            case regular = "GillSans-SemiBold"
            case bold = "GillSans-SemiBoldItalic"
        }
        
        public enum Bold: String {
            case regular = "GillSans-Bold"
            case bold = "GillSans-BoldItalic"
            case ultraBold = "GillSans-UltraBold"
        }
        
        public enum Light: String {
            case regular = "GillSans-Light"
            case bold = "GillSans-LightItalic"
        }
    }
    
    public enum GujaratiSangamMN: String {
        case regular = "GujaratiSangamMN"
        case italic = "GujaratiSangamMN-Bold"
    }
    
    public enum GurmukhiMN: String {
        case regular = "GurmukhiMN"
        case italic = "GurmukhiMN-Bold"
    }
    
    public enum HeitiSC: String {
        case light = "STHeitiSC-Light"
        case medium = "STHeitiSC-Medium"
    }
    
    public enum HeitiTC: String {
        case light = "STHeitiTC-Light"
        case medium = "STHeitiTC-Medium"
    }
    
    public enum Helvetica: String {
        case regular = "Helvetica"
        case italic = "Helvetica-Oblique"
        
        public enum Bold: String {
            case bold = "Helvetica-Bold"
            case italic = "Helvetica-BoldItalic"
        }
        
        public enum Light: String {
            case regular = "Helvetica-Light"
            case bold = "Helvetica-LightItalic"
        }
    }
    
    public enum HelveticaNeue: String {
        case regular = "HelveticaNeue"
        case italic = "HelveticaNeue-Italic"
        
        public enum Bold: String {
            case bold = "HelveticaNeue-Bold"
            case italic = "HelveticaNeue-BoldItalic"
        }
        
        public enum Condensed: String {
            case black = "HelveticaNeue-CondensedBlack"
            case bold = "HelveticaNeue-CondensedBold"
        }
        
        public enum Light: String {
            case regular = "HelveticaNeue-Light"
            case italic = "HelveticaNeue-LightItalic"
        }
        
        public enum Medium: String {
            case regular = "HelveticaNeue-Medium"
            case italic = "HelveticaNeue-MediumItalic"
        }
        
        public enum UltraLight: String {
            case regular = "HelveticaNeue-UltraLight"
            case italic = "HelveticaNeue-UltraLightItalic"
        }
        
        public enum Thin: String {
            case regular = "HelveticaNeue-Thin"
            case italic = "HelveticaNeue-ThinItalic"
        }
    }
    
    public enum HiraginoMinchoProN: String {
        case regular = "HiraMinProN-W3"
        case bold = "HiraMinProN-W6"
    }
    
    public enum HiraginoSans: String {
        case regular = "HiraginoSans-W3"
        case bold = "HiraginoSans-W6"
    }
    
    public enum HoeflerText: String {
        case regular = "HoeflerText-Regular"
        case italic = "HoeflerText-Italic"
        
        public enum Black: String {
            case regular = "HoeflerText-Black"
            case italic = "HoeflerText-BlackItalic"
        }
    }
    
    public enum IowanOldStyle: String {
        case regular = "IowanOldStyle-Roman"
        case italic = "IowanOldStyle-Italic"
        
        public enum Bold: String {
            case regular = "IowanOldStyle-Bold"
            case italic = "IowanOldStyle-BoldItalic"
        }
    }
    
    public enum Kailasa: String {
        case regular = "Kailasa"
        case bold = "Kailasa-Bold"
    }
    
    public enum KannadaSangamMN: String {
        case regular = "KannadaSangamMN"
        case bold = "KannadaSangamMN-Bold"
    }
    
    public enum KhmerSangamMN: String {
        case regular = "KhmerSangamMN"
    }
    
    public enum KohinoorBangla: String {
        case light = "KohinoorBangla-Light"
        case regular = "KohinoorBangla-Regular"
        case semiBold = "KohinoorBangla-SemiBold"
    }
    
    public enum KohinoorTelugu: String {
        case light = "KohinoorTelugu-Light"
        case regular = "KohinoorTelugu-Regular"
        case semiBold = "KohinoorTelugu-SemiBold"
    }
    
    public enum LaoSangamMN: String {
        case light = "LaoSangamMN"
    }
    
    public enum MalayalamSangamMN: String  {
        case regular = "MalayalamSangamMN"
        case bold = "MalayalamSangamMN-Bold"
    }
    
    public enum Menlo: String {
        case regular = "Menlo-Regular"
        case italic = "Menlo-Italic"

        public enum Bold: String {
            case regular = "Menlo-Bold"
            case italic = "Menlo-BoldItalic"
        }
    }
    
    public enum Marion: String {
        case regular = "Marion-Regular"
        case bold = "Marion-Bold"
        case italic = "Marion-Italic"
    }
    
    public enum MarkerFelt: String {
        case thin = "MarkerFelt-Thin"
        case wide = "MarkerFelt-Wide"
    }
    
    public enum Noteworthy: String {
        case light = "Noteworthy-Light"
        case bold = "Noteworthy-Bold"
    }
    
    public enum NewYork {
        public enum ExtraLarge: String {
            case medium = "NewYorkExtraLarge-Medium"
            case mediumItalic = "NewYorkExtraLarge-MediumItalic"
            case regular = "NewYorkExtraLarge-Regular"
            case regularItalic = "NewYorkExtraLarge-RegularItalic"
            case black = "NewYorkExtraLarge-Black"
            case blackItalic = "NewYorkExtraLarge-BlackItalic"
            case bold = "NewYorkExtraLarge-Bold"
            case boldItalic = "NewYorkExtraLarge-BoldItalic"
            case heavy = "NewYorkExtraLarge-Heavy"
            case heavyItalic = "NewYorkExtraLarge-HeavyItalic"
            case semiBold = "NewYorkExtraLarge-SemiBold"
            case semiBoldItalic = "NewYorkExtraLarge-SemiBoldItalic"
        }
        
        public enum Large: String {
            case medium = "NewYorkLarge-Medium"
            case mediumItalic = "NewYorkLarge-MediumItalic"
            case regular = "NewYorkLarge-Regular"
            case regularItalic = "NewYorkLarge-RegularItalic"
            case black = "NewYorkLarge-Black"
            case blackItalic = "NewYorkLarge-BlackItalic"
            case bold = "NewYorkLarge-Bold"
            case boldItalic = "NewYorkLarge-BoldItalic"
            case heavy = "NewYorkLarge-Heavy"
            case heavyItalic = "NewYorkLarge-HeavyItalic"
            case semiBold = "NewYorkLarge-SemiBold"
            case semiBoldItalic = "NewYorkLarge-SemiBoldItalic"
        }
        
        public enum Medium: String {
            case medium = "NewYorkMedium-Medium"
            case mediumItalic = "NewYorkMedium-MediumItalic"
            case regular = "NewYorkMedium-Regular"
            case regularItalic = "NewYorkMedium-RegularItalic"
            case black = "NewYorkMedium-Black"
            case blackItalic = "NewYorkMedium-BlackItalic"
            case bold = "NewYorkMedium-Bold"
            case boldItalic = "NewYorkMedium-BoldItalic"
            case heavy = "NewYorkMedium-Heavy"
            case heavyItalic = "NewYorkMedium-HeavyItalic"
            case semiBold = "NewYorkMedium-SemiBold"
            case semiBoldItalic = "NewYorkMedium-SemiBoldItalic"
        }
        
        public enum Small: String {
            case medium = "NewYorkSmall-Medium"
            case mediumItalic = "NewYorkSmall-MediumItalic"
            case regular = "NewYorkSmall-Regular"
            case regularItalic = "NewYorkSmall-RegularItalic"
            case black = "NewYorkSmall-Black"
            case blackItalic = "NewYorkSmall-BlackItalic"
            case bold = "NewYorkSmall-Bold"
            case boldItalic = "NewYorkSmall-BoldItalic"
            case heavy = "NewYorkSmall-Heavy"
            case heavyItalic = "NewYorkSmall-HeavyItalic"
            case semiBold = "NewYorkSmall-SemiBold"
            case semiBoldItalic = "NewYorkSmall-SemiBoldItalic"
        }
    }
    
    public enum Optima: String {
        case regular = "Optima-Regular"
        case italic = "Optima-Italic"
        case extraBlack = "Optima-ExtraBlack"
        
        public enum Bold: String {
            case regular = "Optima-Bold"
            case bold = "Optima-BoldItalic"
        }
    }
    
    public enum OriyaSangamMN: String {
        case light = "OriyaSangamMN"
        case bold = "OriyaSangamMN-Bold"
    }
    
    public enum Palatino: String {
        case regular = "Palatino-Roman"
        case italic = "Palatino-Italic"
        
        public enum Bold: String {
            case regular = "Palatino-Bold"
            case bold = "Palatino-BoldItalic"
        }
    }
    
    public enum Papyrus: String {
        case regular = "Papyrus"
        case condensed = "Papyrus-Condensed"
    }
    
    public enum PartyLET: String {
        case regular = "PartyLetPlain"
    }
    
    public enum PingFangHK: String {
        case ultraLight = "PingFangHK-Ultralight"
        case Light = "PingFangHK-Light"
        case thin = "PingFangHK-Thin"
        case regular = "PingFangHK-Regular"
        case medium = "PingFangHK-Medium"
        case semiBold = "PingFangHK-SemiBold"
    }
    
    public enum PingFangSC: String {
        case ultraLight = "PingFangSC-Ultralight"
        case Light = "PingFangSC-Light"
        case thin = "PingFangSC-Thin"
        case regular = "PingFangSC-Regular"
        case medium = "PingFangSC-Medium"
        case semiBold = "PingFangSC-SemiBold"
    }
    
    public enum PingFangTC: String {
        case ultraLight = "PingFangTC-Ultralight"
        case Light = "PingFangTC-Light"
        case thin = "PingFangTC-Thin"
        case regular = "PingFangTC-Regular"
        case medium = "PingFangTC-Medium"
        case semiBold = "PingFangTC-Semibold"
    }
    
    public enum SF {
        // Default for WatchOS
        public enum Compact {
            public enum Display: String {
                case light = "SFCompactDisplay-Light"
                case medium = "SFCompactDisplay-Medium"
                case regular = "SFCompactDisplay-Regular"
                case thin = "SFCompactDisplay-Thin"
                case ultraLight = "SFCompactDisplay-Ultralight"
                case black = "SFCompactDisplay-Black"
                case bold = "SFCompactDisplay-Bold"
                case heavy = "SFCompactDisplay-Heavy"
                case semiBold = "SFCompactDisplay-Semibold"
            }
            
            public enum Rounded: String {
                case light = "SFCompactRounded-Light"
                case medium = "SFCompactRounded-Medium"
                case regular = "SFCompactRounded-Regular"
                case thin = "SFCompactRounded-Thin"
                case ultraLight = "SFCompactRounded-Ultralight"
                case black = "SFCompactRounded-Black"
                case bold = "SFCompactRounded-Bold"
                case heavy = "SFCompactRounded-Heavy"
                case semiBold = "SFCompactRounded-Semibold"
            }
            
            public enum Text: String {
                case light = "SFCompactText-Light"
                case medium = "SFCompactText-Medium"
                case regular = "SFCompactText-Regular"
                case thin = "SFCompactText-Thin"
                case ultraLight = "SFCompactText-Ultralight"
                case italic = "SFCompactText-Italic"
                case lightItalic = "SFCompactText-LightItalic"
                case mediumItalic = "SFCompactText-MediumItalic"
                case thiItalic = "SFCompactText-ThinItalic"
                case ultraLightItalic = "SFCompactText-UltralightItalic"
                case black = "SFCompactText-Black"
                case bold = "SFCompactText-Bold"
                case heavy = "SFCompactText-Heavy"
                case semiBold = "SFCompactText-Semibold"
                case blackItalic = "SFCompactText-BlackItalic"
                case boldItalic = "SFCompactText-BoldItalic"
                case heavyItalic = "SFCompactText-HeavyItalic"
                case semiBoldItalic = "SFCompactText-SemiboldItalic"
            }
        }

        // Mono Spaced
        public enum Mono: String {
            case light = "SFMono-Light"
            case medium = "SFMono-Medium"
            case regular = "SFMono-Regular"
            case lightItalic = "SFMono-LightItalic"
            case mediumItalic = "SFMono-MediumItalic"
            case regularItalic = "SFMono-RegularItalic"
            case bold = "SFMono-Bold"
            case heavy = "SFMono-Heavy"
            case semiBold = "SFMono-Semibold"
            case boldItalic = "SFMono-BoldItalic"
            case heavyItalic = "SFMono-HeavyItalic"
            case semiBoldItalic = "SFMono-SemiboldItalic"
        }
        
        // Default for iOS, MacOS, & tvOS
        public enum Pro {
            public enum Display: String {
                case light = "SFProDisplay-Light"
                case medium = "SFProDisplay-Medium"
                case regular = "SFProDisplay-Regular"
                case thin = "SFProDisplay-Thin"
                case ultraLight = "SFProDisplay-Ultralight"
                case lightItalic = "SFProDisplay-LightItalic"
                case mediumItalic = "SFProDisplay-MediumItalic"
                case regularItalic = "SFProDisplay-RegularItalic"
                case thinItalic = "SFProDisplay-ThinItalic"
                case ultralightItalic = "SFProDisplay-UltralightItalic"
                case black = "SFProDisplay-Black"
                case bold = "SFProDisplay-Bold"
                case heavy = "SFProDisplay-Heavy"
                case semiBold = "SFProDisplay-Semibold"
                case blackItalic = "SFProDisplay-BlackItalic"
                case boldItalic = "SFProDisplay-BoldItalic"
                case heavyItalic = "SFProDisplay-HeavyItalic"
                case semiboldItalic = "SFProDisplay-SemiboldItalic"
            }
            
            public enum Rounded: String {
                case light = "SFProRounded-Light"
                case medium = "SFProRounded-Medium"
                case regular = "SFProRounded-Regular"
                case thin = "SFProRounded-Thin"
                case ultraLight = "SFProRounded-Ultralight"
                case black = "SFProRounded-Black"
                case bold = "SFProRounded-Bold"
                case heavy = "SFProRounded-Heavy"
                case semiBold = "SFProRounded-Semibold"
            }
            
            public enum Text: String {
                case light = "SFProText-Light"
                case medium = "SFProText-Medium"
                case regular = "SFProText-Regular"
                case thin = "SFProText-Thin"
                case ultraLight = "SFProText-Ultralight"
                case italic = "SFProText-Italic"
                case lightItalic = "SFProText-LightItalic"
                case mediumItalic = "SFProText-MediumItalic"
                case thiItalic = "SFProText-ThinItalic"
                case ultraLightItalic = "SFProText-UltralightItalic"
                case black = "SFProText-Black"
                case bold = "SFProText-Bold"
                case heavy = "SFProText-Heavy"
                case semiBold = "SFProText-Semibold"
                case blackItalic = "SFProText-BlackItalic"
                case boldItalic = "SFProText-BoldItalic"
                case heavyItalic = "SFProText-HeavyItalic"
                case semiBoldItalic = "SFProText-SemiboldItalic"
            }
        }
    }
    
    public enum SavoyeLet: String {
        case regular = "SavoyeLetPlain"
    }
    
    public enum SinhalaSangamMN: String {
        case regular = "SinhalaSangamMN"
        case bold = "SinhalaSangamMN-Bold"
    }
    
    public enum SnellRoundhand: String {
        case regular = "SnellRoundhand"
        case bold = "SnellRoundhand-Bold"
        case black = "SnellRoundhand-Black"
    }
    
    public enum Symbol: String {
        case regular = "Symbol"
    }
    
    public enum TamilSangamMN: String {
        case regular = "TamilSangamMN"
        case bold = "TamilSangamMN-Bold"
    }
    
    public enum TeluguSangamMN: String {
        case regular = "TeluguSangamMN"
        case bold = "TeluguSangamMN-Bold"
    }
    
    public enum Thonburi: String {
        case regular = "Thonburi"
        case bold = "Thonburi-Bold"
        case light = "Thonburi-Light"
    }
    
    public enum TimesNewRoman: String {
        case regular = "TimesNewRomanPSMT"
        case italic = "TimesNewRomanPS-ItalicMT"
      
        public enum Bold: String {
            case regular = "TimesNewRomanPS-BoldMT"
            case italic = "TimesNewRomanPS-BoldItalicMT"
        }
    }
    
    public enum TrebuchetMS: String {
        case regular = "TrebuchetMS"
        case italic = "TrebuchetMS-Italic"

        public enum Bold: String {
            case regular = "TrebuchetMS-Bold"
            case italic = "TrebuchetMS-BoldItalic"
        }
    }
    
    public enum Verdana: String {
        case regular = "Verdana"
        case italic = "Verdana-Italic"

        public enum Bold: String {
            case regular = "Verdana-Bold"
            case italic = "Verdana-BoldItalic"
        }
    }
    
    public enum ZapfDingbats: String {
        case regular = "ZapfDingbatsITC"
    }
    
    public enum Zapfino: String {
        case regular = "Zapfino"
    }
}
