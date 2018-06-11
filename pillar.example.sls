cron:
  lookup:
    jobs:
      duply_etc_backup:
        cmd: duply myprofile full
        minute: random
        hour: 22
        daymonth: '*'
      daily_cron:
        cmd: echo 'hello world daily'
        special: '@daily'
      on_reboot_cron:
        cmd: echo 'execute a cron on reboot'
        special: '@reboot'
    envs:
      MAILTO:
        present: True
        value: ""
      MAILTO-for-other-user:
        name: MAILTO
        present: True
        value: ""
        user: 'www'
      PATH:
        present: True
        value: /sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/CUSTOM_PATH
      ABSENT_VARIABLE:
        present: False
        value: super_secret_value
