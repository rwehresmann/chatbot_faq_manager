[![Build Status](https://travis-ci.org/rwehresmann/chatbot_faq_manager.svg?branch=master)](https://travis-ci.org/rwehresmann/chatbot_faq_manager)

# Chatbot FAQ Manager

This chatbot use the [API.ai](https://api.ai/) service, and was builded to be integrated with [Slack](https://slack.com/). Its main functionality is to **manage** the **FAQ** of a team, and also can be used as a **link agregator**. Currently, whit this bot you can:

  * Create a question-answer associated to tags as a record of your FAQ;
  * Remove questions/answers from your FAQ;
  * Perform searches by tag, content or just list all your FAQ records;
  * The same above but for links in the link agregator.

## Dependencies

This app is docker based. To avoid extra configurations, you should have `docker` and `docker-compose` installed. 

If you don't whant to install these softwares, you will be able to use this app installing `ruby` (>= 2.3) and `Postgresql` (>= 9.5).

## Usage

  * Clone this repo `git clone https://github.com/rwehresmann/chatbot_faq_manager.git`;
  * In the repo folder, run: 
    * `docker-compose build`;
    * `docker-compose run --rm website rake db:create`;
    * `docker-compose run --rm website rake db:migrate`.
  
It's done! You can start the application running `docker-compose up`. To test the application functionalities in your local machine, run `curl` commands in your terminal. For instance:

```
curl -H "Content-Type: application/json" -X POST -d '{"result":{"source":"agent","resolvedQuery":"help","action":"general_help","actionIncomplete":false,"parameters":{},"contexts":[],"metadata":{"intentId":"96f80b7f-ba7f-4b52-b5f5-dda9b6e3ab5f","webhookUsed":"true","webhookForSlotFillingUsed":"false","webhookResponseTime":18,"intentName":"general_help"}}}' http://localhost:9292/webhook
```

This will show the chatbot help message. This JSON structure sended is specific from API.ai (for further information you should read their [documentation](https://docs.api.ai/docs/)).

You can, of course, use this app in your Slack channel in a simple way. Check below.

### Integrating with Slack

The app isn't available in Slack apps directory, because of that you need to follow a few extra steps (all the services described bellow have a free option): 

  * Start creating an app in [Heroku](https://id.heroku.com/login) (fill free to choose any other cloud service you want);
  * Create your agent in [api.ai](https://console.api.ai/api-client/#/login) (you can use the same name of the app in your agent, or any other name, doesn't matter);
  * In the configurations of your agent you'll see the option to import agent configuration. Click and import the file  `/backup/chatbot_faq_manager.zip` (located inside the app repo);
  * In your agent, you'll see the `Fullfilment` option. Click and enable it, also adding in `URL` option the URL from the app that you created. Save these modifications;
  * Follow the instructions from [api.ai Slack integration guide](https://docs.api.ai/docs/slack-integration).

At the end of the integration guide, you will be able to add the Chatbot FAQ Manager in your Slack channel!

## Contributing

A lot can be done to improve this chatbot. Whant to contribute? Fork and send a pull request. Have any questions? Open an issue or contact me.
