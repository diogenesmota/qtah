-- | Bindings in the top-level @Qt::@ namespace.
module Graphics.UI.Qtah.Internal.Interface.Qt (
  mod_Qt,
  qmods_Qt,
  e_Alignment,
  e_AspectRatioMode,
  ) where

import Foreign.Cppop.Generator.Spec
import Graphics.UI.Qtah.Internal.Generator.Types

mod_Qt = modifyModule' (makeModule "qt" "qt.hpp" "qt.cpp") $ do
  addModuleExports
    [ ExportEnum e_Alignment
    , ExportEnum e_AspectRatioMode
    ]

qmods_Qt :: [QtModule]
qmods_Qt = []

e_Alignment =
  makeEnum (ident1 "Qt" "Alignment") Nothing
  [ -- Horizontal flags.
    (0x01, ["align", "left"])
  , (0x02, ["align", "right"])
  , (0x04, ["align", "h", "center"])
  , (0x08, ["align", "justify"])
    -- Vertical flags.
  , (0x20, ["align", "top"])
  , (0x40, ["align", "bottom"])
  , (0x80, ["align", "v", "center"])
    -- Useful in right-to-left mode.
  , (0x10, ["align", "absolute"])
  ]

e_AspectRatioMode =
  makeEnum (ident1 "Qt" "AspectRatioMode") Nothing
  [ (0, ["ignore", "aspect", "ratio"])
  , (1, ["keep", "aspect", "ratio"])
  , (2, ["keep", "aspect", "ratio", "by", "expanding"])
  ]