<?php

$message = $argv[1] ?? 'No message';
file_put_contents('/pingwatch/sms_log.txt', date('Y-m-d H:i:s') . " - $message\n", FILE_APPEND);

// Call your API to send alert
