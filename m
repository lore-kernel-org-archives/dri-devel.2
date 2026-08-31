Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A941C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9FC10E2E4;
	Mon, 31 Aug 2026 16:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KplII1cj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BEB10E2E4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:44:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB786601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475C81F000E9;
 Mon, 31 Aug 2026 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788194655;
 bh=BUaJ38pOd6auOKcDizy6oTg2sPhyNPxaLBo+mVtcmbQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KplII1cjpuNSwG1XZo0BXLnqtn2OuQuMkDaNwZnFQyZRmfSGKybKf1ousakAl/CDn
 2RJqhx5nrQf90dePK7QBHinr4BKLeFYDMydov66iOn6nFPT3AfZ4azFJxOcx4KApwU
 KW5mPxxU10+fPlGcJETOGOoZu64Yz8BykO1RR3QkhII1KnJ/EdLiwzJh5RtS+PTqJi
 pTeDqw6I0z84Ody5rfLor4CcFg4Ds0jVVgDiLG4EbGnpZft6O+Ix4xWykgtY0MEeR5
 mVzqNJ7ktqHcFEMYWYxlmK3Fpd4bsOgJCzRXp32WbR+t/usBAed1PKig7MeNIh653j
 2ub//LPb20kAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] drm/nouveau/bios: skip the IFR header
 if present
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-478-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-478-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:44:14 +0000
Message-Id: <20260831164415.475C81F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unvalidated `offset` parsed from the IFR header is used directly f=
or MMIO reads, potentially causing out-of-bounds memory accesses and kernel=
 panics.
- [High] Unvalidated alignments for `data_size`, `offset`, and `pci_rom_off=
set` can cause unaligned MMIO reads, triggering alignment faults.
- [Low] Use of undeclared function/macro 'kzalloc_obj' causes a build failu=
re.
--

commit 9d4cb5f612195048e40857e29840a031219f8e6b
Author: Timur Tabi <ttabi@nvidia.com>

drm/nouveau/bios: skip the IFR header if present

This commit adds logic to parse the Init-from-ROM (IFR) header on GPUs
like GA100, adjusting PROM reads to skip the header and reach the PCI
Expansion ROM image. It handles version 1, 2, and 3 IFR headers by
reading offsets and validating the PCI ROM signature.

Link: https://patch.msgid.link/20260430223838.2530778-9-ttabi@nvidia.com

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c b/drive=
rs/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> index 39144ceb117b4..9e171b1bad732 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.c

[ ... ]

> @@ -24,34 +24,126 @@
> =20
>  #include <subdev/pci.h>
> =20
> +#define NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE 0x4947564E	/* "NVGI" */
> +#define NV_ROM_DIRECTORY_IDENTIFIER 0x44524652			/* "RFRD" */
> +
> +struct priv {
> +	struct nvkm_device *device;
> +	u32 pci_rom_offset;
> +};

[ ... ]

>  static u32
>  nvbios_prom_read(void *data, u32 offset, u32 length, struct nvkm_bios *b=
ios)
>  {
> -	struct nvkm_device *device =3D data;
> +	struct priv *priv =3D data;
> +	struct nvkm_device *device =3D priv->device;
>  	u32 i;
> -	if (offset + length <=3D 0x00100000) {
> -		for (i =3D offset; i < offset + length; i +=3D 4)
> -			*(u32 *)&bios->data[i] =3D nvkm_rd32(device, 0x300000 + i);
> -		return length;
> -	}
> -	return 0;
> +
> +	/* Make sure we don't try to read past the end of data[] */
> +	if (offset + length > bios->size)
> +		return 0;
> +
> +	/* Make sure the read falls within the 1MB PROM window */
> +	if (offset + priv->pci_rom_offset + length > 0x00100000)
> +		return 0;
> +
> +	for (i =3D offset; i < offset + length; i +=3D 4)
> +		*(u32 *)&bios->data[i] =3D nvkm_rd32(device, 0x300000 + priv->pci_rom_=
offset + i);

[Severity: High]
Is it possible for priv->pci_rom_offset to be unaligned here?

Since nvkm_rd32() performs a 32-bit MMIO read, an unaligned offset parsed=20
from the untrusted VBIOS could trigger an Alignment Fault (data abort) on=20
strictly aligned architectures like ARM/ARM64.

> +	return length;
>  }

[ ... ]

>  static void *
>  nvbios_prom_init(struct nvkm_bios *bios, const char *name)
>  {
>  	struct nvkm_device *device =3D bios->subdev.device;
> +	struct priv *priv;
> +	u32 fixed0;
> +
> +	/* There is no PROM on NV4x iGPUs */
>  	if (device->card_type =3D=3D NV_40 && device->chipset >=3D 0x4c)
>  		return ERR_PTR(-ENODEV);
> +
> +	priv =3D kzalloc_obj(*priv);

[Severity: Low]
Does this code build correctly? It looks like kzalloc_obj is an undeclared=
=20
macro or function, which breaks the build. Should this be a call to=20
kzalloc(sizeof(*priv), GFP_KERNEL) instead?

> +	if (!priv)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Disable the PCI ROM shadow so that we can read PROM. */
>  	nvkm_pci_rom_shadow(device->pci, false);
> -	return device;
> +
> +	/*
> +	 * Check for an IFR header. If present, parse it to find the actual PCI=
 ROM header.
> +	 *
> +	 * The IFR header is documented in Documentation/gpu/nova/core/vbios.rst
> +	 */
> +	fixed0 =3D nvkm_rd32(device, 0x300000);
> +	if (fixed0 =3D=3D NV_PBUS_IFR_FMT_FIXED0_SIGNATURE_VALUE) {
> +		u32 fixed1 =3D nvkm_rd32(device, 0x300004);
> +		u8 version =3D (fixed1 >> 8) & 0xff;
> +		u32 fixed2, data_size, offset, signature;
> +
> +		switch (version) {
> +		case 1:
> +		case 2:
> +			data_size =3D (fixed1 >> 16) & 0x7fff;
> +			priv->pci_rom_offset =3D nvkm_rd32(device, 0x300000 + data_size + 4);

[Severity: High]
Could this read trigger an unaligned MMIO access?=20

The data_size is extracted directly from the header without alignment check=
s.
If it is not a multiple of 4, adding it to the base address will cause an=20
unaligned 32-bit read, triggering an Alignment Fault on architectures like
ARM/ARM64.

> +			break;
> +		case 3:
> +			fixed2 =3D nvkm_rd32(device, 0x300008);
> +			data_size =3D fixed2 & 0x000fffff;
> +
> +			/* ROM directory offset */
> +			offset =3D nvkm_rd32(device, 0x300000 + data_size) + 4096;
> +
> +			signature =3D nvkm_rd32(device, 0x300000 + offset);

[Severity: High]
Can this lead to an out-of-bounds MMIO read or unaligned access?

The offset value is parsed directly from the IFR header and used immediately
as an index for nvkm_rd32(). If the device provides a malformed or malicious
offset (e.g., 0x0F000000), the read could fall completely outside the=20
device->pri mapping, triggering a synchronous external abort and a kernel=20
panic.

Additionally, there appear to be no checks ensuring the offset is 4-byte=20
aligned, which carries the same alignment fault risk as data_size above.

> +			if (signature !=3D NV_ROM_DIRECTORY_IDENTIFIER) {
> +				nvkm_error(&bios->subdev, "could not find IFR ROM directory\n");
> +				goto fail;
> +			}
> +
> +			priv->pci_rom_offset =3D nvkm_rd32(device, 0x300000 + offset + 8);

[Severity: High]
Could this subsequent MMIO read also fail for the same reasons? It relies
on the unvalidated offset value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-478-sashal@kernel.org?part=3D1
