OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if !defined?(OpenSSL::SSL::VERIFY_PEER)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo,  R::WEIBO_KEY, R::WEIBO_SECRET
  provider :github, R::GITHUB_KEY, R::GITHUB_SECRET
end

