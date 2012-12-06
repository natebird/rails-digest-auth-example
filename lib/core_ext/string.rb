require 'digest/sha1'
require 'digest/md5'
require 'zlib'

class String
  def to_sha1
    Digest::SHA1.hexdigest self
  end

  def to_md5
    Digest::MD5.hexdigest self
  end

  def gzip
    # Zlib::Deflate.deflate(self)

    io = StringIO.new
    gz = Zlib::GzipWriter.new(io)
    gz.write(self)
    gz.close
    io.string
  end

  def gzip!
    replace gzip
  end

  def gunzip
  #   Zlib::Inflate.inflate(self)
  # rescue Zlib::DataError
  #   self

    Zlib::GzipReader.new(StringIO.new(self)).read
  rescue Zlib::GzipFile::Error
    self
  end

  def gunzip!
    replace gunzip
  end
end