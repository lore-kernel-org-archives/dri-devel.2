Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A04606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwqXsG28
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7343A10E51B;
	Thu, 29 Oct 2026 08:35:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2355B10E51B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:34:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF6A943503;
 Thu, 29 Oct 2026 08:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4FD1F01825;
 Thu, 29 Oct 2026 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793262896;
 bh=1Ouf2mmj4Y8UxWzhKa8KzLvb3IP4Kq+84OZcI7QUlMI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QwqXsG28fQ2UuuT4f5Wl6x+DVCyo3NoOTr4LTWQpZ59G1rG6BsvsnxFQaJtdJjvcp
 R+1mMWf78kI46aLyWUvgn63LeZ6h4IemBwPZYZmClzbQ0KfOqecpJDQ9LDyTozVsE2
 mDRfs3AmKnl5dYJ72bu/TNrl62/viLcvo4ZAoJnTcUaeYLXxJPH1MTA3yxtSiTMzpD
 CRda0aLybGSVbQjntq5WamGNFHHge57ho+8M4ojiwRfvlgtzIJ40k/aHrjyTTVHHUG
 cE+My/L28RsP0O6fDHacJd6Kip9EUfVkkBNALhMazwAdxyN6QoSWxoR+dqacLdgouR
 OJfT+vR1u9C3g==
Message-ID: <sashiko-outbox-188969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/rockchip: vop2: Use
 drm_format_info_min_pitch() for plane offsets
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029081429.862-2-kernel@airkyi.com>
References: <20261029081429.862-1-kernel@airkyi.com>
 <20261029081429.862-2-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:34:56 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/rockchip: vop2: 64-bit division by hsub in vop2_plane_atomic=
_update()
--

commit 6053e1180bcd99e2d0019c04165b9318bc1a9fc3
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: vop2: Use drm_format_info_min_pitch() for plane offsets

This commit replaces fb->format->cpp[] with drm_format_info_min_pitch()
when computing horizontal plane offsets in vop2_plane_atomic_update() to
support packed 10-bit formats such as NV15, NV20, and NV30.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..adee018c6ef07 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> @@ -1309,7 +1309,7 @@ static void vop2_plane_atomic_update(struct drm_pla=
ne *plane,
>  		int hsub =3D fb->format->hsub;
>  		int vsub =3D fb->format->vsub;
> =20
> -		offset =3D (src->x1 >> 16) * fb->format->cpp[1] / hsub;
> +		offset =3D drm_format_info_min_pitch(fb->format, 1, src->x1 >> 16) / h=
sub;

[Severity: Medium]
Does dividing the return value of drm_format_info_min_pitch() by hsub in
vop2_plane_atomic_update() cause a 64-bit division linker regression on
32-bit architectures?

drm_format_info_min_pitch() returns a uint64_t:

drivers/gpu/drm/drm_fourcc.c:drm_format_info_min_pitch() {
	if (!info || plane < 0 || plane >=3D info->num_planes)
		return 0;

	return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[plane],
			    drm_format_info_block_width(info, plane) *
			    drm_format_info_block_height(info, plane));
}

Because hsub is a runtime int variable, dividing the uint64_t result
directly with '/' promotes the expression to a 64-bit unsigned division
before assigning to unsigned long offset. Since CONFIG_ROCKCHIP_VOP2 can be
built on 32-bit targets (via 32-bit ARM ARCH_ROCKCHIP or COMPILE_TEST),
this emits an unresolved call to __aeabi_uldivmod or __udivdi3 at link time.

Additionally, drm_format_info.block_w[1] is defined in units of subsampled
chroma pixels (for example, block_w is { 4, 2, 0 } for NV15 and NV20), so
drm_format_info_min_pitch() expects buffer_width for plane 1 to already be
subsampled. Dividing by hsub after DIV_ROUND_UP_ULL() rounds up before
subsampling and then truncates.

Should (src->x1 >> 16) / hsub be passed as the buffer_width argument to
drm_format_info_min_pitch(), or should offset be assigned before dividing by
hsub as is done in vop_plane_atomic_update() in rockchip_drm_vop.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029081429.862-=
1-kernel@airkyi.com?part=3D1
