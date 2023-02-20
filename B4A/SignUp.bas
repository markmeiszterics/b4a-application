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

	Private RegNameField As B4XFloatTextField
	Private RegEmailField As B4XFloatTextField
	Private RegPasswordField As B4XFloatTextField
	Private RegPasswordAgainField As B4XFloatTextField
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("regisztracio")

End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub RegButton_Click
	Try
		If RegPasswordField.Text <> RegPasswordAgainField.Text Then
			xui.MsgboxAsync("A jelszavak nem egyeznek meg!","Regisztracio")
		Else
			Wait For (insertData) Complete (success As Boolean)
			If success Then
				xui.MsgboxAsync("Sikeres regisztracio!","Regisztracio")
				Wait For Msgbox_result (response As Int)
				If response = xui.DialogResponse_Positive Then
					StartActivity(SignIn)
					Activity.Finish
				End If
			End If
		End If
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException,"Hiba")
	End Try
End Sub

Private Sub insertData As ResumableSub
	Dim result As Boolean
	Try
		Dim sql_query  As String = $"INSERT INTO felhasznalok (felhasznalonev,email,jelszo) VALUES (?,?,?)"$
		Main.sql.ExecNonQuery2(sql_query, Array As Object(RegNameField.Text, RegEmailField.Text, RegPasswordField.Text))
		result = True
	Catch
		Log(LastException)
		xui.MsgboxAsync(LastException,"Hiba")
		result = False
	End Try
	
	Return result
End Sub