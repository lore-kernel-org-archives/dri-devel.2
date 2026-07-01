Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF758C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46ED10EDC1;
	Wed,  1 Jul 2026 06:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ebe/ZxvY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A6210EDC1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 06:44:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B68894045C;
 Wed,  1 Jul 2026 06:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C1A1F000E9;
 Wed,  1 Jul 2026 06:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782888276;
 bh=a4Nympn5Mueu+P11aHHm23p1iTRbD/UfVjMr6mDWRDg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ebe/ZxvYX5xLjc3g7XsSSfLRBR42YqcslRQamCSUqXsPyjMarHoQ1ja9XZnga50JM
 eBJS1kyTdmaQ78X4k2iTpz5o/9sT/Sei3bjtKPJAerq8odwBrNlxWqjnP7kwab1ieW
 ieNhEqYltjPJbvHNVbC2znapKy/Vs81E8WuvwK2lpgY9WZ/N1aV0vpOKC9VWga9kjZ
 1/emGoijZHu3N534d1cnLC3yqgQNbuTi7AOSVbMnZPlV2bKoC5BgPdzulOL+7+iApk
 9UIkVIg11Z3pbNAs23QrfaW8m71qMk8B6t152Hc65zb4CTXY9Q4P6efYixOsSn693o
 +TP4xDWDHqk9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/gpusvm: free the whole IOVA reservation on
 unmap
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701062800.409248-2-honghuan@amd.com>
References: <20260701062800.409248-1-honghuan@amd.com>
 <20260701062800.409248-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:44:35 +0000
Message-Id: <20260701064436.70C1A1F000E9@smtp.kernel.org>
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
- [High] The `dma_iova_destroy()` API violates its contract by failing to f=
ree the entire IOVA reservation, causing leaks across multiple subsystems.
--

commit 2502141c3a5e40996ab0b0ebb511ee9346f04740
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/gpusvm: free the whole IOVA reservation on unmap

This commit fixes an IOVA space leak in drm_gpusvm by replacing a call
to dma_iova_destroy() with dma_iova_unlink() and dma_iova_free(). The
issue occurred because dma_iova_destroy() only freed the linked portion
of the reservation.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..3145d55cd860b 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1146,10 +1146,19 @@ static void __drm_gpusvm_unmap_pages(struct drm_g=
pusvm *gpusvm,
>  		};
>  		bool use_iova =3D dma_use_iova(&svm_pages->state);
> =20
> -		if (use_iova)
> -			dma_iova_destroy(dev, &svm_pages->state,
> -					 svm_pages->state_offset,
> -					 svm_pages->dma_addr[0].dir, 0);

[Severity: High]
This is a pre-existing issue, but does dma_iova_destroy() violate its contr=
act
across the kernel by failing to free the entire IOVA reservation?

While this patch correctly works around the leak in drm_gpusvm by using
dma_iova_unlink() and dma_iova_free(), the underlying dma_iova_destroy()
implementation still appears to use mapped_len to determine how much to fre=
e:

drivers/iommu/dma-iommu.c:dma_iova_destroy() {
    ...
    __iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs, true);
    ...
}

If mapped_len is smaller than state->__size, the rest of the IOVA space is
leaked, eventually exhausting the IOVA space and causing DMA mapping failur=
es.
This appears to affect other subsystems as well. For example, if pages are
skipped during migration:

drivers/gpu/drm/drm_pagemap.c:drm_pagemap_migrate_unmap_pages() {
    ...
    dma_iova_destroy(dev, &state->dma_state, state->offset, dir, 0);
    ...
}

It also seems reachable in error paths where a mapping fails halfway:

drivers/dma-buf/dma-buf-mapping.c:dma_buf_phys_vec_to_sgt() {
    ...
    dma_iova_destroy(attach->dev, dma->state, mapped_len, dir, DMA_ATTR_MMI=
O);
    ...
}

Would it be better to fix dma_iova_destroy() centrally so it always frees t=
he
entire IOVA space regardless of the mapped_len parameter, rather than
open-coding the fix here?

> +		/*
> +		 * IOVA is reserved for the whole range but only the linked
> +		 * system pages (state_offset bytes) need unlinking; free the
> +		 * entire reservation to avoid leaking the device-page part.
> +		 * On the error path state_offset is 0, so just free it.
> +		 */
> +		if (use_iova) {
> +			if (svm_pages->state_offset)
> +				dma_iova_unlink(dev, &svm_pages->state, 0,
> +						svm_pages->state_offset,
> +						svm_pages->dma_addr[0].dir, 0);
> +			dma_iova_free(dev, &svm_pages->state);
> +		}
> =20
>  		for (i =3D 0, j =3D 0; i < npages; j++) {
>  			struct drm_pagemap_addr *addr =3D &svm_pages->dma_addr[j];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701062800.4092=
48-1-honghuan@amd.com?part=3D1
