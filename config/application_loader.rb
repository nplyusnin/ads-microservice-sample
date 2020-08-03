# frozen_string_literal: true

module ApplicationLoader
  extend self

  def load_app!
    require_app
  end

  private

  def require_app
    require_file 'config/application.rb'
  end

  def require_file(path)
    require File.join(root, path)
  end

  def require_dir(path)
    require File.join(root, path)
    Dir["#{path}/**/*.rb"].sort.each { |file| require file }
  end

  def root
    File.expand_path('..', __dir__)
  end
end
