Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70123606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=m.kesenheimer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=XByIxACq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E41A10EA03;
	Sun,  1 Nov 2026 11:58:24 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DFF10E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1793482740; x=1794087540; i=m.kesenheimer@gmx.net;
 bh=aatEu+R4oBdwmoKSEBwu1Bsxl90H2OUPzCkzXJ7y7C4=;
 h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
 References:To:cc:content-transfer-encoding:content-type:date:from:
 message-id:mime-version:reply-to:subject:to;
 b=XByIxACqmeiub8PIOVnAFlquRvCgmcun7AN+oTXB4HPL+YLCHg6FaMEKLaXGKti8
 V209pRUQ4ETYcA55rgMMQK9CdL6mvGKz1WQqCNP+MhKlx8MQu9lycvkJAO9DjayWT
 tgJqGCP2YmuL2+d0eH1q7Ol4yugIKsX2t65J0YITumX6KluP7YjysKGwmNBzR/C2Z
 7vrzTIerR/oYAQqyN5O4OXvPKQH0luzuR2GJ+GxKzFSikR5Vzg1j8Qzeta24d1SuQ
 yfn/8YGtl+7EFcj1rlSH84JCISRRHoCvz7D38ikDc4TdQXGrn6CLi9lifUnlKOCAZ
 yFORPyUZjQ7AhrZMsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1wzImT0jub-00Nnzl; Sat, 31
 Oct 2026 22:39:00 +0100
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH v3] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
From: Matthias Kesenheimer <m.kesenheimer@gmx.net>
In-Reply-To: <sashiko-outbox-192131@kernel.org>
Date: Sat, 31 Oct 2026 22:38:39 +0100
Cc: dri-devel@lists.freedesktop.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F53B8B6D-FEE0-4FDB-9C4B-A890F1AFCEF2@gmx.net>
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
 <sashiko-outbox-191902@kernel.org>
 <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
 <sashiko-outbox-192131@kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Provags-ID: V03:K1:4qhBb6Sjor0xIMasGv40WNOmi9NA3XHTykPlZA0B22SQsVPEzvZ
 TMtAeUM/lhOoT6w3R0cBZ2zOkGZJ5i86gc+w+AUA+MocBhGAip1cJTDBEpAC/ahf/YKGRGp
 eYkVY368Vb/jmuJHfGbb5fgissx9dp19RVnuujl/Yss/Lq52ueqSubg/fUk9XqG+6to41yg
 0kdl1FM9Twc7Qi1uJZ0TA==
UI-OutboundReport: notjunk:1;M01:P0:fTbWVmw0/5A=;jB0OJ59OdDAgcVEezCV4PlrJ9Vj
 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
 4+Q=
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When multiple cards share the same PCI device ID (e.g. RX 6600 and
RX 6600 XT both use 0x73ff), the VFCT table contains separate VBIOS
images for each card distinguished by their bus number.

The current implementation iterates VFCT entries and returns on the
first device-identity match, which may not have an exact bus match.
This causes cards to load the wrong VBIOS image (e.g. RX 6600 loading
RX 6600 XT's VBIOS), resulting in incorrect clock speeds and
potential system hangs.

Walk the VFCT table in a single pass, preferring an exact bus match.
amdgpu_acpi_vfct_match() returns 0 on an exact bus match, 1 on a
device-identity-only match, or -ENODEV on no match. The walk records
the matched entry - an exact bus match ends the walk immediately,
otherwise the first device-identity match is kept as a fallback. The
VBIOS is then loaded and validated once, after the walk, and the
bus-mismatch notice is emitted only when that fallback is actually
used.

Changes since v2:
- Load and validate the VBIOS once, after the walk, instead of
  duplicating the kmemdup()/check_atom_bios()/amdgpu_bios_release()
  sequence between the exact-match and fallback branches.
- Only emit the bus-mismatch notice when the device-identity fallback
  is actually used, avoiding a false notice on multi-GPU systems where
  an exact bus match exists.

Signed-off-by: Matthias Kesenheimer <m.kesenheimer@gmx.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 66 ++++++++++++++++--------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe..d69f8df87249 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct =
amdgpu_device *adev)
  * the bus numbers disagree we accept the entry if the device identity
  * matches.
  *
- * Returns: 0 on match, -ENODEV on no match
+ * Returns: 0 on exact bus match, 1 on device-identity match (bus
+ * mismatch), -ENODEV on no match
  */
 static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
 				  VFCT_IMAGE_HEADER *vhdr)
@@ -460,11 +461,7 @@ static int amdgpu_acpi_vfct_match(struct =
amdgpu_device *adev,
 		return 0;

 	/* Bus mismatch but device identity matches (PCI renumbering =
case) */
-	dev_notice(adev->dev,
-		   "VFCT bus number mismatch: table %u !=3D runtime %u, =
matching by device identity (vendor 0x%04x device 0x%04x)\n",
-		   vhdr->PCIBus, adev->pdev->bus->number,
-		   adev->pdev->vendor, adev->pdev->device);
-	return 0;
+	return 1;
 }

 static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
@@ -474,6 +471,7 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	UEFI_ACPI_VFCT *vfct;
 	unsigned int offset;
 	bool r =3D false;
+	GOP_VBIOS_CONTENT *vbios =3D NULL;

 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
@@ -487,8 +485,9 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	offset =3D vfct->VBIOSImageOffset;

 	while (offset < tbl_size) {
-		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
-		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
+		GOP_VBIOS_CONTENT *entry =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
+		VFCT_IMAGE_HEADER *vhdr =3D &entry->VbiosHeader;
+		int match;

 		offset +=3D sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
@@ -502,23 +501,46 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 			goto out;
 		}

-		if (vhdr->ImageLength &&
-		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
-			adev->bios =3D kmemdup(&vbios->VbiosContent,
-					     vhdr->ImageLength,
-					     GFP_KERNEL);
-
-			if (!check_atom_bios(adev, vhdr->ImageLength)) {
-				amdgpu_bios_release(adev);
-				goto out;
-			}
-			adev->bios_size =3D vhdr->ImageLength;
-			r =3D true;
-			goto out;
+		if (!vhdr->ImageLength)
+			continue;
+
+		match =3D amdgpu_acpi_vfct_match(adev, vhdr);
+		if (match < 0)
+			continue;
+
+		if (match =3D=3D 0) {
+			/* Exact bus match wins - use it and stop =
scanning */
+			vbios =3D entry;
+			break;
 		}
+
+		/* match =3D=3D 1: record the first device-identity =
match as a fallback */
+		if (!vbios)
+			vbios =3D entry;
 	}

-	dev_info(adev->dev, "ACPI VFCT table present but broken (too =
short #2),skipping\n");
+	/* Load and validate the matched VBIOS once */
+	if (vbios) {
+		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
+
+		if (vhdr->PCIBus !=3D adev->pdev->bus->number)
+			dev_notice(adev->dev,
+				   "VFCT bus number mismatch: table %u =
!=3D runtime %u, matching by device identity (vendor 0x%04x device =
0x%04x)\n",
+				   vhdr->PCIBus, =
adev->pdev->bus->number,
+				   adev->pdev->vendor, =
adev->pdev->device);
+		adev->bios =3D kmemdup(&vbios->VbiosContent,
+				     vhdr->ImageLength,
+				     GFP_KERNEL);
+
+		if (!check_atom_bios(adev, vhdr->ImageLength)) {
+			amdgpu_bios_release(adev);
+			goto out;
+		}
+		adev->bios_size =3D vhdr->ImageLength;
+		r =3D true;
+	} else {
+		dev_info(adev->dev, "ACPI VFCT table present but broken =
(too short #2),skipping\n");
+	}

 out:
 	acpi_put_table(hdr);
--
2.56.0

> On 31. Oct 2026, at 21:51, sashiko-bot@kernel.org wrote:
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential =
issue(s) to consider:
> - [Medium] drm/amdgpu: changelog and Signed-off-by placed below --- =
separator
> - [Low] drm/amdgpu: false bus-mismatch notice in =
amdgpu_acpi_vfct_match()
> - [Low] drm/amdgpu: duplicated VBIOS load logic in =
amdgpu_acpi_vfct_bios()
> --
>=20
> commit 02e5f189d060ccb33fa88a19690736b51eba300f
> Author: Matthias Kesenheimer <m.kesenheimer@gmx.net>
>=20
> drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
>=20
> This commit modifies amdgpu_acpi_vfct_bios() and =
amdgpu_acpi_vfct_match()
> to walk the ACPI VFCT table in a single pass, preferring an exact PCI =
bus
> number match and falling back to the first device-identity match only =
if no
> exact bus match is found.
>=20
>>    drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
>>=20
>>    Thanks for the review. Addressing both points:
>>     - The unused fallback_vbios/fallback_vhdr are now actually used: =
the first device-identity match is recorded during the pass and loaded =
only if no exact bus match is found.
>>    - Collapsed the two passes into a single table walk, keeping all =
matching logic in amdgpu_acpi_vfct_match() (returns 0 exact-bus / 1 =
identity-only / -ENODEV none). Matching behavior is unchanged from v1.
>>=20
>>    The patch works on a live system.
>=20
> [Severity: Medium]
> It looks like the v2 review reply was placed above the --- separator, =
while
> the actual commit description and Signed-off-by tag were placed below =
it.
> When applied via git am, everything below --- is stripped, leaving the
> commit without its changelog explanation or Signed-off-by tag. Could =
the
> commit description and Signed-off-by be moved above the --- line, with =
the
> v2 changelog notes below it?
>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> index f9315e0472fe9..ef9fd98eb9e1a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>> @@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct =
amdgpu_device *adev)
>>  * the bus numbers disagree we accept the entry if the device =
identity
>>  * matches.
>>  *
>> - * Returns: 0 on match, -ENODEV on no match
>> + * Returns: 0 on exact bus match, 1 on device-identity match (bus
>> + * mismatch), -ENODEV on no match
>>  */
>> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>>  VFCT_IMAGE_HEADER *vhdr)
>> @@ -464,7 +465,7 @@ static int amdgpu_acpi_vfct_match(struct =
amdgpu_device *adev,
>>   "VFCT bus number mismatch: table %u !=3D runtime %u, matching by =
device identity (vendor 0x%04x device 0x%04x)\n",
>>   vhdr->PCIBus, adev->pdev->bus->number,
>>   adev->pdev->vendor, adev->pdev->device);
>> - return 0;
>> + return 1;
>> }
>=20
> [Severity: Low]
> Will amdgpu_acpi_vfct_match() log a false bus-mismatch notice when =
probing
> the second GPU on a system with multiple identical PCI device IDs?
>=20
> When amdgpu_acpi_vfct_bios() walks the VFCT table for the second card,
> amdgpu_acpi_vfct_match() first encounters the entry for the first card =
on a
> different bus and immediately prints:
>=20
>    dev_notice(adev->dev,
>               "VFCT bus number mismatch: table %u !=3D runtime %u, =
matching by device identity (vendor 0x%04x device 0x%04x)\n",
>               ...);
>=20
> before returning 1, even though a subsequent VFCT entry matches the =
second
> card's bus number exactly and is used instead.
>=20
> Would it be better to move this dev_notice() out of =
amdgpu_acpi_vfct_match()
> and emit it in amdgpu_acpi_vfct_bios() only when the fallback entry is
> actually selected after the loop?
>=20
>>=20
>> static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
>> @@ -474,6 +475,8 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> UEFI_ACPI_VFCT *vfct;
>> unsigned int offset;
>> bool r =3D false;
>> + GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
>> + VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;
>>=20
>> if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>> return false;
>> @@ -489,6 +492,7 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> while (offset < tbl_size) {
>> GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + =
offset);
>> VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
>> + int match;
>>=20
>> offset +=3D sizeof(VFCT_IMAGE_HEADER);
>> if (offset > tbl_size) {
>> @@ -502,8 +506,15 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> goto out;
>> }
>>=20
>> - if (vhdr->ImageLength &&
>> -    !amdgpu_acpi_vfct_match(adev, vhdr)) {
>> + if (!vhdr->ImageLength)
>> + continue;
>> +
>> + match =3D amdgpu_acpi_vfct_match(adev, vhdr);
>> + if (match < 0)
>> + continue;
>> +
>> + /* Exact bus match - use immediately */
>> + if (match =3D=3D 0) {
>> adev->bios =3D kmemdup(&vbios->VbiosContent,
>>     vhdr->ImageLength,
>>     GFP_KERNEL);
>> @@ -516,9 +527,29 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
>> r =3D true;
>> goto out;
>> }
>> +
>> + /* Device-identity match (bus mismatch) - record as fallback */
>> + if (!fallback_vbios) {
>> + fallback_vbios =3D vbios;
>> + fallback_vhdr =3D vhdr;
>> + }
>> }
>>=20
>> - dev_info(adev->dev, "ACPI VFCT table present but broken (too short =
#2),skipping\n");
>> + /* No exact bus match - use the first device-identity match */
>> + if (fallback_vbios) {
>> + adev->bios =3D kmemdup(&fallback_vbios->VbiosContent,
>> +     fallback_vhdr->ImageLength,
>> +     GFP_KERNEL);
>> +
>> + if (!check_atom_bios(adev, fallback_vhdr->ImageLength)) {
>> + amdgpu_bios_release(adev);
>> + goto out;
>> + }
>> + adev->bios_size =3D fallback_vhdr->ImageLength;
>> + r =3D true;
>> + } else {
>> + dev_info(adev->dev, "ACPI VFCT table present but broken (too short =
#2),skipping\n");
>> + }
>=20
> [Severity: Low]
> As reported by Sashiko on v1 [1], this isn't a bug, but the kmemdup(),
> check_atom_bios(), and amdgpu_bios_release() sequence in
> amdgpu_acpi_vfct_bios() is still duplicated between the exact-match =
branch
> inside the loop and the fallback_vbios branch after the loop.
>=20
> Since vhdr is &vbios->VbiosHeader, could the loop simply record the =
matched
> GOP_VBIOS_CONTENT pointer (breaking immediately when match =3D=3D 0) =
and run the
> allocation and validation once after the loop?
>=20
> [1] =
https://lore.kernel.org/r/6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://sashiko.dev/#/patchset/2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.ne=
t?part=3D1

