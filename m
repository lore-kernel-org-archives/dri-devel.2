Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C07CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C80E10F0AA;
	Thu,  7 May 2026 10:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oXzD96vh";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D091D10F0AA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:19:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106D519F6
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 03:19:16 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 1E26C3F836
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778149161; bh=TG08dbsdevsuUuKiOfCppaUESy80nCb00HkxvqnrU2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oXzD96vhu672aCnXbsoMO3Gh92QJjDkkwSB7/EYGXTMlgWMAIJ4d7rSonpxIrpXqX
 zqxJCuaMy38ePyiLQmFxFLfeP6aBBGLp2nT9yQWGE0yhtVny3nuaKOErNMch5SXja1
 jmxOODwdyu1Kmq9/hAgoAAM6SmzYYX2jkZuUTchQ=
Date: Thu, 7 May 2026 11:18:55 +0100
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
Subject: Re: [PATCH 2/3] drm/gem: Fix a race between drm_gem_lru_scan() and
 drm_gem_object_release()
Message-ID: <afxnD-YhUsLdLmWN@e142607>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
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

On Wed, May 06, 2026 at 02:16:27PM +0200, Boris Brezillon wrote:
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
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gem.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index fca42949eb2b..97cf63de0112 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1660,15 +1660,19 @@ drm_gem_lru_scan(struct drm_gem_lru *lru,
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
> +			if (obj->lru)
> +				drm_gem_lru_remove_locked(obj);
> +
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
