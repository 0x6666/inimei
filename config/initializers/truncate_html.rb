TruncateHtml.configure do |config|
  config.length        = 100
  config.omission      = '...(continued)'
  config.word_boundary = false
end