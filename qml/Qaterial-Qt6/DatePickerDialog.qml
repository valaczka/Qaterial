/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls
//import Qt.labs.calendar

// Qaterial
import Qaterial as Qaterial
import "." as Qaterial

Qaterial.ModalDialog
{
	id: root

	property date from: new Date(1900, 0, 1)
	property date to: new Date(2099, 11, 31)
	property date date

	property string headerDateFormat: "MMMM dd. ddd"
	property string gridDateFormat: "yyyy MMMM"

	property double cellSize: Qaterial.Style.pixelSizeRatio * 35

	readonly property int currentDay: date.getDate()
	readonly property int currentMonth: date.getMonth()
	readonly property int currentYear: date.getFullYear()

	readonly property date _today: new Date()

	property bool yearListVisible: false

	padding: 0

	standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

	signal todayRequest()

	dialogImplicitWidth: cellSize * 8.5
	implicitHeight: cellSize * 13


	header: Rectangle {
		id: titleOfDate
		height: Math.max(todayButton.implicitHeight, headerColumn.implicitHeight, 48)
		width: root.width
		color: Qaterial.Style.accentColor

		Qaterial.AppBarButton {
			id: todayButton
			icon.source: Qaterial.Icons.calendar
			icon.color: Qaterial.Colors.black
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: 10
			onClicked: root.todayRequest()
		}

		Column {
			id: headerColumn
			anchors.left: parent.left
			anchors.leftMargin: 20
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: todayButton.left
			anchors.rightMargin: 10

			Qaterial.LabelHeadline5
			{
				text: root.currentYear
				color: Qaterial.Colors.black
				opacity: yearListVisible ? 1.0 : 0.5
				width: parent.width
				topPadding: 10
				bottomPadding: 5

				MouseArea {
					anchors.fill: parent
					onClicked: {
						yearListVisible = true
					}
				}
			}

			Qaterial.LabelHeadline4
			{
				text: root.date.toLocaleDateString(Qt.locale(), root.headerDateFormat)
				color: Qaterial.Colors.black
				opacity: yearListVisible ? 0.5 : 1.0
				width: parent.width
				topPadding: 5
				bottomPadding: 10
				font.capitalization: Font.Capitalize

				MouseArea {
					anchors.fill: parent
					onClicked: {
						yearListVisible = false
					}
				}
			}
		}
	}

	contentItem: Item {
		id: mainForm
		height: cellSize * 12
		width: cellSize * 8

		ListView {
			id: calendar
			anchors.fill: parent
			visible: true
			clip: true

			snapMode: ListView.SnapOneItem
			orientation: ListView.Horizontal
			spacing: root.cellSize
			model: CalendarModel {
				id: calendarModel
				from: new Date(new Date().getFullYear(), 0, 1);
				to: new Date(new Date().getFullYear(), 11, 31);
				function setYear(newYear) {
					if (calendarModel.from.getFullYear() > newYear) {
						calendarModel.from = new Date(newYear, 0, 1);
						calendarModel.to = new Date(newYear, 11, 31);
					} else {
						calendarModel.to = new Date(newYear, 11, 31);
						calendarModel.from = new Date(newYear, 0, 1);
					}
					root.date.setFullYear(newYear)
					calendar.goToLastPickedDate()
				}
			}

			delegate: Item {
				height: calendar.width
				width: calendar.height
				Item {
					id: monthYearTitle
					anchors {
						top: parent.top
					}
					height: root.cellSize * 1.2
					width: parent.width

					Qaterial.LabelBody1 {
						anchors.horizontalCenter: parent.horizontalCenter
						property date _d: new Date(model.year, model.month, 1)
						text: _d.toLocaleDateString(Qt.locale(), gridDateFormat)
						color: Qaterial.Style.primaryTextColor()
					}
				}

				DayOfWeekRow {
					id: weekTitles
					locale: monthGrid.locale
					anchors {
						top: monthYearTitle.bottom
						horizontalCenter: parent.horizontalCenter
					}
					height: root.cellSize
					width: monthGrid.width
					delegate: Qaterial.LabelCaption {
						text: model.shortName
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
					}
				}

				MonthGrid {
					id: monthGrid
					month: model.month
					year: model.year
					spacing: 0
					anchors {
						top: weekTitles.bottom
						horizontalCenter: parent.horizontalCenter
					}
					width: root.cellSize * 7
					height: root.cellSize * 6

					locale: Qt.locale()
					delegate: Rectangle {
						height: root.cellSize
						width: root.cellSize
						radius: height * 0.5
						readonly property bool highlighted: enabled && model.day === root.currentDay && model.month === root.currentMonth
						readonly property bool today: enabled && model.day === root._today.getDate() && model.month === root._today.getMonth() &&
													  model.year === root._today.getFullYear()

						enabled: model.month === monthGrid.month
						color: enabled && highlighted ? Qaterial.Style.accentColor : "transparent"

						Qaterial.LabelBody2 {
							anchors.centerIn: parent
							text: model.day
							scale: highlighted ? 1.25 : 1
							Behavior on scale { NumberAnimation { duration: 150 } }
							visible: parent.enabled
							color: parent.highlighted ? Qaterial.Colors.black :
														today ? Qaterial.Style.accentColor : Qaterial.Style.primaryTextColor()
						}
						MouseArea {
							anchors.fill: parent
							onClicked: {
								root.date = model.date
							}
						}
					}
				}
			}

			Connections {
				target: root

				function onTodayRequest() {
					var d = new Date()
					root.date = d
					calendarModel.setYear(d.getFullYear())
					calendar.goToLastPickedDate()
				}
			}

			Component.onCompleted: {
				calendarModel.setYear(root.currentYear)
				goToLastPickedDate()
			}

			function goToLastPickedDate() {
				positionViewAtIndex(root.currentMonth, ListView.SnapToItem)
			}
		}

		ListView {
			id: yearsList
			anchors.fill: parent
			orientation: ListView.Vertical
			visible: false

			property int currentYear
			property int startYear: root.from.getFullYear()
			property int endYear : root.to.getFullYear()

			clip: true

			model: ListModel {
				id: yearsModel
			}

			delegate: Item {
				width: yearsList.width
				height: yearLabel.font.pixelSize * 1.75
				Qaterial.LabelHeadline4 {
					id: yearLabel
					anchors.centerIn: parent
					text: name
					scale: index == yearsList.currentYear - yearsList.startYear ? 1.5 : 1
					color: Qaterial.Style.accentColor
				}
				MouseArea {
					anchors.fill: parent
					onClicked: {
						calendarModel.setYear(yearsList.startYear + index);
						yearListVisible = false
					}
				}
			}

			Component.onCompleted: {
				for (var year = startYear; year <= endYear; year ++)
					yearsModel.append({name: year});
			}

			Connections {
				target: root
				function onYearListVisibleChanged() {
					if (yearListVisible) {
						yearsList.visible = true
						calendar.visible = false
						yearsList.currentYear = root.currentYear
						yearsList.positionViewAtIndex(yearsList.currentYear - yearsList.startYear, ListView.SnapToItem);
					} else {
						yearsList.visible = false
						calendar.visible = true
					}
				}
			}
		}

	}

}
