class MhsModel {
  String mhsNim;
  String mhsNama;
  String mhsKelas;
  String mhsKdmatkul;
  String mhsEmail;

 MhsModel({
  this.mhsNim;
  this.mhsNama;
  this.mhsKelas;
  this.mhsKdmatkul;
  this.mhsEmail;

  factory MhsModel.fromJson(Map<String, dynamic> json) => MhsModel (
    mhsNim: json['nim'],
    mhsNama: json['nama'],
    mhsKelas: json['kelas'],
    mhsKdmatkul: json['kdmatkul'],
    mhsEmail: json['email']
    );
  
}
  