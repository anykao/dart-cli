import "package:http/http.dart" as http;
import 'package:oauth/oauth.dart' as oauth;
import 'dart:convert';

const consumerKey = "LIibQKGfqTTfMGwA8Zg5Q0AxH";
const consumerSecret = "l6PdG9kHQvDHIYbu8SEY0FmmapDpJs93jbQtFb8fDnfBjIVV8F";
const accessToken = "105493979-m3ZUyQxRlt68W0qBU1KYAYfDdJJ0IenbZk4IFMQN";
const accessSecret = "aVVjQUyYnRxGw4zPDOGt8OEXZfz5MPap4qk8yHZEgH1cx";

main() async {
  await newsApi();
}

twitter() async {
  oauth.Tokens oauthTokens = new oauth.Tokens(
      consumerId: consumerKey,
      consumerKey: consumerSecret,
      userId: accessToken,
      userKey: accessSecret);
  final twitterClient = new oauth.Client(oauthTokens);
  Uri uri =
      Uri.parse("https://api.twitter.com/1.1/statuses/user_timeline.json");
  Map<String, String> queryParameters = new Map<String, String>.from(
    uri.queryParameters,
  );
  queryParameters['screen_name'] = "realDonaldTrump";
  queryParameters['tweet_mode'] = "extended";
  queryParameters['count'] = '20';
  uri = uri.replace(queryParameters: queryParameters);
  final body = await twitterClient.read(uri.toString());
  for (var m in json.decode(body)) {
    var tweet = new Tweet.fromJson(m);
    print(tweet.created_at);
    print(tweet.full_text);
    print(tweet.favorite_count);
  }
}

newsApi() async {
  const API_KEY = "d4c71a2485b844aaa74bb58ce3d653e5";
  final body = await http.read(
      "https://newsapi.org/v2/top-headlines?sources=hacker-news&apiKey=$API_KEY");
  print(body);
}

class Tweet {
  final String created_at;
  final String full_text;
  final int favorite_count;
  Tweet({
    this.created_at,
    this.full_text,
    this.favorite_count,
  });

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return new Tweet(
      created_at: json['created_at'],
      full_text: json['full_text'],
      favorite_count: json['favorite_count'],
    );
  }
}
