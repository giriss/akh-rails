class PaypalController < ApplicationController
  def masspay
  end

  def expresscheckout
=begin
    PayPal::SDK.configure(
      :mode      => "sandbox",  # Set "live" for production
      :username  => "akhil05_api1.mail.com",
      :password  => "1381743824",
      :signature => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr"
    )
=end
=begin
    @data = {
      :METHOD => "setExpressCheckout",
      :VERSION => "90",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :PAYMENTREQUEST_0_AMT => "10",
      :PAYMENTREQUEST_0_CURRENCYCODE => "USD",
      :PAYMENTREQUEST_0_PAYMENTACTION => "SALE",
      :returnUrl => "http://gagkas.tk/learn/lesson10",
      :cancelUrl => "http://gagkas.tk/learn/lesson8"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
    @token = @req.body.split('TOKEN=')[1].split('&')[0]
=end
    @api = PayPal::SDK::Merchant::API.new

# Build request object
  @set_express_checkout = @api.build_set_express_checkout({
  :SetExpressCheckoutRequestDetails => {
    :ReturnURL => "http://gagkas.tk/learn/lesson10",
    :CancelURL => "http://gagkas.tk/learn/lesson8",
    :PaymentDetails => [{
      :OrderTotal => {
        :currencyID => "USD",
        :value => "12.0" },
      :ItemTotal => {
        :currencyID => "USD",
        :value => "12" },
      :NotifyURL => "https://paypal-sdk-samples.herokuapp.com/merchant/ipn_notify",
      :PaymentDetailsItem => [{
        :Name => "Deposit dollar",
        :Quantity => 1,
        :Amount => {
          :currencyID => "USD",
          :value => "12" },
        :ItemCategory => "Digital" }],
      :PaymentAction => "Sale" }] } })

  # Make API call & get response
  @set_express_checkout_response = @api.set_express_checkout(@set_express_checkout)

  # Access Response
  if @set_express_checkout_response.success?
    @token = @set_express_checkout_response.Token
  else
    @errors = @set_express_checkout_response.Errors
  end
    redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{@token}"
  end
end
