# a copy of ruby 1.8 ftptls

require 'socket'
require 'openssl'
require 'net/ftp'

module Net
  class FTPTLS < FTP
    def connect(host, port=FTP_PORT)
      @hostname = host
      super
    end

    def login(user = "anonymous", passwd = nil, acct = nil)
       store = OpenSSL::X509::Store.new
       store.set_default_paths
       ctx = OpenSSL::SSL::SSLContext.new('SSLv23')
       ctx.cert_store = store
       ctx.verify_mode = OpenSSL::SSL::VERIFY_PEER
       ctx.key = nil
       ctx.cert = nil
       voidcmd("AUTH TLS")
       @sock = OpenSSL::SSL::SSLSocket.new(@sock, ctx)
       @sock.connect
       @sock.post_connection_check(@hostname)
       super(user, passwd, acct)
       voidcmd("PBSZ 0")
    end
  end
end