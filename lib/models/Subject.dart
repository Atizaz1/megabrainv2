class Subject 
{
    int ssCode;
    String ssName;

    Subject({
        this.ssCode,
        this.ssName,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        ssCode: json["ss_code"],
        ssName: json["ss_name"],
    );

    Map<String, dynamic> toJson() => {
        "ss_code": ssCode,
        "ss_name": ssName,
    };
}