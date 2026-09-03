Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E504C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69E210F51A;
	Thu,  3 Sep 2026 11:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VpCLWZxr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6063110F51A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:29:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1303F41311;
 Thu,  3 Sep 2026 11:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072C1F000E9;
 Thu,  3 Sep 2026 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788434989;
 bh=jI8IRwHQ5Ttqa0WuZNC7/n63Yzr9jhoFqwpkKFdEevA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VpCLWZxrgca8j3r+CjC6D63qUSWLHntCdFrGcuQFhPrLd411I4trAAJm9W1AHhD8x
 tihnH4A0oBA2LidTgiEtIidLde100yOBn4fnPoV6NimsfimGCMtv9BqWDYjyUjKN6U
 kSHyvX7OCMu6gDOv3VOd2xb0gg1zlPVEU8P+DyZnCr+rJdNU8Sx/Sm06eyDjDHoCZD
 JGTAEqur6oMZeb++i4w6IzO7YmE+AHrJRyxL332TXfWuR5KYRGYTfVyyMUXKt0Ve7U
 jdRSaiuD9GMUNWsvPFPooqLLeB12iKLsZF9BLIxhwhN8u58HFalwA21Vrv2WE6PaXI
 rp21xeK3VUdGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] drm/sti: Don't use GFP_DMA when calling
 dma_alloc_wc()
To: "Baoquan He" <hebaoquan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903111836.1777265-3-hebaoquan@kylinos.cn>
References: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
 <20260903111836.1777265-3-hebaoquan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:29:48 +0000
Message-Id: <20260903112948.C072C1F000E9@smtp.kernel.org>
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
- [Critical] The `sti_cursor_atomic_check` callback incorrectly mutates per=
sistent global plane state and frees active DMA memory during the validatio=
n-only atomic check phase. This violates the DRM atomic API contract and ca=
uses a hardware use-after-free if triggered by a TEST_ONLY commit or if the=
 commit fails.
- [High] Missing error handling for DMA allocation failure in `sti_hqvdp_in=
it` leads to a NULL pointer dereference later in `sti_hqvdp_atomic_update`.
--

commit ffcf141c00928add2d88a408f8402ffc52667925
Author: Baoquan He <hebaoquan@kylinos.cn>
drm/sti: Don't use GFP_DMA when calling dma_alloc_wc()

This commit removes the redundant GFP_DMA flag from dma_alloc_wc() calls
in the sti DRM driver, as the DMA core already handles zone selection based
on the device's coherent DMA mask.

> diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_c=
ursor.c
> --- a/drivers/gpu/drm/sti/sti_cursor.c
> +++ b/drivers/gpu/drm/sti/sti_cursor.c
[ ... ]
> @@ -240,7 +240,7 @@ static int sti_cursor_atomic_check(struct drm_plane *=
drm_plane,
>  		cursor->pixmap.base =3D dma_alloc_wc(cursor->dev,
>  						   cursor->pixmap.size,
>  						   &cursor->pixmap.paddr,
> -						   GFP_KERNEL | GFP_DMA);
> +						   GFP_KERNEL);
>  		if (!cursor->pixmap.base) {
>  			DRM_ERROR("Failed to allocate memory for pixmap\n");
>  			return -EINVAL;

[Severity: Critical]
This is a pre-existing issue, but does this mutate persistent global plane
state during the validation-only atomic check phase?

Just before this allocation, sti_cursor_atomic_check() frees the active
DMA buffer (cursor->pixmap.base). Could this cause a hardware use-after-free
if triggered by a TEST_ONLY commit while the hardware is still scanning out
the old buffer? It appears the mutation of global state here breaks the core
assumption that TEST_ONLY commits are side-effect free.

[ ... ]
> diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hq=
vdp.c
> --- a/drivers/gpu/drm/sti/sti_hqvdp.c
> +++ b/drivers/gpu/drm/sti/sti_hqvdp.c
[ ... ]
> @@ -860,7 +860,7 @@ static void sti_hqvdp_init(struct sti_hqvdp *hqvdp)
>  	size =3D NB_VDP_CMD * sizeof(struct sti_hqvdp_cmd);
>  	hqvdp->hqvdp_cmd =3D dma_alloc_wc(hqvdp->dev, size,
>  					&dma_addr,
> -					GFP_KERNEL | GFP_DMA);
> +					GFP_KERNEL);
>  	if (!hqvdp->hqvdp_cmd) {
>  		DRM_ERROR("Failed to allocate memory for VDP cmd\n");
>  		return;
>  	}

[Severity: High]
This is a pre-existing issue, but should this function return an error code
if the allocation fails instead of just returning void?

If dma_alloc_wc() fails here in sti_hqvdp_init(), the error is logged but
not propagated to the caller, leaving hqvdp->hqvdp_cmd as NULL. Could this
allow the plane to be successfully registered, resulting in a NULL pointer
dereference later when userspace attempts to use the plane?

For example, sti_hqvdp_atomic_update() dereferences the pointer
unconditionally:

sti_hqvdp_atomic_update()
   cmd =3D hqvdp->hqvdp_cmd + cmd_offset;
   cmd->top.config =3D TOP_CONFIG_PROGRESSIVE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903111836.1777=
265-1-hebaoquan@kylinos.cn?part=3D2
