Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349A6C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:27:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2B510E3A9;
	Tue,  1 Sep 2026 07:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OjRdVT1j";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC0510E3A5;
 Tue,  1 Sep 2026 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788247621;
 bh=1kN7fTlQ6sHmpPtay97EVjBnatz6R3Nl9kno2ZQdCZw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OjRdVT1jY4kYf7Sak4ITsdfB+sPej0lrhc6TPF1gxPlznyWJQnMRoB7s/kMvINUDS
 XlmdqL4DgJe00D/0/JS1yqPNMP7y2aZmh39CHwt4vjcviW1XyVtnN/Abu+pCAx3oba
 9ex+aF8IMXja4/V09cVkPzU/CktbwqewMNfqAX10Az9xh7JdX4740JDMmLm+LS7cK6
 pXE6ve4Lz3PTgWm/+MV1sCw50pD2aHNIsMp1hDjVYvgkyQvvqTk7NaDs3w6iLRnZQg
 XENBHJ8cN9o3PyuKnwDO0CzKr/C8tc3QTITDSz+f+RMYk2rzoUuSLJ0q6sRHF/0xpb
 /02jIccEGYprw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0509F17E04BF;
 Tue, 01 Sep 2026 09:27:00 +0200 (CEST)
Date: Tue, 1 Sep 2026 09:26:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Steven Price <steven.price@arm.com>, Liviu
 Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org (open list),
 linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display
 hardware), freedreno@lists.freedesktop.org (open list:DRM DRIVER for
 Qualcomm display hardware)
Subject: Re: [PATCH] drm/gem: Drop ticket arg to lru_scan()
Message-ID: <20260901092655.2904f1b5@fedora-21.home>
In-Reply-To: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
References: <20260831174409.465181-1-robin.clark@oss.qualcomm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 31 Aug 2026 10:44:08 -0700
Rob Clark <robin.clark@oss.qualcomm.com> wrote:

> Commit 3392291fc509 ("drm/msm: Fix shrinker deadlock") dropped the only
> use of the ticket arg, but at the time left drm_gem_lru_scan() unchanged
> to avoid conflicts with in-flight pathor shrinker support.  This commit

                                    ^ panthor

> is the followup to remove the unused arg.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

