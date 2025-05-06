class PictureMailer < ApplicationMailer
  default from: 'strokinmyshii@mail.com'

  def all_pictures_csv
    csv_data = Picture.to_csv
    attachments["pictures-#{Date.today}"] = {
      mime_type: "text/csv; charset=utf-8",
      content: csv_data
    }

    recipients = ['stevendawn98@gmail.com']

    mail(to: recipients, subject: "Your pictures CSV export")
  end
end
