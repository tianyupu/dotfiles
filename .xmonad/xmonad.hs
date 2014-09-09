import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import XMonad.Prompt
import XMonad.Prompt.Input
import System.IO

main = do
        xmproc <- spawnPipe "xmobar"
        xmonad $ defaultConfig
                { manageHook = manageDocks <+> manageHook defaultConfig
                , focusedBorderColor = "#d33682" -- 'magenta' from solarized
                , normalBorderColor  = "#6c71c4" -- 'base02' from solarized
                , layoutHook = avoidStruts $ layoutHook defaultConfig
                , startupHook = startup
                , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                         , ppTitle = xmobarColor "#268bd2" "" . shorten 100 -- 'blue' from solarized
                         , ppCurrent = xmobarColor "#b58900" "" . wrap "[" "]" -- make the current window yellow from solarized
                        }
                , terminal = "xterm"
                } `additionalKeysP`
                [ ("M-S-l", spawn "xscreensaver-command -activate")
                , ("M-S-s", spawn "scrot -s")
                , ("C-M-x", sudoSpawn "shutdown -h now")
                , ("C-M-z", sudoSpawn "pm-suspend")
                , ("M-b", spawn "google-chrome")
                , ("M-f", spawn "thunar")
                , ("<F10>", spawn "amixer set Master 5%+")
                , ("<F9>", spawn "amixer set Master 5%-")
                , ("<F8>", spawn "amixer set Master toggle")
                , ("<F7>", spawn "xbacklight +20")
                , ("<F6>", spawn "xbacklight -20")
                ]

startup :: X()
startup = do
        spawn "redshift"
        spawn "$HOME/.dropbox-dist/dropboxd"
        spawn "xscreensaver -no-splash"
        spawn "xrdb -merge $HOME/.Xresources"
        spawn "xterm"

sudoSpawn command = withPrompt "Password" $ run command
        where run command password = spawn $ concat ["echo ", password, " | sudo -S ", command]

withPrompt prompt fn = inputPrompt defaultXPConfig prompt ?+ fn
