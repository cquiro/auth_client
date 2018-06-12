class ImageService
  def initialize(uploaded_image)
    @uploaded_image = uploaded_image
  end

  def to_base64
    Base64.strict_encode64(image)
  end

  private

  attr_reader :uploaded_image

  def image
    File.read(uploaded_image.tempfile)
  end
end
