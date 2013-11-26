# Cinch deploy plugin

A Cinch plugin to start deploy process via irc messages.

## Configuration

with `smfbot`:

    plugins:
      "Cinch::Plugins::Deploy":
        :configurations:
          - :users:
              - me
            :channels:
              - '#my-app'
            :trigger: 'deploy-my-app'
            :command: './deploy-my-app.sh'
