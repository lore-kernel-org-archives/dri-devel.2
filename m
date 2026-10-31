Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30239606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOH7zf86
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6035410E01F;
	Sat, 31 Oct 2026 10:37:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B903210E01F
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 10:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 685544307E;
 Sat, 31 Oct 2026 10:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAD61F000C1;
 Sat, 31 Oct 2026 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793443031;
 bh=Tub2aDYWl2iskU3hYVj15B9FXcvOtJ7Hu2yJfcxaPL8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=fOH7zf86Z+O/2kPF/ILaZAWs2r6HSwuYe2EcRR2leAUEkm5PDYW2jy5Fkp22EV2K0
 v3Y/qwd/nLCy3086Zjcf9suggbSOTlLe3LsPdsNqTvXglwnHSoH4rSHNBNS4Y689tc
 LnRSyHwL3+fJ4tENui+Cko5+qMNBP4907TFqFkhvYZJ9OYkNCsSy1BtM9SbfOIFvHd
 I+aAdgMD/GN0tPh2fzGwmRAQXvQBK5fv6hV55G1Duupc/PuxxlvyQx393TUkl+i4ww
 yLzqs0AttY1PZgOBy2oQQQnquMtTYW5Yaf8m3MzljIF7bRwxqh+y9jPHvv/DONseTg
 tjvNHJ1KFzYuQ==
Message-ID: <sashiko-outbox-191902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
To: "Matthias Kesenheimer" <m.kesenheimer@gmx.net>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 10:37:10 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm/amdgpu: unused variables in amdgpu_acpi_vfct_bios() break -Werr=
or builds
- [Low] drm/amdgpu: duplicated VFCT loop in amdgpu_acpi_vfct_bios() and dea=
d code
--

commit 50a61733895d9903e897b70fe18231ffdb69f9ae
Author: Matthias Kesenheimer <m.kesenheimer@gmx.net>

drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup

This commit updates amdgpu_acpi_vfct_bios() to perform two passes over the
ACPI VFCT table, preferring an exact PCI bus match in the first pass before
falling back to device-identity matching in the second pass.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index f9315e0472fe9..0cee0872100a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -474,6 +474,8 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>  	UEFI_ACPI_VFCT *vfct;
>  	unsigned int offset;
>  	bool r =3D false;
> +	GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
> +	VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;

[Severity: Low]
Are fallback_vbios and fallback_vhdr left over from an earlier single-pass
version of this patch? Neither pointer is referenced anywhere in
amdgpu_acpi_vfct_bios(), which triggers -Wunused-variable warnings (and bre=
aks
builds with CONFIG_WERROR=3Dy or CONFIG_DRM_AMDGPU_WERROR=3Dy) when CONFIG_=
ACPI is
enabled.

> =20
>  	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>  		return false;
> @@ -486,6 +488,44 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devi=
ce *adev)
>  	vfct =3D (UEFI_ACPI_VFCT *)hdr;
>  	offset =3D vfct->VBIOSImageOffset;
> =20
> +	/* First pass: look for exact bus match */
> +	while (offset < tbl_size) {
> +		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + offse=
t);
> +		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> +
> +		offset +=3D sizeof(VFCT_IMAGE_HEADER);
> +		if (offset > tbl_size) {
> +			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
> +			goto out;
> +		}
> +
> +		offset +=3D vhdr->ImageLength;
> +		if (offset > tbl_size) {
> +			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
> +			goto out;
> +		}
> +
> +		if (vhdr->ImageLength && vhdr->PCIBus =3D=3D adev->pdev->bus->number &&
> +		    vhdr->VendorID =3D=3D adev->pdev->vendor &&
> +		    vhdr->DeviceID =3D=3D adev->pdev->device &&
> +		    vhdr->PCIDevice =3D=3D PCI_SLOT(adev->pdev->devfn) &&
> +		    vhdr->PCIFunction =3D=3D PCI_FUNC(adev->pdev->devfn)) {
> +			adev->bios =3D kmemdup(&vbios->VbiosContent,
> +					     vhdr->ImageLength,
> +					     GFP_KERNEL);
> +
> +			if (!check_atom_bios(adev, vhdr->ImageLength)) {
> +				amdgpu_bios_release(adev);
> +				goto out;
> +			}
> +			adev->bios_size =3D vhdr->ImageLength;
> +			r =3D true;
> +			goto out;
> +		}
> +	}

[Severity: Low]
This isn't a bug, but the first pass duplicates the entire VFCT table walk,
truncation checks, and VBIOS loading logic of the second pass, while also
open-coding the VendorID, DeviceID, PCIDevice, and PCIFunction checks from
amdgpu_acpi_vfct_match().

Because any entry with a matching bus and device identity now jumps to out =
in
the first pass, the exact bus check in amdgpu_acpi_vfct_match() also becomes
unreachable dead code during the second pass:

drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c:amdgpu_acpi_vfct_match() {
	...
	/* Exact bus number match - preferred */
	if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
		return 0;
	...
}

Would it be simpler to record the first device-identity match in
fallback_vbios and fallback_vhdr during a single pass over the table (and l=
oad
it after the loop if no exact bus match was found), avoiding the duplicated
table walk and keeping the matching logic in one place?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6C5E74D6-8F98-48BC-=
9173-7E85D243B3D3@gmx.net?part=3D1
