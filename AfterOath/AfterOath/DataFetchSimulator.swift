//
//  DataFetchSimulator.swift
//  AfterOath
//
//  Created by Mike Laursen on 11/16/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import Foundation

class DataFetchSimulator {
    typealias DataRecord = Dictionary<String, String>
    
    private let dataRecords: [DataRecord] = [
        ["thumbnail": "https://i.pinimg.com/originals/a4/eb/a5/a4eba5a87811eef3e5e17fbeb606703e.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://simonscat.com/wp-content/uploads/2017/10/2593-1-344351__lQ8mYrpw.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.redd.it/eoyuaw26tjp01.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://lostdogrescue.org/wp-content/uploads/2018/04/Ben-and-Bruno-nc-4.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.pinimg.com/originals/d6/aa/ca/d6aaca39aebcd703a2aa5bc4f5ef0eef.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://www.cathouseonthekings.com/animals/98/a_014898_1481414511.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/42206224/1/?bust=1531795990", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "http://in1li1tgpn-flywheel.netdna-ssl.com/wp-content/uploads/2015/11/pretty-kitty-head-tilt.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.pinimg.com/originals/5f/ee/b3/5feeb384305ac794d0f92ad7f6fcad76.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://static.wixstatic.com/media/1add48_d0292f4f89494d03b173710c3c9b1664~mv2_d_2268_4032_s_2.jpg/v1/fill/w_900,h_1600,al_c,q_90/file.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.pinimg.com/originals/a4/eb/a5/a4eba5a87811eef3e5e17fbeb606703e.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://simonscat.com/wp-content/uploads/2017/10/2593-1-344351__lQ8mYrpw.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.redd.it/eoyuaw26tjp01.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://lostdogrescue.org/wp-content/uploads/2018/04/Ben-and-Bruno-nc-4.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.pinimg.com/originals/d6/aa/ca/d6aaca39aebcd703a2aa5bc4f5ef0eef.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://www.cathouseonthekings.com/animals/98/a_014898_1481414511.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/42206224/1/?bust=1531795990", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "http://in1li1tgpn-flywheel.netdna-ssl.com/wp-content/uploads/2015/11/pretty-kitty-head-tilt.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://i.pinimg.com/originals/5f/ee/b3/5feeb384305ac794d0f92ad7f6fcad76.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"],
        ["thumbnail": "https://static.wixstatic.com/media/1add48_d0292f4f89494d03b173710c3c9b1664~mv2_d_2268_4032_s_2.jpg/v1/fill/w_900,h_1600,al_c,q_90/file.jpg", "hfs": "https://www.radiantmediaplayer.com/media/bbb-360p.mp4"]]
    
    private var fetching = false
    
    var recordsFetched = 0
    
    var recordsTotal: Int {
        get {
            return dataRecords.count
        }
    }
    
    func dataRecord(at index: Int) -> DataRecord? {
        guard index < recordsFetched else {
            return nil
        }
        return dataRecords[index]
    }
    
    func fetchData(maxRow: Int, completion: @escaping () -> ()) {
        guard maxRow >= 0 && maxRow < dataRecords.count else {
            return
        }
        
        if !fetching && maxRow > recordsFetched - 1 {
            fetching = true
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
                self.recordsFetched = maxRow + 1
                self.fetching = false
                completion()
            }
        }
    }

    func fetchData(indexPaths: [IndexPath]) {
        let maxRow: Int = indexPaths.reduce(0) { (maxRow, indexPath) -> Int in
            max(maxRow, indexPath.row)
        }
        fetchData(maxRow: maxRow) {
        }
    }
}
