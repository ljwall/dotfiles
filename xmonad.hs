import XMonad
import XMonad.StackSet
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
-- import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Hooks.ManageHelpers (doCenterFloat)
import System.IO

-- Solarized colours
base03 =  "#002b36"
base02 =  "#073642"
base01 =  "#586e75"
base00 =  "#657b83"
base0 =   "#839496"
base1 =   "#93a1a1"
base2 =   "#eee8d5"
base3 =   "#fdf6e3"
yellow =  "#b58900"
orange =  "#cb4b16"
red =     "#dc322f"
magenta = "#d33682"
violet =  "#6c71c4"
blue =    "#268bd2"
cyan =    "#2aa198"
green =   "#859900"

main = do
    -- nscreen <- countScreens
    xmproc <- spawnPipe "/usr/bin/xmobar /home/liam/.xmobarrc"
    xmonad $ desktopConfig
        { modMask     = mod4Mask,
          layoutHook = avoidStruts $ layoutHook defaultConfig,
          manageHook = composeAll
            [ manageHook defaultConfig,
              manageDocks,
              className =? "Gimp"  --> doFloat,
              className =? "feh" --> doCenterFloat,
              (className =? "XTerm") <||> (className =? "UXTerm") --> doTransparent 0.85
            ],
          logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc,
              ppCurrent = fmtCurrentWS,
              ppHidden = fmtHiddenWS,
              ppTitle = xmobarColor base3 "" . shorten 100
            }
          {-logHook = do
            currentTag <- (get >>= (return . tag . workspace . current . windowset))
            wstags <- (ask >>= (return . XMonad.workspaces . config))
            io $ hPutStrLn xmproc ("Hello " ++ (show wstags) ++ " " ++ (xmobarColor blue base03 currentTag)) -}
        } `additionalKeys` [
            ((mod4Mask, xK_p), spawn "rofi -show run -modi run,ssh -no-parse-known-hosts"),
            ((mod4Mask, xK_s), spawn "rofi -show ssh -modi run,ssh -no-parse-known-hosts")
        ]

doTransparent :: Float -> ManageHook
doTransparent x = ask >>= (\w -> liftX . spawn $ "transset-df --id " ++ (show w) ++ " " ++ (show x) ++ " >/dev/null") >> idHook

fmtCurrentWS :: String -> String
fmtCurrentWS x = xmobarColor base3 ""  $ "[" ++ x ++ "]"

fmtHiddenWS :: String -> String
fmtHiddenWS x = xmobarColor base0 "" x

