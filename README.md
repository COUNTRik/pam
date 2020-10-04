# pam

Запретим всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников.

Добавим в */etc/sesuruty/time.conf* строчку ``login;*;!root;Wd0000-2400``, которая запрещает логин в выходные, кроме пользователя root.

Добавим в */etc/pam.d/login* после строчки *account required pam_nologin.so* еще две строчки

``
account [default=ignore success=1] pam_succeed_if.so  user ingroup admin
``

``
account    required     pam_time.so
``
