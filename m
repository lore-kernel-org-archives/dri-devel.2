Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A718CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4FE10E219;
	Fri, 16 Oct 2026 10:37:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0B7D210E219
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:37:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A90A1516
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:37:36 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 35BAC3F871
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792147059; bh=H5mKO5Y1gmWntaGySIDF8f2mRTRQxgVPKQrC/XW56zU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CKW0Ib0BuarC1d6MP9Y9szaz3C/zax6WMirjRKEPX8CI+IfEQHH9z30HzQgKDEDxB
 HOBawJIgm7yln+POqoT+FNwT7avrAdnkGvJF1tMsWTlERPNMLVQqXRhbw5niPdtx/O
 bi2EKeBwVquk0nt5WjPKLAdh1sGstcc1gEzcL2v0=
Date: Fri, 16 Oct 2026 11:37:29 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Don't invalidate OTHER caches
Message-ID: <atH-aR1wVZw8Ppke@e142607>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
 <20260924-panthor-mmu-fixes-v1-1-e25f9b106466@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924-panthor-mmu-fixes-v1-1-e25f9b106466@collabora.com>
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

On Thu, Sep 24, 2026 at 02:30:43PM +0200, Boris Brezillon wrote:
> Don't invalidate the OTHER caches (AKA L1 read-only caches) since
> this seems to trip out the flush-elimination logic on v13, and it's not
> needed in practice (can't leak other context data because of TLB
> invalidation or corrupt physical pages returned to the system because
> it's a RO cache).
> 
> It's also worth noting that the downstream driver has been avoid
> OTHER caches invalidation from the start, and that we were doing
> the same until atomic page table update was introduced.
> 
> Fixes: 6e2d3b3e8589 ("drm/panthor: Add support for atomic page table updates")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 9f63a048df61..7e98084b9a1e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -634,7 +634,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  
>  	/* Flush+invalidate RW caches, invalidate RO ones. */
>  	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> -				       CACHE_CLEAN | CACHE_INV, CACHE_INV);
> +				       CACHE_CLEAN | CACHE_INV, 0);
>  	if (ret)
>  		return ret;
>  
> @@ -1841,8 +1841,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  		 * range is narrow enough and the HW supports it.
>  		 */
>  		ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> -					       CACHE_CLEAN | CACHE_INV,
> -					       CACHE_INV);
> +					       CACHE_CLEAN | CACHE_INV, 0);
>  
>  		/* Unlock the region if the flush is effective. */
>  		if (!ret)
> 
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
