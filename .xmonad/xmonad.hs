import XMonad
import XMonad.Config.Gnome
import XMonad.Util.Dmenu

import qualified Data.Map as M

main = xmonad gnomeConfig
       { modMask = mod4Mask
       , keys = overrideKeys <+> keys gnomeConfig
       }

overrideKeys (XConfig { modMask = modm}) = M.fromList $
  [ ((modm, xK_p), spawn "dmenu_run")]
