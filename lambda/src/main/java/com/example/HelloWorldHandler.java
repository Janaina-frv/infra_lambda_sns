package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SQSEvent;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.AmazonSNSClientBuilder;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;

public class HelloWorldHandler implements RequestHandler<SQSEvent, String> {

    private static final String TOPIC_ARN = System.getenv("SNS_TOPIC_ARN");
    private final AmazonSNS snsClient = AmazonSNSClientBuilder.defaultClient();

    @Override
    public String handleRequest(SQSEvent event, Context context) {
        for (SQSEvent.SQSMessage msg : event.getRecords()) {
            context.getLogger().log("Recebido: " + msg.getBody());

            PublishRequest publishRequest = new PublishRequest()
                    .withTopicArn(TOPIC_ARN)
                    .withMessage(msg.getBody())
                    .withSubject("Mensagem da Lambda");

            try {
                PublishResult result = snsClient.publish(publishRequest);
                context.getLogger().log("Mensagem enviada. MessageId: " + result.getMessageId());
            } catch (Exception e) {
                context.getLogger().log("Erro ao enviar mensagem: " + e.getMessage());
            }
        }
        return "Mensagens processadas!";
    }
}
