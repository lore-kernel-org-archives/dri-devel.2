Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2EC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514A910E008;
	Fri, 28 Aug 2026 11:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Go43AZz2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C26210E008
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 11:23:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2695601FE;
 Fri, 28 Aug 2026 11:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2251F000E9;
 Fri, 28 Aug 2026 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787916229;
 bh=f6Oi3j+3U5cY9T2jZL32NDGwOL3FvhhcxbKLbfVe9Gc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Go43AZz2f32tI7LBn7k9gZ5+Jy1lqazQ07J+rqSVkZK228Gs4mkoEm4I0xFM35M4K
 QJ8jNkhhfJWUldF7tlFpA/kTuDmu4Txp82fGLe0g9FAjGa48r1+0Bk+3Yjtv/I6oQv
 KnbbJ+hOafF7Tka8Gz2DG1a86ploSmDqTBspuSUUixZWO1nUKOyv7nwONUj06pNTpK
 bGQYQq+CBw4JxvhKYnU+dTMd/fwAz6SBME+Whp9l6y5h2oSVW2Mzr3yYZ3ApSq2N4B
 qhd+zqQEvJf+ZqVFZl4R9JsY37Ln/QuSXfpoRO74LgfE8BgDO7DofUMzsmjijVs7gt
 tg+iuhRZvMk6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: fausten <yunfeng.li.nb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828110437.1592832-1-yunfeng.li.nb@gmail.com>
References: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
 <20260828110437.1592832-1-yunfeng.li.nb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 11:23:48 +0000
Message-Id: <20260828112349.4F2251F000E9@smtp.kernel.org>
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
- [High] Bypassing the `cursor_max_dim` check for older hardware removes al=
l size limits for `VMW_CURSOR_UPDATE_GB_ONLY` cursors, leading to kernel de=
adlocks.
--

commit 40fdf3cf95cd9e88874c6ede6ef6e1bfc8402258
Author: Yunfeng Li <yunfeng.li.nb@gmail.com>

drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as unset

This commit modifies the cursor plane validation to skip the maximum dimens=
ion
check if the hardware reports a maximum of 0 (like SVGA version 2). This
fixes an issue on VMware Fusion guests where the hardware cursor would fail
to appear due to the register not being implemented.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c

[ ... ]

> @@ -748,8 +750,10 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *=
plane,
>  		u32 cursor_max_dim =3D
>  			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
> =20
> -		if (new_state->crtc_w > cursor_max_dim ||
> -		    new_state->crtc_h > cursor_max_dim) {
> +		/* Cursor MOBs, and thus this register, exist only on hw version 18+. =
*/
> +		if (cursor_max_dim > 0 &&
> +		    (new_state->crtc_w > cursor_max_dim ||
> +		     new_state->crtc_h > cursor_max_dim)) {

[Severity: High]
Does skipping this dimension check when cursor_max_dim is 0 allow userspace
to request arbitrarily large cursors?

If a user requests a massive cursor (e.g., 4096x4096), this check is bypass=
ed
and the update proceeds. Later, vmw_send_define_cursor_cmd() attempts to
allocate a command buffer for the cursor:

drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c:vmw_send_define_cursor_cmd() {
    ...
    const u32 image_size =3D width * height * sizeof(*image);
    const u32 cmd_size =3D sizeof(*cmd) + image_size;

    cmd =3D VMW_CMD_RESERVE(dev_priv, cmd_size);
    ...
}

For a 4096x4096 cursor, this results in a ~64MB allocation request. Since
this requested size vastly exceeds the typical command buffer pool, does
this cause the internal allocator to stall indefinitely?

drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:vmw_cmdbuf_alloc_space() {
    ...
    } else {
        wait_event(man->alloc_queue, vmw_cmdbuf_try_alloc(man, &info));
    }
    ...
}

Because the space can never become available for such a large allocation,
it appears this creates an uninterruptible deadlock in the DRM KMS subsyste=
m.

>  			drm_warn(&vmw->drm,
>  				 "Cursor dimensions (%d, %d) exceed device max %u\n",
>  				 new_state->crtc_w, new_state->crtc_h,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828110437.1592=
832-1-yunfeng.li.nb@gmail.com?part=3D1
