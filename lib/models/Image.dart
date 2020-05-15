class Img 
{
    int imageCode;
    int ssCode;
    int areaCode;
    int topicCode;
    String imageName;
    String openImage;

    Img({
        this.imageCode,
        this.ssCode,
        this.areaCode,
        this.topicCode,
        this.imageName,
        this.openImage,
    });

    factory Img.fromJson(Map<String, dynamic> json) => Img(
        imageCode: json["image_code"],
        ssCode: json["ss_code"],
        areaCode: json["area_code"],
        topicCode: json["topic_code"],
        imageName: json["image_name"],
        openImage: json["open_image"],
    );

    Map<String, dynamic> toJson() => 
    {
        "image_code": imageCode,
        "ss_code": ssCode,
        "area_code": areaCode,
        "topic_code": topicCode,
        "image_name": imageName,
        "open_image": openImage,
    };
}