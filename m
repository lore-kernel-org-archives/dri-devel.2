Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65707CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E6510EDD7;
	Wed,  6 May 2026 15:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FmnnVKGi";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B80C610EDD7
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:07:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A5F1A00;
 Wed,  6 May 2026 08:06:59 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB7173F7B4;
 Wed,  6 May 2026 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778080025; bh=0Qvkwoc6ppPEBLSk9uM5Rsgl5b8rqzzkFxSZy6MZlV8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FmnnVKGik6Xi8qEL1+q1giTNjcCEklsr6JI2g2nwenfvZhfM3nqzgpT+RM2xxmcJC
 xly2Z0kjShS+ZRLlyw6kV6yCShZvUoFu2DPHS+flFwwTX2uS0zZJ94JWhsqo0vVpe1
 zeNFJykwZSUlOJaLygI3u2hyQJgsKDJ1m5jWaAZo=
Message-ID: <ed1b0be1-cf6e-4318-b040-12d315eae3f0@arm.com>
Date: Wed, 6 May 2026 16:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/panthor: Add freed_sz parameter to
 reclaim_priv_bos
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
 <20260506-panthor-explicit-reclaim-v1-1-44f82ac147ce@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260506-panthor-explicit-reclaim-v1-1-44f82ac147ce@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 06/05/2026 11:45, Nicolas Frattaroli wrote:
> panthor_mmu_reclaim_priv_bos returns the number of freed pages. However,
> how many bytes of freed memory this translates to can't generally be
> deduced from the number of pages, as the page size is a per-VM property.
> 
> It may be useful to know the exact number of bytes that have been freed

The "useful" aspect seems to just be a drm_dbg() message from what I can
see with this series? Am I missing something or is it not actually that
useful?

Thanks,
Steve

> for observability and debugging purposes. To that end, add a new
> parameter "freed_sz", which is a pointer to a size_t where this
> information will be stored. It may be NULL, in which case the
> information isn't stored at all.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c |  3 ++-
>  drivers/gpu/drm/panthor/panthor_mmu.c | 12 ++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 13295d7a593d..80e82238f3c5 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1511,7 +1511,8 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  		goto out;
>  
>  	freed += panthor_mmu_reclaim_priv_bos(ptdev, sc->nr_to_scan - freed,
> -					      &remaining, panthor_gem_try_evict);
> +					      &remaining, NULL,
> +					      panthor_gem_try_evict);
>  	if (freed >= sc->nr_to_scan)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a7ee14986849..b81388b35a58 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3127,13 +3127,18 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
>  unsigned long
>  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  			     unsigned int nr_to_scan, unsigned long *remaining,
> +			     size_t *freed_sz,
>  			     bool (*shrink)(struct drm_gem_object *,
>  					    struct ww_acquire_ctx *))
>  {
> +	unsigned long newly_freed;
>  	unsigned long freed = 0;
>  	LIST_HEAD(remaining_vms);
>  	LIST_HEAD(vms);
>  
> +	if (freed_sz)
> +		*freed_sz = 0;
> +
>  	mutex_lock(&ptdev->reclaim.lock);
>  	list_splice_init(&ptdev->reclaim.vms, &vms);
>  
> @@ -3152,8 +3157,11 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  
>  		mutex_unlock(&ptdev->reclaim.lock);
>  
> -		freed += drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
> -					  remaining, shrink, NULL);
> +		newly_freed = drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
> +					       remaining, shrink, NULL);
> +		if (freed_sz)
> +			*freed_sz += panthor_vm_page_size(vm) * newly_freed;
> +		freed += newly_freed;
>  
>  		mutex_lock(&ptdev->reclaim.lock);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index 3522fbbce369..12b18b5f90e1 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -52,6 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
>  unsigned long
>  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  			     unsigned int nr_to_scan, unsigned long *remaining,
> +			     size_t *freed_sz,
>  			     bool (*shrink)(struct drm_gem_object *,
>  					    struct ww_acquire_ctx *));
>  int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
> 

