Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33AEC624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E148110E593;
	Tue,  1 Sep 2026 16:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="uV/9gXCK";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 26FEC10E108
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:31:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81461BD0
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:31:41 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4AD4E3F85F
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788280305; bh=hLe45cnDUnZxwdK4p4TDAGy82nU9hy3GkuXKLYRaHoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uV/9gXCK3HR8MNnsk4Svjf+0Imcqp/qJqKdV5uyUugTO3b5RGqvmJddKJpmRUBViu
 1jWJtBZcY1b+gIR+vY4/1FcdgUFlhbh0a02tItlsni281unoTzUs3WotWhg8Vwf/4Z
 6Y5ZU7qKJvr8p4Zr8jCvOQzj9g/KM2wnr0by1p3M=
Date: Tue, 1 Sep 2026 17:31:43 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH] drm/gem: Drop ticket arg to lru_scan()
Message-ID: <apb970Ep6EHHKpAq@e142607>
References: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
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

On Mon, Aug 31, 2026 at 10:44:08AM -0700, Rob Clark wrote:
> Commit 3392291fc509 ("drm/msm: Fix shrinker deadlock") dropped the only
> use of the ticket arg, but at the time left drm_gem_lru_scan() unchanged
> to avoid conflicts with in-flight pathor shrinker support.  This commit
> is the followup to remove the unused arg.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

With the panthor spelling fixed:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gem.c              | 13 +++----------
>  drivers/gpu/drm/msm/msm_gem_shrinker.c | 22 ++++++++++------------
>  drivers/gpu/drm/panthor/panthor_gem.c  | 14 ++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu.c  |  5 ++---
>  drivers/gpu/drm/panthor/panthor_mmu.h  |  3 +--
>  include/drm/drm_gem.h                  |  3 +--
>  6 files changed, 23 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e3ed684ddcf2..15acb958ecd5 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1656,8 +1656,7 @@ drm_gem_lru_scan(struct drm_device *dev,
>  		 struct drm_gem_lru *lru,
>  		 unsigned int nr_to_scan,
>  		 unsigned long *remaining,
> -		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
> -		 struct ww_acquire_ctx *ticket)
> +		 bool (*shrink)(struct drm_gem_object *obj))
>  {
>  	struct drm_gem_lru still_in_lru;
>  	struct drm_gem_object *obj;
> @@ -1690,20 +1689,17 @@ drm_gem_lru_scan(struct drm_device *dev,
>  		 */
>  		mutex_unlock(&dev->gem_lru_mutex);
>  
> -		if (ticket)
> -			ww_acquire_init(ticket, &reservation_ww_class);
> -
>  		/*
>  		 * Note that this still needs to be trylock, since we can
>  		 * hit shrinker in response to trying to get backing pages
>  		 * for this obj (ie. while it's lock is already held)
>  		 */
> -		if (!ww_mutex_trylock(&obj->resv->lock, ticket)) {
> +		if (!ww_mutex_trylock(&obj->resv->lock, NULL)) {
>  			*remaining += obj->size >> PAGE_SHIFT;
>  			goto tail;
>  		}
>  
> -		if (shrink(obj, ticket)) {
> +		if (shrink(obj)) {
>  			freed += obj->size >> PAGE_SHIFT;
>  
>  			/*
> @@ -1727,9 +1723,6 @@ drm_gem_lru_scan(struct drm_device *dev,
>  
>  		dma_resv_unlock(obj->resv);
>  
> -		if (ticket)
> -			ww_acquire_fini(ticket);
> -
>  tail:
>  		drm_gem_object_put(obj);
>  		mutex_lock(&dev->gem_lru_mutex);
> diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> index 9d2788f79ace..3514d5c84989 100644
> --- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
> +++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
> @@ -102,7 +102,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
>  }
>  
>  static bool
> -purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
> +purge(struct drm_gem_object *obj)
>  {
>  	if (!is_purgeable(to_msm_bo(obj)))
>  		return false;
> @@ -114,7 +114,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
>  }
>  
>  static bool
> -evict(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
> +evict(struct drm_gem_object *obj)
>  {
>  	if (is_unevictable(to_msm_bo(obj)))
>  		return false;
> @@ -133,21 +133,21 @@ wait_for_idle(struct drm_gem_object *obj)
>  }
>  
>  static bool
> -active_purge(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
> +active_purge(struct drm_gem_object *obj)
>  {
>  	if (!wait_for_idle(obj))
>  		return false;
>  
> -	return purge(obj, ticket);
> +	return purge(obj);
>  }
>  
>  static bool
> -active_evict(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
> +active_evict(struct drm_gem_object *obj)
>  {
>  	if (!wait_for_idle(obj))
>  		return false;
>  
> -	return evict(obj, ticket);
> +	return evict(obj);
>  }
>  
>  static unsigned long
> @@ -156,7 +156,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  	struct msm_drm_private *priv = shrinker->private_data;
>  	struct {
>  		struct drm_gem_lru *lru;
> -		bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket);
> +		bool (*shrink)(struct drm_gem_object *obj);
>  		bool cond;
>  		unsigned long freed;
>  		unsigned long remaining;
> @@ -180,8 +180,7 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  		stages[i].freed =
>  			drm_gem_lru_scan(priv->dev, stages[i].lru, nr,
>  					 &stages[i].remaining,
> -					 stages[i].shrink,
> -					 NULL);
> +					 stages[i].shrink);
>  		nr -= stages[i].freed;
>  		freed += stages[i].freed;
>  		remaining += stages[i].remaining;
> @@ -222,7 +221,7 @@ msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan)
>  static const int vmap_shrink_limit = 15;
>  
>  static bool
> -vmap_shrink(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket)
> +vmap_shrink(struct drm_gem_object *obj)
>  {
>  	if (!is_vunmapable(to_msm_bo(obj)))
>  		return false;
> @@ -250,8 +249,7 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
>  		unmapped += drm_gem_lru_scan(priv->dev, lrus[idx],
>  					     vmap_shrink_limit - unmapped,
>  					     &remaining,
> -					     vmap_shrink,
> -					     NULL);
> +					     vmap_shrink);
>  	}
>  
>  	*(unsigned long *)ptr += unmapped;
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 54535bae2b0c..17408f832af3 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1392,8 +1392,7 @@ panthor_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
>  	return count ? count : SHRINK_EMPTY;
>  }
>  
> -static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
> -					       struct ww_acquire_ctx *ticket)
> +static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj)
>  {
>  	/*
>  	 * Track last locked entry for unwinding locks in error and
> @@ -1479,8 +1478,7 @@ static bool panthor_gem_try_evict_no_resv_wait(struct drm_gem_object *obj,
>  	return ret == 0;
>  }
>  
> -static bool panthor_gem_try_evict(struct drm_gem_object *obj,
> -				  struct ww_acquire_ctx *ticket)
> +static bool panthor_gem_try_evict(struct drm_gem_object *obj)
>  {
>  	struct panthor_gem_object *bo = to_panthor_bo(obj);
>  
> @@ -1488,7 +1486,7 @@ static bool panthor_gem_try_evict(struct drm_gem_object *obj,
>  	if (dma_resv_wait_timeout(obj->resv, DMA_RESV_USAGE_BOOKKEEP, false, 10) <= 0)
>  		return false;
>  
> -	return panthor_gem_try_evict_no_resv_wait(&bo->base, ticket);
> +	return panthor_gem_try_evict_no_resv_wait(&bo->base);
>  }
>  
>  static unsigned long
> @@ -1503,13 +1501,13 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  
>  	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.unused,
>  				  sc->nr_to_scan - freed, &remaining,
> -				  panthor_gem_try_evict_no_resv_wait, NULL);
> +				  panthor_gem_try_evict_no_resv_wait);
>  	if (freed >= sc->nr_to_scan)
>  		goto out;
>  
>  	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.mmapped,
>  				  sc->nr_to_scan - freed, &remaining,
> -				  panthor_gem_try_evict_no_resv_wait, NULL);
> +				  panthor_gem_try_evict_no_resv_wait);
>  	if (freed >= sc->nr_to_scan)
>  		goto out;
>  
> @@ -1523,7 +1521,7 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
>  
>  	freed += drm_gem_lru_scan(&ptdev->base, &ptdev->reclaim.gpu_mapped_shared,
>  				  sc->nr_to_scan - freed, &remaining,
> -				  panthor_gem_try_evict, NULL);
> +				  panthor_gem_try_evict);
>  
>  out:
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index e10dbd18d8cf..ab070bc74857 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3133,8 +3133,7 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
>  unsigned long
>  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  			     unsigned int nr_to_scan, unsigned long *remaining,
> -			     bool (*shrink)(struct drm_gem_object *,
> -					    struct ww_acquire_ctx *))
> +			     bool (*shrink)(struct drm_gem_object *))
>  {
>  	unsigned long freed = 0;
>  	LIST_HEAD(remaining_vms);
> @@ -3160,7 +3159,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  
>  		freed += drm_gem_lru_scan(&ptdev->base, &vm->reclaim.lru,
>  					  nr_to_scan - freed,
> -					  remaining, shrink, NULL);
> +					  remaining, shrink);
>  
>  		mutex_lock(&ptdev->base.gem_lru_mutex);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index 3522fbbce369..abc36e7204be 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -52,8 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
>  unsigned long
>  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  			     unsigned int nr_to_scan, unsigned long *remaining,
> -			     bool (*shrink)(struct drm_gem_object *,
> -					    struct ww_acquire_ctx *));
> +			     bool (*shrink)(struct drm_gem_object *));
>  int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
>  					struct panthor_vm *vm,
>  					u32 slot_count);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 8a704f6a65c1..ffa607c91aa2 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -616,8 +616,7 @@ drm_gem_lru_scan(struct drm_device *dev,
>  		 struct drm_gem_lru *lru,
>  		 unsigned int nr_to_scan,
>  		 unsigned long *remaining,
> -		 bool (*shrink)(struct drm_gem_object *obj, struct ww_acquire_ctx *ticket),
> -		 struct ww_acquire_ctx *ticket);
> +		 bool (*shrink)(struct drm_gem_object *obj));
>  
>  int drm_gem_evict_locked(struct drm_gem_object *obj);
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
