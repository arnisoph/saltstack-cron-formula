cron:
  lookup:
    jobs:
      duply_etc_backup:
        cmd: duply myprofile full
        minute: random
        hour: 22
