Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2F606A683
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aB73SqZ/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3B310FE0B;
	Wed, 25 Nov 2026 18:07:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC72310E237
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:07:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB6AC6140C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635861F000C6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630067;
 bh=q1/8NX9tTn6yrNSH2LSJtT9LShYZUIVrNhW9M7CDGEg=;
 h=Date:From:To:Subject:In-Reply-To;
 b=aB73SqZ/xrw2cVNU73sFKUSIosXxMUW4RvxkIxa2jz84/Mn0d9JF3nhZwih1HNLgU
 06Y+wvwgEmfqWg1GnBPAoWj+EbQQLJFw6Vzz0efGhOGx4MBd85r204ohZdA2gVwQie
 kHBTyMJRFDhX/JljRDki6DfFLrrg2+lqN8s+83m+fGiNJTRQGd3ZDwGKko5EMQ8/+k
 ooDvywqnHxiuL0ftlMJQONuOxWO4tOIn/bLppDRtUMfupqJeaHlnx6ITAJpMBhSyZu
 b77vVeo27laiQNpfuupR2tW2ZF5VQ+rTXmLwWdnkiwr5Ab71KzUKoxWcG/wIclRuSC
 8uC6Z1ldfFDfQ==
Date: Wed, 25 Nov 2026 19:07:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: dri-devel@lists.freedesktop.org
Subject: [MAILER-DAEMON@tor.source.kernel.org: Undelivered Mail Returned to
 Sender]
Message-ID: <awcjWRYyPAyI2oQU@devuan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zukzd3q5olwe5ea7"
Content-Disposition: inline
In-Reply-To: <20261125174008.9710362667@tor.source.kernel.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--zukzd3q5olwe5ea7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: dri-devel@lists.freedesktop.org
Subject: [MAILER-DAEMON@tor.source.kernel.org: Undelivered Mail Returned to
 Sender]
Message-ID: <awcjWRYyPAyI2oQU@devuan>
MIME-Version: 1.0
In-Reply-To: <20261125174008.9710362667@tor.source.kernel.org>

I got this email bounced when sending to the listed maintainers.
Are the addresses ok?


Cheers,
Alex

----- Forwarded message from Mail Delivery System <MAILER-DAEMON@tor.source=
=2Ekernel.org> -----

Date: Wed, 25 Nov 2026 17:40:08 +0000 (UTC)
=46rom: Mail Delivery System <MAILER-DAEMON@tor.source.kernel.org>
To: alx@kernel.org
Subject: Undelivered Mail Returned to Sender
Message-Id: <20261125174008.9710362667@tor.source.kernel.org>

This is the mail system at host tor.source.kernel.org.

I'm sorry to have to inform you that your message could not
be delivered to one or more recipients. It's attached below.

For further assistance, please send mail to postmaster.

If you do so, please include this problem report. You can
delete your own text from the attached returned message.

                   The mail system

<koby.elbaz@intel.com>: host mgamail.eglb.intel.com[198.175.65.9] said: 550
    #5.1.0 Address rejected. (in reply to RCPT TO command)

<konstantin.sinyuk@intel.com>: host mgamail.eglb.intel.com[198.175.65.9] sa=
id:
    550 #5.1.0 Address rejected. (in reply to RCPT TO command)

Reporting-MTA: dns; tor.source.kernel.org
X-Postfix-Queue-ID: 8A98A62391
X-Postfix-Sender: rfc822; alx@kernel.org
Arrival-Date: Wed, 25 Nov 2026 17:40:02 +0000 (UTC)

Final-Recipient: rfc822; koby.elbaz@intel.com
Original-Recipient: rfc822;koby.elbaz@intel.com
Action: failed
Status: 5.0.0
Remote-MTA: dns; mgamail.eglb.intel.com
Diagnostic-Code: smtp; 550 #5.1.0 Address rejected.

Final-Recipient: rfc822; konstantin.sinyuk@intel.com
Original-Recipient: rfc822;konstantin.sinyuk@intel.com
Action: failed
Status: 5.0.0
Remote-MTA: dns; mgamail.eglb.intel.com
Diagnostic-Code: smtp; 550 #5.1.0 Address rejected.

Date: Wed, 25 Nov 2026 18:39:58 +0100
=46rom: Alejandro Colomar <alx@kernel.org>
To: Koby Elbaz <koby.elbaz@intel.com>,  Konstantin Sinyuk
 <konstantin.sinyuk@intel.com>, dri-devel@lists.freedesktop.org
Cc: Alejandro Colomar <alx@kernel.org>
Subject: [PATCH] accel/habanalabs: Add missing const
Return-Path: <alx@kernel.org>
Message-ID: <a284672589d00aa039a8c53ccf43bd1a5fd8e8f9.1795628340.git.alx@ke=
rnel.org>
X-Mailer: git-send-email 2.55.0

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





----- End forwarded message -----

--=20
<https://www.alejandro-colomar.es>

--zukzd3q5olwe5ea7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmsHI+sACgkQ64mZXMKQ
wqnIpQ//XTaAduqVhg+qxwjEDDlIWid0dHvHrQV16TdpbXb+BhLS4SS7tWuHXFX+
lDBqJlS+pTERBecyDJNtENTkHCClNNnPj0w4uQMjPpXIaIX0V5Vi2a2a4W4ZTaFk
VaeuOiUq+0OAxMQWvSDC39EmaOM+YB0ihjgfGZrfifTnlZ7RRwlGlerKtJQZJOJS
gzx2+kivC3ZJMosQ+yXnXahxC0eQChoduqHgbmhhcb+brgCnmf4PZHds0ekiJ4fy
BGcY5nVyUygONjbGCNMdeOcmNZLcroFgF3rm8n3EPcPSSlIojnuImb8lDKVB3RJj
CZd5v5A22OrEdmnB+BoemqMWHc1bbi3paTbl5yb6UDS0KILA0OdaxfIPGGRRshFM
4QWuwaCTXIJcC4EOm6i6O++2cGESMBFQzIa0wxW5LGao/IX6ZAt+nfEb0gSVaTh8
ux9njL4RC5VqGbOBfOHF7dpuiyt42PjUCs3UmuiR709RoORe9BsiFe5RncU+08a/
oM1O/h+Xh+h8FRwZO08A3TFnHfDtXh86rnAOU6KD8V7RXU0MQecQTvp7jxDBAy+O
3sCz+uxUi8cc4xF0ObNfuFSJ5fNLGMRXxWbTuDhKIZutwERMtG9jAX/kaV7ahCZu
m2eBpx3OgvvZNIxK6HC0S1obgG/zBshs3Mh9/HwIr7JUn51trTc=
=sSKk
-----END PGP SIGNATURE-----

--zukzd3q5olwe5ea7--
