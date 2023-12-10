//
//  ReaderCTViewController.swift
//  小说阅读器
//
//  Created by 郭朝顺 on 2023/11/4.
//

import UIKit


struct Const {
    static let ScreenWidth = UIScreen.main.bounds.size.width
    static let ScreenHeight = UIScreen.main.bounds.size.height

}

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height - 50


class ReaderCTViewController: UIViewController {


    var readView: ReadView = ReadView()
    var frameArray: [CTFrame] = []
    var frameIndex: Int = 0



    override func viewDidLoad() {
        super.viewDidLoad()

        let width = Const.ScreenWidth
        let height = Const.ScreenHeight - 120

        self.readView.frame = CGRect(x: 12, y: 88, width: width - 24, height: height)

        let model = ReadPageModel()
        model.content = self.handleData()
        self.createCTFrame(contentStr: model.content!)
        self.readView.frameRef = self.frameArray[self.frameIndex]
        self.view.addSubview(self.readView)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touchu: UITouch = touches.first!
        let point = touchu.location(in: touchu.view)

        if (point.x > Const.ScreenWidth * 0.5) {
            self.frameIndex += 1
        } else {
            self.frameIndex -= 1
        }

        if (self.frameIndex <= 0) {
            self.frameIndex = 0
        } else if (self.frameIndex >= self.frameArray.count) {
            self.frameIndex = self.frameArray.count - 1
        }

        self.readView.frameRef = self.frameArray[self.frameIndex]


    }

    func handleData() -> String {
        let path = Bundle.main.path(forResource: "神墓", ofType: "txt")
        let content = try? String.init(contentsOfFile: path!, encoding: .utf8)
        return content!
    }


    func createCTFrame(contentStr: String) {

        let range = NSMakeRange(0, contentStr.count)
        let att = NSMutableAttributedString(string: contentStr)

        att.addAttribute(.foregroundColor, value: UIColor.lightGray, range: range)

        att.addAttribute(.font, value: UIFont.systemFont(ofSize: 22), range: range)

        let framesetter = CTFramesetterCreateWithAttributedString(att as CFAttributedString)
        let path = CGPath(rect: self.readView.bounds, transform: nil)

        var pageStart = 0
        var frameArray: [CTFrame] = []

        var i: Int = 0

        repeat {

            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(pageStart, 0), path, nil)

            let pageRange = CTFrameGetVisibleStringRange(frame)

            let beginIndex = contentStr.index(contentStr.startIndex, offsetBy: pageRange.location)
            let endIndex = contentStr.index(beginIndex, offsetBy: pageRange.length)
            let onePage = String(contentStr[beginIndex..<endIndex])
            pageStart = pageRange.location + pageRange.length


            print("第\(i)页" ,pageRange, onePage)

            i+=1
            frameArray.append(frame)
        } while(pageStart < contentStr.count )
        self.frameArray = frameArray

    }

}
