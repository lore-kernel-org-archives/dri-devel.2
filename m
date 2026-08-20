Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0CDC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F0E10F136;
	Thu, 20 Aug 2026 17:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhVZQc3g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66EF10F136
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:11:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5CAA60A5D;
 Thu, 20 Aug 2026 17:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB61F000E9;
 Thu, 20 Aug 2026 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787245865;
 bh=QG5HxDKn7NzximHb80hKBjthbOnshEjiIlgeUQ33+LY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fhVZQc3gCzNox99TTlx0EmRm2Esb9KDJ3HasPmOBl8uHV9aUGnh/J7+3A5r6R+MUc
 FbWtq+7qvGppJiEupq9FeJ6q6N9A0K4E9XDbJiPDvCJTrLeepyOVl/dZj3My96HDJP
 QuWp7BSwEu9DsOZzVvBe+l9hlqJ4ZCni4Ll99u9Tcx209aSJm1qoDi2//doNY2xHZ2
 aXF8dIC9rs4BNvCxthSS+805NpMabAGQDBdrfVwA1SHHc6gFk/dVTEUlbM+Iaklv46
 Dr8r/ANwgDUiuRci51TI4q4mm1T29rdPvSmHztZOf2zb1O9dztugpIosXe28WeBa3l
 RMJKcEVoev7+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Return gem fd handle for scanout buffers
To: "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820165838.442723-1-maaz.mombasawala@broadcom.com>
References: <20260820165838.442723-1-maaz.mombasawala@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 17:11:04 +0000
Message-Id: <20260820171105.7CBB61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Passing an `int *` to a function expecting a `u32 *` causes an inco=
mpatible pointer type build failure.

Pre-existing issues:
- [High] Concurrent lockless access to the RB-tree `vbo->res_tree` leads to=
 tree corruption and an associated Use-After-Free window.
--

--- Patch [1]: [PATCH] drm/vmwgfx: Return gem fd handle for scanout buffers=
 ---
commit b5937886d1e50afefe640e402b3c52ae509b9578
Author: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

drm/vmwgfx: Return gem fd handle for scanout buffers

When prime_handle_to_fd is called on a gem buffer handle, we return an
fd for the surface handle if the gem buffer backs a surface.
Return the gem buffer's handle instead for cases when the surface is a
scanout buffer.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.h
> index 38bea8abab84c..ff33ba1075a40 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h

[ ... ]

> @@ -1180,9 +1180,11 @@ int vmw_gb_surface_define(struct vmw_private *dev_=
priv,
>  struct vmw_surface *vmw_lookup_surface_for_buffer(struct vmw_private *vm=
w,
>  						  struct vmw_bo *bo,
>  						  u32 handle);
> -u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
> -					 struct vmw_bo *bo,
> -					 u32 handle);
> +void vmw_lookup_surface_and_handle_for_buffer(struct vmw_private *vmw,
> +					      struct vmw_bo *bo,
> +					      u32 handle,
> +					      u32 *srf_handle,
> +					      struct vmw_surface **p_srf);
>  int vmw_dumb_create(struct drm_file *file_priv,

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_prime.c
> index 598b90ac7590b..7e6581ee09cc1 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> @@ -93,8 +93,9 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
>  	struct vmw_private *vmw =3D vmw_priv(dev);
>  	struct ttm_object_file *tfile =3D vmw_fpriv(file_priv)->tfile;
>  	struct vmw_bo *vbo;
> +	struct vmw_surface *surface =3D NULL;
> +	int surf_handle =3D 0;
>  	int ret;
> -	int surf_handle;
> =20
>  	if (handle > VMWGFX_NUM_MOB) {
>  		ret =3D ttm_prime_handle_to_fd(tfile, handle, flags, prime_fd);
> @@ -106,16 +107,19 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
>  			ret =3D drm_gem_prime_handle_to_fd(dev, file_priv, handle,
>  							 flags, prime_fd);
>  		} else {
> -			surf_handle =3D vmw_lookup_surface_handle_for_buffer(vmw,
> -									   vbo,
> -									   handle);
> -			if (surf_handle > 0)
> +			vmw_lookup_surface_and_handle_for_buffer(vmw, vbo,
> +								 handle,
> +								 &surf_handle,
                                                                 ^^^^^^^^^^=
^^

[Severity: Low]
Does passing an int pointer to a parameter that expects a u32 pointer cause=
 a
compiler warning or build failure?

The function signature for vmw_lookup_surface_and_handle_for_buffer() expli=
citly
requires a u32 pointer for the fourth parameter.

[Severity: High]
This isn't a bug introduced by this patch, but does calling this locklessly
lead to tree corruption or a use-after-free?

When vmw_prime_handle_to_fd() calls vmw_lookup_surface_and_handle_for_buffe=
r(),
it eventually calls vmw_bo_surface() which iterates over the vbo->res_tree
RB-tree locklessly:

drivers/gpu/drm/vmwgfx/vmwgfx_bo.c:vmw_bo_surface() {
    ...
    for (rb_itr =3D rb_first(&vbo->res_tree); rb_itr;
         rb_itr =3D rb_next(rb_itr)) {
    ...
}

Concurrently, other ioctls can acquire the dma_resv lock and modify the
res_tree. Can this concurrent modification result in an infinite loop or a
kernel crash?

Also, in vmw_lookup_user_surface_for_buffer(), the RCU read lock is acquired
after the pointer surf has already been retrieved:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_lookup_user_surface_for_buffer(=
) {
    ...
    surf =3D vmw_bo_surface(bo);
    if (surf) {
        rcu_read_lock();
    ...
}

Could this leave a window where the object can be freed before the lock is
acquired?

> +								 &surface);
> +			if (surface && !surface->metadata.scanout)
>  				ret =3D ttm_prime_handle_to_fd(tfile, surf_handle,
>  							     flags, prime_fd);
>  			else
>  				ret =3D drm_gem_prime_handle_to_fd(dev, file_priv,
>  								 handle, flags,
>  								 prime_fd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820165838.4427=
23-1-maaz.mombasawala@broadcom.com?part=3D1
