require 'httpclient'
module Guard
  class ProStores < Guard
    class Uploader < HTTPClient
      def push(path, options)
        status = post('https://mystore.prostores.com/CP/submit/',
              action: 'login',
              username: options[:user],
              password: options[:pass],
              submit: 'Sign In')
        if status.header['location'][0] =~ /let\/(.+)\/Admin/ #grab the store name from the redirect
          storename = $1
        else
          return false
        end
        templateFile = open(path)
        post('https://store01.prostores.com/servlet/#{storename}/Admin/TemplateEditSource',
              :tpl => path.split('.')[0],
              :templateseturl => options[:templateUrl],
              :confirmed => 'false',
              :promptSave => 'false',
              :promptPublish => 'true',
              :promptUndo => 'false',
              :tsource => templateFile.read
            )
        templateFile.close
        return true
      end
    end
  end
end