Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8B606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=m.kesenheimer@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=VlsCchcE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EFD10E400;
	Sun,  1 Nov 2026 12:00:43 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC6010E01F
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1793442484; x=1794047284; i=m.kesenheimer@gmx.net;
 bh=E6gVdfFttPl8A4mq3YCUciK5tliV6Sw8MhIgtRCSVpQ=;
 h=X-UI-Sender-Class:From:Content-Type:Content-Transfer-Encoding:
 Mime-Version:Subject:Message-Id:Date:Cc:To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=VlsCchcEDurH/J3nXnC7lLGIsx7e0fAbkvLwyLDKigwcvd/YNJIRM6rh9XwZWSo/
 ONZ65qycZE6aifdzp/CWOpBWXRDXo0XSN1lWj47DbLGHUuG5vjn/+pWdW+V8m1B6C
 IF4sdUJ2ewQc0g/lU+G3CX7+DiHO/aONY53cZX7bzgLBhe636PNUqvpiGojATQIvw
 DbxxvodmWRXIKsCPiLl3bQyF647rAnYXtYAuKGq6lUIdVuy291byJavdfnpceZh14
 X5mAV0e5L180WTpJBJeoLcsF3sCgD3KJssPRIbgR9W4TlxD91pASVWqpTZXrWmIF7
 V9TI/yHuyX2jWDow4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bX1-1wNbfD3Dmd-017RkV; Sat, 31
 Oct 2026 11:28:04 +0100
From: Matthias Kesenheimer <m.kesenheimer@gmx.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
Message-Id: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
Date: Sat, 31 Oct 2026 11:27:53 +0100
Cc: alex.deucher@amd.com,
 christian.koenig@amd.com,
 airlied@gmail.com
To: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-Provags-ID: V03:K1:OT5AYzBk6DShKwld6SqWKA4lUYx8OzTC/t658i95AlnAgLBDuyZ
 bBiShxDQ85+XTzi3VLM/iJla3RKQ/NiF3XDuWkeX7q/uDVZ0+RgwnOOT5b36L3LqXdcJFD/
 o38jN6Eb7I6Z+1fwhIkAZZlrMswQ0h91hz4QpzkoWmn8gHbLk9rV6x+wX7n3RvOea1yWzRQ
 nDUwP4WL8oTmcnVi07ADQ==
UI-OutboundReport: notjunk:1;M01:P0:E2bKgkQG4ZU=;2AjPFNExMuzGVb2BZ/vSdsawt67
 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
 0zQ1aQwJac50=
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When multiple cards share the same PCI device ID (e.g. RX 6600 and
RX 6600 XT both use 0x73ff), the VFCT table contains separate VBIOS
images for each card distinguished by their bus number.

The current implementation iterates VFCT entries and returns on the
first device-ID match, which may not have an exact bus match. This
causes cards to load the wrong VBIOS image (e.g. RX 6600 loading
RX 6600 XT's VBIOS), resulting in incorrect clock speeds and
potential system hangs.

Fix: perform two passes over the VFCT table. First pass looks for
an exact bus match. If no exact match is found, second pass falls
back to device-identity matching (vendor + device + slot +
function), which handles PCI bus renumbering cases.

This ensures exact bus matches are preferred while still supporting
the device-identity fallback for systems where the kernel
renumbers PCI buses.

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f9315e0472fe..0cee0872100a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -474,6 +474,8 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	UEFI_ACPI_VFCT *vfct;
 	unsigned int offset;
 	bool r =3D false;
+	GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
+	VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;

 	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
 		return false;
@@ -486,6 +488,44 @@ static bool amdgpu_acpi_vfct_bios(struct =
amdgpu_device *adev)
 	vfct =3D (UEFI_ACPI_VFCT *)hdr;
 	offset =3D vfct->VBIOSImageOffset;

+	/* First pass: look for exact bus match */
+	while (offset < tbl_size) {
+		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
+		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
+
+		offset +=3D sizeof(VFCT_IMAGE_HEADER);
+		if (offset > tbl_size) {
+			dev_info(adev->dev, "ACPI VFCT image header =
truncated,skipping\n");
+			goto out;
+		}
+
+		offset +=3D vhdr->ImageLength;
+		if (offset > tbl_size) {
+			dev_info(adev->dev, "ACPI VFCT image =
truncated,skipping\n");
+			goto out;
+		}
+
+		if (vhdr->ImageLength && vhdr->PCIBus =3D=3D =
adev->pdev->bus->number &&
+		    vhdr->VendorID =3D=3D adev->pdev->vendor &&
+		    vhdr->DeviceID =3D=3D adev->pdev->device &&
+		    vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) =
&&
+		    vhdr->PCIFunction =3D=3D =
PCI_FUNC(adev->pdev->devfn)) {
+			adev->bios =3D kmemdup(&vbios->VbiosContent,
+					     vhdr->ImageLength,
+					     GFP_KERNEL);
+
+			if (!check_atom_bios(adev, vhdr->ImageLength)) {
+				amdgpu_bios_release(adev);
+				goto out;
+			}
+			adev->bios_size =3D vhdr->ImageLength;
+			r =3D true;
+			goto out;
+		}
+	}
+
+	/* Second pass: fall back to device-identity matching */
+	offset =3D vfct->VBIOSImageOffset;
 	while (offset < tbl_size) {
 		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
 		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
--
2.56.0=
