
::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = 'F6wRC69O02zEWCGh45bSoHFnGWKNKFmm5hwld65B'
  config.qiniu_secret_key    = '8fg8H0OeVUhvZZPiFAAD94IkC833cde7ODpLZg20'
  config.qiniu_bucket        = 'inimei'
  config.qiniu_bucket_domain = 'nzli9q6s5.qnssl.com'
  #config.qiniu_bucket_private= false #default is false
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = 'https'

  config.qiniu_up_host       = 'http://up.qiniug.com' #七牛上传海外服务器,国内使用可以不要这行配置
end
