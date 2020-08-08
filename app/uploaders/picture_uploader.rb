class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 画像が未設定の時にデフォルトで設定する画像のURL
  def default_url(*args)
    "/images/" + [version_name, "default.png"].compact.join('_')
  end

  # 画像サイズ設定
  # 詳細表示用：400 * 400の正方形に整形
  version :thumb400 do
    process resize_and_pad(400, 400, background = :transparent, gravity = 'Center')
  end

  # 一覧表示用：200 * 200の正方形に中央から切り抜き
  version :thumb200 do
    process resize_to_fill: [200, 200, "Center"]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
