module Account::RegistrationsHelper
  def captcha_options
    {
      :theme => "white",
      :lang => "vi",
      :custom_translations => {
        :instructions_visual => t('captcha.instructions_visual'),
        #:instructions_audio => "Trascrivi ci\u00f2 che senti:",
        #:play_again => "Riascolta la traccia audio",
        #:cant_hear_this => "Scarica la traccia in formato MP3",
        #:visual_challenge => "Modalit\u00e0 visiva",
        #:audio_challenge => "Modalit\u00e0 auditiva",
        :refresh_btn => t('captcha.refresh_btn'),
        #:help_btn => "Aiuto",
        #:incorrect_try_again => "Scorretto. Riprova.",
      }
    }
  end
end
