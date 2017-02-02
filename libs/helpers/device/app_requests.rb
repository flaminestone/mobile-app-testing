
class AppRequests
  APP = { google_play: { command: 'com.android.vending/com.google.android.finsky.activities.MainActivity', package: 'none' },
          app_install: { command: 'android.intent.action.VIEW -d', package: 'none' },
          onlyoffice: { command: 'com.onlyoffice.documents/.activities.MainActivity', package: 'com.onlyoffice.documents' },
          google_chrome: {command:'com.android.chrome/com.google.android.apps.chrome.Main'}}.freeze

  ONLYOFFICE_PAGES_ACTIVITY = { main_page: 'com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity',
                    login_page: 'com.onlyoffice.documents/com.onlyoffice.documents.activities.LoginActivity',
                    doc_viewer: 'com.onlyoffice.documents/com.onlyoffice.documents.activities.DocViewerActivity' }.freeze
end
