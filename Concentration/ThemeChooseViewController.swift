//
//  ThemeChooseViewController.swift
//  Concentration
//
//  Created by Julea Parkhomava on 2/25/21.
//

import UIKit

class ThemeChooseViewController: UIViewController, UISplitViewControllerDelegate {

    let themes =
        ["Sports":"⚽️🏒🏹🥊🤿🥋🎣🪁🛹⛸",
         "Faces":"🥰😛😅😂😊🙃😍😤☹️🤐",
         "Animals":"🐶🦁🐷🐸🐔🐥🦊🐯🐝"]
    
    // MARK: - Navigation
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    //почему не запускается приложение с экрана выбора? 7я лекция - 1ч:04мин
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController
    ) -> Bool
    {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            return cvc.theme == nil
        }
        return false
    }

    @IBAction func ChangeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let button = sender as? UIButton, let themeName = button.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
        }else if let cvc = lastConcentrationViewController{
            if let button = sender as? UIButton, let themeName = button.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else{
            performSegue(withIdentifier: "Change Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastConcentrationViewController: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton, let themeName = button.currentTitle, let theme = themes[themeName]{
            if let cvc = segue.destination as? ConcentrationViewController{
                cvc.theme = theme
                lastConcentrationViewController = cvc
            }
        }
    }
    
}
