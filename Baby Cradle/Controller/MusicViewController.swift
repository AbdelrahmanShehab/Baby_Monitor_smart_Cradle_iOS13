//
//  MusicViewController.swift
//  Baby Cradle
//
//  Created by Abdelrahman Shehab on 5/15/20.
//  Copyright © 2020 Abdelrahman Shehab. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class MusicViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var music = Music()
    var playList:[String] = []
    var thisSong = 0
    var audioStuffed = false


    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var songLabel: UILabel!

    //MARK: - Play ▶️
    @IBAction func play(_ sender: UIButton)
    {
        if audioStuffed == true && audioPlayer.isPlaying == false
        {
            audioPlayer.play()

            // Setting Music on in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
    }

    //MARK: - Pause ⏸
    @IBAction func pause(_ sender: UIButton)
    {
        if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()

            // Setting Music Off in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: 0)
        }
    }

    //MARK: - Skip ⏩
    @IBAction func skip(_ sender: UIButton) {

        if thisSong < playList.count-1 && audioStuffed == true
        {
            playThisSong(thisOne: playList[thisSong+1])
            thisSong += 1
            songLabel.text = playList[thisSong]

            // Setting Next Song in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }
    }

    //MARK: - Previous ⏪
    @IBAction func previous(_ sender: UIButton) {
        if thisSong != 0 && audioStuffed == true
        {
            playThisSong(thisOne: playList[thisSong-1])
            thisSong -= 1
            songLabel.text = playList[thisSong]

            // Setting Previous Song in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }
    }

    //MARK: - Volume
    @IBAction func volumeSlider(_ sender: UISlider) {

        if audioStuffed == true
        {
            audioPlayer.volume = sender.value
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

//        musicTableView.tableFooterView = UIView()
        getSongName()
    }

    //MARK: - Music Methods

    //FUNCTION THAT GETS THE NAME OF THE SONGS
    func getSongName()
    {
        let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)

        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

            //loop through the found urls
            for song in songPath
            {
                var mySong = song.absoluteString

                if mySong.contains(".mp3")
                {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count-1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    playList.append(mySong)
                }

            }

            musicTableView.reloadData()
        }
        catch
        {
            print ("ERROR")
        }
    }

    // Play Specific Song  Function
    func playThisSong(thisOne:String)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
        }
        catch
        {
            print ("ERROR")
        }
    }

}

//MARK: - TableView Delegation & DataSourece Methods
extension MusicViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return playList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = playList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        do
        {
            let audioPath = Bundle.main.path(forResource: playList[indexPath.row], ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            audioPlayer.play()
            thisSong = indexPath.row
            audioStuffed = true
            
            songLabel.text = playList[thisSong]

            // Setting Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)

        }
        catch
        {
            print ("ERROR")
        }
    }

}
