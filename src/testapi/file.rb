require "digest"

module FileAPI
  def self.md5(path)
      Digest::MD5.hexdigest(File.read(path))
  end
end
