Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC97CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 13:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1963010E5E1;
	Fri,  8 May 2026 13:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mIOLYQ6t";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B24EA10E5E1
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 13:49:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0758D358B
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:49:32 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 0B0C73F836
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778248177; bh=KWYJnVlBnj7V7qkaHdFDGEGcW0rUpKIbmySK/TzA54M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mIOLYQ6tmStQRUeNvHh+vTe9xgTcwMdTeG7naUJd4dbyytv13aSzBajRzughrCfQr
 OZHPvsRlg8FjkWErqWLUGpjPMZiZAy+t5ErA0Qq0kkcBDEmq3JPzuLPa0CQzuCeyqR
 l/Otf/7qAdkAcljJwBNRMJ9Q29C72MxEjUH7w0K8=
Date: Fri, 8 May 2026 14:49:16 +0100
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
Subject: Re: [PATCH v2 2/4] drm/gem: Fix a race between drm_gem_lru_scan()
 and drm_gem_object_release()
Message-ID: <af3p3GsJAskjVMWQ@e142607>
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-2-39cdb7d577c9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508-panthor-shrinker-fixes-v2-2-39cdb7d577c9@collabora.com>
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

On Fri, May 08, 2026 at 12:40:48PM +0200, Boris Brezillon wrote:
> The following race can currently happen:
> 
> | Thread 0 in `drm_gem_lru_scan`               | Thread 1 in `drm_gem_object_release` |
> | -                                            | -                                    |
> | move obj1 with refcount==0 to `still_in_lru` |                                      |
> | move obj2 with refcount!=0 to `still_in_lru` |                                      |
> | mutex_unlock                                 |                                      |
> | shrink obj2                                  |                                      |
> |                                              | lru = obj1->lru; // `still_in_lru`   |
> | mutex_lock                                   |                                      |
> | move obj1 back to the original lru           |                                      |
> | mutex_unlock                                 |                                      |
> | return                                       |                                      |
> |                                              | dereference `still_in_lru`           |
> 
> Move the drm_gem_lru_move_tail_locked() after the
> kref_get_unless_zero() check so that we don't end up with a
> vanishing LRU when we hit drm_gem_object_release(). We also need to
> remove the skipped object from its LRU, otherwise we'll keep hitting
> it on subsequent loop iterations until it's actually removed from the
> list in the drm_gem_release().
> 
> Fixes: e7c2af13f811 ("drm/gem: Add LRU/shrinker helper")
> Reported-by: Chia-I Wu <olvaffe@gmail.com>
> Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/gpu/drm/drm_gem.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index fca42949eb2b..0e087c770883 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1573,11 +1573,31 @@ drm_gem_lru_remove(struct drm_gem_object *obj)
>  {
>  	struct drm_gem_lru *lru = obj->lru;
>  
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

I like the description, but I think it's worth merging the later comment around
the second check here as that is basically the whole "belt and braces" mechanism
for ensuring correctness.

Best regards,
Liviu

> +	 */
>  	if (!lru)
>  		return;
>  
>  	mutex_lock(lru->lock);
> -	drm_gem_lru_remove_locked(obj);
> +	/* Check a second time with the lock held to make sure we're not racing
> +	 * with another drm_gem_lru_remove[_locked]() call.
> +	 */
> +	if (obj->lru)
> +		drm_gem_lru_remove_locked(obj);
>  	mutex_unlock(lru->lock);
>  }
>  EXPORT_SYMBOL(drm_gem_lru_remove);
> @@ -1660,15 +1680,17 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
>  		if (!obj)
>  			break;
>  
> -		drm_gem_lru_move_tail_locked(&still_in_lru, obj);
> -
>  		/*
>  		 * If it's in the process of being freed, gem_object->free()
> -		 * may be blocked on lock waiting to remove it.  So just
> -		 * skip it.
> +		 * may be blocked on lock waiting to remove it.  So just remove
> +		 * it from its current LRU and skip it.
>  		 */
> -		if (!kref_get_unless_zero(&obj->refcount))
> +		if (!kref_get_unless_zero(&obj->refcount)) {
> +			drm_gem_lru_remove_locked(obj);
>  			continue;
> +		}
> +
> +		drm_gem_lru_move_tail_locked(&still_in_lru, obj);
>  
>  		/*
>  		 * Now that we own a reference, we can drop the lock for the
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
