#coding: utf-8

import smtplib
import commands

aux = commands.getoutput("git show --summary")
du = commands.getoutput('du -sh')

body = aux + '\n Tamanho do backup: ' + du


def enviar(remetente, para, mensagem, usuario, senha):
    header = 'De: ' + remetente + '\n' + 'Para: ' + \
        para + '\n' + 'Subject: Notificação de backup \n'
    msg = header + mensagem
    server = smtplib.SMTP_SSL('email-ssl.com.br:465')
    #server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    # server.starttls()
    server.ehlo()
    server.login(usuario, senha)
    server.sendmail(remetente, para, msg)
    server.quit()
    return True


enviou = enviar('no-reply@email.com.br', 'contato@email.com.br',
                body, 'no-reply@email.com.br', 'awesomepassword')

if enviou:
    print('E-mail enviado')
else:
    print('O e-mail não foi enviado')
