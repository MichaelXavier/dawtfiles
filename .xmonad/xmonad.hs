import qualified Data.Map as M
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Accordion
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.StackSet(greedyView)
import qualified XMonad.StackSet as W
import XMonad.Actions.NoBorders


overrideKeys (XConfig { modMask = modm}) = M.fromList $
    [ ((modm, xK_p), spawn "$SHELL -c dmenu_run")
    , ((modm .|. controlMask, xK_w), spawn "xcalib -invert -alter -s 0")
    , ((modm .|. controlMask, xK_e), spawn "xcalib -invert -alter -s 1")
    , ((modm, xK_g), withFocused toggleBorder)
    ] ++ multiScreenMapping
  where
    -- copied from defaultConfig, but reversed because xinerama
    -- numbers my screens backwards for some reason
    multiScreenMapping =
      [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
          | (key, sc) <- zip [xK_w, xK_e] [0, 1]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myManageHook = composeAll (
    [ manageHook gnomeConfig
    , resource  =? "stalonetray" --> doIgnore
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doIgnore
    , manageDocks
    ])

myStartupHook = do
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "stalonetray"
  spawnOnce "unity-settings-daemon"
  spawnOnce "gnome-settings-daemon"
  spawnOnce "nm-applet"
  spawnOnce "pasystray"
  spawnOnce "fdpowermon"
  spawnOnce "btsync-gui"


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/michael/.xmobarrc"
    xmonad $ gnomeConfig {
         manageHook = myManageHook
       , layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
       , logHook = dynamicLogWithPP xmobarPP
                   { ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor "green" "" . shorten 50
                   }
       , startupHook = myStartupHook
       , modMask = mod4Mask
       , keys = overrideKeys <+> keys gnomeConfig
       , terminal = "gnome-terminal"
       -- , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
       }
