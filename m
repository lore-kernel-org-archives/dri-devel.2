Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C92606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPWnhgLq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA50E10E2C4;
	Tue, 10 Nov 2026 08:44:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC27510E2C4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A04D0437B5;
 Tue, 10 Nov 2026 08:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E261F0089F;
 Tue, 10 Nov 2026 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794300259;
 bh=4idCkFkRpH1req2etKHzdHiI/h61uOTNpanzDzYgeAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YPWnhgLqqfPb4Lh7w1QnSZ/MYRXyLeF5A93kzcwF7hZ9Ooyo6B9MKrZ6qP42K2628
 3eeake0FznlUN1pgWS9/j1undR++W+jUMJgb45xMgKqHYjI3IhqhnoT0VzjDb+GT7K
 oMH/QDthU5Mi9mJLFEI+Szj/FXDNZ32sJN+xxodxmimmDF92MY/mGfwR96RteGef0/
 1aAsmfr+48zHbsLt9BgDCAjIxp+4rSMlOBTtsFXj+DdPM0li4u0gZl4yUy3Xh9f8TB
 MTC7Ehr319vgBjh6lrjZtoT2Z++gHFPD+bVtOPGkFD+jWdM1OW7TdFF7K0tvB9jUj1
 HFW4t2VM1ffog==
Message-ID: <sashiko-outbox-206657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] drm/rockchip: vop2: Fix the AFBC offsets of a
 source that starts inside a superblock
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-vop2-fixes-v1-8-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
 <20261110-vop2-fixes-v1-8-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:44:18 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/rockchip: vop2: wrong 32x8 AFBC x mask in
  vop2_afbc_transform_offset()
- [Low] drm/rockchip: vop2: missing Fixes trailer for commit
  604be85547ce
--

commit 1aeff8145623ebb58cb0a14969b5391365ee2e1c
Author: Arun Iyengar <aiyengar1990@gmail.com>

> drm/rockchip: vop2: Fix the AFBC offsets of a source that starts inside a=
 superblock
>
> The AFBC decoder of a window takes the position of the source in the
> framebuffer (AFBC_PIC_OFFSET), the number of superblock columns to
> decode (AFBC_TILE_NUM) and the offset of the first pixel inside its
> superblock (the transform offset). For a source that doesn't start at
> x =3D 0:
>
> - The tile number only counts the superblocks of the source width, one
>   short when the source starts inside a superblock and ends inside
>   another one.
> - The transform offset is the whole x position, truncated to the 8 bit
>   field, instead of the position in the 16 pixel wide superblock.
>
> Count the superblock columns from the first one the source touches, and
> take the x offset in the superblock, like the vendor kernel does for the
> not mirrored cases. The X mirrored and rotated cases are left as they are.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

[Severity: Low]
Since this fixes a bug introduced with the initial VOP2 driver, should it
include:

  Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 9ad138457204f..dfb76bfbc358f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -486,7 +486,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plan=
e_state *pstate,
>  		ty =3D act_yoffset;
>  		break;
>  	case DRM_MODE_REFLECT_Y:
> -		tx =3D act_xoffset;
> +		tx =3D act_xoffset & 0xf;
>  		ty =3D bottom_crop_line_num - act_yoffset;
>  		break;
>  	case DRM_MODE_ROTATE_90:
> @@ -498,7 +498,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plan=
e_state *pstate,
>  		ty =3D vir_width - width - act_xoffset;
>  		break;
>  	case 0:
> -		tx =3D act_xoffset;
> +		tx =3D act_xoffset & 0xf;
>  		ty =3D act_yoffset;
>  		break;
>  	}

[Severity: Medium]
Does masking act_xoffset with 0xf break 32x8 AFBC superblocks when
(act_xoffset % 32) is between 16 and 31?

In vop2_plane_atomic_update(), block_w is 32 when
AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 is set (such as on RK3576 cluster windows),
and afbc_tile_num is computed using (src->x1 >> 16) % block_w.  Hardcoding
0xf here truncates tx to 0..15 instead of 0..31, shifting the decoded
plane horizontally by 16 pixels whenever bit 4 of act_xoffset is set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-vop2-fixes=
-v1-0-d336e9dd90d3@gmail.com?part=3D8
