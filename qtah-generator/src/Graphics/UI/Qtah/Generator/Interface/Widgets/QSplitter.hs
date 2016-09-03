-- This file is part of Qtah.
--
-- Copyright 2015-2016 Bryan Gardiner <bog@khumba.net>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

module Graphics.UI.Qtah.Generator.Interface.Widgets.QSplitter (
  aModule,
  ) where

import Foreign.Hoppy.Generator.Spec (
  Export (ExportClass),
  addReqIncludes,
  classSetEntityPrefix,
  ident,
  includeStd,
  makeClass,
  mkConstMethod,
  mkCtor,
  mkMethod,
  mkProp,
  mkProps,
  )
import Foreign.Hoppy.Generator.Types (boolT, enumT, intT, objT, ptrT, voidT)
import Graphics.UI.Qtah.Generator.Interface.Core.QList (c_QListInt)
import Graphics.UI.Qtah.Generator.Interface.Core.Types (e_Orientation)
import Graphics.UI.Qtah.Generator.Interface.Listener (c_ListenerIntInt)
import Graphics.UI.Qtah.Generator.Interface.Widgets.QFrame (c_QFrame)
import Graphics.UI.Qtah.Generator.Interface.Widgets.QWidget (c_QWidget)
import Graphics.UI.Qtah.Generator.Module (AModule (AQtModule), makeQtModule)
import Graphics.UI.Qtah.Generator.Types

{-# ANN module "HLint: ignore Use camelCase" #-}

aModule =
  AQtModule $
  makeQtModule ["Widgets", "QSplitter"] $
  [ QtExport $ ExportClass c_QSplitter
  ] ++ map QtExportSignal signals

c_QSplitter =
  addReqIncludes [includeStd "QSplitter"] $
  classSetEntityPrefix "" $
  makeClass (ident "QSplitter") Nothing [c_QFrame]
  [ mkCtor "new" []
  , mkCtor "newWithParent" [ptrT $ objT c_QWidget]
  , mkCtor "newWithOrientation" [enumT e_Orientation]
  , mkCtor "newWithOrientationAndParent" [enumT e_Orientation, ptrT $ objT c_QWidget]
  ] $
  [ mkMethod "addWidget" [ptrT $ objT c_QWidget] voidT
  , mkConstMethod "count" [] intT
    -- TODO getRange
    -- TODO handle
  , mkConstMethod "indexOf" [ptrT $ objT c_QWidget] intT
  , mkMethod "insertWidget" [intT, ptrT $ objT c_QWidget] voidT
  , mkConstMethod "isCollapsible" [intT] boolT
  , mkMethod "refresh" [] voidT
    -- TODO restoreState
    -- TODO saveState
  , mkMethod "setCollapsible" [intT, boolT] voidT
  , mkMethod "setSizes" [objT c_QListInt] voidT
  , mkMethod "setStretchFactor" [intT, intT] voidT
  , mkMethod "sizes" [] $ objT c_QListInt
  , mkConstMethod "widget" [intT] $ ptrT $ objT c_QWidget
  ] ++
  mkProps
  [ mkProp "childrenCollapsible" boolT
  , mkProp "handleWidth" intT
  , mkProp "opaqueResize" boolT
  , mkProp "orientation" $ enumT e_Orientation
  ]

signals =
  [ makeSignal c_QSplitter "splitterMoved" c_ListenerIntInt ]
