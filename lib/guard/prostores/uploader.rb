require 'httpclient'
module Guard
    class ProStores < Guard
        class Uploader < HTTPClient
            def push(path, options)
                status = post("https://store01.prostores.com/servlet/wholesomebookswholesale/Admin/AdminTimeoutLogon?name=#{options[:user]}&password=#{options[:pass]}&jsenabled=true") unless cookies.join.include?('ps_auth')
                return false unless status.body.include?('SUCCESS')
                templateFile = open(path)
                post('https://store01.prostores.com/servlet/wholesomebookswholesale/Admin/TemplateEditSource',
                          {
                           :tpl => path.split('.')[0],
                           :templateseturl => options[:templateUrl],
                           :confirmed => 'false',
                           :promptSave => 'false',
                           :promptPublish => 'true',
                           :promptUndo => 'false',
                           :tsource => templateFile.read
                          })
                templateFile.close
                return true
            end
        end
    end
end