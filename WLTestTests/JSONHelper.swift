//
//  JSONHelper.swift
//  WLTest
//
//  Created by Jordan Perry on 8/19/17.
//  Copyright © 2017 Jordan Perry. All rights reserved.
//

import Foundation

struct JSONHelper {
    static let testCompleteJson = "{\"products\":[{\"productId\":\"31e1cb21-5504-4f02-885b-8f267131a93f\",\"productName\":\"VIZIO Class Full-Array LED Smart TV\",\"shortDescription\":\"\\u003cul\\u003e\\n\\t\\u003cli\\u003eResolution: 1080p\\u003c/li\\u003e\\n\\t\\u003cli\\u003eRefresh Rate: 240Hz\\u003c/li\\u003e\\n\\t\\u003cli\\u003eHDMI Inputs: 4\\u003c/li\\u003e\\n\\u003c/ul\\u003e\",\"longDescription\":\"\\u003cul\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eVIZIO Internet Apps Plus\\u003c/b\\u003e&reg; &ndash; Instantly enjoy the latest hit movies, TV shows, music and even more premium apps made for the big screen&sup1;\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eFull-Array LED backlight\\u003c/b\\u003e &ndash; Distributes LEDs behind the entire screen delivering superior light uniformity and picture performance\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003e32 Active LED Zones\\u003c/b\\u003e &ndash; Dynamically adjusts the LED backlight per zone creating deeper, pure black levels and higher contrast\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eClear Action 720\\u003c/b\\u003e &ndash; Enhanced motion clarity with 240Hz effective refresh rate and powerful image processing for stunning sharp detail in sports and fast action scenes.\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eActive Pixel Tuning\\u003c/b\\u003e &ndash; Intelligent pixel-level brightness adjustments for increased picture accuracy and contrast.\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eBuilt-in Wi-Fi\\u003c/b\\u003e &ndash; Easily connect to the Internet with ultra-fast 802.11n wireless\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003e1080p Full HD resolution\\u003c/b\\u003e &ndash; Enjoy high-definition TV with a crystal-clear picture\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003e20 million to 1 DCR\\u003c/b\\u003e &nbsp;&ndash; Exceptionally high contrast for deeper blacks and more radiant whites.\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eM-Series Signature Design\\u003c/b\\u003e &ndash; Give your room a designer upgrade with the ultra-narrow, near borderless design of M-Series\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eSmart remote with backlit keyboard\\u003c/b\\u003e &ndash; Easy to search and type, even in the dark\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003e4 HDMI ports\\u003c/b\\u003e &ndash; Perfect for connecting your high definition entertainment devices to the TV\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003e1 USB ports\\u003c/b\\u003e &ndash; share photos, music, and video right on the big screen\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eDTS Studio Sound\\u003c/b\\u003e &ndash; Advanced virtual surround sound audio from VIZO&rsquo;s two built-in speakers\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eNew TV settings menu with on-screen user manual\\u003c/b\\u003e &ndash; More intuitive menu system with quick, on-screen access to the user manual. No need to search for a paper user manual.\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eAmbient Light Sensor\\u003c/b\\u003e &ndash; Intelligent backlight sensors automatically adjust to surrounding brightness for a great picture in virtually any room.\\u003c/li\\u003e\\n\\t\\u003cli style=\\\"font-size: 13px;\\\"\\u003e\\u003cb\\u003eEnergy Star 6.0\\u003c/b\\u003e &nbsp;&ndash; More energy efficient than conventional CCFL-based LCD TVs to save you even more on energy bills\\u003c/li\\u003e\\n\\u003c/ul\\u003e\",\"price\":\"$878.00\",\"productImage\":\"http://someurl/0084522601078_A\",\"reviewRating\":0.0,\"reviewCount\":0,\"inStock\":true}],\"totalProducts\":342,\"pageNumber\":1,\"pageSize\":1,\"status\":200,\"kind\":\"walmart#resourcesItem\",\"etag\":\"\\\"8CFBhe6u8DU7TYV4E99mWMYD7NI/SzvVVxbsh5WbRz6-_IkoE-N_XPI\\\"\"}".data(using: .utf8)
    
    static let invalidJson = "[\"test\"]".data(using: .utf8)
    
    static let evaluatedShortDescription = "<ul>\n\t<li>Resolution: 1080p</li>\n\t<li>Refresh Rate: 240Hz</li>\n\t<li>HDMI Inputs: 4</li>\n</ul>"
    static let evaluatedLongDescription = "<ul>\n\t<li style=\"font-size: 13px;\"><b>VIZIO Internet Apps Plus</b>&reg; &ndash; Instantly enjoy the latest hit movies, TV shows, music and even more premium apps made for the big screen&sup1;</li>\n\t<li style=\"font-size: 13px;\"><b>Full-Array LED backlight</b> &ndash; Distributes LEDs behind the entire screen delivering superior light uniformity and picture performance</li>\n\t<li style=\"font-size: 13px;\"><b>32 Active LED Zones</b> &ndash; Dynamically adjusts the LED backlight per zone creating deeper, pure black levels and higher contrast</li>\n\t<li style=\"font-size: 13px;\"><b>Clear Action 720</b> &ndash; Enhanced motion clarity with 240Hz effective refresh rate and powerful image processing for stunning sharp detail in sports and fast action scenes.</li>\n\t<li style=\"font-size: 13px;\"><b>Active Pixel Tuning</b> &ndash; Intelligent pixel-level brightness adjustments for increased picture accuracy and contrast.</li>\n\t<li style=\"font-size: 13px;\"><b>Built-in Wi-Fi</b> &ndash; Easily connect to the Internet with ultra-fast 802.11n wireless</li>\n\t<li style=\"font-size: 13px;\"><b>1080p Full HD resolution</b> &ndash; Enjoy high-definition TV with a crystal-clear picture</li>\n\t<li style=\"font-size: 13px;\"><b>20 million to 1 DCR</b> &nbsp;&ndash; Exceptionally high contrast for deeper blacks and more radiant whites.</li>\n\t<li style=\"font-size: 13px;\"><b>M-Series Signature Design</b> &ndash; Give your room a designer upgrade with the ultra-narrow, near borderless design of M-Series</li>\n\t<li style=\"font-size: 13px;\"><b>Smart remote with backlit keyboard</b> &ndash; Easy to search and type, even in the dark</li>\n\t<li style=\"font-size: 13px;\"><b>4 HDMI ports</b> &ndash; Perfect for connecting your high definition entertainment devices to the TV</li>\n\t<li style=\"font-size: 13px;\"><b>1 USB ports</b> &ndash; share photos, music, and video right on the big screen</li>\n\t<li style=\"font-size: 13px;\"><b>DTS Studio Sound</b> &ndash; Advanced virtual surround sound audio from VIZO&rsquo;s two built-in speakers</li>\n\t<li style=\"font-size: 13px;\"><b>New TV settings menu with on-screen user manual</b> &ndash; More intuitive menu system with quick, on-screen access to the user manual. No need to search for a paper user manual.</li>\n\t<li style=\"font-size: 13px;\"><b>Ambient Light Sensor</b> &ndash; Intelligent backlight sensors automatically adjust to surrounding brightness for a great picture in virtually any room.</li>\n\t<li style=\"font-size: 13px;\"><b>Energy Star 6.0</b> &nbsp;&ndash; More energy efficient than conventional CCFL-based LCD TVs to save you even more on energy bills</li>\n</ul>"
    
    static func serialize(with data: Data?) -> Any? {
        guard let data = data else {
            return nil
        }
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch {
            return nil
        }
    }
}
