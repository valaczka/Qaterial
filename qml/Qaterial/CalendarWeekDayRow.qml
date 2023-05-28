import QtQuick 2.15
import Qaterial 1.0 as Qaterial
import "." as Qaterial

Row
{
  id: root

  property int size: Qaterial.Style.roundIcon.size
  property var model: Qaterial.Style.calendarWeekDayRowModel

  Repeater
  {
	model: root.model
	delegate: Qaterial.LabelCaption
	{
	  text: modelData

	  width: root.size
	  height: root.size

	  horizontalAlignment: Text.AlignHCenter
	  verticalAlignment: Text.AlignVCenter
	}
  }
}
