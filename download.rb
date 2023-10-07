require 'tmpdir'
require './constants'

Dir.mktmpdir do |tmpdir| 
  list_path = "#{tmpdir}/#{LIST_FN}"
  system <<-EOS
curl -o #{list_path} #{LIST_URL}
  EOS
  File.foreach(list_path) {|l|
    url = l.strip
    fn = url.split('/')[-1]
    system <<-EOS
curl -o #{SRC_DIR}/#{fn} #{url}
    EOS
  }
end

