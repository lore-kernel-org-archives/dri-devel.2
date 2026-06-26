Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87966CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D8A10E31B;
	Fri, 26 Jun 2026 08:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L/4rD4n+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 509CF10E31B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 08:00:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 817E260098;
 Fri, 26 Jun 2026 08:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D01F000E9;
 Fri, 26 Jun 2026 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782460811;
 bh=yeVaN3A2FyTahp8a/aIe3YNPyoKsGJSscn463n5tKrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/4rD4n+45/T+SfkoJWr7AO2JhmG5ZsXpvDRCTvzj2f6X33s8LAdH9d/lyMBYjoZC
 op3P2jXAownAlFsBHID/JFE1RC9QEwe/kXRycSKlZ95sSzvkSyAwZIT7YuyL2Lb80y
 Mj7ENiVfSYPZbxq59GFbrzxxGOtskz+nCyGomQxlf3v8SYiGXeG0M89bnhbTlAIx+J
 77POjM/CJnteDtQh3bzY2+3//FVYzrl4nV9/I+3FD4xvlk0DkLodGvYgYigiiSaGBW
 47PVAiU+WzkvLRvDHqnO4+8BDqrQitNJwB7H/LXUpto0YgtuNBWIy5FLG33t73N24q
 XhNxq+F6fa1HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ttm: Account for NULL pages in ttm_pool_backup
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626074653.1326683-1-matthew.brost@intel.com>
References: <20260626074653.1326683-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:00:10 +0000
Message-Id: <20260626080011.070D01F000E9@smtp.kernel.org>
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
- [High] Missing HighMem check causes NULL pointer dereference in CPA subsy=
stem on 32-bit x86.
- [High] Severe performance degradation and IPI storms due to unbatched TLB=
 flushes.

Pre-existing issues:
- [High] Double dma_unmap_page() occurs if backup fails on the first page a=
nd is retried.
--

commit 45896340105924fcd05f25382e4001c011252d32
Author: Matthew Brost <matthew.brost@intel.com>

drm/ttm: Account for NULL pages in ttm_pool_backup

This commit fixes a NULL pointer dereference in ttm_pool_backup by
switching from the batched set_pages_array_wb() to set_pages_wb() after
validating that each page is not NULL.

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11add..2636bf1005925 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c

[ ... ]

> +		order =3D ttm_pool_page_order(pool, page);
> +		num_pages =3D 1UL << order;
> =20
> +#ifdef CONFIG_X86
> +		/* Anything returned to the system needs to be cached. */
> +		if (tt->caching !=3D ttm_cached)
> +			set_pages_wb(page, 1 << order);

[Severity: High]
When shrinking GPU buffers under memory pressure on 32-bit x86 systems, can
this cause a NULL pointer dereference in the CPA subsystem?

The previous implementation using set_pages_array_wb() had an internal check
for HighMem pages. Since page_address(page) returns NULL for HighMem pages,
passing them directly to set_pages_wb() calls set_memory_wb(0, numpages),
which triggers a warning and -EFAULT in __cpa_process_fault().

Should there be a !PageHighMem(page) check here?

[Severity: High]
Additionally, does replacing the batched set_pages_array_wb() with per-chunk
set_pages_wb() calls inside this loop cause an IPI storm?

For highly fragmented buffer objects, calling set_pages_wb() on every
allocation chunk will trigger a cross-CPU IPI for TLB invalidation each tim=
e,
potentially leading to severe latency spikes or soft lockups.

> +#endif
> +
> +		if (tt->dma_address)
> +			ttm_pool_unmap(pool, tt->dma_address[i],
> +				       num_pages);

[Severity: High]
This is a pre-existing issue, but does this unmap lead to a double
dma_unmap_page() if the backup fails and is retried?

If ttm_backup_backup_page() returns ENOMEM for the first page, the loop
aborts and returns a negative error without setting TTM_TT_FLAG_BACKED_UP.

Because this loop has already unmapped the DMA addresses unconditionally
without clearing the pointers in the array, a subsequent retry from the
shrinker will execute this loop again, calling dma_unmap_page() on the same
IOVA addresses.

> +		if (flags->purge) {
> +			shrunken +=3D num_pages;
> +			page->private =3D 0;
> +			__free_pages_gpu_account(page, order, false);
> +			memset(tt->pages + i, 0,
> +			       num_pages * sizeof(*tt->pages));
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626074653.1326=
683-1-matthew.brost@intel.com?part=3D1
