//
//  ReaderCellViewController.swift
//  小说阅读器
//
//  Created by 郭朝顺 on 2023/11/4.
//

import UIKit

class ReaderCellViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var dataArray: [ReaderLineModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: "ReaderCell", bundle: nil), forCellReuseIdentifier: "ReaderCell")
        self.dataArray = self.handleData()

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReaderCell = self.tableView.dequeueReusableCell(withIdentifier: "ReaderCell") as! ReaderCell
        cell.contentLabel.text = self.dataArray[indexPath.row].content
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  self.dataArray[indexPath.row].rowHeight
    }


    func handleData() -> [ReaderLineModel] {
        let path = Bundle.main.path(forResource: "神墓", ofType: "txt")
        let content = try? String.init(contentsOfFile: path!, encoding: .utf8)
        let dataArray: [String]? = content?.components(separatedBy: CharacterSet.newlines)


        let font = UIFont.systemFont(ofSize: 17)

        let maxWidth = UIScreen.main.bounds.size.width - 24

        let result: [ReaderLineModel]? = dataArray?.map { oneLine in
            let model = ReaderLineModel()
            model.content = oneLine
            model.rowHeight = oneLine.calculateTextSize(textFont: font, maxWidth: maxWidth).height
            return model
        }
        return result!
    }
    

}
