//
//  DataSource.swift
//  AfterOath
//
//  Created by Mike Laursen on 11/13/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class DataSource {
    static let dataTemplate: [Dictionary<String, String>] = [["thumbnail": "https://i.pinimg.com/originals/a4/eb/a5/a4eba5a87811eef3e5e17fbeb606703e.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"], ["thumbnail": "https://4.bp.blogspot.com/-W5G9ZcmGDW0/W5u-IkoSifI/AAAAAAAAA_A/XRzI9E9bsbsTnz7KdeygEWL1debGE_AkQCEwYBhgL/s1600/20180914_094056.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"], ["thumbnail": "https://4.bp.blogspot.com/-G7HhVx1Swac/V4_N51dcwxI/AAAAAAABpAw/w8_k1uJsLrgAdLKREJQLxjWZoPGFGfl4QCLcB/s1600/funny-cats-216-17.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"]]
    
    private var data: [Dictionary<String, String>] = []
    private var fetchingData: Bool = false
    
    func fetchData(completion: @escaping ([Dictionary<String, String>]) -> ()) {
        if !fetchingData {
            fetchingData = true
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                self.data.append(contentsOf: DataSource.dataTemplate)
                self.fetchingData = false
                completion(self.data)
            }
        }
    }
}
