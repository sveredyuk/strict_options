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
  end

  context 'when all strict options are set' do
    let(:product) { ProductWithOptions.new("My Product",
                                  brand: "My brand",
                                    sku: "A1000",
                                  price: 100) }

    it { expect(product.full_name).to eq "My brand My Product (A1000)" }
    it { expect{product.full_name}.not_to raise_error }
    it { expect(product.dicounted_price).to eq 80.0 }
    it { expect{product.dicounted_price}.not_to raise_error }
  end

  context 'when some strict options are pass' do
    let(:product) { ProductWithOptions.new("My Product") }

    it { expect{product.full_name}.to raise_error(ArgumentError,
                                          "options :brand, :sku are missing") }
    it { expect{product.dicounted_price}.to raise_error(ArgumentError,
                                          "option :price is missing") }
  end
end
