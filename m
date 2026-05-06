Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F05ECD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F6210E1E2;
	Wed,  6 May 2026 16:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SnK+kHR9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54D5B10E1DA;
 Wed,  6 May 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778084713;
 bh=aEwby3hiBqgi8nQZsciVDDvsXj0kYmX+laF5UjXUEVg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SnK+kHR945GSMVWTHitLyP5YzUUC+Qab+3fG5NC2Z26bG+xuOvlr/PRHlKxMgnDlz
 HKQR4cJav6qPwr3wgPZoWIThhRtZHykxEkCLGsEc+Mzk0Pfx3LBkOrXYB4IKMyq1uD
 j6wYINvzl+ZG7dxF5bkuyEgKbhilySGoH71+pYiXf+5RHd9235Uovays0WXmBLUCJS
 /x2AUxprmTwu1L7zr/QkGZRMhjvJj1CUxWY3xBmXQ6Cym812zep4LdrEHgT7Q4kHe4
 jHyWzzlrBXwgHWsEr8Em6dn9D69o38CNxcQDQSTGWlFMN1PKooi0s4My9NgdtT09yx
 yQ3PeyNbJTGcg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 40B6217E124B;
 Wed,  6 May 2026 18:25:12 +0200 (CEST)
Date: Wed, 6 May 2026 18:25:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>, Chia-I Wu
 <olvaffe@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn
 Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Don't use the racy
 drm_gem_lru_remove() helper
Message-ID: <20260506182506.204a1ed2@fedora>
In-Reply-To: <23c69bee-868d-4142-a96e-36de61f23f4f@arm.com>
References: <20260506-panthor-shrinker-fixes-v1-0-e7721526de96@collabora.com>
 <20260506-panthor-shrinker-fixes-v1-1-e7721526de96@collabora.com>
 <23c69bee-868d-4142-a96e-36de61f23f4f@arm.com>
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

On Wed, 6 May 2026 16:40:22 +0100
Steven Price <steven.price@arm.com> wrote:

> On 06/05/2026 13:16, Boris Brezillon wrote:
> > drm_gem_lru_remove() dereference stores drm_gem_object::lru in a local
> > variable that's then dereferenced to acquire the LRU lock. Because this
> > assignment in done without the LRU lock held, it can race with  
> s/in/is/     ^^
> > drm_gem_lru_scan() where drm_gem_object::lru is temporarily assigned
> > a stack-allcated LRU that goes away when leaving the function. By
> > the time we dereference this local lru variable, the object might already
> > be gone.
> > 
> > It feels like drm_gem_lru_move_tail() was never meant to be used this
> > way, because there's no easy way we can avoid this race unless we defer
> > the locking to the caller. Let's add an explicit LRU for unreclaimable
> > BOs instead, and have all BOs added to this LRU at creation time.
> > 
> > Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
> > Reported-by: Chia-I Wu <olvaffe@gmail.com>
> > Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/86
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Reviewed-by: Chia-I Wu <olvaffe@gmail.com>  
> 
> With minor typos fixed
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although an alternative would be to expose drm_gem_lru_remove_locked()
> in some form (maybe a wrapper which requires passing in the lock?)

I considered that too, but I thought it was less invasive to just have
a default LRU to start in at creation time, and end in there's nothing
left to reclaim. It's also what MSM does, so I figured I'd do that too.

> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_device.h | 10 ++++++++++
> >  drivers/gpu/drm/panthor/panthor_gem.c    |  5 ++++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> > index 4e4607bca7cc..45b71546f83c 100644
> > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > @@ -190,6 +190,16 @@ struct panthor_device {
> >  		/** @reclaim.lock: Lock protecting all LRUs */
> >  		struct mutex lock;
> >  
> > +		/**
> > +		 * @reclaim.unreclaimable: unreclaimable BOs
> > +		 *
> > +		 * Either the BO is unreclaimable because it has no pages allocated,
> > +		 * or it's unreclaimable because pages are pinned.
> > +		 *
> > +		 * All BOs start in that list at creation time.  
> s/that/this/                        ^^^^
> 
> Thanks,
> Steve
> 
> > +		 */
> > +		struct drm_gem_lru unreclaimable;
> > +
> >  		/**
> >  		 * @reclaim.unused: BOs with unused pages
> >  		 *
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> > index 13295d7a593d..8e31740126e7 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -204,7 +204,7 @@ void panthor_gem_update_reclaim_state_locked(struct panthor_gem_object *bo,
> >  		drm_gem_lru_move_tail(&ptdev->reclaim.gpu_mapped_shared, &bo->base);
> >  		break;
> >  	case PANTHOR_GEM_UNRECLAIMABLE:
> > -		drm_gem_lru_remove(&bo->base);
> > +		drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
> >  		break;
> >  	default:
> >  		drm_WARN(&ptdev->base, true, "invalid GEM reclaim state (%d)\n", new_state);
> > @@ -994,6 +994,7 @@ static struct panthor_gem_object *
> >  panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
> >  		   struct panthor_vm *exclusive_vm, u32 usage_flags)
> >  {
> > +	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
> >  	struct panthor_gem_object *bo;
> >  	int ret;
> >  
> > @@ -1026,6 +1027,7 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
> >  	}
> >  
> >  	panthor_gem_debugfs_set_usage_flags(bo, usage_flags);
> > +	drm_gem_lru_move_tail(&ptdev->reclaim.unreclaimable, &bo->base);
> >  	return bo;
> >  
> >  err_put:
> > @@ -1551,6 +1553,7 @@ int panthor_gem_shrinker_init(struct panthor_device *ptdev)
> >  		return ret;
> >  
> >  	INIT_LIST_HEAD(&ptdev->reclaim.vms);
> > +	drm_gem_lru_init(&ptdev->reclaim.unreclaimable, &ptdev->reclaim.lock);
> >  	drm_gem_lru_init(&ptdev->reclaim.unused, &ptdev->reclaim.lock);
> >  	drm_gem_lru_init(&ptdev->reclaim.mmapped, &ptdev->reclaim.lock);
> >  	drm_gem_lru_init(&ptdev->reclaim.gpu_mapped_shared, &ptdev->reclaim.lock);
> >   
> 

