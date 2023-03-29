//
//  ViewController.swift
//  TableStory_Demo
//
//  Created by Royal, Cindy L on 3/28/23.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Zelick's Icehouse", neighborhood: "Downtown", desc: "An outdoor bar located near Gumby's Pizza. Events such as drag shows, trivia, and karaoke are offered weekly here! Great spot to spend time and get some fresh air with friends! Try their delicious Dos-a-Rita's!", lat: 29.882480, long: -97.945410, imageName: "IMG_6155"),
    Item(name: "The Taproom", neighborhood: "Hyde Park", desc: "If you like beer, Taproom is a great choice of venue for you! Also with a nice selection of food, Taproom is one of the original bars in San Marcos. ", lat: 29.883390, long: -97.940650, imageName: "IMG_6193"),
    Item(name: "The Marc", neighborhood: "Mueller", desc: "Recently reopened, The Marc is a great venue for a fun night ut! This venue has live DJ's and artists perform often. Check their website for their event schedule!", lat: 29.882030, long: -97.940540, imageName: "IMG_6165"),
    Item(name: "Mayloo's", neighborhood: "UT", desc: "Mayloo's is a fan favorite here in San Marcos. A great bar for college students and to bring friends. Make sure to try to the classic gameface.", lat: 29.883070, long: -97.939840, imageName: "IMG_6175"),
    Item(name: "Chance's R", neighborhood: "Hyde Park", desc: "A great hole in the wall located just off the square in San Marcos. This bar has the friendliest staff and cheap drinks! Join on Wednesday's for Karaoke with host Brandon Summers.", lat: 29.875260, long: -97.938850, imageName: "IMG_6209")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }


   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       //Add image references
                    let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       return cell!
   }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "ShowDetailSegue" {
                  if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                      // Pass the selected item to the detail view controller
                      detailViewController.item = selectedItem
                  }
              }
          }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 29.895190, longitude: -97.9444)
        let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

    }


}


//Demo created on March 28 for GitHub

