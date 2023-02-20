B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=12.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim xui As XUI
End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private LoginEmailField As B4XFloatTextField
	Private LoginPasswordField As B4XFloatTextField
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("bejelentkezes")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub LoginOKButton_Click
	Try
		Wait for (Login) Complete (success As Boolean)
		If success Then
			Log("Felhasznalo beleptetve, atiranyitas a dashboardra!")
		End If
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException,"Hiba")
	End Try
End Sub

Private Sub Login As ResumableSub
	Dim result As Boolean
	
	Try
		Dim sql_query As String = $"SELECT email, jelszo FROM felhasznalok WHERE email=? AND jelszo=?"$
		Dim rs As ResultSet = Main.sql.ExecQuery2(sql_query, Array As String(LoginEmailField.Text,LoginPasswordField.Text))
		If rs.NextRow Then
			Log(rs.GetString("email"))
			Log(rs.GetString("jelszo"))
			StartActivity(Dashboard)
			Activity.Finish
		Else
			xui.MsgboxAsync("Helytelen belepesi adatok!","Bejelentkezes")
			result = False
		End If
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException,"Bejelentkezes")
		result = False
	End Try
	
	Return result
End Sub