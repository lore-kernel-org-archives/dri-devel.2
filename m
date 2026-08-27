Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11211C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519DE10EF25;
	Thu, 27 Aug 2026 09:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MGTo5FTp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C5710EF25
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7213C401B9;
 Thu, 27 Aug 2026 09:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340141F000E9;
 Thu, 27 Aug 2026 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787822132;
 bh=JbOzVw5o8Yl+nmZmmgygs7vBwRXy6gxBRq6lNuUTJlc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MGTo5FTpcr0+hd/ja4j7xAiHvjeI3fZUimyDPFlsBjPcPne5vRK9rk/X7zNDyE3vZ
 Fub4n7tbXqsLqIagJLPKOnT7XGhx8e+RHLQhc5EDaTcZGny7nqcaCmC7uZwG7jhTks
 FakDldo/nh91OrsvC7uXFcb9R67chqFV8m78jeUYIcox08PcQhqzRqj4hXb5UvKwqI
 c9/VnzvJ6DkHMqIII5J/ZaY3/UiMyFjDvqzA8RNrWCu4KwJjl9RwNAkRi5Vjr6HMCE
 Lk/RHd4DNGMCz6IIl8CUn1Uc0Zj+tum+3+9yxuUrPpTp0P4nfBxi1Xyy6fSTtD5HcW
 UiAldBPuszhiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: switch from get_user_pages to pin_user_pages
To: "Seongjun Hong" <hsj0512@snu.ac.kr>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827090100.428302-1-hsj0512@snu.ac.kr>
References: <20260827090100.428302-1-hsj0512@snu.ac.kr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 09:15:31 +0000
Message-Id: <20260827091532.340141F000E9@smtp.kernel.org>
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
- [High] Missing FOLL_LONGTERM flag in pin_user_pages for long-term DMA.

Pre-existing issues:
- [Critical] The error path in `radeon_ttm_tt_pin_userptr` leaks scatterlis=
t entries and leaves a dangling pointer that triggers a Use-After-Free.
- [Critical] The return value of `radeon_ttm_tt_pin_userptr` is ignored, ca=
using the driver to program the GPU GART with uninitialized memory.
--

commit 5aab225074cf5de663f6a8e7e139c7bfe602c69f
Author: Seongjun Hong <hsj0512@snu.ac.kr>

drm/radeon: switch from get_user_pages to pin_user_pages

This commit replaces get_user_pages with pin_user_pages to guarantee
that these DMA pages are pinned correctly.

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index e7ab8162ac694..22fc35a0e8d81 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -349,7 +349,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_devic=
e *bdev, struct ttm_tt *ttm
>  		uint64_t userptr =3D gtt->userptr + pinned * PAGE_SIZE;
>  		struct page **pages =3D ttm->pages + pinned;
> =20
> -		r =3D get_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
> +		r =3D pin_user_pages(userptr, num_pages, write ? FOLL_WRITE : 0,
>  				   pages);

[Severity: High]
Does this pinning operation require the FOLL_LONGTERM flag?

Documentation (Documentation/core-api/pin_user_pages.rst) dictates that
long-term DMA pins must use FOLL_LONGTERM. Without it, pinning memory
indefinitely in ZONE_MOVABLE or CMA regions might break memory compaction
and hotplug, potentially leading to CMA exhaustion.

>  		if (r < 0)
>  			goto release_pages;
[ ... ]
> @@ -377,7 +377,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_devic=
e *bdev, struct ttm_tt *ttm
>  	kfree(ttm->sg);

[Severity: Critical]
This is a pre-existing issue, but does this error path leak the scatterlist
and leave a dangling pointer?

If dma_map_sgtable() fails, we jump here and call kfree(ttm->sg). This
frees the container struct without calling sg_free_table(ttm->sg), leaking
the inner scatterlist array.

Additionally, ttm->sg is not set to NULL. When the object is later torn dow=
n,
radeon_ttm_tt_unpin_userptr() sees a non-NULL ttm->sg:

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_tt_unpin_userptr() {
    ...
    /* double check that we don't free the table twice */
    if (!ttm->sg || !ttm->sg->sgl)
        return;

    /* free the sg table and pages again */
    dma_unmap_sgtable(rdev->dev, ttm->sg, direction, 0);
    ...
}

Could this lead to a use-after-free when it dereferences the freed pointer
and attempts to unmap it?

> =20
>  release_pages:
> -	release_pages(ttm->pages, pinned);
> +	unpin_user_pages(ttm->pages, pinned);
>  	return r;
>  }

[Severity: Critical]
This is also a pre-existing issue, but is it safe to ignore the return value
of radeon_ttm_tt_pin_userptr() here?

In radeon_ttm_backend_bind():

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_backend_bind() {
    ...
    if (gtt->userptr) {
        radeon_ttm_tt_pin_userptr(bdev, ttm);
        flags &=3D ~RADEON_GART_PAGE_WRITE;
    }

    r =3D radeon_gart_bind(rdev, gtt->offset, ttm->num_pages,
                         ttm->pages, gtt->ttm.dma_address, flags);
    ...
}

If radeon_ttm_tt_pin_userptr() fails (for example, if userspace provides an
invalid userptr), the failure is ignored. The ttm->dma_address array remains
uninitialized (zeroed) and is blindly passed to radeon_gart_bind().

Could this result in programming the hardware GART with zeroed DMA addresse=
s,
effectively mapping physical address 0x0 for GPU read/write access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827090100.4283=
02-1-hsj0512@snu.ac.kr?part=3D1
