Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBCDC98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED82C10E78B;
	Mon, 28 Sep 2026 05:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A0noBykY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C52510E78B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:48:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63F8743DD7;
 Mon, 28 Sep 2026 05:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1A91F000FF;
 Mon, 28 Sep 2026 05:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790574487;
 bh=wab64JdkfXaLn0c5A2ewyQIPdafcHb6wyChBfLV/sH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A0noBykY4nx7r8yXlwlYnjB0vQm9+U5JQNGqQTTdspixfUOD4NT2FmRbWNQyJK106
 ucYdQhC28W2q4EOASNZOEx8PNqJRWLRsCz91AdzqLPjbRZzlMwCgJEAYgSuVwQB/+Q
 0AaqKT3ae7y64rjGr2XXog4asNhmD80wghbUlzRpWx7F8vC35CQRL7hwyyHMW+gs1n
 SE0zG6UBHpfAfmdo0JED2jmPdSy/GxpyJ0H/jo5wqdK+iXw+2W4PcMygZs1//nv5Sc
 1m15/amyQcc/ABZ2KVW/QSqnzrUOzqGLTdKxxu4ZGhTip9PMSaFMrL4GuKNOuPmh66
 nAYOC88pA7XQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] iommu: export iommu_get_dma_domain()
To: "Jianfeng Liu" <liujianfeng1994@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260928053901.7270-2-liujianfeng1994@gmail.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-2-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:48:06 +0000
Message-Id: <20260928054807.2C1A91F000FF@smtp.kernel.org>
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
- [High] iommu: architectural violation bypassing DMA API and dma-buf isola=
tion
- [Medium] iommu: missing NULL check in exported iommu_get_dma_domain()
- [Low] iommu: missing fallback stub for iommu_get_dma_domain()
--

commit 9558776a7b7367aa853a5851fe8a04b46536b527
Author: Jianfeng Liu <liujianfeng1994@gmail.com>

iommu: export iommu_get_dma_domain()

This commit exports iommu_get_dma_domain() to allow modular drivers to reco=
ver
the physical address behind a DMA address for imported dma-bufs.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..330f9a79248bd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2327,6 +2327,7 @@ struct iommu_domain *iommu_get_dma_domain(struct de=
vice *dev)
>  {
>  	return dev->iommu_group->default_domain;

[Severity: Medium]
Does this code introduce a regression where modular callers could trigger a
kernel panic? An unconditional dereference of dev->iommu_group will crash
if the passed device does not have an IOMMU group, which can occur with
SWIOTLB fallbacks or missing bindings.

>  }
> +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);

[Severity: High]
Can exporting this function lead to memory corruption by breaking DMA API
and dma-buf isolation? By allowing callers to reverse-translate IOVAs via
iommu_iova_to_phys(), it bypasses the opacity of the DMA mapping API. This
specifically defeats CONFIG_DMABUF_DEBUG (which zeroes struct page
pointers to catch this abuse) and could be dangerous if the DMA API uses
SWIOTLB bounce buffers or dynamic deferred TLB invalidation.

[Severity: Low]
Will this cause build regressions for configs lacking CONFIG_IOMMU_API?
Since the function is now exported for general modular use, any caller
built without CONFIG_IOMMU_API will fail to link or compile because
include/linux/iommu.h lacks a corresponding empty stub in the
!CONFIG_IOMMU_API block.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053901.7270=
-1-liujianfeng1994@gmail.com?part=3D1
