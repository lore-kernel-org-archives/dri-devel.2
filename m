Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7A606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl33FeTf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BED110E21A;
	Wed, 25 Nov 2026 17:40:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD0510FDFC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:40:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A98A62391;
 Wed, 25 Nov 2026 17:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C871F000C0;
 Wed, 25 Nov 2026 17:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795628401;
 bh=M2g+G/tvQNp3LxBHNoGlox25/uvG1WTjXF4IJToyDhU=;
 h=Date:From:To:Cc:Subject;
 b=Xl33FeTfA4sLf7/itclWITt6NOGdCQU+PWw4E6N6IFcSCgcf2/P0LmwKL2Sn/wY6T
 eZEr7hZoDkGkxFB37gb9oKFeUfgzGYHPjVnMnxaFY3IbKZYA6HY+q6L2BUO4Ej13+M
 O+f4Ol0NrJT7tRPQRsRF92hplKKPS6jPMhHs5yYh+jPhUxSazODLwqJWeerXQ/C5c5
 xrJwJSEyTFdjmON6p1D8gvgM9HHcoPGD8zfW1V7qw8cjj/xux7KLnIVcENdho7kLBQ
 gIbPWHjA0NS1Ma5Zs/0nvYrW76oT1TE4O51Oba7Cd3xoV7WSZrBBNkJtKbTiB8zn8e
 UP3H7zER8CoIQ==
Date: Wed, 25 Nov 2026 18:39:58 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Koby Elbaz <koby.elbaz@intel.com>, 
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] accel/habanalabs: Add missing const
Message-ID: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h7epo4kskpadjrsr"
Content-Disposition: inline
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--h7epo4kskpadjrsr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Koby Elbaz <koby.elbaz@intel.com>, 
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>, dri-devel@lists.freedesktop.org
Cc: Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] accel/habanalabs: Add missing const
Message-ID: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@kernel.org>
MIME-Version: 1.0

These pointers are derived from other const pointers.

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

These were found while changing some <linux/string.h> APIs to preserve
the const qualifier in the return type.


Have a lovely night!
Alex

 drivers/accel/habanalabs/common/firmware_if.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/=
habanalabs/common/firmware_if.c
index c8f1e252241d..8ae1e0e4dae1 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -68,7 +68,8 @@ int hl_fw_version_cmp(struct hl_device *hdev, u32 major, =
u32 minor, u32 subminor
=20
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
-	char *str, *fw_ver, *whitespace;
+	char *fw_ver;
+	const char *str, *whitespace;
 	u32 ver_offset;
=20
 	fw_ver =3D kmalloc(VERSION_MAX_LEN, GFP_KERNEL);
@@ -105,7 +106,7 @@ static char *extract_fw_ver_from_str(const char *fw_str)
  *
  * Return: Upon success, return a pointer to the given_char in the string.=
 Upon failure, return NULL
  */
-static char *extract_u32_until_given_char(char *str, u32 *ver_num, char gi=
ven_char)
+static const char *extract_u32_until_given_char(const char *str, u32 *ver_=
num, char given_char)
 {
 	char num_str[8] =3D {}, *ch;
=20
@@ -136,7 +137,7 @@ static char *extract_u32_until_given_char(char *str, u3=
2 *ver_num, char given_ch
  */
 static int hl_get_sw_major_minor_subminor(struct hl_device *hdev, const ch=
ar *fw_str)
 {
-	char *end, *start;
+	const char *end, *start;
=20
 	end =3D strnstr(fw_str, "-rc-", VERSION_MAX_LEN);
 	if (end =3D=3D fw_str)
@@ -194,7 +195,7 @@ static int hl_get_sw_major_minor_subminor(struct hl_dev=
ice *hdev, const char *fw
  *
  * Return: 0 on success, negative error code for failure.
  */
-static int hl_get_preboot_major_minor(struct hl_device *hdev, char *preboo=
t_ver)
+static int hl_get_preboot_major_minor(struct hl_device *hdev, const char *=
preboot_ver)
 {
 	preboot_ver =3D extract_u32_until_given_char(preboot_ver, &hdev->fw_inner=
_major_ver, '.');
 	if (!preboot_ver) {
--=20
2.55.0


--h7epo4kskpadjrsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHHW4ACgkQ64mZXMKQ
wqmFDxAAlaT/XuWp+B9kw+hplmAKgCB+OjUw1eD6MPQXQQeQ3OM9pzkoC0eJir2j
K06uyfYE0eSq2fKdgKnLcI8+bFX0uYjMT3PaHrgTVnkO9m2RrY5HKUWpiLrgYP8A
iO4pC7slOgllDHE0KVm8RABEO03YJeq7NE5pVDh0222v6lzfpFwRG/5SdebP035s
q4sJL1TUVh7YzW3NctPAok212jSpVyU3KFE3mWZ2LU4YYwqc8g/OYQGuq+QyZ8bP
vPZZqcEtQ/zHpDQKQYYZYNe5aP47IJcx8qqIfFaP0YdTclZQD29pk/m+F2yjXA2i
n/I3Iw7ctcQiGsadJed5wd9K3Dtn9x2A44/Qj4dTPYh79Lc9pKtkufqDHclVPTNx
6K7XSq+9Cm45NoX6y60C4hvVsSvc0LhZqEoyqjiczO716AzFPbnA91ObMBe8opOk
Zcu0Ce6Pi7BjxB04fNMKjdqvltW/ZSDbz5ezpLsI1kErCRIa6KyjcMlRDOnMNYwE
gqTD8l/dorpKDs3ACWDEybvTQRvHyUsToG5VxNxYD1c7CUhqn1M1Svz0H6aODDhu
J7qTpWLMi5b7aHwyoIhTbu28OPi4rs9eA9x0QevdWctLBkpuD47xsMNv7zGA8FQe
LXzMKKUWbkc6KJ1OskhnltEadoGG3GXOkSBHl7AwwMO9aGCQ288=
=VMvC
-----END PGP SIGNATURE-----

--h7epo4kskpadjrsr--
