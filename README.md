# StrictOptions

## Description

Allow you define strict attributes for options hash.

Common practice in Ruby OOP are something like this:

```ruby
  class MyBestClass
    def initialize(name, data, options = {})
      @name    = name
      @data    = data
      @options = options
    end

    def some_method
      raise ArgumentError, "No user set" unless options[:user]
      raise ArgumentError, "No blah set" unless options[:blah]

      # ... do something if user & blah was set
    end
  end
```

If you want some short method that allow raise `ArgumentError` (or some other Error) for all strict options you can use `strict_options!` method.

## Installation & Setup

Gemfile:
```ruby
gem 'strict_options'
```
and run `bundle` in console

or for plain ruby-program:

```ruby
gem install strict_options
```
and in rubyfile:

```ruby
require 'strict_options'
```

## Example

```ruby
require 'strict_options'

class Product
  include StrictOptions

  def initialize(name, options = {})
    @name    = name
    @options = options
    @sku     = options.fetch(:sku,   nil)
    @price   = options.fetch(:price, nil)
    @brand   = options.fetch(:brand, nil)
  end

  def full_name
    strict_options!(:brand, :sku)
    "#{@brand} #{@name} (#{@sku})"
  end

  def dicounted_price
    strict_options!(:price)
    @price * 0.8
  end
end

```
And now you will control options attributes:

```ruby
p = Product.new("iPhone")
p.full_name #=> options :brand, :sku are missing (ArgumentError)
p.discounted_price #=> option :price is missing (ArgumentError)
```
and don't miss any attributes
```ruby
p = Product.new("iPhone", brand: "Apple", sku: "iphone_6s_16gb", price: 649)
puts p.full_name #=> Apple iPhone (iphone_6s_16gb)
puts p.discounted_price #=> 519.2
```

>Hold your hand at API pulse*

## TODO
* Some improvements ? =)
