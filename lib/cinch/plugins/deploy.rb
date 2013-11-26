module Cinch
  module Plugins
    class Deploy
      include Cinch::Plugin

      listen_to :message

      def listen(m)
        return if @running
        @running = true
        config[:configurations].each do |config|
          if config[:channels].include?(m.channel.to_s) and config[:users].include?(m.user.nick) and m.message =~ Regexp.new(config[:trigger])
            IO.popen("config[:command] 2>&1") do |handle|
              while line = handle.gets
                m.reply line, true
              end
            end
          else
            m.reply "ch:#{m.channel.to_s} usr:#{m.user.nick} msg:#{m.message}", true
          end
        end
      rescue Exception => e
        m.reply "exception: #{e.message}"
      ensure
        @running = nil
      end

    end
  end
end
