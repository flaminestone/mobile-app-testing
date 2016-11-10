
class AppRequests
  APP = {:google_play => {:command => 'com.android.vending/com.google.android.finsky.activities.MainActivity', :package => 'none'},
         :app_install => {:command => 'android.intent.action.VIEW -d', :package => 'none'},
         :onlyoffice => {:command => 'com.onlyoffice.documents/.activities.MainActivity', :package => 'com.onlyoffice.documents'}}
end