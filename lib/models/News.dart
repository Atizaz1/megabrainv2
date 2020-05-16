class News 
{
    int id;
    DateTime newsDate;
    String news;
    int newsPriority;

    News(
    {
        this.id,
        this.newsDate,
        this.news,
        this.newsPriority,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["id"],
        newsDate: DateTime.parse(json["news_date"]),
        news: json["news"],
        newsPriority: json["news_priority"],
    );

    Map<String, dynamic> toJson() => 
    {
        "id": id,
        "news_date": "${newsDate.year.toString().padLeft(4, '0')}-${newsDate.month.toString().padLeft(2, '0')}-${newsDate.day.toString().padLeft(2, '0')}",
        "news": news,
        "news_priority": newsPriority,
    };
}