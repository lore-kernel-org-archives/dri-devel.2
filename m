Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672C2CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A903710E1D2;
	Wed,  6 May 2026 15:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pTtyE1gt";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0019410E1D2;
 Wed,  6 May 2026 15:40:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D24B71A00;
 Wed,  6 May 2026 08:40:23 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993E63F7B4;
 Wed,  6 May 2026 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778082029; bh=bHXOtIzqT8aOSc77byfk93z12RxtohGmdl0a/NUjWzU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pTtyE1gtb59IOTxDCirzd886wiUYkHfrrdpGH1jR/zeOy1suieCwDv4WiMz5r9wPj
 Z9chez35XI2F+KicGm33sPSBp6scUbZOQONyEH/cUBN55N8Qsr50yWkZoqEZGfJHZN
 CDZR8sD/883aBHX6Ei0tlT6ZnKZ6D928YZis8a/s=
Message-ID: <23c69bee-868d-4142-a96e-36de61f23f4f@arm.com>
Date: Wed, 6 May 2026 16:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panthor: Don't use the racy drm_gem_lru_remove()
 helper
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
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

On 06/05/2026 13:16, Boris Brezillon wrote:
> drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
> variable that's then dereferenced to acquire the LRU lock. Because this
> assignment in done without the LRU lock held, it can race with
s/in/is/     ^^
> drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
> a stack-allcated LRU that goes away when leaving the function. By
> the time we dereference this local lru variable, the object might already
> be gone.
> 
> It feels like drm_gem_lru_move_tail() was never meant to be used this
> way, because there's no easy way we can avoid this race unless we defer
> the locking to the caller. Let's add an explicit LRU for unreclaimable
> BOs instead, and have all BOs added to this LRU at creation time.
> 
> Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
> Reported-by: Chia-I Wu <olvaffe@gmail.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

With minor typos fixed

Reviewed-by: Steven Price <steven.price@arm.com>

Although an alternative would be to expose drm_gem_lru_remove_locked()
in some form (maybe a wrapper which requires passing in the lock?)

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
s/that/this/                        ^^^^

Thanks,
Steve

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

