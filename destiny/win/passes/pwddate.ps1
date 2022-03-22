

#----------------------------------------------------------------
# Password Expiration Notification
# Author: Mikhail Tokarev
#----------------------------------------------------------------


#----------------------------------------------------------------
# User Input

$ExpPeriod=42                                                            #Enter expiration period defined in your Group policy
$UserScope="OU=Employees,DC=destiny,DC=ent"                            #In This OU script will check when password was changed
$Date1=3                                                                 #Enter First Date (how many days must left before expiration that would script send e-mail)
$Date2=7
$Date3=1                                                                 #Enter First Second (how many days must left before expiration that would script send e-mail)
$ReportFolder='C:\scripts\pass_time\'                #Folder to store reports    
$ReportDate=Get-Date -UFormat "%d-%m-%y"                                 #Just to add date to report file name. 
$ReportFullPath=$ReportFolder+'PWDReport-'+$ReportDate+'.txt'            #AutoGenerated Report Full Path                            
$SMTPServerName="10.1.20.17"                                           #Enter Your SMTP Server address or name
$MailFrom="""Password Monitoring"" <pass_exp@destiny.ent>"         #Enter "FROM" Field
$MailBody="Your Password is about to Expire use Web Access to Change it. ���� �������� ������ ����� ��������. ���������� �������� ������."#Message Body


# End User Input
#----------------------------------------------------------------


#----------------------------------------------------------------
#Define External Functions

#SMTP Send function

function sendMail{

     Write-Host "Sending Email"

     #SMTP server name
     $smtpServer = $SMTPServerName

     #Creating a Mail object
     $msg = new-object Net.Mail.MailMessage

     #Creating SMTP server object
     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     #Email structure 
     $msg.From = $MailFrom
     $msg.To.Add($MailRecipient)
     $msg.subject = $MailSubject
     $msg.body = $MailBody

     #Sending email 
     $smtp.Send($msg)
  
}


#SMTP Send Function End

#End Functions Defining
#----------------------------------------------------------------


#----------------------------------------------------------------
#Importing External modules

Import-Module activedirectory

#End External Modules loads
#----------------------------------------------------------------

#----------------------------------------------------------------
#Script Body

$ExprDate1=(Get-Date).AddDays($Date1).DayOfYear
$ExprDate2=(Get-Date).AddDays($Date2).DayOfYear
$ExprDate3=(Get-Date).AddDays($Date3).DayOfYear

$AllUsers=Get-ADUser -Server delta -Filter * -SearchBase $UserScope -Properties PasswordLastSet,EmailAddress

foreach ($User in $AllUsers){


#If (($User).PasswordLastSet.AddDays($ExpPeriod).DayOfYear -eq $ExprDate1 -or ($User).PasswordLastSet.AddDays($ExpPeriod).DayOfYear -eq $ExprDate2 -or ($User).PasswordLastSet.AddDays($ExpPeriod).DayOfYear -eq $ExprDate3)
#{
#$MailSubject="Your Account Password Expires on"+" "+($User).PasswordLastSet.AddDays($ExpPeriod)
#$MailRecipient=$User.EmailAddress

#sendMail

Write-Output ''$User.EmailAddress'password last set '$User.PasswordLastSet'---------'  #| Out-File -FilePath $ReportFullPath -Append}

}


#End Script
#------------------------------------------------------------------