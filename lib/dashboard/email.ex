defmodule Dashboard.Email do
    import Bamboo.Email

    alias Dashboard.Helper

    def sensor_alert_email(sensor_name, sensor_value, role, complemento) do
        new_email(
            from: "system@iot.com",
            to: Helper.get_user_by_id(role),
            subject: "Alerta de Sensor",
            text_body: "Saudações,\n Você esta recebendo este email pois o sensor "<>sensor_name<>" alacançou o valor de "<>sensor_value<>" "<>complemento<>".\nAtt,\nO Sistema"
        )
    end

    def recovery_email(email) do

        new_email(
            from: "system@iot.com",
            to: Helper.user_by_role(-1),
            subject: "Recuperação de Senha",
            text_body: "Saudações,\n O usuario de email :"<>email<>" requisitou a troca de sua senha.\nAtt,\nO Sistema"
        )
    end

    

end