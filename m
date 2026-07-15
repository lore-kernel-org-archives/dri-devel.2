Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7824C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F5610E1AA;
	Wed, 15 Jul 2026 20:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqsA7lje";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39DD10E1AA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:19:02 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso5499623f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784146741; x=1784751541; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HRGfRZp6riY4S2dWkx8gtcMTY1YiznpYBmmZdtr/CE=;
 b=MqsA7lje4juh4AR1HIaCwL3gJ5MG4ANpicwcrnk7Mo58gw9de11J9oMgMs2RoWeNNl
 9JOuuFtQkwIpqeaw4sqOxLdsp/6MKxil/LNn3OU9o+JnbOUGGUtDEtL9kGVIhtuaTUfl
 noDwwNwTux392KT7kSBvEoS7ZFvfN06IEMsiwKN/ogC21+5IKdo/8BRsqHay86RAtwRi
 z9Mqm31eM0m6d8gii3MQDr4a6H6BBWO3UCUH6pBhtlB1s04vZJt7AvfxmpzQu1Fgto6E
 PoBtxqCRAwF4iKD43+tkUK4ibZ9c7UXpsL0hHjlSFIoxdiLDTZxawZyEy2ijwUQLBJBJ
 8aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784146741; x=1784751541;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7HRGfRZp6riY4S2dWkx8gtcMTY1YiznpYBmmZdtr/CE=;
 b=tPO0BgALkQyJLDotgEAvOWAR+yjQ2jTzHvf4VGqhUGCgeZChWusHyeWypj6vkWR61v
 oSWGF5SdObveWo7OfvupFDvXqErlwecnU8IMXJeK5pHWGRKHtb+1Od38nMXWhPc+t4LM
 OsUuOHbxKTN8YsQfFlnbouWJDTKmSI66VDhjxV/eo6FMQtVi9Qn83RHBTJnmqb2ztJ2z
 p2fsOAe9YD9737zRPlYlRjQ/mh3rlQMVvuhOkCRZ+zCH807JJymbJdGDUlCLuDT0BAXP
 joaKmmvJS8qtrB/Vi22rLlnQDQkhssyBN295VJC/v6it15T7weiMBdaCQnHK9kyzCLOQ
 ZF0g==
X-Gm-Message-State: AOJu0YyFPO3LmMGvMb7PrYGIYYW1aifAY/EXycDMqt8ckGC1L00WRppv
 epmO2cim8jTua/IKpVV5ks+P6q9cmzANbODOVS3nhBkHznMzf4vzsUF54BSToYUF
X-Gm-Gg: AfdE7ckWgU849ytF0G84N7yNZuL1DvjeJxqLzzj0+ACjuh/7TkaTb1mRAbi1ucjmAvx
 QX4qP5NcQbabv/DmRkHDwrE3DKU5qQQwwbboyiCe7BG7qtnTqlpOnkPP6bsuKJ3EpQhDalndQrO
 I09O+flfWsYGHS8vyR800h442/LZbHKLdoz/Gt3uw0/gbnJBZp5AMGy4ggqjkd4rOfmpd4CnYJy
 hPyFDxt1Ae2qrC+DzcyF23lEYtXo+1W/swfumizmWxx5ERnlca5sqdKFg6F1PGR7RDrp61BUVRN
 U+kgbKB20wy8UmU3+XeybdqtUBAU+sTTOXP9G9yiDSliSVNEq+KYiprNHvBDkGyqE01Ec5RBp8Q
 mjNXCl71ZdgEKPA0HuKfWOqbDOSuMIDYkWe5TJJWM9YPQa4s7UD/p5hSUsvAROM/aJ2j7/FCgs4
 g0TANlnNLbZMeT5pEzGrSqN1WdOt5HxGnNyDhjv/W1M0Dk6wfYoDJJ8K/Gt1FgarYTXyLo6RSuY
 FBucAMPgX6mZJuEIkQ=
X-Received: by 2002:a5d:64cc:0:b0:475:c946:36c5 with SMTP id
 ffacd0b85a97d-47f4fcc87c5mr4964106f8f.9.1784146741164; 
 Wed, 15 Jul 2026 13:19:01 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635ac2esm19386874f8f.13.2026.07.15.13.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:19:00 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/amd/display: Support DRM format modifiers on
 GFX6-8
Date: Wed, 15 Jul 2026 22:18:59 +0200
Message-ID: <74354275.0thIPus4bt@timur-max>
In-Reply-To: <20260715110821.BF5F01F000E9@smtp.kernel.org>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-4-timur.kristof@gmail.com>
 <20260715110821.BF5F01F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 2026. j=C3=BAlius 15., szerda 13:08:20 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 sashiko-
bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider: - [High] Missing bit-to-byte conversion in
> `tile_bytes` calculation. - [High] NULL pointer dereference in
> `amdgpu_dm_plane_add_modifier_dedup`. - [Medium] Missing 8-bpp modifier
> exposure in `amdgpu_dm_plane_add_gfx6_modifiers`. --
>=20
> --- Patch [3]: [PATCH 3/4] drm/amd/display: Support DRM format modifiers =
on
> GFX6-8 --- commit 3fb28c857b70a3a3413b8818708816df4bf9fc7e
> Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
>     drm/amd/display: Support DRM format modifiers on GFX6-8
>=20
>     Expose displayable DRM format modifiers based on which
>     tiling modes are supported by the GFX block.
>=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c index
> > b2507c5de7c86..9d56ce635cbda 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>=20
> [ ... ]
>=20
> > @@ -180,6 +180,19 @@ STATIC_IFN_KUNIT void
> > amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *si>=20
> >  }
> >  EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
> >=20
> > +STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mo=
ds,
> > uint64_t *size, +					=09
	 uint64_t *cap, uint64_t mod)
> > +{
> > +	uint64_t i;
> > +
> > +	for (i =3D 0; i < *size; ++i)
> > +		if ((*mods)[i] =3D=3D mod)
> > +			return;
>=20
> [Severity: High]
> If a previous call to amdgpu_dm_plane_add_modifier() fails to reallocate =
the
> array, it sets *mods to NULL but leaves *size at its previous non-zero
> value:
>=20
> amdgpu_dm_plane_add_modifier() {
>     ...
> 		if (!new_mods) {
> 			kfree(*mods);
> 			*mods =3D NULL;
> 			return;
> 		}
>     ...
> }
>=20
> Will this loop cause a NULL pointer dereference on the next call to
> amdgpu_dm_plane_add_modifier_dedup() since it unconditionally evaluates
> (*mods)[i] without checking if *mods is NULL?

This can't happen in practice. amdgpu_dm_plane_get_plane_modifiers() alloca=
tes=20
enough space for 128 modifiers but amdgpu_dm_plane_add_gfx6_modifiers() onl=
y=20
adds up to 4 modifiers to the array.

That being said, let me know what you recommend to do with this.

>=20
> > +
> > +	amdgpu_dm_plane_add_modifier(mods, size, cap, mod);
> > +}
> > +EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
>=20
> [ ... ]
>=20
> > @@ -468,6 +516,246 @@ static void
> > amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *ad
> [ ... ]
>=20
> > +/**
> > + * amdgpu_dm_plane_get_gfx7_macro_tile_idx() - Get macro tile mode ind=
ex
> > on GFX7-8 + *
> > + * @bpp: bits per pixel in the image
> > + * @tile_split_bytes: actual tile split bytes, see
> > amdgpu_dm_plane_calc_gfx7_tile_split() + *
> > + * Select which macro tiling mode from the table is suitable for the
> > given bits per pixel, + * assuming 2D_TILED_THIN1 array mode and DISPLAY
> > micro tile mode (and no multisampling). + * Note that the tiling table =
is
> > uAPI and userspace relies on specific modes being + * present at specif=
ic
> > indices.
> > + * See CiLib::HwlComputeMacroModeIndex() in addrlib.
> > + */
> > +static u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp, const
> > u32 tile_split_bytes) +{
> > +	const u32 tile_bytes =3D clamp(8 * 8 * bpp, 64, tile_split_bytes);
>=20
> [Severity: High]
> Does this calculation compute the microtile size in bits instead of bytes?
> Because it lacks a division by 8 (e.g., (8 * 8 * bpp) / 8), the computed
> tile_bytes is artificially inflated. For a 16bpp format, this would
> calculate 1024 instead of 128, leading to an incorrect macro tile index
> being selected which may cause tiled buffers to be rejected or misrendered
> on GFX7-8.

This may be a real issue. I will look into this.

>=20
> > +	const u32 macro_tile_idx =3D ilog2(tile_bytes / 64);
> > +
> > +	WARN_ON(macro_tile_idx >=3D 16);
> > +
> > +	return macro_tile_idx;
> > +}
>=20
> [ ... ]
>=20
> > +/**
> > + * amdgpu_dm_plane_add_gfx6_modifiers() - Expose modifiers for GFX6-8
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @mods: Pointer to array of format modifiers
> > + * @size: Pointer to size of the array
> > + * @capacity: Pointer to capacity of the array
> > + *
> > + * Calculate a DRM format modifier for macro tiled modes for each
> > supported + * bits per pixel value. Use de-duplication because on some
> > GPUs it may happen + * that different bpp results in the exact same mac=
ro
> > tiling mode, depending + * on the tiling table.
> > + *
> > + * Also expose a micro tiled only mode. This is less optimal, but
> > supported. + */
> > +static void amdgpu_dm_plane_add_gfx6_modifiers(const struct amdgpu_dev=
ice
> > *adev, +					       u64 **mods,
> > +					       u64 *size,
> > +					       u64 *capacity)
> > +{
> > +	/* 2D tiled displayable */
> > +	amdgpu_dm_plane_add_modifier(mods, size, capacity,
> > +		amdgpu_dm_plane_calc_gfx6_mod(adev, 16,=20
DC_ARRAY_2D_TILED_THIN1));
>=20
> [Severity: Medium]
> Are we missing the 8-bpp modifier exposure here?
>=20
> The helper function amdgpu_dm_plane_get_gfx6_tile_idx() explicitly suppor=
ts
> bpp =3D=3D 8, but we only seem to expose 16, 32, and 64 bpp formats here.
> Without this, userspace might not be able to negotiate 2D tiling for 8-bpp
> formats.

The macro tile mode array has macro tile modes for 8 bpp, but DC doesn't=20
expose any formats with 8 bpp. So we don't need to expose modifiers for 8 b=
pp=20
either.

>=20
> > +	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> > +		amdgpu_dm_plane_calc_gfx6_mod(adev, 32,=20
DC_ARRAY_2D_TILED_THIN1));
> > +	amdgpu_dm_plane_add_modifier_dedup(mods, size, capacity,
> > +		amdgpu_dm_plane_calc_gfx6_mod(adev, 64,=20
DC_ARRAY_2D_TILED_THIN1));
> > +
> > +	/* 1D tiled displayable */
> > +	amdgpu_dm_plane_add_modifier(mods, size, capacity,
> > +		amdgpu_dm_plane_calc_gfx6_mod(adev, 0,=20
DC_ARRAY_1D_TILED_THIN1));
> > +}




