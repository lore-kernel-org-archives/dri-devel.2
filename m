Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D366606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaW4FoUW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40E610E1EC;
	Sat, 31 Oct 2026 20:51:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8345810E33B
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:51:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9E8340A05;
 Sat, 31 Oct 2026 20:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905841F000C1;
 Sat, 31 Oct 2026 20:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793479884;
 bh=QPMcV+Izi/qv+Ieu3Lc++FmK8Mp9qixTNbAwaRMjLxQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=TaW4FoUWG7oN8ebA1j1qOO/DGco7luYoakVMsHH2CmikwC65DLBa4/zvKT3o6PU0w
 IbumzLYZeqffb4PbwNcRADEQd8YRx1AEdAtIqEhnwBQHkPDJC8oM7jykmJwJjYmT0R
 Kvb835meyUnTah6nb+mQF6vtZOj7opWm4oe0xoPhaGDXzydZBf9hyPSpIGQPfjiV0J
 HdbjZPpLAOo86zujBKeuCr3MbdffMqRETE1xffb8DGN7giN2HytCFAcGlxf3tpfIBt
 s2SP3OYXPX3rAoip3hzFAIwJ+g/QLzEJwX8xRSmKkSGSUItaOSR7uH+BS+CuwmFt3b
 Fel2nwSCu9ctg==
Message-ID: <sashiko-outbox-192131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
To: "Matthias Kesenheimer" <m.kesenheimer@gmx.net>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
 <sashiko-outbox-191902@kernel.org>
 <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 20:51:24 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/amdgpu: changelog and Signed-off-by placed below --- separat=
or
- [Low] drm/amdgpu: false bus-mismatch notice in amdgpu_acpi_vfct_match()
- [Low] drm/amdgpu: duplicated VBIOS load logic in amdgpu_acpi_vfct_bios()
--

commit 02e5f189d060ccb33fa88a19690736b51eba300f
Author: Matthias Kesenheimer <m.kesenheimer@gmx.net>

drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup

This commit modifies amdgpu_acpi_vfct_bios() and amdgpu_acpi_vfct_match()
to walk the ACPI VFCT table in a single pass, preferring an exact PCI bus
number match and falling back to the first device-identity match only if no
exact bus match is found.

>     drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
>    =20
>     Thanks for the review. Addressing both points:
>      - The unused fallback_vbios/fallback_vhdr are now actually used: the=
 first device-identity match is recorded during the pass and loaded only if=
 no exact bus match is found.
>     - Collapsed the two passes into a single table walk, keeping all matc=
hing logic in amdgpu_acpi_vfct_match() (returns 0 exact-bus / 1 identity-on=
ly / -ENODEV none). Matching behavior is unchanged from v1.
>    =20
>     The patch works on a live system.

[Severity: Medium]
It looks like the v2 review reply was placed above the --- separator, while
the actual commit description and Signed-off-by tag were placed below it.
When applied via git am, everything below --- is stripped, leaving the
commit without its changelog explanation or Signed-off-by tag. Could the
commit description and Signed-off-by be moved above the --- line, with the
v2 changelog notes below it?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index f9315e0472fe9..ef9fd98eb9e1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_d=
evice *adev)
>   * the bus numbers disagree we accept the entry if the device identity
>   * matches.
>   *
> - * Returns: 0 on match, -ENODEV on no match
> + * Returns: 0 on exact bus match, 1 on device-identity match (bus
> + * mismatch), -ENODEV on no match
>   */
>  static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>  				  VFCT_IMAGE_HEADER *vhdr)
> @@ -464,7 +465,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_devic=
e *adev,
>  		   "VFCT bus number mismatch: table %u !=3D runtime %u, matching by de=
vice identity (vendor 0x%04x device 0x%04x)\n",
>  		   vhdr->PCIBus, adev->pdev->bus->number,
>  		   adev->pdev->vendor, adev->pdev->device);
> -	return 0;
> +	return 1;
>  }

[Severity: Low]
Will amdgpu_acpi_vfct_match() log a false bus-mismatch notice when probing
the second GPU on a system with multiple identical PCI device IDs?

When amdgpu_acpi_vfct_bios() walks the VFCT table for the second card,
amdgpu_acpi_vfct_match() first encounters the entry for the first card on a
different bus and immediately prints:

    dev_notice(adev->dev,
               "VFCT bus number mismatch: table %u !=3D runtime %u, matchin=
g by device identity (vendor 0x%04x device 0x%04x)\n",
               ...);

before returning 1, even though a subsequent VFCT entry matches the second
card's bus number exactly and is used instead.

Would it be better to move this dev_notice() out of amdgpu_acpi_vfct_match()
and emit it in amdgpu_acpi_vfct_bios() only when the fallback entry is
actually selected after the loop?

> =20
>  static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> @@ -474,6 +475,8 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>  	UEFI_ACPI_VFCT *vfct;
>  	unsigned int offset;
>  	bool r =3D false;
> +	GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
> +	VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;
> =20
>  	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>  		return false;
> @@ -489,6 +492,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>  	while (offset < tbl_size) {
>  		GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + offse=
t);
>  		VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> +		int match;
> =20
>  		offset +=3D sizeof(VFCT_IMAGE_HEADER);
>  		if (offset > tbl_size) {
> @@ -502,8 +506,15 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devi=
ce *adev)
>  			goto out;
>  		}
> =20
> -		if (vhdr->ImageLength &&
> -		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
> +		if (!vhdr->ImageLength)
> +			continue;
> +
> +		match =3D amdgpu_acpi_vfct_match(adev, vhdr);
> +		if (match < 0)
> +			continue;
> +
> +		/* Exact bus match - use immediately */
> +		if (match =3D=3D 0) {
>  			adev->bios =3D kmemdup(&vbios->VbiosContent,
>  					     vhdr->ImageLength,
>  					     GFP_KERNEL);
> @@ -516,9 +527,29 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devi=
ce *adev)
>  			r =3D true;
>  			goto out;
>  		}
> +
> +		/* Device-identity match (bus mismatch) - record as fallback */
> +		if (!fallback_vbios) {
> +			fallback_vbios =3D vbios;
> +			fallback_vhdr =3D vhdr;
> +		}
>  	}
> =20
> -	dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2),=
skipping\n");
> +	/* No exact bus match - use the first device-identity match */
> +	if (fallback_vbios) {
> +		adev->bios =3D kmemdup(&fallback_vbios->VbiosContent,
> +				     fallback_vhdr->ImageLength,
> +				     GFP_KERNEL);
> +
> +		if (!check_atom_bios(adev, fallback_vhdr->ImageLength)) {
> +			amdgpu_bios_release(adev);
> +			goto out;
> +		}
> +		adev->bios_size =3D fallback_vhdr->ImageLength;
> +		r =3D true;
> +	} else {
> +		dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2)=
,skipping\n");
> +	}

[Severity: Low]
As reported by Sashiko on v1 [1], this isn't a bug, but the kmemdup(),
check_atom_bios(), and amdgpu_bios_release() sequence in
amdgpu_acpi_vfct_bios() is still duplicated between the exact-match branch
inside the loop and the fallback_vbios branch after the loop.

Since vhdr is &vbios->VbiosHeader, could the loop simply record the matched
GOP_VBIOS_CONTENT pointer (breaking immediately when match =3D=3D 0) and ru=
n the
allocation and validation once after the loop?

[1] https://lore.kernel.org/r/6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2630FE08-2F46-4D29-=
AF3C-DD9EF2DE581E@gmx.net?part=3D1
