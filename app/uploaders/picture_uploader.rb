# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :qiniu
  # storage :fog

  # 指定预转数据处理命令
  # https://github.com/qiniu/ruby-sdk/issues/48
  # http://docs.qiniu.com/api/put.html#uploadToken
  # http://docs.qiniutek.com/v3/api/io/#uploadToken-asyncOps
  # http://developer.qiniu.com/docs/v6/api/reference/security/put-policy.html#put-policy-persistent-ops-explanation
  def qiniu_async_ops
    commands = []
    %W(small little middle large).each do |style|
      commands << "http://#{self.qiniu_bucket_domain}/#{self.store_dir}/#{self.filename}/#{style}"
    end
    commands
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.production?
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  process resize_to_limit: [400, 400]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "picture.#{file.extension}" if original_filename.present?
  end

end
