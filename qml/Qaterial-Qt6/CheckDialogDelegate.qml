/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.CheckDelegate
{
  onClicked: ListView.view.currentIndex = index
  //checked: ListView.isCurrentItem
  backgroundColor: Qaterial.Style.dialogColor
  indicatorSpacing: Qaterial.Style.dialog.indicatorSpacing
  alignTextRight: true
  LayoutMirroring.enabled: true
  width: parent ? parent.width : implicitWidth
} // RadioDelegate
