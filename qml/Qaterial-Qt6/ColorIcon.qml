/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import Qt5Compat.GraphicalEffects

import Qaterial as Qaterial
import "." as Qaterial

Item
{
  id: root

  // ICON CONTROL
  property alias source: _icon.icon
  property bool fill: false
  property bool outlined: false
  property bool roundIcon: fill || outlined
  //property alias mirror: _icon.mirror
  property bool mirror: false //???
  property bool roundOpacity: true

  // COLORS
  property alias color: _icon.color // color color: Qaterial.Style.primaryTextColor()
  property color roundColor
  property color roundBorderColor: roundColor

  // SIZE
  width: roundIcon ? roundSize : iconSize
  height: roundIcon ? roundSize : iconSize

  property double iconSize: 24 * Qaterial.Style.pixelSizeRatio
  property double roundSize: 40 * Qaterial.Style.pixelSizeRatio

  Rectangle
  {
	id: _round
	width: root.roundSize
	height: root.roundSize
	color: root.fill ? root.roundColor : "transparent"
	radius: root.roundSize / 2
	visible: root.roundIcon
	border.width: root.outlined ? 1 : 0
	border.color: root.outlined ? root.roundBorderColor : "transparent"
	opacity: roundOpacity ? 0.5 : 1.0
  } // Rectangle

  /*Image
  {
	id: _image
	width: root.iconSize
	height: root.iconSize
	visible: false
	fillMode: Image.PreserveAspectFit
	sourceSize.height: root.iconSize
	sourceSize.width: root.iconSize
	anchors.centerIn: parent
  } // Image

  ColorOverlay
  {
	source: _image
	anchors.fill: _image
	color.r: root.color.r
	color.g: root.color.g
	color.b: root.color.b
	color.a: 1
	cached: true
  } // ColorOverlay


  opacity: color.a*/

  Icon {
	  id: _icon
	  width: root.iconSize
	  height: root.iconSize
	  size: root.iconSize
	  anchors.centerIn: parent
  }
} // Item
