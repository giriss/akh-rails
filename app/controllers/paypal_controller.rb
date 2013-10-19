class PaypalController < ApplicationController
  def masspay
    @api = PayPal::SDK::Merchant::API.new
    @mass_pay = @api.build_mass_pay({
      :ReceiverType => "EmailAddress",
      :MassPayItem => [{
        :ReceiverEmail => "akhile@dr.com",
        :Amount => {
          :currencyID => "USD",
          :value => "10.00" }
          }]
        })
    
    # Make API call & get response
    @mass_pay_response = @api.mass_pay(@mass_pay)
    
    # Access Response
    if @mass_pay_response.success?
      @ret = @mass_pay_response.Ack
    else
      @ret = @mass_pay_response.Errors
    end
    @ret = "Post to send money using PayPal! yeah I did it ;) !! ^_^<br />" + @ret
  end

  def expresscheckout
    @api = PayPal::SDK::Merchant::API.new

    # Build request object
    @set_express_checkout = @api.build_set_express_checkout({
      :SetExpressCheckoutRequestDetails => {
        :ReturnURL => "http://gagkas.tk/paypal/lesson10",
        :CancelURL => "http://gagkas.tk/paypal/lesson8",
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
