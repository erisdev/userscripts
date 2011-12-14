require 'coffee-script'
require 'rexml/document'

COFFEE_FILES = FileList['src/*.coffee']
JS_FILES     = COFFEE_FILES.pathmap '%{^src,bin}X.js'

task :default => :compile

desc "compile UserScripts"
task :compile => JS_FILES

desc "remove compiled files"
task :clean do
  js_files = JS_FILES.existing
  rm *js_files unless js_files.empty?
end

if RUBY_PLATFORM =~ /darwin/
  # I don't know how to do this on other platforms. Sorry, guys!
  # Just open the scripts in your favorite browser by hand.
  
  xml = REXML::Document.new(`defaults read com.apple.LaunchServices LSHandlers | plutil -convert xml1 -o - -`)
  browser = REXML::XPath.first(xml, '/plist/array/dict/key["LSHandlerURLScheme"][following-sibling::*[1]="http"]/../key["LSHandlerRoleAll"]/following-sibling::*[1]').text
  
  namespace :install do
    JS_FILES.each do |script|
      script_id = File.basename script, '.user.js'
      desc "install #{script_id}"
      task(script_id) { sh 'open', '-b', browser, script }
    end
  end
end

def Proc.pathmap spec
  proc { |file| file.pathmap spec }
end

class IO
  def peek
    ch = getc
    ungetc ch
    ch
  end
end

rule %r(\.user.js$) => Proc.pathmap('%{^bin,src}X.coffee') do |t|
  $stderr.puts "coffee -o #{File.dirname t.name} -c #{t.source}"
  
  File.open(t.source) do |src|
    File.open(t.name, 'w') do |out|
      puts src
      while src.peek == '#'
        # Write out comment header more-or-less verbatim.
        out.write src.readline.sub(/^#/, '//')
      end
      
      # Compile the rest.
      out.write CoffeeScript.compile(src, :filename => t.name, :bare => true)
    end
  end
end
