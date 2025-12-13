package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.AmazonSNSClientBuilder;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;

public class HelloWorldHandler implements RequestHandler<String, String> {

    // ARN do tópico SNS
    private static final String TOPIC_ARN = System.getenv("SNS_TOPIC_ARN");

    private final AmazonSNS snsClient = AmazonSNSClientBuilder.defaultClient();

    @Override
    public String handleRequest(String input, Context context) {

        context.getLogger().log("Recebido: " + input);

        PublishRequest publishRequest = new PublishRequest()
                .withTopicArn(TOPIC_ARN)
                .withMessage(input)
                .withSubject("Mensagem da Lambda");

        PublishResult result = snsClient.publish(publishRequest);

        context.getLogger().log("Mensagem enviada. MessageId: " + result.getMessageId());

        return "Mensagem enviada para o SNS com sucesso!";
    }
}
