source "https://rubygems.org"

gem "jekyll", "~> 4.2", ">= 4.2.0"
gem "webrick", "~> 1.7"

# Warning - in the start of 2020, Font Awesome was replaced, so from 0.9.0
# onwards the `fa` icons won't work.
# https://github.com/jekyll-octopod/jekyll-bulma/commits/master .
gem "jekyll-bulma", "0.8.1"

group :jekyll_plugins do
  gem "jekyll-github-metadata", "~> 2.13", ">= 2.13.0"
  gem "jekyll-sitemap", "~> 1.4", ">= 1.4.0"
  gem "jekyll-seo-tag", "~> 2.7", ">= 2.7.1"

  gem "jemoji", "~> 0.12", ">= 0.12.0"

  gem "faraday", "~> 1.3"
  gem "jekyll-timeago", "~> 0.13"
end

gem "rufo", "~> 0.12.0", :group => :development

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data
# gem and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
