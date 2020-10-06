# pam

Запретим всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников.

Добавим в */etc/sesuruty/time.conf* строчку ``login;*;!root;!Wd0000-2400``, которая запрещает логин в выходные, кроме пользователя root.

Добавим в */etc/pam.d/login* после строчки *account required pam_nologin.so* еще две строчки:

Эта строчка указывает тип*account* (контроль ресурсов), *[default=ignore success=1]* флаг контроля где при успешном срабатывании модуля происходит переход через одно правило (success=1), в остальных срабавтываниях игнорируется (default=ignore), *pam_succeed_if.so  user ingroup admin* условие срабатывания, pam_succeed_if.so - успешное срабатывание если - user ingroup admin - пользователь состоит в группе admin.

``
account [default=ignore success=1] pam_succeed_if.so  user ingroup admin
``


Эта строчка, которая идет сразу после предыдущей, ограничивает пользователей по времени, параметры которой задаются в файле /etc/security/time.conf

``
account    required     pam_time.so
``


В папке *scripts* приведен пример скрипта с комментариями.