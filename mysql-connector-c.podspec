Pod::Spec.new do |s|
  s.name         = "mysql-connector-c"
  s.version      = "1.0.0"
  s.summary      = "A MySQL library that works on iOS and Mac."

  s.description  = <<-DESC
                   This is a static library for connecting to MySQL databases natively using C.

                   I found it difficult to find a current MySQL database adapter. Most either didn't
                   support iOS, or only supported old architectures. This library supports
                   i386, x86_64, armv7, armv7s, and arm64.
                   DESC

  s.homepage     = "https://github.com/ketzusaka/mysql-connector-c"
  s.license      = "MIT"
  s.author             = { "James Richard" => "ketzu@me.com" }
  s.social_media_url   = "http://twitter.com/ketzusaka"
  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"
  s.source       = { :git => "https://github.com/ketzusaka/mysql-connector-c.git", :tag => "1.0.0" }
  s.source_files  = "Sources/include/**/*.{h}"
  s.vendored_libraries = "Sources/libmysqlclient.a"
  s.library   = "c++"
end
