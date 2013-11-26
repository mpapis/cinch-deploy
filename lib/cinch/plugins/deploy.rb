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
            IO.popen("#{config[:command]} 2>&1") do |handle|
              while line = handle.gets
                # do not use ,true for nick, it breaks on split
                m.reply "#{m.user.nick}: #{config[:command]} > #{line}"
              end
            end
          end
        end
      rescue Exception => e
        m.reply "#{config[:command]} - exception: #{e.message}"
        puts e.backtrace
      ensure
        @running = nil
      end

    end
  end
end
