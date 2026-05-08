Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAEDCD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 15:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1D0010F533;
	Fri,  8 May 2026 15:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="c9i7qdR4";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1367910E0D7
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 15:01:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 591493596
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:01:07 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 6D90E3F763
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778252472; bh=tBSLp4TFWnzxz3eHgUik+or3IqdAn5knLKmt0L5xo5M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c9i7qdR4lhHGdCkWpkGKeJldGli/BBQXOAUlgXotnztO9g01aem3rKzZdfBX+81u1
 Iwi/VgiT20unhTgUfMdLndJc2/ffEyl6WPsTxzw3jKKh4yQXQFv6eo/uSZuAC0+GCW
 zm3xm+MNh8wyULSScuGJ8MWNwL2Q4Naaec1FtosY=
Date: Fri, 8 May 2026 16:00:51 +0100
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
Subject: Re: [PATCH v2 3/4] drm/gem: Stop exposing the racy/unsafe
 drm_gem_lru_remove() helper
Message-ID: <af36o8diwtmA4z8K@e142607>
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-3-39cdb7d577c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508-panthor-shrinker-fixes-v2-3-39cdb7d577c9@collabora.com>
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

On Fri, May 08, 2026 at 12:40:49PM +0200, Boris Brezillon wrote:
> The only place where it's safe to call drm_gem_lru_remove() is when
> we know the drm_gem_object::lru field can't be concurrently updated,
> which we know is the case when the drm_gem_object is destroyed.
> 
> Rather than trying to make that safe, let's kill the function and inline
> its content in drm_gem_object_release().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gem.c | 90 ++++++++++++++++++++---------------------------
>  include/drm/drm_gem.h     |  1 -
>  2 files changed, 39 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 0e087c770883..c85a39b8b163 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1108,6 +1108,15 @@ drm_gem_release(struct drm_device *dev, struct drm_file *file_private)
>  	idr_destroy(&file_private->object_idr);
>  }
>  
> +static void
> +drm_gem_lru_remove_locked(struct drm_gem_object *obj)
> +{
> +	obj->lru->count -= obj->size >> PAGE_SHIFT;
> +	WARN_ON(obj->lru->count < 0);
> +	list_del(&obj->lru_node);
> +	obj->lru = NULL;
> +}
> +
>  /**
>   * drm_gem_object_release - release GEM buffer object resources
>   * @obj: GEM buffer object
> @@ -1118,13 +1127,42 @@ drm_gem_release(struct drm_device *dev, struct drm_file *file_private)
>  void
>  drm_gem_object_release(struct drm_gem_object *obj)
>  {
> +	struct drm_gem_lru *lru;
> +
>  	if (obj->filp)
>  		fput(obj->filp);
>  
>  	drm_gem_private_object_fini(obj);
>  
>  	drm_gem_free_mmap_offset(obj);
> -	drm_gem_lru_remove(obj);
> +
> +	/*
> +	 * We do the lru != NULL check without the lru->lock held, which
> +	 * means we might end up with a stale lru value by the time the
> +	 * lock is acquired.
> +	 *
> +	 * This is deemed safe because:
> +	 * 1. the LRU is assumed to outlive any GEM object it was attached
> +	 *    (LRUs are usually bound to a drm_device). So even if obj->lru
> +	 *    has become NULL, it still point to a valid object that can
> +	 *    safely be dereferenced to get the lock.
> +	 *
> +	 * 2. all LRUs a GEM object might be attached to must share the same
> +	 *    lock (lock that's usually part of the driver-specific device
> +	 *    object), so taking the lock on the 'old' LRU is equivalent
> +	 *    to taking it on the new one (if any)
> +	 */
> +	lru = obj->lru;
> +	if (lru) {
> +		guard(mutex)(lru->lock);
> +
> +		/* Check a second time with the lock held to make sure we're
> +		 * not racing with the drm_gem_lru_remove_locked() call in
> +		 * drm_gem_lru_scan().
> +		 */
> +		if (obj->lru)
> +			drm_gem_lru_remove_locked(obj);
> +	}
>  }
>  EXPORT_SYMBOL(drm_gem_object_release);
>  
> @@ -1552,56 +1590,6 @@ drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock)
>  }
>  EXPORT_SYMBOL(drm_gem_lru_init);
>  
> -static void
> -drm_gem_lru_remove_locked(struct drm_gem_object *obj)
> -{
> -	obj->lru->count -= obj->size >> PAGE_SHIFT;
> -	WARN_ON(obj->lru->count < 0);
> -	list_del(&obj->lru_node);
> -	obj->lru = NULL;
> -}
> -
> -/**
> - * drm_gem_lru_remove - remove object from whatever LRU it is in
> - *
> - * If the object is currently in any LRU, remove it.
> - *
> - * @obj: The GEM object to remove from current LRU
> - */
> -void
> -drm_gem_lru_remove(struct drm_gem_object *obj)
> -{
> -	struct drm_gem_lru *lru = obj->lru;
> -
> -	/*
> -	 * We do the lru != NULL check without the lru->lock held, which
> -	 * means we might end up with a stale lru value by the time the
> -	 * lock is acquired.
> -	 *
> -	 * This is deemed safe because:
> -	 * 1. the LRU is assumed to outlive any GEM object it was attached
> -	 *    (LRUs are usually bound to a drm_device). So even if obj->lru
> -	 *    has become NULL, it still point to a valid object that can
> -	 *    safely be dereferenced to get the lock.
> -	 *
> -	 * 2. all LRUs a GEM object might be attached to must share the same
> -	 *    lock (lock that's usually part of the driver-specific device
> -	 *    object), so taking the lock on the 'old' LRU is equivalent
> -	 *    to taking it on the new one (if any)
> -	 */
> -	if (!lru)
> -		return;
> -
> -	mutex_lock(lru->lock);
> -	/* Check a second time with the lock held to make sure we're not racing
> -	 * with another drm_gem_lru_remove[_locked]() call.
> -	 */
> -	if (obj->lru)
> -		drm_gem_lru_remove_locked(obj);
> -	mutex_unlock(lru->lock);
> -}
> -EXPORT_SYMBOL(drm_gem_lru_remove);
> -
>  /**
>   * drm_gem_lru_move_tail_locked - move the object to the tail of the LRU
>   *
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 86f5846154f7..d527df98d142 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -611,7 +611,6 @@ int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
>  			    u32 handle, u64 *offset);
>  
>  void drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock);
> -void drm_gem_lru_remove(struct drm_gem_object *obj);
>  void drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj);
>  void drm_gem_lru_move_tail(struct drm_gem_lru *lru, struct drm_gem_object *obj);
>  unsigned long
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
