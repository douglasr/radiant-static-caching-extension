require File.expand_path(File.dirname(__FILE__) + '/../response_cache_config')

class Rack::ResponseCacheSweeper
  def initialize(app, cache_path)
    @app, @cache_path = app, cache_path
  end
  
  def call(env)
    unless ['GET', 'HEAD'].include? env['REQUEST_METHOD']
      in_ignore_prefix = false
      for prefix in ResponseCacheConfig.ignore_prefixes do
        if (env['REQUEST_URI'] =~ Regexp.new(prefix)) then
         in_ignore_prefix = true
         break
        end
      end
      if (!in_ignore_prefix) then
        CacheWriter.ensure_cache_dir
        FileUtils.rm_rf Dir.glob(File.join(@cache_path, '*'))
        %w(edit spider_attempt).each { |part| FileUtils.rm_rf File.join(@cache_path, ".last_#{part}") }
        FileUtils.touch File.join(@cache_path, '.last_edit')
      end
    end
    @app.call(env)
  end
  
end