import XMonad
import XMonad.Config.Gnome
import XMonad.Util.Dmenu
import qualified XMonad.StackSet as W

import qualified Data.Map as M

main = xmonad gnomeConfig
       { modMask = mod4Mask
       , keys = overrideKeys <+> keys gnomeConfig
       }

overrideKeys (XConfig { modMask = modm}) = M.fromList $
    [ ((modm, xK_p), spawn "dmenu_run") ] ++ multiScreenMapping
  where
    -- copied from defaultConfig, but reversed because xinerama
    -- numbers my screens backwards for some reason
    multiScreenMapping =
      [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
          | (key, sc) <- zip [xK_w, xK_e] [1, 0]
          , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
