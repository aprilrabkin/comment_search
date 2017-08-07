#!/usr/bin/env ruby

require './app'
require 'minitest/autorun'
require 'rack/test'
require 'mocha/mini_test'

module HelpersTest < Minitest::Test
  def app
    Sinatra::Application
  end

  def test_add_articles
    # TODO
  end

end