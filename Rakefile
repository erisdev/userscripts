require 'coffee-script'

COFFEE_FILES = FileList['src/*.coffee']
JS_FILES     = COFFEE_FILES.pathmap '%{^src,bin}X.js'

task :default => :compile

task :compile => JS_FILES

task :clean do
  js_files = JS_FILES.existing
  rm *js_files unless js_files.empty?
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

