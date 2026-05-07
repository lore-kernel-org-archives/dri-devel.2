Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49E8CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BE610EFB1;
	Thu,  7 May 2026 10:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fhalT9yd";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B02D110EFB1
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:01:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E283532
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 03:01:50 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 944873F763
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778148115; bh=V6SSn9JDAt3Sb2yowSSRXctJvfC9kF3/lLVSaXdPYEQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fhalT9ydBzVprPEoO+3PuS3GrYMixs3EpBZcsY4Yy93kFXSlmfX9Ybq4MVz0YsPzK
 a3ljzoZJ7I0UZtfyYjXk9sEVrKqBOrdx9aZPnkOo3DD5Y+LVZ6eVWH20DPFgZRArEV
 HLVDzSxWbFvQHoF0eXZy6XyzDOV9ovQA7BpDD/6Y=
Date: Thu, 7 May 2026 11:01:25 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Don't use the racy drm_gem_lru_remove()
 helper
Message-ID: <afxi9ab1O9J_7J1Y@e142607>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
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

On Wed, May 06, 2026 at 02:16:26PM +0200, Boris Brezillon wrote:
> drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
> variable that's then dereferenced to acquire the LRU lock. Because this
> assignment in done without the LRU lock held, it can race with
> drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
> a stack-allcated LRU that goes away when leaving the function. By
> the time we dereference this local lru variable, the object might already
> be gone.
> 
> It feels like drm_gem_lru_move_tail() was never meant to be used this
> way, because there's no easy way we can avoid this race unless we defer
> the locking to the caller. Let's add an explicit LRU for unreclaimable
> BOs instead, and have all BOs added to this LRU at creation time.

I would argue that drm_gem_lru_scan() is broken by design. If you're going
to release the LRU lock in the middle of a loop you can expect that someone
will get hold of your stack-allocated LRU and end up picking the pieces.
This patch is fine in itself by trying to avoid stepping into the fight,
but I think we should also add a warning in drm_gem_lru_scan() for future
users to be aware of the dangers.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
> Reported-by: Chia-I Wu <olvaffe@gmail.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 10 ++++++++++
>  drivers/gpu/drm/panthor/panthor_gem.c    |  5 ++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4e4607bca7cc..45b71546f83c 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -190,6 +190,16 @@ struct panthor_device {
>  		/** @reclaim.lock: Lock protecting all LRUs */
>  		struct mutex lock;
>  
> +		/**
> +		 * @reclaim.unreclaimable: unreclaimable BOs
> +		 *
> +		 * Either the BO is unreclaimable because it has no pages allocated,
> +		 * or it's unreclaimable because pages are pinned.
> +		 *
> +		 * All BOs start in that list at creation time.
> +		 */
> +		struct drm_gem_lru unreclaimable;
> +
>  		/**
>  		 * @reclaim.unused: BOs with unused pages
>  		 *
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 13295d7a593d..8e31740126e7 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -204,7 +204,7 @@ void panthor_gem_update_reclaim_state_locked(struct panthor_gem_object *bo,
>  		drm_gem_lru_move_tail(&ptdev->reclaim.gpu_mapped_shared, &bo->base);
>  		break;
>  	case PANTHOR_GEM_UNRECLAIMABLE:
> -		drm_gem_lru_remove(&bo->base);
> +		drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
>  		break;
>  	default:
>  		drm_WARN(&ptdev->base, true, "invalid GEM reclaim state (%d)\n", new_state);
> @@ -994,6 +994,7 @@ static struct panthor_gem_object *
>  panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
>  		   struct panthor_vm *exclusive_vm, u32 usage_flags)
>  {
> +	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
>  	struct panthor_gem_object *bo;
>  	int ret;
>  
> @@ -1026,6 +1027,7 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
>  	}
>  
>  	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
> +	drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
>  	return bo;
>  
>  err_put:
> @@ -1551,6 +1553,7 @@ int panthor_gem_shrinker_init(struct panthor_device *ptdev)
>  		return ret;
>  
>  	INIT_LIST_HEAD(&ptdev->reclaim.vms);
> +	drm_gem_lru_init(&ptdev->reclaim.unreclaimable, &ptdev->reclaim.lock);
>  	drm_gem_lru_init(&ptdev->reclaim.unused, &ptdev->reclaim.lock);
>  	drm_gem_lru_init(&ptdev->reclaim.mmapped, &ptdev->reclaim.lock);
>  	drm_gem_lru_init(&ptdev->reclaim.gpu_mapped_shared, &ptdev->reclaim.lock);
> 
> -- 
> 2.54.0
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
