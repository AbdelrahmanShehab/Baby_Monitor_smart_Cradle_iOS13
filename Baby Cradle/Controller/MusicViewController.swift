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
    var timer: Timer!
    var isSongPressed = false

    @IBOutlet weak var playOrPauseButton: UIButton!
    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var playedTimeLabel: UILabel!
    @IBOutlet weak var audioView: UIView!
    
    //MARK: - Play ▶️
    @IBAction func didTapPlayOrPause(_ sender: UIButton)
    {
        if audioStuffed == true && audioPlayer.isPlaying == false
        {
            audioPlayer.play()
            music.showPlayOrPauseButton(!isSongPressed, on: sender)

            /// Set zero in Firebase when song ends
            songShouldPauseWhenEnds()

            /// Setting Music on in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)

        } else if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()
            music.showPlayOrPauseButton(!isSongPressed, on: sender)

            /// Setting Music Off in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: 0)

        }
        isSongPressed = !isSongPressed
    }

    //MARK: - Skip ⏭
    @IBAction func skip(_ sender: UIButton) {

        if thisSong < playList.count-1 && audioStuffed == true
        {
            music.showPlayOrPauseButton(isSongPressed, on: playOrPauseButton)
            
            playThisSong(thisOne: playList[thisSong+1])
            thisSong += 1
            songLabel.text = playList[thisSong]

            /// Setting Next Song in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }
    }

    //MARK: - Previous ⏮
    @IBAction func previous(_ sender: UIButton) {
        if thisSong != 0 && audioStuffed == true
        {
            music.showPlayOrPauseButton(isSongPressed, on: playOrPauseButton)

            playThisSong(thisOne: playList[thisSong-1])
            thisSong -= 1
            songLabel.text = playList[thisSong]

            /// Setting Previous Song in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }
    }

    //MARK: - Repeat 🔁
    @IBAction func repeatSong(_ sender: UIButton) {
    }

    //MARK: - Volume 🔊
    @IBAction func volumeSlider(_ sender: UISlider) {

        if audioStuffed == true
        {
            audioPlayer.volume = sender.value
            music.setVolumeRTDFirebase(with: sender.value)
        }
    }

    //MARK: - Mute 🔇
    @IBAction func mute(_ sender: UIButton) {
        if audioPlayer.volume > 0 {
            audioPlayer.volume = 0
            sender.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        } else {
            audioPlayer.volume = 0.75
            sender.setImage(UIImage(systemName: "speaker.2.fill"), for: .normal)

        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        /// Style Views
        audioView.setShadow()
        musicTableView.layer.cornerRadius = 10.0
        view.setGradientBackground(colorOne: UIColor(cgColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), colorTwo: UIColor(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)))
        
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

    /// Play Specific Song  Function
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

    /// Timer to Pause Automatically in Firebase
    @objc func setZeroSongWhenEndsInRTDFirebase() {
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60

        let playedTime = String(format: "%02d:%02d", minutes,seconds) as String
        playedTimeLabel.text = playedTime

        if playedTime == "00:00" && audioPlayer.isPlaying == false{
            music.setMusicInRTDFirebase(with: 0)
        }
    }

    /// Set zero in Firebase till song ends
    func songShouldPauseWhenEnds()
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setZeroSongWhenEndsInRTDFirebase), userInfo: nil, repeats: true)
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
            music.showPlayOrPauseButton(isSongPressed, on: playOrPauseButton)

            thisSong = indexPath.row
            audioStuffed = true

            /// Show the name of selected song on the label
            songLabel.text = playList[thisSong]

            /// Setting Firebase Realtime Database of selected song
            music.setMusicInRTDFirebase(with: thisSong + 1)

            /// Timer to count selected song duration till ends
            songShouldPauseWhenEnds()

        }
        catch
        {
            print ("ERROR")
        }
    }

}
