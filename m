Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A112CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979CB10EDDF;
	Wed,  6 May 2026 15:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="nTulg/TG";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BD83210EDDF;
 Wed,  6 May 2026 15:40:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7146302F;
 Wed,  6 May 2026 08:40:27 -0700 (PDT)
Received: from [10.57.69.49] (unknown [10.57.69.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F63E3F7B4;
 Wed,  6 May 2026 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778082033; bh=dOuepOxYrvpC0eOxRlco60j01LRxjiAn+sxvV1US3cM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nTulg/TGSqDYhnUd1XNCVDDgbDaLvlULG7zZKlbySv2F/KJYCp6CdpgdIUkCCUhTx
 R/t2roT6VmnjoOLMzGDJzQ+kiexzat/4pZZkltZPljC3hlwMasZ6b+8FveS4oFvVGZ
 BIl9nKaIifMIzdLKtb5qNSQY8m95YO2voLATZqm8=
Message-ID: <c6b19d8e-f060-40cb-babc-d58947e71e3e@arm.com>
Date: Wed, 6 May 2026 16:40:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/gem: Stop exposing the racy/unsafe
 drm_gem_lru_remove() helper
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
 <20260506-panthor-shrinker-fixes-v1-3-e7721526de96@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-3-e7721526de96@collabora.com>
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
> The only place where it's safe to call drm_gem_lru_remove() is when
> we know the drm_gem_object::lru field can't be concurrently updated,
> which we know is the case when the drm_gem_object is destroyed.
> 
> Rather than trying to make that safe, let's kill the function and inline
> its content in drm_gem_object_release().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/drm_gem.c | 49 +++++++++++++++++------------------------------
>  include/drm/drm_gem.h     |  1 -
>  2 files changed, 18 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 97cf63de0112..b6df4f62f7b5 100644
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
> @@ -1124,7 +1133,15 @@ drm_gem_object_release(struct drm_gem_object *obj)
>  	drm_gem_private_object_fini(obj);
>  
>  	drm_gem_free_mmap_offset(obj);
> -	drm_gem_lru_remove(obj);
> +
> +	/* If the object refcount drops to zero, it means no one can change
> +	 * the LRU it's inserted into, so it's safe to dereference
> +	 * drm_gem_object::lru without the drm_gem_lru::lock held.
> +	 */
> +	if (obj->lru) {
> +		guard(mutex)(obj->lru->lock);
> +		drm_gem_lru_remove_locked(obj);
> +	}
>  }
>  EXPORT_SYMBOL(drm_gem_object_release);
>  
> @@ -1552,36 +1569,6 @@ drm_gem_lru_init(struct drm_gem_lru *lru, struct mutex *lock)
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
> -	if (!lru)
> -		return;
> -
> -	mutex_lock(lru->lock);
> -	drm_gem_lru_remove_locked(obj);
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

