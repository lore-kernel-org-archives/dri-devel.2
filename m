Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C883C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B76489C46;
	Sun, 23 Aug 2026 09:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NuIJ7rGV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE7D8979D
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:15:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C76A40988;
 Sun, 23 Aug 2026 09:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378ED1F000E9;
 Sun, 23 Aug 2026 09:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787476550;
 bh=ibjjloh4bExvDbTjhuDbPd017AE+wEnBWeqsccy0wdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NuIJ7rGVcy9UF2gEBUFTDuR4ZcN6RLQj5GO9ggmyG4/snItygSPr+IJqsxlNxfGLh
 FnRmQxQTFPEPUcLcbDLYHh7XpwievXWc1pUmgBORc5x43vnb51MrBgFr0kvnt54Eum
 q2zHzXf9IpzfINPEfFXxQVdSdyNomEuFr4DK8saGGJ9lDkcsDFjOoL09F0d7LkRRS8
 ZxkvlSU3oQ7HF8exYaf+gdTFGvKRbK9F+G0DjvXG5c8xml8RC05YtWRzd7LD3FS1YG
 TQrxZJmwT19FY1bUM5NPk3/P0XOj6yyGCaDBn7WFDCQi8Of2i47RomQJ/dNN8iDOgK
 1hEWu/b9+JUQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: fausten <yunfeng.li.nb@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
References: <20260823083211.2654733-1-yunfeng.li.nb@email.com>
 <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 09:15:49 +0000
Message-Id: <20260823091550.378ED1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Integer overflows in framebuffer creation and cursor command s=
ubmission cause a Guest-to-Host Out-Of-Bounds Read.
- [High] Missing Error Handling / NULL Pointer Dereference in `vmw_cursor_p=
lane_prepare_fb`.
- [High] State Confusion in `vmw_cursor_plane_atomic_check` allows bypassin=
g legacy cursor dimension checks, leading to a massive kernel heap Out-Of-B=
ounds read.
--

--- Patch [1]: [PATCH v2] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENS=
ION as unset ---
commit fc08a38eba647596145d861cab4214687c5ce5ce
Author: fausten <yunfeng.li.nb@gmail.com>

drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as unset

This commit treats a reported SVGA_REG_CURSOR_MAX_DIMENSION of 0 as "not
implemented" and skips the cursor dimension check in that case. This restor=
es
the pre-existing behaviour for VMware Fusion guests (SVGA version 2) where =
the
cursor previously did not show up.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index d1e7df5001903..fbdd23ecb2b4b 100644
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
> +		/* Some SVGA implementations (e.g. VMware Fusion) report 0 here. */
> +		if (cursor_max_dim &&
> +		    (new_state->crtc_w > cursor_max_dim ||
> +		    new_state->crtc_h > cursor_max_dim)) {

[Severity: High]
This isn't a bug introduced by this patch, but does the cursor plane code h=
andle
BO mapping failures safely?

In drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c:vmw_cursor_plane_prepare_fb=
(),
the return value of vmw_bo_map_and_cache_size() is cast to void, ignoring
potential mapping failures:

    (void)vmw_bo_map_and_cache_size(bo, size);

If this mapping fails, bo->map.virtual remains NULL. Later, in
vmw_cursor_plane_atomic_update(), vmw_send_define_cursor_cmd() unconditiona=
lly
copies to the command buffer using the unvalidated image pointer:

    memcpy(&cmd[1], image, image_size);

Could this cause a NULL pointer dereference and kernel panic if memory
pressure causes the mapping to fail?

[Severity: High]
This is a pre-existing issue, but does skipping this dimension check expose
a state confusion bug that could lead to an out-of-bounds read?

In drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c:vmw_cursor_plane_atomic_che=
ck(),
update_type is evaluated using vmw_cursor_update_type(vmw, vps). At this po=
int,
vps->uo contains stale state from the previous commit, as it isn't updated =
until
vmw_cursor_plane_prepare_fb().

If userspace commits a BO-backed cursor (GB_ONLY), and then in a subsequent
commit submits a Surface-backed cursor (LEGACY) with huge dimensions
(e.g., 512x512), atomic_check will evaluate the type as GB_ONLY.

Since this patch skips the dimension check when cursor_max_dim =3D=3D 0,
the huge dimensions are accepted. When prepare_fb() runs, vps->uo is updated
and the type correctly becomes LEGACY.

Finally, in vmw_send_define_cursor_cmd(), the memcpy() reads width * height=
 * 4
bytes from the 16KB legacy surface->snooper.image buffer:

    memcpy(&cmd[1], image, image_size);

Could this result in a massive out-of-bounds read of the kernel heap being
sent to the hypervisor?

[Severity: Critical]
This is a pre-existing issue, but does bypassing this check when
cursor_max_dim =3D=3D 0 expose integer overflows that can cause a guest-to-=
host
out-of-bounds read?

If userspace creates a framebuffer with massive dimensions (e.g., 32768x327=
68),
the calculation in drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:vmw_kms_new_framebuf=
fer_bo()
overflows 32 bits:

    requested_size =3D mode_cmd->height * mode_cmd->pitches[0];
    if (unlikely(requested_size > bo->tbo.base.size)) {

This overflow to 0 allows creating a massive framebuffer with a 1-page BO.
Because this patch removes the dimension limit for cursor_max_dim =3D=3D 0,
the large cursor dimensions are accepted.

When vmw_send_define_cursor_cmd() prepares the command:

    const u32 image_size =3D width * height * sizeof(*image);
    const u32 cmd_size =3D sizeof(*cmd) + image_size;

image_size overflows to 0, resulting in only sizeof(*cmd) bytes being alloc=
ated
in the command FIFO. The hypervisor receives the command specifying a
32768x32768 cursor but no pixel data follows in the FIFO.

Will this cause the hypervisor to read 4GB out-of-bounds from the command F=
IFO?

>  			drm_warn(&vmw->drm,
>  				 "Cursor dimensions (%d, %d) exceed device max %u\n",
>  				 new_state->crtc_w, new_state->crtc_h,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823085916.2707=
488-1-yunfeng.li.nb@gmail.com?part=3D1
