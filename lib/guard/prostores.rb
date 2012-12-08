require 'guard'
require 'guard/guard'
require 'guard/prostores/uploader'
require 'guard/prostores/ftptls'
module Guard
    class ProStores < Guard
        def notify(msg, img)
            ::Guard::Notifier.notify(msg, {:title => "Guard::Prostores", :img => img})
        end
        def initialize(watchers = [], options = {})
            super
            @options = options
        end
        def start
            @postTemplate = Uploader.new
        end
        def run_on_changes(paths)
            UI.debug paths
            paths.each do |path|
                if path.end_with?('.tpl')
                    exitstatus  = @postTemplate.push(path, @options)
                    if exitstatus == true
                        notify("Posted #{path}", :success)
                    else
                        notify("Failed to upload #{path}", :failed)
                    end
                elsif path.end_with?('.js') || path.end_with?('.css')
                    ftp = Net::FTPTLS.new
                    ftp.connect('myftp.prostores.com')
                    ftp.login(@options[:user], @options[:pass])
                    ftp.passive=true
                    ftp.put(path, "store/#{path}")
                    notify("Uploaded #{path}", :success)
                    ftp.close()
                end
            end
        end
    end
end
