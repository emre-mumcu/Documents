# Encryption & Decryption — Temel Kavramlar

1. Temel Fikir

Plaintext  →  [Encryption]  →  Ciphertext
"Merhaba"                      "x7Kp2m..."

Ciphertext →  [Decryption]  →  Plaintext
"x7Kp2m..."                    "Merhaba"

Şifreleme temelde matematiğe dayanır — veriyi öyle bir dönüşüme uğratırsın ki anahtarı olmayan biri geri döndüremesin.

2. Symmetric vs Asymmetric

**Symmetric (Simetrik) — Tek Anahtar**

Şifrelemek ve çözmek için aynı anahtar kullanılır.

Ali → [AES key ile şifrele] → "x7Kp..." → Ayşe → [aynı AES key ile çöz] → orijinal

Hızlıdır, büyük veri için idealdir

Sorun: Anahtarı karşı tarafa nasıl ileteceksin?

Örnekler: AES, DES, ChaCha20

**Asymmetric (Asimetrik) — Çift Anahtar**

Public key ile şifrelersin, private key ile çözersin. Matematiksel olarak biri diğerinden türetilemez.

Ali → [Ayşe'nin public key'i ile şifrele] → "x7Kp..." → Ayşe → [kendi private key'i ile çöz]

Yavaştır, küçük veri için kullanılır

Anahtar dağıtım problemi yok — public key herkese açık olabilir

Örnekler: RSA, ECC, ElGamal

Pratikte İkisi Birlikte Kullanılır

HTTPS tam olarak bunu yapar — asimetrik ile anahtar paylaşılır, simetrik ile veri şifrelenir.
HTTPS bağlantısı:

* RSA ile AES anahtarını güvenli ilet      (asymmetric)
* Artık AES ile veriyi şifrele/çöz         (symmetric)

3. Block Cipher vs Stream Cipher

**Block Cipher**

Veriyi sabit boyutlu bloklara böler, her bloğu şifreler.

"Merhaba Dünya" → [16 byte'lık bloklar] → her blok ayrı şifrelenir

AES bir block cipher — 128-bit (16 byte) blok boyutu.

**Stream Cipher**

Veriyi bit bit / byte byte şifreler, blok beklemez.

"M" → şifrele → "x"
"e" → şifrele → "7"
"r" → şifrele → "K"

ChaCha20 bir stream cipher — düşük güçlü cihazlarda AES'ten hızlı.

4. AES ve Modları

* AES (Advanced Encryption Standard) bugün en yaygın simetrik algoritmadır. Ama AES tek başına sadece tek bir 16 byte bloğu şifreler. Büyük veriyi şifrelemek için bir mod seçmek gerekir.
* ECB (Electronic Codebook) — Kullanma
	Aynı plaintext bloğu → hep aynı ciphertext bloğu. Desen sızdırır.
	"AAAA AAAA AAAA AAAA" → "X7K2 X7K2 X7K2 X7K2"  ← tekrar görünür!
* CBC (Cipher Block Chaining)
	Her blok, bir önceki şifreli blokla XOR'lanır. ECB'nin desen sorununu çözer ama IV gerektirir ve paralel işlenemez.
* CTR (Counter)
	Bir sayacı şifreleyip plaintext ile XOR'lar — AES'i stream cipher'a dönüştürür. Paralel işlenebilir.
* GCM (Galois/Counter Mode) — Bugünün standardı
	CTR modunun üzerine authentication ekler. Hem şifreler hem de verinin bozulmadığını garanti eder.
	GCM çıktısı:
	├── Ciphertext  (şifrelenmiş veri)
	└── Auth Tag    (16 byte — "bu veri değiştirilmedi" garantisi)

5. IV ve Nonce

IV (Initialization Vector) veya Nonce (Number used once) — şifrelemeye rastgelelik katar.

Neden gerekli: Aynı key ile aynı plaintext → her seferinde farklı ciphertext olmalı

IV olmadan:

"Merhaba" + key → her zaman "x7Kp2m"   ← saldırgan deseni görür

IV ile:

"Merhaba" + key + IV₁ → "x7Kp2m"
"Merhaba" + key + IV₂ → "9qRs4n"      ← tamamen farklı

IV gizli değildir — ciphertext ile birlikte saklanır. Gizli olan sadece key'dir.

Nonce asla tekrar kullanılmamalı — GCM'de aynı key + aynı nonce ile iki farklı mesaj şifrelenirse güvenlik tamamen çöker.

6. Hashing — Şifreleme Değil

Hash fonksiyonları tek yönlüdür — geri döndürülemez.

"Merhaba" → SHA256 → "185f8db3..."   ✅
"185f8db3..." → SHA256 → ???          ❌ imkânsız

Nerelerde kullanılır:

Şifre saklama (bcrypt, Argon2)
Dosya bütünlük kontrolü
Dijital imzalar
PBKDF2'de key türetme (az önce yaptığımız)

Şifre saklamak için AES kullanılmaz — hash kullanılır. Çünkü şifreyi plaintext'e geri döndürmene gerek yoktur, sadece "doğru mu?" sorusunu yanıtlarsın.

7. MAC ve Authentication

MAC (Message Authentication Code) — verinin değiştirilmediğini kanıtlar.

Veri + Key → HMAC → "a3f8..."

Karşı taraf aynı hesaplamayı yapar:

Veri + Key → HMAC → "a3f8..."  ← eşleşti, veri sağlam
                  → "b2e9..."  ← farklı, veri değiştirilmiş!

GCM'deki Auth Tag tam olarak budur — şifreleme ve authentication tek adımda.

8. PBKDF2, bcrypt, Argon2 — Key Derivation

İnsan tarafından hatırlanabilen şifre → kriptografik key dönüşümü.

Düz hash yeterli değil çünkü hızlıdır:

MD5("123456")    → 1 nanosaniye   ← saldırgan milyarlarca deneyebilir
PBKDF2("123456") → 1 saniye       ← brute-force pratikte imkânsız

AlgoritmaÖzellikPBKDF2İterasyon sayısı ayarlanır, yaygınbcryptBellek kullanımı sabit, eski ama güvenliArgon2Hem CPU hem bellek yoğun, modern öneri

9. TLS/HTTPS — Hepsinin Bir Arada Kullanımı

a. Sertifika doğrulama    → Asymmetric (RSA/ECC)
b. Anahtar değişimi       → Diffie-Hellman
c. Veri şifreleme         → Symmetric (AES-GCM)
d. Bütünlük kontrolü      → MAC (GCM Auth Tag)

# Özet

| Kavram        | Ne Yapar                 | Örnek          |
| ------------- | ------------------------ | -------------- |
| Symmetric     | Tek key ile şifrele/çöz  | AES            |
| Asymmetric    | Public/private key çifti | RSA            |
| Block Cipher  | Blok blok şifreler       | AES            |
| Stream Cipher | Byte byte şifreler       | ChaCha20       |
| IV / Nonce    | Rastgelelik katar        | GCM nonce      |
| Hash          | Tek yönlü dönüşüm        | SHA256         |
| MAC           | Bütünlük garantisi       | HMAC, GCM tag  |
| KDF           | Şifreden key türetir     | PBKDF2, Argon2 |
