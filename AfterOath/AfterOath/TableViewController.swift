//
//  TableViewController.swift
//  AfterOath
//
//  Created by Mike Laursen on 11/13/18.
//  Copyright © 2018 Appamajigger. All rights reserved.
//

import UIKit
import AVKit

class TableViewController: UITableViewController {
    static let kScrollOnLastRowHysteresis = CGFloat(integerLiteral: 45)
    static let kRowHeight = CGFloat(integerLiteral: 180)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.rowHeight = TableViewController.kRowHeight

        tableView.prefetchDataSource = self
        DataFetchSimulator.shared.fetchData(maxRow: 3) {
            if let indexPaths = self.tableView.indexPathsForVisibleRows {
                self.tableView.reloadRows(at: indexPaths, with: .automatic)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataFetchSimulator.shared.recordsTotal
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as! TableViewCell
        cell.label.text = String("Row Number: \(indexPath.row)") // TODO: Move to cell class
        cell.assign(indexPath: indexPath)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let videoPath = DataFetchSimulator.shared.dataRecord(at: indexPath.row)?["hfs"] {
            let player = AVPlayer(url: URL(string: videoPath)!)
            let avpvc = AVPlayerViewController()
            avpvc.player = player
            present(avpvc, animated: true) {
                avpvc.player?.play()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension TableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        DataFetchSimulator.shared.fetchData(indexPaths: indexPaths)
    }
}

