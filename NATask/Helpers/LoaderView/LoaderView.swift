//
//  LoaderView.swift
//  Lolya
//
//  Created by mohamed gamal on 4/27/20.
//  Copyright © 2020 mohamed gamal. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    class func instanceFromNib() -> LoaderView {
        return UINib(nibName: "LoaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoaderView
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    override func layoutSubviews() {

    }
    func show() {
        activityIndicator.startAnimating()
    }
    func hide() {
        activityIndicator.stopAnimating()
    }
}

extension UIViewController {
    var loader: LoaderView {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let window = appDelegate.window!
        for view in window.subviews where view is LoaderView {
            return view as! LoaderView
        }
        for view in self.view.subviews where view is LoaderView {
            return view as! LoaderView
        }
        return LoaderView.instanceFromNib()
    }

    func showAppLoader(overContext: Bool = true) {
        let loader = self.loader
        if overContext != true {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = appDelegate.window!
            for view in window.subviews where view is LoaderView {
                return
            }

            loader.frame = window.bounds
            loader.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            window.addSubview(loader)

        } else {
            loader.frame = view.bounds
            loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(loader)

        }
        loader.show()
    }

    func hideAppLoader() {
        loader.hide()
        self.loader.removeFromSuperview()
    }

}
