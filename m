Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D640710E2E9;
	Wed,  8 Jul 2026 22:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k734MGjF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C8F10E2E9
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 22:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13BC040A44;
 Wed,  8 Jul 2026 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8E91F000E9;
 Wed,  8 Jul 2026 22:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783551027;
 bh=pvcYcP/ZkKsKu7heeWROS5l9KXctNGQfSnDTs6tuRDU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k734MGjFOFcetJRJrquCmmNH0dPXPZOaqRoJwaq3JIEEkd8QVSKZdcwsw2BW48HlJ
 6F0ZqJH33HMriBd5KHiFpWGDPER1iRKbZ3YXnMdd6tC9NfZ04w+o/H3Na58DJ2Az5B
 +B6bX4D7Ax78u3l7bS/lq+RzBt7ho/1OC5HiHfE001JLZOlQnBok9RSmcJsXeONo+I
 zbzatAd4lkxNjURwK1GZZBNzC1OS7/536ruf1B7kNfGk0xm9ApPmuVuW7Nq2enxhr0
 +i+fk3PmG/qdr8zQLYIfJ7J30ARsBHuZ72iyEyktDz3kS1Jw/lyd1Hnoe+cDdrfjKK
 hvUal4NTOQYjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: fix vertical stride miscalculation in
 get_block_step_bytes()
To: "Ibrahim Hashimov" <security@auditcode.ai>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708223840.973-1-security@auditcode.ai>
References: <20260708223840.973-1-security@auditcode.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:50:26 +0000
Message-Id: <20260708225026.BC8E91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An integer overflow in `packed_pixels_offset()` causes an out-of-b=
ounds read of kernel memory, which can be leaked to userspace via the write=
back connector.
--

--- Patch [1]: [PATCH] drm/vkms: fix vertical stride miscalculation in get_=
block_step_bytes() ---
commit a61fac2777668983a99bbe0fb747107d5091181a
Author: Ibrahim Hashimov <security@auditcode.ai>

drm/vkms: fix vertical stride miscalculation in get_block_step_bytes()

This commit fixes a vertical stride miscalculation in get_block_step_bytes()
by replacing block width with block height for vertical directions. This
corrects an out-of-bounds read and restores the invariant that the vertical
step is exactly one row of blocks.

> drm/vkms: fix vertical stride miscalculation in get_block_step_bytes()
>=20
> get_block_step_bytes() computes the byte distance between two
> vertically adjacent pixel blocks for the READ_TOP_TO_BOTTOM and
> READ_BOTTOM_TO_TOP directions as:
[ ... ]
> This is exactly how packed_pixels_offset() computes
> it a few lines above in the same file:
>=20
>         int block_pitch =3D fb->pitches[plane_index] *
>                            drm_format_info_block_height(format, plane_ind=
ex);

[Severity: High]
This is a pre-existing issue, but does the calculation in
packed_pixels_offset() suffer from a signed integer overflow?

In drivers/gpu/drm/vkms/vkms_formats.c:packed_pixels_offset(), both
block_y and block_pitch are evaluated as signed 32-bit integers.
While the DRM core restricts height * pitch <=3D UINT_MAX, it does not
prevent the product from exceeding INT_MAX.

If a valid framebuffer is created with height =3D 8192 and pitch =3D 524287,
the y coordinate can go up to 8191. The resulting offset calculation:

    *offset =3D fb->offsets[plane_index] +
              block_y * block_pitch +
              block_x * format->char_per_block[plane_index];

would cause block_y * block_pitch to exceed 2,147,483,647 and overflow
into a negative value.

Could this resulting negative offset cause the blending logic to read from
out-of-bounds kernel memory, potentially leaking it to userspace via the
writeback connector?

> For 1x1-block formats (block_width =3D=3D block_height =3D=3D 1) the two
> expressions happen to coincide, which is why the bug went unnoticed
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index dfb8e13cba87a..1e3a6af9cea52 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708223840.973-=
1-security@auditcode.ai?part=3D1
