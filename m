Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053BDC5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B255E10F311;
	Fri, 21 Aug 2026 14:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Uc42e0TA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA3B10F31E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5DA4140591
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166061F000E9;
 Fri, 21 Aug 2026 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787324102;
 bh=Eiuvuka7dCCFwjjbQ4XnDvlDPSOeUG8BnffJk9c/Y5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uc42e0TAxHNdLZq8sKp1cahbYafxJO2LVb8IN2HvXEj1ngKyd/fLT92Vubx8hqZ+z
 BKCBrGv4L2ZX+v4o5ked+FKAr5qIUXIQxPGmPcH24Eq01xCVVxGOc/W3+yFv2oxr5o
 xIMyWFCOqRi2sA5QKl7jTxKqihCXJIh2l68IaBvzIR/f86VifFhdtFJoDdomhRvOcU
 YC/Q4z0Yy+YEJJBgr0QClz1BDp313AqIYcdqmFZX5Ou0acc2GCOV1GBKWFLzrYSPsu
 X0kh/Wmc6R9HlWzENscczIzI4sW8i3+YHYfol47YEB0Z9AOPjNhUJlSKY2JvUyiJJ6
 KGRLUqJPsxNeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/70] drm/adp: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-1-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-1-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:55:01 +0000
Message-Id: <20260821145502.166061F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing NULL check for `dma_alloc_coherent` and potential integer =
overflow in `new_size` calculation.
- [High] Calling `dma_alloc_coherent()` with `GFP_KERNEL` during `atomic_fl=
ush` violates DRM atomic context constraints.
--

--- Patch [1]: [PATCH 01/70] drm/adp: Switch to drm_atomic_helper_crtc_crea=
te_state ---
commit 3f2217690a441eaa2502ebbe2a7e5840385ac1e3
Author: Maxime Ripard <mripard@kernel.org>

drm/adp: Switch to drm_atomic_helper_crtc_create_state

The adp crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> index ce9dd6222634d..fdf0e63161756 100644
> --- a/drivers/gpu/drm/adp/adp_drv.c
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -351,7 +351,7 @@ static const struct drm_crtc_funcs adp_crtc_funcs =3D=
 {
>  	.destroy =3D drm_crtc_cleanup,
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  	.enable_vblank =3D adp_crtc_enable_vblank,

[Severity: High]
This is a pre-existing issue, but does calling dma_alloc_coherent() with
GFP_KERNEL in adp_crtc_atomic_flush() violate DRM atomic context constraint=
s?

drivers/gpu/drm/adp/adp_drv.c:adp_crtc_atomic_flush() {
...
		if (new_size !=3D 0) {
			adp->mask_buf =3D dma_alloc_coherent(crtc->dev->dev, new_size,
							   &adp->mask_iova, GFP_KERNEL);

adp_crtc_atomic_flush() executes during the hardware programming phase of
drm_atomic_helper_commit_tail(), which is an atomic context where sleeping
is forbidden.

dma_alloc_coherent() with GFP_KERNEL can sleep, potentially causing kernel
warnings and deadlocks.

[Severity: High]
This isn't a bug introduced by this patch, but what happens if
dma_alloc_coherent() returns NULL?

drivers/gpu/drm/adp/adp_drv.c:adp_crtc_atomic_flush() {
...
		if (new_size !=3D 0) {
			adp->mask_buf =3D dma_alloc_coherent(crtc->dev->dev, new_size,
							   &adp->mask_iova, GFP_KERNEL);
			memset(adp->mask_buf, 0xFF, new_size);

The immediate memset() would dereference the NULL pointer.

Additionally, does the calculation of new_size in adp_crtc_atomic_flush() r=
un
the risk of a 32-bit integer overflow for maliciously large resolutions?

	u64 new_size =3D ALIGN(new_state->mode.hdisplay *
			     new_state->mode.vdisplay * 4, PAGE_SIZE);

Is there a chance hdisplay * vdisplay * 4 could overflow before being cast
to u64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D1
