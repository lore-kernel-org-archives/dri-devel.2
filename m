Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63D7C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C145910E43D;
	Sat, 27 Jun 2026 04:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nrtH3Oyh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BFE10E43D
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:33:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 743B2402AD;
 Sat, 27 Jun 2026 04:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C31F000E9;
 Sat, 27 Jun 2026 04:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782534812;
 bh=HkZfO6bOScDntQYdt2ALSqEoT4hf3J19ObXytv1D4zQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nrtH3OyhksEy/0BbpEtz/I57uGbVFl4/NOzDc9BUgKXN+GxzxMd3G0tZ9Z19CzyNU
 jrggQ4QHc2uYCj3ZIF3Y8mghW4LPxlAY6AIWiuds66sIrJmYrIke/2YrMmhuFg8GcF
 piB7qajbBGCyqiPVxLdXfNVxL3LthBmxRvqaacvRHzTETMJ2D6yGa8qB75xmoZUGpC
 MPgjYVasKyhKOzhh/LU3VZ0DhOk+sdz/zDv249FmFR2psKYFfWTuK/RhejF1F2HA31
 cc1ecxJXzAxVDeWRoMQc/4a3UsJj5dbw77gS656q2fBmTwoz/Q4IYQyXNKamC7QNmM
 Yx4h0TcSPkgMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627035418.3796481-4-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
 <20260627035418.3796481-4-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:33:31 +0000
Message-Id: <20260627043332.314C31F000E9@smtp.kernel.org>
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
- [High] Passing uninitialized DMA direction to `dma_iova_destroy()` when m=
apping fails on the first iteration.
- [High] Device memory DMA mappings are permanently leaked if `drm_gpusvm_g=
et_pages()` fails midway through mapping.
--

commit f55ce8322095c92c8d36ce88cefb155d04fd7fd7
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_range

Since the physical pages and MM VA range have been abstractly separated,
this commit moves struct drm_gpusvm_pages out of struct drm_gpusvm_range
to bring flexibility to the drm gpu SVM framework. It updates helpers
and documentation to operate directly on driver-embedded pages objects.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 85fbadc9716a4..6b79aecb22dbc 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -183,7 +232,10 @@
>   *				goto retry;
>   *		}
>   *
> - *		err =3D drm_gpusvm_range_get_pages(gpusvm, range, &ctx);
> + *		err =3D drm_gpusvm_get_pages(gpusvm, &drange->pages,
> + *					   gpusvm->mm, &range->notifier->notifier,
> + *					   drm_gpusvm_range_start(range),
> + *					   drm_gpusvm_range_end(range), &ctx);

[Severity: High]
This is a pre-existing issue, but passing an uninitialized DMA direction
to dma_iova_destroy() can occur if mapping fails on the first iteration.

In drm_gpusvm_get_pages(), the dma_addr array is allocated without
zeroing. If dma_iova_link() fails on the very first page (i=3D0):

drivers/gpu/drm/drm_gpusvm.c:drm_gpusvm_get_pages() {
        ...
        if (dma_use_iova(state)) {
                err =3D dma_iova_link(...);
                if (err)
                        goto err_unmap;
        }
        ...
}

The code jumps to err_unmap and calls __drm_gpusvm_unmap_pages(), which
dereferences the uninitialized dir parameter:

drivers/gpu/drm/drm_gpusvm.c:__drm_gpusvm_unmap_pages() {
        ...
        if (use_iova)
                dma_iova_destroy(dev, &svm_pages->state,
                                 svm_pages->state_offset,
                                 svm_pages->dma_addr[0].dir, 0);
}

Could this lead to undefined behavior in the DMA API during IOVA teardown?


[Severity: High]
This isn't a bug introduced by this patch, but it appears device memory DMA
mappings are permanently leaked if drm_gpusvm_get_pages() fails midway
through mapping.

In drm_gpusvm_get_pages(), svm_pages->dpagemap is only populated upon
complete success:

drivers/gpu/drm/drm_gpusvm.c:drm_gpusvm_get_pages() {
        ...
        if (pagemap) {
                flags.has_devmem_pages =3D true;
                drm_pagemap_get(dpagemap);
                drm_pagemap_put(svm_pages->dpagemap);
                svm_pages->dpagemap =3D dpagemap;
        }
        ...
}

If a failure occurs (e.g. DMA mapping error) after successfully mapping one
or more device pages, the code jumps to err_unmap. Because
svm_pages->dpagemap remains NULL on this error path, the unmap loop skips
calling device_unmap():

drivers/gpu/drm/drm_gpusvm.c:__drm_gpusvm_unmap_pages() {
        struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;
        ...
        else if (dpagemap && dpagemap->ops->device_unmap)
                dpagemap->ops->device_unmap(dpagemap, dev, addr);
}

Could this exhaust mapping resources over time by permanently leaking
these mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627035418.3796=
481-1-honglei1.huang@amd.com?part=3D4
