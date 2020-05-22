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
    var playList:[Song] = []
    var music = Music()
    var thisSong = 0
    var timer: Timer!
    var isPopup = false
    var audioStuffed = false
    var isSongPressed = false

    @IBOutlet weak var playOrPauseButton: UIButton!
    @IBOutlet weak var musicTableView: UITableView!
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var playedTimeLabel: UILabel!


    // PUT NAMES AND ARTWORK IMAGE OF SONGS AND STRUCTURE THEM IN PLAYLIST 
    func configureSongs()
    {
        playList.append(Song(
            name: "Cradle",
            imageName: "cradle_artwork"))
        playList.append(Song(
            name: "Baby Shark Doo Doo",
            imageName: "shark_artwork"))
    }

    //MARK: - Play ▶️
    @IBAction func didTapPlayOrPause(_ sender: UIButton)
    {
        isSongPressed = !isSongPressed

        if audioStuffed == true && audioPlayer.isPlaying == false
        {
            audioPlayer.play()
            setPlayOrPauseButtonImage()

            /// Set zero in Firebase when song ends
            songShouldPauseWhenEnds()

            /// Setting Music Position  on in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)

        } else if audioStuffed == true && audioPlayer.isPlaying
        {
            audioPlayer.pause()
            setPlayOrPauseButtonImage()

            /// Setting Music Off in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: 0)

        }

    }

    //MARK: - Skip ⏭
    @IBAction func skip(_ sender: UIButton) {

        isSongPressed = true

        if thisSong < playList.count-1 && audioStuffed == true
        {
            setPauseButtonOnSelectedCell()
            
            playThisSong(thisOne: playList[thisSong+1].name)
            thisSong += 1
            let song = playList[thisSong]

            /// Render Name AND Image Of Song in View
            songLabel.text = song.name
            artWorkImageView.image = UIImage(named: song.imageName)

            /// Setting Next Song Position in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }
    }

    //MARK: - Previous ⏮
    @IBAction func previous(_ sender: UIButton) {

        isSongPressed = true

        if thisSong != 0 && audioStuffed == true
        {
            setPauseButtonOnSelectedCell()

            playThisSong(thisOne: playList[thisSong-1].name)
            thisSong -= 1
            let song = playList[thisSong]

            /// Render Name AND Image Of Song in View
            songLabel.text = song.name
            artWorkImageView.image = UIImage(named: song.imageName)

            /// Setting Previous Song Position in Firebase Realtime Database
            music.setMusicInRTDFirebase(with: thisSong + 1)
        }
        else
        {
            // TODO SOME CODE
        }

    }

    //MARK: - Repeat 🔁
    @IBAction func repeatSong(_ sender: UIButton) {

        music.setRepeat(player: audioPlayer, on: sender)
    }

    //MARK: - Volume 🔊
    @IBAction func volumeSlider(_ sender: UISlider) {

        if audioStuffed == true
        {
            audioPlayer.volume = sender.value

            /// Set Volume Value of The Song in RTDFirebase
            music.setVolumeRTDFirebase(with: sender.value)
        }
    }

    //MARK: - Mute 🔇
    @IBAction func mute(_ sender: UIButton) {
        if isPopup {
            Alert.showPopUP(on: self)
        }
        music.setMuteOrUnMute(player: audioPlayer, on: sender)
        isPopup = false
    }

    //MARK: - ViewDidLoad Method
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Style Views
        audioView.setShadow()
        artWorkImageView.setShadowImage()
        musicTableView.layer.cornerRadius = 15
        view.setGradientBackground(colorOne: UIColor(cgColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)), colorTwo: UIColor(cgColor: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)))

        /// Methods To Configure songs in Playlist and Choose it to play
        configureSongs()
        chooseSongToPlay()

    }
    override func viewDidAppear(_ animated: Bool) {
        isPopup = true
    }

    //MARK: - Music Methods

    //FUNCTION THAT ALLOW TO CHOSSE SONG FROM PLAYLIST TO PLAY AND GETS THE NAME OF THE SONGS
    func chooseSongToPlay()
    {
        let song = playList[thisSong].name
        let urlString = Bundle.main.path(forResource: song, ofType: "mp3")

        /// Play Song in Foreground & Background
        do
        {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            try AVAudioSession
                .sharedInstance()
                .setCategory(
                    AVAudioSession.Category.playAndRecord,
                    mode: .default,
                    options: [.defaultToSpeaker]
            )

            guard urlString != nil else {
                print("urlstring is nil")
                return
            }

        } catch {
            print("Failed to set audio session category.  Error: \(error)")
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

    /// Show Play Or Pause button Image Function
    func setPlayOrPauseButtonImage() {
        if isSongPressed {
            music.showPlayOrPauseButton(!isSongPressed, on: playOrPauseButton)

        } else {
            music.showPlayOrPauseButton(!isSongPressed, on: playOrPauseButton)
        }
    }
    /// Show  Pause button Of Selected Cell
    func setPauseButtonOnSelectedCell() {
        if isSongPressed {
            music.showPlayOrPauseButton(!isSongPressed, on: playOrPauseButton)

        } else {
            music.showPlayOrPauseButton(isSongPressed, on: playOrPauseButton)
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

    /// Set zero in Firebase when song ends
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = playList[indexPath.row]

        /// Render Name AND Image Of Song in View
        cell.textLabel?.text = song.name
        cell.imageView?.image = UIImage(named: song.imageName)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        do
        {
            tableView.deselectRow(at: indexPath, animated: true)

            audioStuffed = true
            isSongPressed = true
            thisSong = indexPath.row
            let song = playList[thisSong]

            playThisSong(thisOne: song.name)

             setPauseButtonOnSelectedCell()

            /// Render Name AND Image Of Song in View
            songLabel.text = song.name
            artWorkImageView.image = UIImage(named: song.imageName)

            /// Setting Firebase Realtime Database of selected song
            music.setMusicInRTDFirebase(with: thisSong + 1)

            /// Timer to count selected song duration till ends
            songShouldPauseWhenEnds()

        }
    }

}
