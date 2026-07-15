Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE169C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C91910E22A;
	Wed, 15 Jul 2026 20:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iQnozDiq";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72BA310E22A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 20:33:39 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so48359125e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784147618; x=1784752418; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nAB/Dxh5aQngnDlynNEsilHV8wWynbKXlXm4+QUJxuk=;
 b=iQnozDiqR0L3iAp0j7mFOZ221mwtVk58rxezs1Sapc2X2/0Nmwi6OPQm/wGUIsoH5v
 2xOUnnUsxf10u6RSAAgFI14YLibfzDzIMQHwL+I5wNnM3ptXgRX3WIF+NyIHcuKKiLmH
 6DNtWlOmiA/XtY+nh6P1enbvf2UIi3HLOWYTQCTEe1b/JBEbG9Qe//j8GsWtnfEPBtCY
 tspN+DnMwNLCxlKBXARQadUzn+e9f+oqmoH1DRjI3EU7rmX7bt0yLStdyqqi0g6+55LD
 oB9MpPcZlCENhQl9Y7BFWzXhayBgUeJgG6Gr+tPI3lMyQJvHDgXMdwZf9pettzMntEO4
 WEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784147618; x=1784752418;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nAB/Dxh5aQngnDlynNEsilHV8wWynbKXlXm4+QUJxuk=;
 b=rVJCK1BIPl0rbqZ2ubRJGlqKfnYEjEYEexkc9Mjd3K9ACgLi759YJNyd1Ry2z6LE2V
 i5Y7cHZBWQG1ueNY+CS4LM+KBS7DqLcATcUsCDdSjJujorZ/B4UV3JEnOxu2sHEJph/D
 TV10yhq2L7XPwOR44x3hY6ikfV+wssBDwdz8T9hJcNGBY3ES3sRccYc++i4gUb7Za5h+
 +5OqaRCkVnk786Dc109KM3OJ4pgd8wluWC+xzranTL/Y0YL6xQStC3ri9fZpPFSBnXNr
 NGbacYEMrWkV9VMxSSTyHnjx1tkLOEwBYmdYir8iP50cGgvsjJnrG3YNXNV/mseas+2h
 S47A==
X-Gm-Message-State: AOJu0YyiIsYDBkzD4Iu01xXyXggZcferpqQmQFqhoHexeQE5gy5fjFGN
 73mPE3w7DUTGbBwX3LLLDQTXiVnEkk6CjOesul15EnuVVCvmk1BrvI4L57K+KDN4
X-Gm-Gg: AfdE7cl9rpG5+okUj2mNV0MvZAOx28dL2ifdRnREwrRFKZSwC5IEHOK/PMkifuTZK39
 XDdtUoW/ZyFX7reTLZRx2dENXwQo8p4OQcVokwPd/79PsBZUfe5VGsEmvuOz6jO3ngZDJVtQ9XR
 bZiNTsyBxyuKolMxnBdJgqB2/P3PRF8BQsorkP+XZS6rkmCvFkNUkSKrdmjd27B4+8vWvMreo1Y
 2vFhVjBVkk1VFxVS+SxfYI0ewkZIIkMSyMPtgcgJ3uVUU4Dt0EtJ+Ay0dSikhfBMyQuvY0/28Mw
 rwyV3NtJmdrJsKoQYLxP8y5tBsp6gbo70rZ58fUjinGYQCXVpkdvTGNoX/vI32EQhkudX7Unt1o
 tRc1FVCPudZlWyYNK5JKKRtdLMeO8nnPrAWNyHdFlN+qZSTbDiACu619sW6k02mZ5Id8U+O3ExB
 87XRFwtn/PBGRG6oSSXc5ZSKXDnr0igLexKT1CsCzeLR3O4B2bPaCzghyseFzSieIlLdbg3EKCv
 EPcokEPcaX14xhAnKo=
X-Received: by 2002:a05:600c:8115:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-4953c14f78dmr45418425e9.2.1784147617760; 
 Wed, 15 Jul 2026 13:33:37 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c59b810sm83871685e9.0.2026.07.15.13.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 13:33:37 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers on
 GFX6-8
Date: Wed, 15 Jul 2026 22:33:36 +0200
Message-ID: <14520093.2vocr9iq0E@timur-max>
In-Reply-To: <20260715111051.A0D9F1F000E9@smtp.kernel.org>
References: <20260715105757.13125-1-timur.kristof@gmail.com>
 <20260715105757.13125-3-timur.kristof@gmail.com>
 <20260715111051.A0D9F1F000E9@smtp.kernel.org>
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

On 2026. j=C3=BAlius 15., szerda 13:10:51 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 sashiko-
bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider: - [High] Uninitialized variable `block_size_log2` in
> GFX6 modifier path causes undefined behavior and potential kernel panic. -
> [High] User-controlled `PIPE_CONFIG` in GFX6 modifier can trigger
> `unreachable()`, leading to kernel panic or undefined behavior. - [Medium]
> Unbounded `drm_err()` on invalid GFX6 array mode allows userspace to flood
> the kernel log. --
>=20
> --- Patch [2]: [PATCH 2/4] drm/amdgpu: Convert tiling flags to modifiers =
on
> GFX6-8 --- commit 642125971654c581668fe700356dfbee6905eccc
> Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Subject: drm/amdgpu: Convert tiling flags to modifiers on GFX6-8
>=20
> This commit converts the tiling flags to modifiers on GFX8 and older,
> so that the DC display driver can rely on them like on newer generations.
>=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c index
> > 950937b363fbe..dcca930ed3c04 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>=20
> [ ... ]
>=20
> > @@ -940,6 +940,55 @@ static int convert_tiling_flags_to_modifier(struct
> > amdgpu_framebuffer *afb)>=20
> >  	return 0;
> > =20
> >  }
> >=20
> > +static int convert_tiling_flags_to_modifier_gfx6(struct
> > amdgpu_framebuffer *afb) +{
> > +	const uint32_t array_mode =3D AMDGPU_TILING_GET(afb->tiling_flags,
> > ARRAY_MODE); +	const uint32_t pipe_config =3D
> > AMDGPU_TILING_GET(afb->tiling_flags, PIPE_CONFIG);
> [ ... ]
>=20
> > +	switch (array_mode) {
> > +	case DC_ARRAY_LINEAR_GENERAL:
> > +	case DC_ARRAY_LINEAR_ALLIGNED:
> > +		modifier =3D DRM_FORMAT_MOD_LINEAR;
> > +		break;
> > +
> > +	case DC_ARRAY_2D_TILED_THIN1:
> > +		/* Macro tiled modes only */
> > +		modifier |=3D
> > +			AMD_FMT_MOD_SET(PIPE_CONFIG, pipe_config) |
> > +			AMD_FMT_MOD_SET(TILE_SPLIT, tile_split) |
> > +			AMD_FMT_MOD_SET(BANK_WIDTH, bank_width) |
> > +			AMD_FMT_MOD_SET(BANK_HEIGHT, bank_height) |
> > +			AMD_FMT_MOD_SET(MACRO_TILE_ASPECT,=20
macro_tile_aspect) |
> > +			AMD_FMT_MOD_SET(NUM_BANKS, num_banks);
> > +		fallthrough;
> > +
> > +	case DC_ARRAY_1D_TILED_THIN1:
> > +		/* Micro and macro tiled modes */
> > +		modifier |=3D
> > +			AMD_FMT_MOD |
> > +			AMD_FMT_MOD_SET(TILE_VERSION,=20
AMD_FMT_MOD_TILE_VER_GFX6) |
> > +			AMD_FMT_MOD_SET(TILE, array_mode) |
> > +			AMD_FMT_MOD_SET(MICROTILE, micro_tile_mode);
> > +		break;
> > +
> > +	default:
> > +		drm_err(&adev->ddev, "array mode 0x%x not supported by=20
DCE\n",
> > array_mode);
> [Severity: Medium]
> Could this drm_err() be triggered repeatedly by a user space process
> providing an invalid array_mode to DRM_IOCTL_MODE_ADDFB2, flooding the
> kernel log?
>=20
> Should this use a rate-limited print or drm_dbg_kms() instead to prevent =
log
> spam from unprivileged users?

I will just change this to drm_dbg_kms()

>=20
> > +		return -EINVAL;
> > +	}
> > +
> > +	afb->base.modifier =3D modifier;
> > +	afb->base.flags |=3D DRM_MODE_FB_MODIFIERS;
> > +	return 0;
> > +}
>=20
> [ ... ]
>=20
> > @@ -1093,7 +1142,7 @@ static int amdgpu_display_verify_sizes(struct
> > amdgpu_framebuffer *rfb)>=20
> >  			get_block_dimensions(block_size_log2,=20
format_info->cpp[i],
> >  		=09
> >  					     &block_width,=20
&block_height);
> >=20
> > -		} else {
> > +		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >=3D
> > AMD_FMT_MOD_TILE_VER_GFX9) {>=20
> >  			int swizzle =3D AMD_FMT_MOD_GET(TILE,=20
modifier);
> >  		=09
> >  			switch ((swizzle & ~3) + 1) {
> >=20
> > @@ -1120,6 +1169,60 @@ static int amdgpu_display_verify_sizes(struct
> > amdgpu_framebuffer *rfb)>=20
> >  			get_block_dimensions(block_size_log2,=20
format_info->cpp[i],
> >  		=09
> >  					     &block_width,=20
&block_height);
> >=20
> > +		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) =3D=3D
> > AMD_FMT_MOD_TILE_VER_GFX6) { +			const u32=20
display_micro_tile_pitch =3D 32;
> > /* required by DCE */ +			const u32=20
micro_tile_width =3D 8;
> > +			const u32 micro_tile_height =3D 8;
> > +			const u32 micro_tile_mode =3D=20
AMD_FMT_MOD_GET(MICROTILE, modifier);
> > +			const u32 array_mode =3D AMD_FMT_MOD_GET(TILE,=20
modifier);
> > +			u32 num_banks, bank_width, bank_height,=20
pipe_config,
> > macro_tile_aspect;
> > +			u32 num_pipes;
> > +
> > +			if (AMD_FMT_MOD_GET(DCC, modifier)) {
> > +				drm_dbg_kms(rfb->base.dev, "DCC=20
is not displayable on GFX6-8\n");
> > +				return -EINVAL;
> > +			}
> > +			if (array_mode !=3D=20
AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 &&
> > +			    array_mode !=3D=20
AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
> > +				drm_dbg_kms(rfb->base.dev,
> > +					"Array mode %u is not=20
supported by the display driver\n",
> > +					array_mode);
> > +				return -EINVAL;
> > +			}
> > +			if (micro_tile_mode !=3D=20
AMD_FMT_MOD_MICROTILE_DISPLAY) {
> > +				drm_dbg_kms(rfb->base.dev,
> > +					"Micro tile mode %u is=20
not displayable on GFX6-8\n",
> > +					micro_tile_mode);
> > +				return -EINVAL;
> > +			}
> > +
> > +			num_banks =3D 2 << AMD_FMT_MOD_GET(NUM_BANKS,=20
modifier);
> > +			bank_width =3D 1 <<=20
AMD_FMT_MOD_GET(BANK_WIDTH, modifier);
> > +			bank_height =3D 1 <<=20
AMD_FMT_MOD_GET(BANK_HEIGHT, modifier);
> > +			pipe_config =3D AMD_FMT_MOD_GET(PIPE_CONFIG,=20
modifier);
> > +			macro_tile_aspect =3D 1 <<=20
AMD_FMT_MOD_GET(MACRO_TILE_ASPECT, modifier);
> > +
> > +			if (pipe_config >=3D=20
AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16)
> > +				num_pipes =3D 16;
> > +			else if (pipe_config >=3D=20
AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16)
> > +				num_pipes =3D 8;
> > +			else if (pipe_config >=3D=20
AMD_FMT_MOD_PIPE_CONFIG_P4_8x16)
> > +				num_pipes =3D 4;
> > +			else if (pipe_config =3D=3D=20
AMD_FMT_MOD_PIPE_CONFIG_P2)
> > +				num_pipes =3D 2;
> > +			else
> > +				unreachable();
>=20
> [Severity: High]
> Since pipe_config comes from AMD_FMT_MOD_GET(PIPE_CONFIG, modifier), which
> is user-controlled via the framebuffer modifier, could a user pass a value
> smaller than AMD_FMT_MOD_PIPE_CONFIG_P2?
>=20
> If so, hitting unreachable() here would result in undefined compiler
> behavior. With CONFIG_OBJTOOL enabled, it can emit an invalid instruction
> that immediately panics the kernel. If execution falls through, num_pipes
> remains uninitialized and is subsequently used in a multiplication.

I will replace unreachable() with "return -EINVAL"

>=20
> > +
> > +			if (array_mode <=20
AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1) {
> > +				block_width =3D=20
display_micro_tile_pitch;
> > +				block_height =3D micro_tile_height;
> > +			} else {
> > +				/* Assume non-PRT macro tiling=20
modes */
> > +				block_width =3D num_pipes *=20
micro_tile_width *
> > +					      bank_width *=20
macro_tile_aspect;
> > +				block_height =3D micro_tile_height=20
* bank_height *
> > +					       num_banks /=20
macro_tile_aspect;
> > +			}
> >=20
> >  		}
> >  	=09
> >  		ret =3D amdgpu_display_verify_plane(rfb, i, format_info,
> >  	=09
> >  						 =20
block_width, block_height, block_size_log2);
>=20
> [Severity: High]
> Does this pass an uninitialized block_size_log2 into
> amdgpu_display_verify_plane()?

I will fix that, thanks for noticing.



