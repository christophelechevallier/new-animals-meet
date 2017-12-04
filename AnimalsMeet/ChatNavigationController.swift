//
//  ChatNavigationController.swift
//  AnimalsMeet
//
//  Created by Adrien morel on 20/05/2017.
//  Copyright © 2017 AnimalsMeet. All rights reserved.
//

import UIKit
import Material
import Fusuma
import PromiseKit
import ARSLineProgress

class ChatNavigationController: NavigationController, PageTabBarControllerDelegate, SearchBarDelegate {
    
    let fontSize: CGFloat = 18
    var pagerVC : PageTabBarController?
    var conversations : ChatTableViewController?
    var otherView : UIViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversations = ChatTableViewController(style: .plain)
        otherView = UIViewController()
        
        conversations!.pageTabBarItem.title = "Amis"
        conversations!.pageTabBarItem.titleLabel!.font = UIFont.boldSystemFont(ofSize: fontSize)
        otherView!.pageTabBarItem.title = "Other View"
        conversations!.pageTabBarItem.backgroundColor = Color.grey.lighten4
        otherView!.pageTabBarItem.backgroundColor = Color.grey.lighten4
        
        pagerVC = PageTabBarController(viewControllers: [conversations!, otherView!])
        pagerVC!.delegate = self
        pagerVC!.pageTabBarAlignment = .top
        pagerVC!.pageTabBar.lineAlignment = .bottom
        navigationBar.isOpaque = true
        pagerVC!.edgesForExtendedLayout = []
        
        navigationBar.backgroundColor = Color.grey.lighten1
        //pagerVC!.title = "Mensajes"
        
        view.backgroundColor = .white
        let profileImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        profileImg.kf.setImage(with:  App.instance.userModel.image)
        //profileImg.rounded()
        profileImg.cornerRadius = profileImg.bounds.width / 2
        
        let profileImageButton = UIBarButtonItem(customView: profileImg)
        
        
        let newPostButton = UIBarButtonItem()
        newPostButton.image =  #imageLiteral(resourceName: "icons8-create_new")
        newPostButton.tintColor = Color.blue.base
        
        let search = SearchBar(frame: CGRect(x: 0, y: 0, width:  (Screen.bounds.width - 54*2), height: 30))
        search.delegate = self
        search.contentMode = .center
        search.cornerRadius = 8
        search.backgroundColor = Color.grey.lighten2
        search.isClearButtonAutoHandleEnabled = false
        
        let searchBarButton = UIBarButtonItem(customView: search)
    
        pagerVC?.navigationItem.setLeftBarButtonItems([profileImageButton,searchBarButton], animated: true)
        pagerVC?.navigationItem.setRightBarButtonItems([newPostButton],animated: true)
        
        view.backgroundColor = Color.grey.lighten2
        
        pushViewController(pagerVC!, animated: false)
    }
    
    
    //tabbar delegate
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        if viewController == conversations {
            otherView!.pageTabBarItem.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
            conversations!.pageTabBarItem.titleLabel!.font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            conversations!.pageTabBarItem.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
            otherView!.pageTabBarItem.titleLabel!.font = UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    //search delegate
    func searchBar(searchBar: SearchBar, didChange textField: UITextField, with text: String?) {
        print("Buscando ahora:" + (text ?? ""))
        conversations?.filter = (text ?? "")!
        conversations?.shouldRefresh()
    }
    
}
