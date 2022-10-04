class Uploder < ApplicationRecord
  require 'net/http'
  include Rails.application.routes.url_helpers

    has_many_attached :files

    validate :correct_file_type
    
    def combine_pdf
      pdf = CombinePDF.new
      files.attachments.each do |attachment|
        debugger
        key = attachment.key
        path = ActiveStorage::Blob.service.send(:path_for, key)
        pdf << CombinePDF.load(path)
        # pdf << CombinePDF.parse(Net::HTTP.get_response(URI.parse(attachment.url)).body)
        # pdf << CombinePDF.load(attachment)
      end
      pdf.save "combined.pdf"
    end

  private
  

  # def correct_file_type
  #   debugger
  #   if self.files.attached? && !self.content_type.in?(%w(application/pdf))
  #     uploder.purge
  #     errors.add(:files, 'Must be a PDF file')
  #   end
  # end

  def correct_file_type
    files.blobs.each do |file|
      if files.attached? && !file.content_type.in?(%w(application/pdf))
        raise ActiveRecord::Rollback
        errors.add(:files, 'Must be a PDF file')
      end
    end
  end
end
