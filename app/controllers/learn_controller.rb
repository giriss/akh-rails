class LearnController < ApplicationController
  require 'net/http'
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
      @name = params[:name]
       render text: @name
  end
  
  def lesson4
      uri = URI "http://akh-rails.herokuapp.com/learn/lesson3"
      res = Net::HTTP.post_form uri, :name => :Akhile
      render text: res.body
  end
  
  def lesson5
      @num = params[:num].to_f
      @power = params[:power].to_f
      @ret = @num ** @power
      render text: @ret
  end

end
