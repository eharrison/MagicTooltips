# MagicTooltips

![alt text](https://miro.medium.com/max/1200/1*0LQvCBhTonwClgMaL5dTww.gif)

## About

The app demonstrates a flexible tooltip manager that will:
1. dim the background
2. highlight a specific view
3. show a tooltip with the specified direction

## Requirements

- iOS 12+
- Swift 5.0

## Usage

1. Copy Tooltip folder to your project
2. Create an enum implementing the protocol **Tooltip** (see **ViewControllerTooltip.swift**)
3. Create a reference of the **TooltipManager** in your UIViewController or view you wish to present the tooltips from. (see **ViewController.swift**)
4. Setup tooltips upon start (see **setupTooltips** in **ViewController.swift**)

For more detailed explanation, check article:
https://medium.com/@ichordnean/flexible-tooltips-in-ios-1ffa5d7d2f36

Happy coding! 😀
