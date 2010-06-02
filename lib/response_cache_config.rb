class ResponseCacheConfig
  cattr_accessor :cache_dir, :ignore_prefixes
  @@cache_dir = defined?(STATIC_CACHE_DIR) ? STATIC_CACHE_DIR : "#{RAILS_ROOT}/public/radiant-cache"
  @@ignore_prefixes = defined?(IGNORE_PREFIXES) ? IGNORE_PREFIXES : []
end