class LearnController < ApplicationController
  
  require 'net/http'
  require 'net/https'
  
  skip_before_action :verify_authenticity_token, only: [:lesson3]
  def lesson1
        source = <<-EOS
            SyntaxError in WelcomeController#lesson1
            
            /var/lib/stickshift/52481c5f5973cac82a000106/app-root/data/629255/app/controllers/welcome_controller.rb:9: invalid multibyte char (US-ASCII)
            /var/lib/stickshift/52481c5f5973cac82a000106/app-root/data/629255/app/controllers/welcome_controller.rb:6: syntax error, unexpected $end, expecting tSTRING_CONTENT or tSTRING_DBEG or tSTRING_DVAR or tSTRING_END
            Rails.root: /var/lib/stickshift/52481c5f5973cac82a000106/app-root/data/629255
            
            Application Trace | Framework Trace | Full Trace
            Request
            
            Parameters:
            
            None
            Show session dump
            
            Show env dump
            
            Response
            
            Headers:
            
            None
        EOS
        
        comp_data = Zlib::Deflate.deflate source, 9 # QuickLZ::compress source
        decomp_data = Zlib::Inflate.inflate comp_data # QuickLZ::decompress comp_data
        @return = <<-EOS
            - block compress -<br />
            uncompress size: #{source.length}<br />
            compress size: #{comp_data.length}<br />
            decompress size: #{decomp_data.length}<br />
            compression ratio: #{source.length.to_f/comp_data.length.to_f}
        EOS
        
        @style = %Q{
            <head>
                <link href='http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700,300italic,400italic,500italic,700italic|Kite+One' rel='stylesheet' type='text/css'>
                <style type="text/css">
                    body{
                        font-family: "Kite One";
                    }
                </style>
                <body>
            </head>
        }
        
        render text: @style + @return + "</body>"
  end

  def lesson2
        xml_string = <<-EOXML
            <root title="Akhil learn">
            <sitcoms>
            <sitcom>
              <name>Married with Children</name>
              <characters>
                <character>Al Bundy</character>
                <character>Bud Bundy</character>
                <character>Marcy Darcy</character>
              </characters>
            </sitcom>
            <sitcom>
              <name>Perfect Strangers</name>
              <characters>
                <character>Larry Appleton</character>
                <character>Balki Bartokomous</character>
              </characters>
            </sitcom>
            </sitcoms>
            <dramas>
            <drama>
              <name>The A-Team</name>
              <characters>
                <character>John "Hannibal" Smith</character>
                <character>Templeton "Face" Peck</character>
                <character>"B.A." Baracus</character>
                <character>"Howling Mad" Murdock</character>
              </characters>
            </drama>
            </dramas>
            </root>
        EOXML
        
        @doc = Nokogiri::XML xml_string
        # the following line
        # is same as 
        # @doc.at_css("root").attribute("root")
        @t = @doc.at_css("root")["title"].to_s
        @x = Array.new
        @doc.css("character").each do |node|
          @x << "<li>" + node.text + "</li>"
        end
        
        @style = %Q{
            <head>
                <link href='http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700,300italic,400italic,500italic,700italic|Kite+One' rel='stylesheet' type='text/css'>
                <style type="text/css">
                    body{
                        font-family: "Kite One";
                    }
                </style>
                <body>
            </head>
        }
        
        render text: @style + "<h1>" + @t + "</h1>" + @x.join + "</body>"
  end

  def lesson3
    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    render text: @name
  end
  
  def lesson4

    if params[:name] then
      @name = params[:name]
    else
      @name = 'default'
    end
    uri = URI "http://hselihka.tk/learn/lesson3"
    res = Net::HTTP.post_form uri, :name => @name
    render text: res.body
  end
  
  def lesson5
      @num = params[:num].to_f
      @power = params[:power].to_f
      @ret = @num ** @power
      render text: @ret
  end
  
  def lesson6
    # POST a send money using Payza api (Testmode=TRUE)
    @data = {
      :USER => "akhil05@mail.com",
      :PASSWORD => "vaHYkV4Mkwqv8dzF",
      :AMOUNT => "25",
      :CURRENCY => "USD",
      :RECEIVEREMAIL => "client_1_akhil05@mail.com",
      :SENDEREMAIL => "akhil05@mail.com",
      :PURCHASETYPE => "1",
      :NOTE => "This is a test transaction.",
      :TESTMODE => "1"
    }
    @url = "https://api.payza.com/svc/api.svc/sendmoney"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @ret = "Post to send money using payza (Test mode), pretty c0ol huh !?!<br />" + @req.body
    render text: @ret
  end
  
  def lesson7
    @data = {
      :METHOD => "MassPay",
      :VERSION => "90",
      :EMAILSUBJECT => "C0ol !! Aint' it, you have just received your payments from sum.mn ! :*",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :RECEIVERTYPE => "EmailAddress",
      :CURRENCYCODE => "USD",
      :L_EMAIL0 => "akhile@dr.com",
      :L_AMT0 => "10",
      :L_NOTE0 => "Keep up the good work. Eny0yZz !! ;)"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @ret = "Post to send money using PayPal! yeah I did it ;) !! ^_^<br />" + @req.body
    render text: @ret
  end
  
  def lesson8
    
  end
  
  def lesson9
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
      :cancelUrl => "http://fb.com"
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
#=begin
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
#=end
#   @req = Net::HTTP.post_form @uri, @data
    @token = @req.body.split('=')[1].split('&')[0]
    redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#{@token}"
  end
  
  def lesson10
    @token = params[:token]
    @data = {
      :METHOD => "GetExpressCheckoutDetails",
      :VERSION => "90",
      :USER => "akhil05_api1.mail.com",
      :PWD => "1381743824",
      :SIGNATURE => "AP8wAEeWcdquPOE6hUJmW1U9KBctAiUTu.2IbHJTknQnojFEGJvXtVHr",
      :TOKEN => @token
    }
    @url = "https://api-3t.sandbox.paypal.com/nvp"
    @uri = URI @url
    @uri = URI.parse @url
    @https = Net::HTTP.new @uri.host, @uri.port
    @https.use_ssl = true
    @post = Net::HTTP::Post.new @uri.path
    @post.set_form_data @data
    @req = @https.start {|https| https.request @post}
    @payerid = @req.body.split("PAYERID=")[1].split("&")[0]
    
  end

end
