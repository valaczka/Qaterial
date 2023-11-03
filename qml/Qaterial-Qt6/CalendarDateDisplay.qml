import QtQuick
import QtQuick.Controls

import Qaterial as Qaterial
import "." as Qaterial

Rectangle
{
  id: root
  implicitWidth: 280
  implicitHeight: 80
  radius: Qaterial.Style.dialog.radius
  color: Qaterial.Style.accentColor

  property string text

  property alias todayButton: todayButton

  /*Rectangle
  {
	anchors.bottom: parent.bottom
	anchors.left: parent.left
	anchors.right: parent.right
	height: parent.height / 2
	color: parent.color
  }*/

  Qaterial.LabelHeadline4
  {
	leftPadding: 20
	anchors.verticalCenter: parent.verticalCenter
	text: root.text
	color: Qaterial.Colors.black //Qaterial.Style.textColorDark
  }

	Qaterial.AppBarButton {
		id: todayButton
		icon.source: Qaterial.Icons.calendar
		icon.color: Qaterial.Colors.black
		anchors.verticalCenter: parent.verticalCenter
		anchors.right: parent.right
	}
}
