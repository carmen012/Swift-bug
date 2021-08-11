//
//  ViewController.swift
//  NewsApp
//
//  Created by Carmen on 2/10/2020.
//  Copyright © 2020 Carmen. All rights reserved.
//

import Speech
import UIKit
import AVFoundation


class ViewController: UIViewController {
var url = ""
@IBOutlet var btn_start: UIButton!

@IBAction func speech(_ sender: Any) {
isStart  = !isStart

if isStart{
startSpeechRecognization()
btn_start.setTitle("stop", for: .normal)
btn_start.backgroundColor = .systemRed
}else{
cancelSpeech()
btn_start.setTitle("start", for: .normal)
btn_start.backgroundColor = .systemGreen
}
}

@IBOutlet var textView: UITextView!
let audioEngine = AVAudioEngine()
let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "en-GB"))
let request = SFSpeechAudioBufferRecognitionRequest()
var task : SFSpeechRecognitionTask!
var isStart : Bool = false
var timer: Timer?
var speechRequest : SFSpeechAudioBufferRecognitionRequest?
var countingSpeechWord = ["first","second","third","fourth","fifth","sixth","seventh","eighth","ninth","tenth","eleventh","twelfth","thirteenth","fourteenth","fifteenth","sixteenth","seventeenth","eighteenth","nineteenth","twentieth"]
var countingNumberWord = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
var countingNumberInWord = ["one","two","three","four","five","six","seven","eight","nine","ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eighteen","nineteen","twentie"]
var countingNumberSpeechWord = ["1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th","13th","14th","15th","16th","17th","18th","19th","20th"]




func requestPermission(){
self.btn_start.isEnabled = false
SFSpeechRecognizer.requestAuthorization{
(authState) in OperationQueue.main.addOperation {
if authState == .authorized {
print("accepted")
self.btn_start.isEnabled = true
}else if authState == .denied{
print("denied the permission")
}else if authState == .notDetermined{
print("don't support")
}else if authState == .restricted{
print("restricted using speech")
}
}
}
}

func cancelSpeech(){
if audioEngine.isRunning {
task?.cancel()
task?.finish()
task = nil

if request.accessibilityActivate() == false{
request.endAudio()
}
audioEngine.stop()
audioEngine.inputNode.removeTap(onBus: 0)

}

}






override func viewDidLoad() {
super.viewDidLoad()
requestPermission()
    self.timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.cancelSpeechAuto), userInfo: nil, repeats: false)
    self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.restartSpeechAuto), userInfo: nil, repeats: false)

self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.cancelSpeechAuto), userInfo: nil, repeats: true)
self.timer = Timer.scheduledTimer(timeInterval: 31, target: self, selector: #selector(self.restartSpeechAuto), userInfo: nil, repeats: true)
menu()


}
@objc func cancelSpeechAuto(){
cancelSpeech()
btn_start.setTitle("start", for: .normal)
btn_start.backgroundColor = .systemGreen
isStart = false
}
@objc func restartSpeechAuto(){
startSpeechRecognization()
btn_start.setTitle("stop", for: .normal)
btn_start.backgroundColor = .systemRed
isStart = true
}

func startSpeechRecognization(){
task?.cancel()
task = nil


let node = audioEngine.inputNode
let recordingFormat = node.outputFormat(forBus: 0)
node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat){(buffer,_) in self.request.append(buffer)}
audioEngine.prepare()
do{
try audioEngine.start()
}catch _{
print("fail")
}
guard let myRecognization = SFSpeechRecognizer() else{
print("false")
return
}
if !myRecognization.isAvailable{
print("pls try again")
}
task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
guard let response = response else{
if error != nil {
print(error?.localizedDescription as Any)
} else{
print("can't response")
}
return
}

let msg = response.bestTranscription.formattedString
_ = msg.split(separator: " ")
var lastString = ""
for segment in response.bestTranscription.segments{
let indexTo = msg.index(msg.startIndex, offsetBy: segment.substringRange.location)
lastString = String(msg[indexTo...]).lowercased()
}
    if self.url==""  {
let url1 = "https://newsapi.org/v2/everything?q="
let url2 = "&apiKey=91840c3833304f409673f14db04b981b"
self.url = url1+lastString+url2
print(lastString)
self.showInfo()
}
else{
switch(lastString){
case ("restart"):
self.i=7
self.getData(from: self.url,cmdNumber: 0)
break
case ("stop"):
self.i=1
break
case ("title"):
self.i=0
self.getData(from: self.url,cmdNumber: 0)
break
case ("description"):
self.i=2
self.getData(from: self.url,cmdNumber: 0)
break
case ("specific"):
self.i=3
self.getData(from: self.url,cmdNumber: 0)
break
default:

if self.i == 5{
if self.countingSpeechWord.contains(lastString){
self.getNumber(array:self.countingSpeechWord,element: lastString)
} else if self.countingNumberWord.contains(lastString){
self.getNumber(array: self.countingNumberWord, element: lastString)
} else if self.countingNumberInWord.contains(lastString){
self.getNumber(array: self.countingNumberInWord, element: lastString)
}else if self.countingNumberSpeechWord.contains(lastString){
self.getNumber(array: self.countingNumberSpeechWord, element: lastString)
}
else{
self.i = 6
self.getData(from: self.url,cmdNumber: 5)
}
} else if self.i==9999{
self.getData(from: self.url, cmdNumber: 0)
}
else{
print(lastString)
}
break
}
}
}

) }

func getNumber(array:[String],element: String){
self.i = 4
let lastStringIndex = array.firstIndex(of: element)
print(lastStringIndex as Any)
getData(from: self.url,cmdNumber:lastStringIndex!)
}
func showInfo(){
self.textView.text = "You have 3 modes, title, desciption and specific, also you can say 'stop' or 'restart' to control the application."
}


func menu(){
btn_start.isHidden = true
let word = ["Welcome to News reporter. tell me which topic do you want to know? such as business, entertainment, CNN or the other keyword. This is the demo verson, only support one word."]
self.textView.text = word[0]
    self.i=9999

}



func speakOut(word: String){
let utterance = AVSpeechUtterance(string: word)
utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
let synth = AVSpeechSynthesizer()
synth.speak(utterance)

}

func abc(kk: String, abv: Int){
let url = URL(string:kk )!
URLSession.shared.dataTask(with:url ) { data, _, _  in
if let data = data{
let result = try? JSONDecoder().decode(NewsFeed.self, from: data)
print(result)
}
}.resume()
}

func getData(from: String,cmdNumber: Int){



let url = URL(string: from)!
URLSession.shared.dataTask(with:url) { data, _, _  in
if let data = data{
let json = try? JSONDecoder().decode(NewsFeed.self, from: data)
if self.i == 0{
let word = "title mode"
let timer = (word.count*100000)+200000

self.speakOut(word: word)
usleep(useconds_t(timer))
for index in self.index ... (json?.articles?.count)! - 1{
if  self.i == 1 {
break
}else{
print(json?.articles?[index].title)
self.speakOut(word:"the \(self.countingSpeechWord[index]) news" + (json?.articles?[index].title)!)
print("here have \(json?.articles?[index].title?.count)")
DispatchQueue.main.async {
self.textView.text = json?.articles?[index].title
}
let timer = ((json?.articles?[index].title?.count)!*98000)
print(useconds_t(timer))
usleep(useconds_t(timer))
self.index = index
print (" the number of \(index+1) record played")
}
}

}else if self.i == 2{

self.speakOut(word: "got it. now play")
let timer = ("got it. now play".count*98000)
usleep(useconds_t(timer))
for index in self.index ... (json?.articles!.count)!-1 {
if  self.i == 1 {
break
          }else{

self.speakOut(word: "the \(self.countingSpeechWord[index]) news"+(json?.articles![index].description)!)
DispatchQueue.main.async {
self.textView.text = json?.articles![index].description
                       }
let timer2 = ("\(self.countingSpeechWord[index]) news".count+(json?.articles![index].description?.count)!*98000)
usleep(useconds_t(timer2))
print (" the number of \(index+1) record played")
}

}

}else if self.i == 3{
  self.i = 1
let word = ["specific mode","tell me which news do you what to listen? please speak in a number."]
self.speakOut(word: word[0])
let timer = (word[0].count*88000)
usleep(useconds_t(timer))
self.speakOut(word: word[1])
let timer2 = (word[1].count*88000)
usleep(useconds_t(timer2))
    
self.i = 5
}
else if self.i == 4{
 self.i = 1
self.speakOut(word: "the \(self.countingSpeechWord[cmdNumber]) news" + (json?.articles![cmdNumber].description!)!)
let timer = ("the \(self.countingSpeechWord[cmdNumber]) news".count + (json?.articles![cmdNumber].description!.count)!)*75000
    DispatchQueue.main.async {
    self.textView.text = json?.articles?[cmdNumber].description
    }
    let word = "Speak a number to next news or choose the other mode"
usleep(useconds_t(timer))
    self.speakOut(word: word)
    let timer2 = (word.count*88000)
    usleep(useconds_t(timer2))
self.i=5

} else if self.i == 6{
    self.i = 1
let word = "Sorry, I can't hear you. Please try it again"
    DispatchQueue.main.async {
    self.textView.text = word
    }

    
self.i = cmdNumber
}else if self.i == 7{

let word = "got it, all the mode will restart, please choose title, or description again"
    self.speakOut(word: word)
    let timer = (word.count)*80000
    self.index = 0
  self.i = 1
}

}
}.resume()

}
var i = 0
var index = 0




}

