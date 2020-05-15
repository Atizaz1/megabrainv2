class Area {
    int areaCode;
    int ssCode;
    String areaName;
    String openArea;

    Area({
        this.areaCode,
        this.ssCode,
        this.areaName,
        this.openArea,
    });

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        areaCode: json["area_code"],
        ssCode: json["ss_code"],
        areaName: json["area_name"],
        openArea: json["open_area"],
    );

    Map<String, dynamic> toJson() => {
        "area_code": areaCode,
        "ss_code": ssCode,
        "area_name": areaName,
        "open_area": openArea,
    };
}