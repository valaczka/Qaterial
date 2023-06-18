/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial
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
