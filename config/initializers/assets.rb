# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

NEED_TO_COMPILE_STYLESHEET_EXT = %w(.css .scss .sass .coffee .erb .js)

def find_asset(dir, source, kind)
  assets = []

  Dir["#{dir}/*"].each do | path |

    if File.directory? path
      assets +=  find_asset( path, source, kind)
      next
    end

    ext = File.extname(path)
    path = path[0..-ext.length-1] if NEED_TO_COMPILE_STYLESHEET_EXT.include? ext

    assets << Pathname.new(path).relative_path_from(Rails.root.join("#{source}/assets/#{kind}")).to_s
  end
  assets
end

def precompile_assets
  assets = []

  %w(app vendor).each do |source|
    %w(images javascripts stylesheets).each do |kind|
      Dir[Rails.root.join("#{source}/assets/#{kind}/*")].each do |path|
        if File.directory? path
          assets += find_asset(path, source, kind)
        end
      end
    end
  end
  assets
end

Rails.application.config.assets.precompile += precompile_assets
