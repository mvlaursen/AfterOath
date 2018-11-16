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
    static let scrollOnLastRowHysteresis = CGFloat(integerLiteral: 45)
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    let dataSource = DataSource()
    var data: [Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
                
        activityIndicator.hidesWhenStopped = true
        tableView.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height - 3.0 * TableViewController.scrollOnLastRowHysteresis)
        tableView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        dataSource.fetchData(completion: updateOnNewData)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // #warning Number of rows temporarily set to 1
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as! TableViewCell
        cell.label.text = String("Row Number: \(indexPath.row)")
        if let imagePath = data[indexPath.row]["thumbnail"] {
            if let imageData = try? Data(contentsOf: URL(string: imagePath)!) {
                cell.thumbnailImageView.image = UIImage(data: imageData)
            }
        }
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
        if let videoPath = data[indexPath.row]["hfs"] {
            let player = AVPlayer(url: URL(string: videoPath)!)
            let avpvc = AVPlayerViewController()
            avpvc.player = player
            present(avpvc, animated: true) {
                avpvc.player?.play()
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height > 0.0 {
            let totalHeight = scrollView.contentSize.height - scrollView.contentOffset.y
            if (totalHeight + TableViewController.scrollOnLastRowHysteresis < scrollView.frame.size.height) {
                activityIndicator.center = CGPoint(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height - 3.0 * TableViewController.scrollOnLastRowHysteresis)
                tableView.bringSubviewToFront(activityIndicator)
                activityIndicator.startAnimating()
                dataSource.fetchData(completion: updateOnNewData)
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
    
    // MARK: - Data
    
    func updateOnNewData(newData: [Dictionary<String, String>]) {
        data = newData
        activityIndicator.stopAnimating()
        tableView.reloadData()
    }
}
