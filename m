Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF160606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JlhB53Dt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD1110ED69;
	Mon, 16 Nov 2026 09:05:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15D010ED69
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 09:04:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D3EB4168B;
 Mon, 16 Nov 2026 09:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E951F000C4;
 Mon, 16 Nov 2026 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794819893;
 bh=+A3+MNOLgN2dCbdmsfPHdZsamFx2Y2kd6CS1caYfwZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JlhB53Dtk1GaHYavXbNS7k13YKgHFwIafkxVLUT4gjmB9iJ5jGirl2Eg4jzy7UB8P
 LRVJ/09E00XHnVIBBsZsC5jcnGmcnGNl7XcWaG5fiJduL2oUkMTnYfvZfLnXscTsFz
 UrxdOXjMnphDeoiAVcmG35CVJeacVOsnWf5F+hYHloeRYITvx3dRpu+ky1o17gXqM4
 90c3/LrG9C0MAIypZxW57V7Ta1hqF+j/oqReb61wajIcVmbUaBO4B5X89sUISjdCJy
 QeVAVY6pWaeBAtnw/R3GDuvGUXMKy2K3WjBdeKZpBiD3WvBVfkQ1FnBcbjIDd0XD4M
 7VmgkdABARq2w==
Message-ID: <sashiko-outbox-216579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] drm/rockchip: vop2: Use
 drm_format_info_min_pitch() for plane offsets
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116084555.1061-2-kernel@airkyi.com>
References: <20261116084555.1061-1-kernel@airkyi.com>
 <20261116084555.1061-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:04:52 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/rockchip: vop2: unaligned block offset for 10-bit packed
  YUV in vop2_plane_atomic_update()
--

commit e065b869dbf756b6652ed995b5a03b6d5409975e
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Use drm_format_info_min_pitch() for plane offsets

This commit replaces fb->format->cpp[] with drm_format_info_min_pitch()
when calculating plane byte offsets in vop2_plane_atomic_update() to
support block-packed 10-bit formats such as NV15, NV20, and NV30.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..0de038acb56fc 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1290,7 +1290,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
> =20
>  	afbc_en =3D drm_is_afbc(fb->modifier);
> =20
> -	offset =3D (src->x1 >> 16) * fb->format->cpp[0];
> +	offset =3D drm_format_info_min_pitch(fb->format, 0, src->x1 >> 16);
> =20
>  	/*
>  	 * AFBC HDR_PTR must set to the zero offset of the framebuffer.
> @@ -1309,7 +1309,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
>  		int hsub =3D fb->format->hsub;
>  		int vsub =3D fb->format->vsub;
> =20
> -		offset =3D (src->x1 >> 16) * fb->format->cpp[1] / hsub;
> +		offset =3D (u32)drm_format_info_min_pitch(fb->format, 1, src->x1 >> 16=
) / hsub;
>  		offset +=3D (src->y1 >> 16) * fb->pitches[1] / vsub;
> =20
>  		if ((pstate->rotation & DRM_MODE_REFLECT_Y) && !afbc_en)

[Severity: Medium]
Can this compute misaligned yrgb_mst and uv_mst offsets for NV15, NV20,
and NV30 when src->x1 >> 16 is not a multiple of 4?

Those formats pack 4 luma pixels and 2 chroma pairs into 5-byte blocks
(char_per_block =3D { 5, 5, 0 }, block_w =3D { 4, 2, 0 }), but
vop2_plane_atomic_check() only requires 2-pixel alignment on src_x for YUV
formats:

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:vop2_plane_atomic_check() {
    ...
	if (fb->format->is_yuv && src_x % 2) {
		drm_dbg_kms(vop2->drm, "Invalid Source: Yuv format not support odd xpos\n=
");
		return -EINVAL;
	}
    ...
}

When src_x % 4 =3D=3D 2 (2.5 bytes into a 5-byte block),
drm_format_info_min_pitch() rounds plane 0 up via DIV_ROUND_UP_ULL() to a
3-byte offset inside a packed 4-pixel block, while dividing plane 1's
5-byte result by hsub =3D 2 on NV15 and NV20 truncates uv_mst down to a
2-byte offset.  This corrupts scanout and, when src_x + src_w reaches
fb->width with src_w % 4 =3D=3D 2, can cause DMA to read 1 byte past the
validated framebuffer pitch on the final scanline.  Should
vop2_plane_atomic_check() also require src_x to be aligned to
drm_format_info_block_width()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116084555.1061=
-1-kernel@airkyi.com?part=3D1
