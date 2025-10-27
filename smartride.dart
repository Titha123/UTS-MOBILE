//Aplikasi pemesanan transportasi "Smartride"

abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double hitungTarif(int jumlahPenumpang);
  void tampilInfo() {
    print('id: $id');
    print('nama Transportasi: $nama');
    print('Tarif Dasar: $_tarifDasar');
    print('Kapasitas: $kapasitas');
  }

  double get tarifDasar => _tarifDasar;
}

//Kelas Taksi

class Taksi extends Transportasi {
  double jarak;

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (tarifDasar * jarak);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jarak: $jarak KM');
  }
}

//Kelas Buss

class Buss extends Transportasi {
  bool adaWifi;

  Buss(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (_tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Ada wifi: ${adaWifi ? 5000 : 0}');
  }
}

//Kelas Pesawat

class Pesawat extends Transportasi {
  String kelas;

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return (tarifDasar * jumlahPenumpang) * (kelas == "Bisnis" ? 1.5 : 1.0);
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Kelas: $kelas');
  }
}

// Kelas Pemesanan

class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(
    this.idPemesanan,
    this.namaPelanggan,
    this.transportasi,
    this.jumlahPenumpang,
    this.totalTarif,
  );

  void cetakStruk() {
    print('*******************************');
    print('id Pemesanan: $idPemesanan');
    print('Nama Pelanggan: $namaPelanggan');
    print('Transportasi: ${transportasi.nama}');
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Tarif:Rp. ${totalTarif.toStringAsFixed(2)}');
    print('*******************************');
  }

  Map<String, dynamic> toMap() {
    return {
      'idPemesanan': idPemesanan,
      'NamaPelanggan': namaPelanggan,
      'Transportasi': transportasi.nama,
      'JumlahPenumpang': jumlahPenumpang,
      'TotalTarif': totalTarif,
    };
  }
}

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  String idPemesanan = 'D${DateTime.now().millisecondsSinceEpoch}';
  return Pemesanan(idPemesanan, nama, t, jumlahPenumpang, total);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  for (var p in daftar) {
    p.cetakStruk();
  }
}

//Kelas main (utama)

void main() {
  Taksi taksi1 = Taksi('T001', 'RED', 1000, 3, 15.0);
  Buss buss1 = Buss('B001', 'Gamalama', 2000, 20, true);
  Pesawat pesawat1 = Pesawat('P001', 'Garuda', 3000, 15, "Bisnis");

  List<Pemesanan> daftarPemesanan = [];

  daftarPemesanan.add(buatPemesanan(taksi1, 'Destitha', 2));
  daftarPemesanan.add(buatPemesanan(buss1, 'Almaqvira', 15));
  daftarPemesanan.add(buatPemesanan(pesawat1, 'Bachmid', 10));

  tampilSemuaPemesanan(daftarPemesanan);
}
