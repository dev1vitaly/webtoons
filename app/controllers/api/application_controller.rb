class Api::ApplicationController < ActionController::API
  include SetLocale
  include SetCurrentContentLanguages
  include SetCurrentContentLanguage
  include SetCurrentInterfaceLanguage
end