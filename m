Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932C0CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDAD910E4FF;
	Wed,  6 May 2026 06:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tBkFY0Kn";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1DE10E4FF
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:36:15 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260506063613euoutp01fc23496a1d9d46cbd422e520e2381cd7~s5nww7kbH0190201902euoutp01V
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:36:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260506063613euoutp01fc23496a1d9d46cbd422e520e2381cd7~s5nww7kbH0190201902euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1778049374;
 bh=UAOX7g+36grI83zuNghQw07p7liRfgICgVlYKc3Nluo=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=tBkFY0KnbNbL7mqrZZLt4TmLURhgSco8cBjnYwUNKXSJRjsDoYHn4VKvY5cyIQ/kj
 +RTc7unxuyTPktcbg4qCNKvS8EaO0MSNy1vaenPrBI6nYZh0bouh4l6bdaNJpeYxe2
 Xt7o54cnUqRoGkMxha75sPFuNX746qzb4QHENLYw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260506063613eucas1p22e2010cea14e69222bfde5d3504571a1~s5nwfFy_d1876018760eucas1p2X;
 Wed,  6 May 2026 06:36:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260506063612eusmtip2ba00c35a881fca512a095dc19595a723~s5nvKmbT_2580225802eusmtip2w;
 Wed,  6 May 2026 06:36:12 +0000 (GMT)
Message-ID: <19fbdfbd-71f5-4e92-8525-aaeddcbf4467@samsung.com>
Date: Wed, 6 May 2026 08:36:11 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/exynos/gem: Fix printk specifier for
 gem_object.size and dma_addr
To: Chen-Yu Tsai <wenst@chromium.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel
 test robot <lkp@intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260408064936.1342321-1-wenst@chromium.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260506063613eucas1p22e2010cea14e69222bfde5d3504571a1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260408064951eucas1p14200e8d85d270f16435e38af36dbcae0
X-EPHeader: CA
X-CMS-RootMailID: 20260408064951eucas1p14200e8d85d270f16435e38af36dbcae0
References: <CGME20260408064951eucas1p14200e8d85d270f16435e38af36dbcae0@eucas1p1.samsung.com>
 <20260408064936.1342321-1-wenst@chromium.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 08.04.2026 08:49, Chen-Yu Tsai wrote:
> In the recent change to use the GEM base object's size field instead of
> the exynos_gem object's additional field, the printk format was not
> adjusted for the change to size_t type. This causes a new warning on
> platforms on which size_t is not unsigned long.
>
> Fix this by using the correct "%zx" type.
>
> While at it, fix the specifier for dma_addr so that the cast to unsigned
> long is not longer needed.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604081331.jSJQSVmg-lkp@intel.com/
> Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
> This is only compile tested. Build for ARM 32-bit confirms the warning
> is fixed. Sorry for the noise.
>
> The commit hash used in the Fixes tag is the current one seen in
> exynos-drm-next.
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> index d9d42809a1a9..f264e170bc26 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
>  	if (kvmap)
>  		exynos_gem->kvaddr = exynos_gem->cookie;
>  
> -	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
> -			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> +	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0x%zx)\n",
> +			  &exynos_gem->dma_addr, exynos_gem->base.size);
>  	return 0;
>  }
>  
> @@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
>  		return;
>  	}
>  
> -	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
> -			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
> +	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(%pad), size(0x%zx)\n",
> +			  &exynos_gem->dma_addr, exynos_gem->base.size);
>  
>  	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
>  			(dma_addr_t)exynos_gem->dma_addr,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

