class Topic 
{
    int topicCode;
    int ssCode;
    int areaCode;
    String topicName;
    dynamic observation;
    String openTopic;

    Topic({
        this.topicCode,
        this.ssCode,
        this.areaCode,
        this.topicName,
        this.observation,
        this.openTopic
    });

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        topicCode: json["topic_code"],
        ssCode: json["ss_code"],
        areaCode: json["area_code"],
        topicName: json["topic_name"],
        observation: json["observation"],
        openTopic: json["open_topic"],
    );

    Map<String, dynamic> toJson() => 
    {
        "topic_code": topicCode,
        "ss_code": ssCode,
        "area_code": areaCode,
        "topic_name": topicName,
        "observation": observation,
        "open_topic": openTopic,
    };
}