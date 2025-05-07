class PictureMailer < ApplicationMailer
  default from: 'stevendawn98@gmail.com'

  def all_pictures_csv
    attachments["pictures-#{Date.today}.csv"] = {
      mime_type: 'text/csv; charset=utf-8',
      content:    Picture.to_csv
    }

   mail(
    to: ['stevendawn98@gmail.com'],
    subject: 'Your pictures CSV Export'
   )
  end
end
