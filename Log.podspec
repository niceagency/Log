Pod::Spec.new do |spec|
  spec.name = "Log"
  spec.version = "1.0.0"
  spec.summary = "Simple logging framework for swift, including levels and extensible domains."
  spec.homepage = "https://github.com/niceagency/log"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Wain" => 'wain@nice.agency' }
  spec.social_media_url = "https://twitter.com/niceagency"

  spec.platform = :ios, "8.0"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/niceagency/log.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "Log/**/*.{h,swift}"
end