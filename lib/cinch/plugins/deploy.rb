module Cinch
  module Plugins
    class Deploy
      include Cinch::Plugin

      def initialize(*args)
        super(*args)
        @running = {}
      end

      listen_to :message

      def listen(m)
        config[:configurations].each do |config|
          deploy(m) if can_deploy?(m)
        end
      rescue Exception => e
        m.reply "exception - #{e.message}", true
        exception(e)
      end

    private

      def can_deploy?(m)
        config[:channels].include?(m.channel.to_s) &&
        config[:users].include?(m.user.nick) &&
        m.message =~ Regexp.new(config[:trigger])
      end

      def deploy(m)
        return if @running[command]
        @running[command] = true
        IO.popen("#{command} 2>&1") do |handle|
          while line = handle.gets
            m.reply "#{command} > #{line}", true
          end
        end
      ensure
        @running.delete(command)
      end

      def command
        config[:command]
      end

    end
  end
end
