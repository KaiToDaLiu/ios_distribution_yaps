//
//  Info.swift
//  build
//
//  Created by DaLiu on 2024/10/12.
//

import Foundation

class Info {
    // build_date 文件路径
    // let xcodeBuildFilePath = "/Users/daliu_kt/Desktop/job/GitHub/KaiToApp/build/build_date.txt"
    
    // build 目录
    let localBuildPath = "/Users/daliu_kt/Desktop/job/GitHub/ios_distribution_yaps/build/"
    
    // git page 地址
    let gitPageHome = "https://KaiToDaLiu.github.io/ios_distribution_yaps/"
    
    /// 2024_09_26_14_56_09
    // private var ipaDirName = "2025_05_16_16_26_09" // HERE!!
    
    /// 2024-09-26 14:56:09
    // private var formatDate = ""
    
    /// Debug or Release
    private var buildMode = ""
    
    public func parse() {
        // 解析出日期和编译模式(Debug或Release)
//        let fileManager = FileManager.default
//        if fileManager.fileExists(atPath: xcodeBuildFilePath) {
//            do {
//                var text = try String(contentsOfFile: xcodeBuildFilePath, encoding: .utf8)
//                text = text.trimmingCharacters(in: .whitespacesAndNewlines) // Debug_2024_09_26_14_56_09
//                self.ipaDirName = text
//                let arr = text.components(separatedBy: "_")
//                assert(arr.count == 6)
//                self.formatDate = arr[0] + "-" + arr[1] + "-" + arr[2] + " " + arr[3] + ":" + arr[4] + ":" + arr[5] // 2024-09-26 14:56:09
//            } catch {
//                print("Error reading file: \(error)")
//            }
//        } else {
//            print("File does not exist")
//        }
        
        print("ipaDirName: \(ipaDirName)")
        print("formatDate: \(formatDate)")
    }
    
    lazy var ipaDirName: String = {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss" // 格式：2025_05_16_16_26_09
        // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // 避免受用户本地化设置影响
        // dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // 可选：使用 UTC 时间
        
        return dateFormatter.string(from: date)
    }()
    
    lazy var formatDate: String = {
        let arr = ipaDirName.components(separatedBy: "_")
        assert(arr.count == 6)
        return arr[0] + "-" + arr[1] + "-" + arr[2] + " " + arr[3] + ":" + arr[4] + ":" + arr[5]
    }()
    
    public func logArchiveInformation() {
        print("=============================================")
        print("            Archive information:")
        print("=============================================")
        print(gitPageHome + "build/" + self.ipaDirName + "/KaiToApp.ipa")
        print(gitPageHome + "57.png")
        print(gitPageHome + "512.png")
        print("Rename file name after export: " + ipaDirName)
        print("Scan download url: https://kaitodaliu.github.io/ios_distribution_yaps/index.html")
    }
    
    public func logHTML() {
        print("=============================================")
        print("              Insert HTML:")
        print("=============================================")
        // 清单文件下载路径, 把这个文件地址生成二维码就可以使用iPhone相册扫码下载
        // self.ipaDirName = "2025_04_18_20_25_45"
        let manifestFullPath = "itms-services:///?action=download-manifest&url=" + gitPageHome + "build/" + ipaDirName + "/manifest.plist"
        let saveFilePath = localBuildPath + ipaDirName + "/qrcode.jpg"
        QRCode().saveQRImage(from: manifestFullPath, path: saveFilePath) // convert from to qr image and save it to path
        print("insert div:")
        let div = """
<div class="vertical">
                <img src="build/\(ipaDirName)/qrcode.jpg" alt="scan it with iphone camera">
                \(formatDate)
            </div>
"""
        print(div)
    }
}
