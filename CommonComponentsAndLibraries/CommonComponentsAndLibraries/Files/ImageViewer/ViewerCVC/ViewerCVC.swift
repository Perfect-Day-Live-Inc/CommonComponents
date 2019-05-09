//
//  ViewerCVC.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 02/11/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum PanDirection {
    case vertical
    case horizontal
}

class UIPanDirectionGestureRecognizer: UIPanGestureRecognizer {
    
    let direction : PanDirection
    
    init(direction: PanDirection, target: AnyObject, action: Selector) {
        self.direction = direction
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .began {
            
            let vel = velocity(in: self.view!)
            switch direction {
            case .horizontal where abs(vel.y) > abs(vel.x):
                state = .cancelled
            case .vertical where abs(vel.x) > abs(vel.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}

protocol ViewerCVCDelegate {
    func playBtnTapped(at Index: Int)
    func dismissImageViewer()
}

class ViewerCVC: UICollectionViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLbl: UILabel!
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    var delegate : ViewerCVCDelegate? = nil
    var index: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.scrollView.delegate = self
        let minScale = scrollView.frame.size.width / imgView.frame.size.width;
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.contentSize = imgView.frame.size
    }
    
    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let velocity = panGesture.velocity(in: self.contentView)//panGesture.translation(in: self.imgView)
        let translation = panGesture.translation(in: self.contentView)
//        panGesture.velocity(in: self.imgView)
        
        if(velocity.y > 0)
        {
            if panGesture.state == .began {
                originalPosition = self.contentView.center
                currentPositionTouched = panGesture.location(in: self.contentView)
            } else if panGesture.state == .changed {
                contentView.frame.origin = CGPoint(
                    x: self.contentView.frame.origin.x,
                    y: translation.y
                )
            } else if panGesture.state == .ended {
                
                if velocity.y >= 1200 {
                    UIView.animate(withDuration: 0.2
                        , animations: {
                            self.contentView.frame.origin = CGPoint(
                                x: self.contentView.frame.origin.x,
                                y: self.contentView.frame.origin.y
                            )
                    }, completion: { (isCompleted) in
                        if isCompleted {
                            if self.delegate != nil{
                                self.delegate!.dismissImageViewer()
                            }
                        }
                    })
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.contentView.center = CGPoint.init(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                    })
                }
            }
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView.center = CGPoint.init(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            })
        }
        
    }
    
    func setDataAccordingToStatus(media: Media){
        self.setPanGesture()
        let thumbImg = UIImage.init(named: "thumb", in: Bundle.init(for: ImageViewer.self), compatibleWith: UITraitCollection.init())
        if media.status == .downloading{
            self.errorLbl.isHidden = true
            self.indicatorView.isHidden = false
            self.playBtn.isHidden = true
            self.indicatorView.startAnimating()
            self.imgView.image = thumbImg
        }else{
            self.errorLbl.isHidden = true
            self.indicatorView.isHidden = true
            self.playBtn.isHidden = true
            self.indicatorView.stopAnimating()
            self.imgView.image = (media.thumbImage != nil) ? media.thumbImage! : thumbImg
        }
    }
    
    func setData(media: Media){
        self.setPanGesture()
        let thumbImg = UIImage.init(named: "thumb", in: Bundle.init(for: ImageViewer.self), compatibleWith: UITraitCollection.init())
        if media.erroMsg != nil{
            self.errorLbl.isHidden = false
            self.indicatorView.isHidden = true
            self.playBtn.isHidden = true
            self.imgView.isHidden = true
            self.errorLbl.text = media.erroMsg
        }else if media.type == .image{
            self.errorLbl.isHidden = true
            self.playBtn.isHidden = true
            if media.status == .downloading || media.status == .stillWait{
                self.indicatorView.isHidden = false
                self.imgView.isHidden = true
                self.indicatorView.startAnimating()
                self.imgView.image = thumbImg
            }else{
                self.indicatorView.isHidden = true
                self.imgView.isHidden = false
                self.indicatorView.stopAnimating()
                self.imgView.image = (media.thumbImage != nil) ? media.thumbImage! : thumbImg
            }
        }else if media.type == .video{
            self.errorLbl.isHidden = true
            if media.status == .downloading || media.status == .stillWait{
                self.indicatorView.isHidden = false
                self.imgView.isHidden = true
                self.playBtn.isHidden = true
                self.indicatorView.startAnimating()
                self.imgView.image = thumbImg
            }else{
                self.indicatorView.isHidden = true
                self.imgView.isHidden = false
                self.playBtn.isHidden = false
                self.indicatorView.stopAnimating()
                self.imgView.image = (media.thumbImage != nil) ? media.thumbImage! : thumbImg
            }
        }else{
            self.errorLbl.isHidden = true
            self.indicatorView.isHidden = false
            self.playBtn.isHidden = true
            self.imgView.isHidden = true
            self.indicatorView.startAnimating()
        }
    }
    
    func setPanGesture(){
        panGestureRecognizer = UIPanDirectionGestureRecognizer(direction: .vertical, target: self, action: #selector(panGestureAction))
//        panGestureRecognizer?.delegate = self
//UIPanGestureRecognizer(target: self, action: #selector(panGestureAction))
        self.addGestureRecognizer(panGestureRecognizer!)
    }
    
    @IBAction func playBtnTapped(_ sender: UIButton){
        if delegate != nil{
            delegate!.playBtnTapped(at: self.index)
        }
    }

}

extension ViewerCVC : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
}
