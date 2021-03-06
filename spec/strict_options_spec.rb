class BaseProduct
  include StrictOptions

  def initialize(name, options = {})
    @name    = name
    @options = options
    @sku     = options.fetch(:sku,    nil)
    @price   = options.fetch(:price,  nil)
    @brand   = options.fetch(:brand,  nil)
  end
end

describe 'StrictOptions' do
  before do
    class ProductWithOptions < BaseProduct
      def full_name
        strict_options!(:brand, :sku)
        "#{@brand} #{@name} (#{@sku})"
      end

      def dicounted_price
        strict_options!(:price)
        @price * 0.8
      end
    end

    class PriceError < StandardError
    end

    class SaleProduct < ProductWithOptions
      def sale_price
        strict_options!(:price, exception_class: PriceError)
        @price * 0.8
      end

      def original_price
        strict_options!(:price, exception_class: PriceError,
                            exception_message: "No price!")
        @price * 0.8
      end

      def double_price
        strict_options!(:price, break_by: :return)

        @price * 2
      end
    end
  end

  context 'all strict options are set' do
    let(:product) { ProductWithOptions.new("My Product",
                                  brand: "My brand",
                                    sku: "A1000",
                                  price: 100) }

    it { expect(product.full_name).to eq "My brand My Product (A1000)" }
    it { expect{product.full_name}.not_to raise_error }
    it { expect(product.dicounted_price).to eq 80.0 }
    it { expect{product.dicounted_price}.not_to raise_error }
  end

  context 'some strict options are pass' do
    let(:product) { ProductWithOptions.new("My Product") }

    it { expect{product.full_name}.to raise_error(ArgumentError,
                                          "options :brand, :sku are missing") }
    it { expect{product.dicounted_price}.to raise_error(ArgumentError,
                                          "option :price is missing") }
  end

  context 'custom exception_class set' do
    let(:product) { SaleProduct.new("My Product") }

    it { expect{product.sale_price}.to raise_error(PriceError,
                                                    "option :price is missing") }
  end

  context 'custom error_message set' do
    let(:product) { SaleProduct.new("My Product") }

    it { expect{product.original_price}.to raise_error(PriceError, "No price!") }
  end
end
