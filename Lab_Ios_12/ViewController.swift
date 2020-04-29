//
//  ViewController.swift
//  Lab_Ios_12
//
//  Created by Шынгыс on 4/26/20.
//  Copyright © 2020 Шынгыс. All rights reserved.
//

import UIKit
var text:String =  ""
var cnt = 0
var data:String = ""


class ViewController: UICollectionViewController{
    
    var URL = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
       var URLS: [URL] = try! FileManager.default.contentsOfDirectory(at: try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0], includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    var pictures = [String]()
    
   
    
    
    
    override func viewDidLoad() {
        let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path2)
        let filePath = url.path
        let fileManager = FileManager.default
        print(try! fileManager.contentsOfDirectory(atPath: filePath!))
        print(URL)
        print(URLS)
       
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.minimumPressDuration = 0.2
               longPress.delaysTouchesBegan = true
               self.collectionView.addGestureRecognizer(longPress)
        collectionView.delegate = self
        collectionView.dataSource = self
        
       

        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
                pictures.append(item)
            
        }
        print(pictures)
        
       
       
    }
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
    if gesture.state != .ended {
        return
    }
    let point = gesture.location(in: self.collectionView)
    if let indexPath = self.collectionView.indexPathForItem(at: point) {
        do {
            try FileManager.default.removeItem(at: URLS[indexPath.row])
            self.reloadFiles(url: self.URL)
        } catch {
            print(error.localizedDescription)
        }
    }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.rightBarButtonItem = .init(title: "Add Folder", style: .plain, target: self, action: #selector(addFolder))
       
        
    }
    override func viewWillAppear(_ animated: Bool) {

    reloadFiles(url: self.URL)
    }
    @objc private func addFolder() {
        let alert = UIAlertController(title: "Enter Folder Name", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addTextField { (textField) in
            textField.text = ""
        }
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { action in
            let textField = alert.textFields![0]
            let dataPath = self.URL.appendingPathComponent(textField.text ?? "")
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: false, attributes: nil)
                self.reloadFiles(url: self.URL)
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        

       
    }
    /*@objc private func addMusic() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let addMusicVC = storyboard.instantiateViewController(identifier: "AddMusicViewController") as AddMusicViewController
               addMusicVC.url = self.url
              navigationController?.pushViewController(addMusicVC, animated: true)
    }*/

  
    
     override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return URLS.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label_text_text.text = URLS[indexPath.row].lastPathComponent
        
                       
        return cell
                       
                   }
    
   
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
       return CGSize(width: 50, height: 50)
   }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let directoryVC = storyboard!.instantiateViewController(identifier: "ViewController") as ViewController
        directoryVC.URL = URLS[indexPath.row]
        reloadFiles(url: self.URL)
        navigationController?.pushViewController(directoryVC, animated: true)
        
    }
    
     func reloadFiles(url: URL) {
           do {
               self.URLS = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
               collectionView.reloadData()
           } catch {
               print(error.localizedDescription)
           }
           collectionView.reloadData()
       }
    
    


}


