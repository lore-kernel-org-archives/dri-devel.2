Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092C606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=m.kesenheimer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=EAogk/tt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B9A10EA12;
	Sun,  1 Nov 2026 12:00:51 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA2410E0A9
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 09:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1793525503; x=1794130303; i=m.kesenheimer@gmx.net;
 bh=aatEu+R4oBdwmoKSEBwu1Bsxl90H2OUPzCkzXJ7y7C4=;
 h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
 References:To:cc:content-transfer-encoding:content-type:date:from:
 message-id:mime-version:reply-to:subject:to;
 b=EAogk/ttFSdzCRom0mQBrdXFfRTo6V9xf14pqO5qR9QOMbs3IPwAy4CiSdmRLFzZ
 4Q5TlVmSxnRQizNPBJYUbMX42OOdXCAPF5s2Y9iF9Fw/wuT4XI28taKMovUwHnW7H
 egnMZck5Oihsvn5oCxz22p7PVhR13V9K6Bbovc4I7pup8DZt2ilJDkAkHBnmHiq4I
 ITtIoK6051Nf/35bUOboF3/DYyJSGjiHr8xfWIo597gdLrzFwIkZqNz0SE0TuqEgx
 sL1yv6J9tE6cv821UjMAJ8A4ddmNPXvFr8jpx1XGF0G/Noqpc20c038G9awDDv3K2
 TrSfYWXq5EAjoxJ5wQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1wcNYw2gsm-015KnQ; Sun, 01
 Nov 2026 10:31:42 +0100
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH v3] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
From: Matthias Kesenheimer <m.kesenheimer@gmx.net>
In-Reply-To: <sashiko-outbox-192131@kernel.org>
Date: Sun, 1 Nov 2026 10:31:31 +0100
Cc: alex.deucher@amd.com,
 christian.koenig@amd.com,
 airlied@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CAB8D41-76B4-49D9-A4B4-6C78A93296C3@gmx.net>
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
 <sashiko-outbox-191902@kernel.org>
 <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
 <sashiko-outbox-192131@kernel.org>
To: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Provags-ID: V03:K1:kFR6ZzmOw2UHOcQMjt7hhjw7yOAvXDyrYFp/L6HNwZnl9SPJhBi
 XXIpHxlavuR28MiYGLFQLqS3vkZOcDW7HAmYOgWtKRZIvdgwXx9KLfnoeHfCreFlQh7Vm61
 IsMZ4HYnx0Ye1otQkiPl18yQ2oZ7cIUQK23GNflQDLcE19WdqCzqqJr0DCVg0Qm0wS1ztvJ
 Ur4TQ7LCxkTQi9qY5/4vQ==
UI-OutboundReport: notjunk:1;M01:P0:57KhD4BwXbQ=;pWQ1A9JJC8wv/kbuSK51zoBWotx
 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
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

