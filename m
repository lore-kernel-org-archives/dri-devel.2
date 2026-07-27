Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC27C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF9E10E6C8;
	Mon, 27 Jul 2026 18:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TPYJVnwm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4992E10E6C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:33:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E24A940B58;
 Mon, 27 Jul 2026 18:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52471F000E9;
 Mon, 27 Jul 2026 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785177187;
 bh=VXqtW1zPAYSi8aSt0ukfYwMzaBuf0OSpLdxb5Mv6E2s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TPYJVnwmxzZvNSH6rEGK5Pg5LefVYu2pLkjGE9dXgGPlmYG5JS/ZAOZQ132EU/BWE
 417hMsFnR2JE7dCbqttyuXEtXYIpoqgIGTfY+WBf0xQ8HFvl1PoT0HdqvvfyH6izNJ
 GKi94gHt/Pg+zyMOWohNDNzIpyBFiL1utZxmIALAOSU/ech9mIFQXkYSP/ke10vcQJ
 dvLIGBdjYZrsN2uOMjHu6RcdT+KybQfhpE93gUqdCCM9RUbsPEJd8Z1kSd4b05VoxO
 /778p2II/XFmCCLTXDe4EXw6aaVXuqgj49hGjtn71XYsRUsLk0wSGW324ENyt/FXLP
 MA/deaPOiv+Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] drm/vmwgfx: Reserve ttm object before resv usage
To: "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727182622.236086-4-maaz.mombasawala@broadcom.com>
References: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
 <20260727182622.236086-4-maaz.mombasawala@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 18:33:07 +0000
Message-Id: <20260727183307.A52471F000E9@smtp.kernel.org>
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

New issues:
- [High] Invalid error handling for ttm_bo_reserve failure causes unbalance=
d unlock.
- [High] Race condition leading to NULL pointer dereference or Use-After-Fr=
ee of guest_memory_bo.

Pre-existing issues:
- [High] Early return in crc_generate_worker leaks surface reference and pe=
rmanently blocks CRC generation.
--

--- Patch [3]: [PATCH v6 3/4] drm/vmwgfx: Reserve ttm object before resv us=
age ---
commit b992ba3fb6a3eb8690f4284b67dfcbe8813b4aea
Author: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

drm/vmwgfx: Reserve ttm object before resv usage

This patch reserves the ttm base object when it is being used to avoid
dma_resv_assert_held warnings.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..3a739a761f3a0 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -52,10 +52,16 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>  		WARN_ON(vbo !=3D res->guest_memory_bo);
>  		WARN_ON(!res->guest_memory_bo);
>  		if (res->guest_memory_bo) {
> +			int ret =3D 0;
>  			/* Reserve and switch the backing mob. */
>  			mutex_lock(&res->dev_priv->cmdbuf_mutex);
>  			(void)vmw_resource_reserve(res, false, true);
> +			ret =3D ttm_bo_reserve(bo, false, false, NULL);
> +			if (ret !=3D 0)
> +				drm_warn(&res->dev_priv->drm,
> +					 "%s: failed reserve\n", __func__);
>  			vmw_resource_mob_detach(res);
> +			ttm_bo_unreserve(bo);

[Severity: High]
If ttm_bo_reserve() fails, the code logs a warning but continues execution.=
 Does
this result in an unbalanced unlock when ttm_bo_unreserve(bo) is unconditio=
nally
called later?

Unlocking a reservation lock that was never successfully acquired can corru=
pt
the lock state and trigger a kernel panic. Should the error path abort or s=
kip
the unlock?

>  			if (res->dirty)
>  				res->func->dirty_free(res);
>  			if (res->coherent)

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 7b8163b5e5014..d0c371df7e4c6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
>  	spin_unlock_irq(&du->vkms.crc_state_lock);
> =20
>  	if (surf) {
> +		int ret;
>  		if (vmw_surface_sync(vmw, surf)) {
>  			drm_warn(
>  				crtc->dev,
> @@ -138,7 +139,14 @@ crc_generate_worker(struct work_struct *work)
>  			return;
>  		}

[Severity: High]
This is a pre-existing issue, but does returning early here skip the
vmw_surface_unreference(&surf) call at the end of the block and leak the
surface memory?

Also, the early return skips resetting du->vkms.crc_pending to false. Will
this permanently block future CRC generation since subsequent worker execut=
ions
will think work is already pending?

> =20
> +		ret =3D ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, false, false, =
NULL);

[Severity: High]
Can this race with vmw_bo_free() and dereference a NULL pointer?

If userspace closes the GEM handle concurrently, vmw_bo_free() might execut=
e,
take the cmdbuf_mutex, set res->guest_memory_bo =3D NULL, and free the BO.

Since guest_memory_bo is accessed here without being protected by
crc_state_lock or other locks held by the worker, could this lead to a NULL
pointer dereference or use-after-free?

> +		if (ret !=3D 0) {
> +			drm_warn(&vmw->drm, "%s: failed reserve\n", __func__);
> +			goto done;
> +		}
>  		compute_crc(crtc, surf, &crc32);
> +		ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);
> +done:
>  		vmw_surface_unreference(&surf);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727182622.2360=
86-1-maaz.mombasawala@broadcom.com?part=3D3
