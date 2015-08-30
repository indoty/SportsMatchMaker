//
//  ViewController.swift
//  SportsMatchMaker
//
//  Created by ShineStar on 8/1/15.
//  Copyright (c) 2015 ShineStar. All rights reserved.
//


import UIKit
import CoreLocation

// hello world cdd

class ViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var webView: UIWebView!
    
    var indicator: UIActivityIndicatorView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray);
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = view.center;
        view.addSubview(indicator);
        indicator.bringSubviewToFront(view);
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        
        let url = NSURL (string: "http://mvc5identity.azurewebsites.net");
        let requestObj = NSURLRequest(URL: url!);
        webView.scrollView.bounces = false;
        webView.delegate = self;
        //webView.scrollView.delegate = self;
        //webView.scrollView.showsHorizontalScrollIndicator = false;
        webView.scalesPageToFit = true;
        webView.loadRequest(requestObj);
        
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestAlwaysAuthorization();
        locationManager.startUpdatingLocation();
    
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.x != 0) {
            scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        indicator.stopAnimating();
        print("Couldn't load content.");
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        indicator.startAnimating();
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        indicator.stopAnimating();
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation();
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.first as? CLLocation {
            locationManager.stopUpdatingLocation();
        }
    }}

