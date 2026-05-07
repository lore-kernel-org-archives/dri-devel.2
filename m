Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C468CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 12:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59F210E222;
	Thu,  7 May 2026 12:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="P3JDXcbm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D320410E222;
 Thu,  7 May 2026 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778158003;
 bh=cnZR5W9FGizEToKXwLmQBP3mXWODE6QQC3LUbnT2NB4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=P3JDXcbmffUPrjf53yyyKHDM8ZwYE8VVRM9AO9P417tn50mcZq/T4XpEFLDz/6L1c
 o1cjbQGiGudEFelzd8awsYxSzXg5XC60ULejTVd+5QUWKERxwmzVZU/XGMo6QD4zOv
 eT6l9HqOwKYfZsNa4rrLxvsqICkctWKRObkJI7jmWcd/l1yJB1VqHOoTfwcGcAmCXR
 ig9BvA5XeDfekjJaNq/ZVztMRON/nH0Uf1ousDGyXz1QtqJrzjhP+r3yzn01tzop0c
 MOc2ySNBSGDDwbwV9QfuprQKsbuFT7aUxlzXM/xATHXZ8pFOhVGzJC8ZeQleYXpyz8
 Io4t+NH/yBvUg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C4B1F17E138B;
 Thu,  7 May 2026 14:46:42 +0200 (CEST)
Date: Thu, 7 May 2026 14:46:39 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Akash Goel
 <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/gem: Fix a race between drm_gem_lru_scan() and
 drm_gem_object_release()
Message-ID: <20260507144639.68bd699f@fedora>
In-Reply-To: <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-2-e7721526de96@collabora.com>
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

On Wed, 06 May 2026 14:16:27 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

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

Actually, this thing is still racy, because obj->lru is dereferenced
without the lru->lock held in drm_gem_object_release(). At this point
I'm wondering if we should expose a drm_gem_lru_remove() taking the LRU
lock as an argument as suggested by Steve, and delegate the
responsibility to call drm_gem_lru_remove() to the driver. Either that,
or we make it so the LRU lock is attached to the drm_device instead of
the GEM (both MSM and panthor assume a device-wide lock for LRU
manipulation).

Rob, what's your take on this matter?
