cron:
  lookup:
    jobs:
      duply_etc_backup:
        cmd: duply myprofile full
        minute: random
        hour: 22
        daymonth: '*'
    envs:
      MAILTO:
        present: True
        value: ""
      PATH:
        present: True
        value: /sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/CUSTOM_PATH
      ABSENT_VARIABLE:
        present: False
        value: super_secret_value
