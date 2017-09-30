import           XMonad
import           XMonad.Actions.NoBorders
import           XMonad.Config.Mate
import qualified XMonad.StackSet          as W
import           XMonad.Util.Dmenu
import           XMonad.Util.SpawnOnce

import qualified Data.Map                 as M

main = xmonad mateConfig
       { modMask = mod4Mask
       , keys = overrideKeys <+> keys mateConfig
       , startupHook = (startupHook mateConfig) >> myStartupHook
       , terminal = "gnome-terminal"
       }

myStartupHook = do
  spawnOnce "nm-applet"

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
