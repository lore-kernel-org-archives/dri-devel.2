Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539A9F5A8A6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD0810E165;
	Mon, 20 Apr 2026 17:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YS6+dYWw";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E71810EB0B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 17:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776707219; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S++YgEaKjfXsPkIugzZV4hAO5yFqJ016OT+dPIdVNlQFkhn5snsei9HZygvenGiUBraUDkFGapRT2dV0SJ6H4L0SvArsNsCXcEOs2rdQC1+qgV8SEba8WQ3vRIbYAQ+JPtkLhJwpJf7/M6/u+fBFVkbXl2d1jlkpNjxYO5DjJSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776707219;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bm4FcGGu07nytUNI2kz1JShR0m/TlWoqE/3LBgeTZk4=; 
 b=DrhXehMpF8Ca+jiKuUYJTLNdz8DanpUEdG8devJDa4TqZAqCC18FXxz8twBDsp3QgVWGppssLOiWgdoPXIPQDKBlzcYtzm3e/ex0Rqblnpjb9c7fAwBTe2XuHOFLm126G1ZjcEshZvYYhLW3Rgzx94iJfN8Zak1xVKFH4R+zbxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776707219; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=bm4FcGGu07nytUNI2kz1JShR0m/TlWoqE/3LBgeTZk4=;
 b=YS6+dYWwq30ljBNnXA1uI3bVkP/uXk2Iu/cmRMdUJe8hZNj5p+l9nsNwnaz2twWa
 sTkE1UmB0GswuZma1+cVZxYqtV4OqWBhjK2YIYdDSfYFgV5hnk0rKqBYRoiuG6do0sN
 0RukogpIOP/quGGWGXzLDyy4Izajd0Y4pYIwf2Pk=
Received: by mx.zohomail.com with SMTPS id 1776707217181988.3795012862995;
 Mon, 20 Apr 2026 10:46:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 2/2] drm/panthor: Implement evicted status for GEM objects
Date: Mon, 20 Apr 2026 19:46:52 +0200
Message-ID: <ArK2sKSOQ3qNB7BnrfkXew@collabora.com>
In-Reply-To: <20260420181735.2990999e@fedora>
References: <20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com>
 <20260420-panthor-bo-reclaim-observability-v1-2-a4d1a36ee84f@collabora.com>
 <20260420181735.2990999e@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 20 April 2026 18:17:35 Central European Summer Time Boris Brezillon wrote:
> On Mon, 20 Apr 2026 17:47:00 +0200
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > For fdinfo to be able to fill its evicted counter with data, panthor
> > needs to keep track of whether a GEM object has ever been reclaimed.
> > Just checking whether the pages are resident isn't enough, as newly
> > allocated objects also won't be resident.
> > 
> > Do this with a new atomic_t member on panthor_gem_object. It's increased
> > when an object gets evicted by the shrinker. While it's allowed to wrap
> > around to below zero and assume a value less than a previous observed
> > value, the reclaim counter will never return to 0 for any particular
> > object once it's been reclaimed at least once.
> > 
> > Use this new member to then set the appropriate DRM_GEM_OBJECT_EVICTED
> > status flag for fdinfo, and use it in the gems debugfs. It's possible to
> > distinguish evicted non-resident pages from newly allocated non-resident
> > pages by checking whether reclaimed_count is != 0.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gem.c | 10 ++++++++++
> >  drivers/gpu/drm/panthor/panthor_gem.h | 11 +++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> > index 69cef05b6ef7..4b761b39565d 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -687,6 +687,10 @@ static void panthor_gem_evict_locked(struct panthor_gem_object *bo)
> >  	if (drm_WARN_ON_ONCE(bo->base.dev, !bo->backing.pages))
> >  		return;
> >  
> > +	/* Don't ever wrap around as far as 0, jump from INT_MIN to 1 */
> > +	if (!atomic_inc_unless_negative(&bo->reclaimed_count))
> > +		atomic_set(&bo->reclaimed_count, 1);
> 
> Can't we just go
> 
> 	atomic_add_unless(&bo->reclaimed_count, 1, INT_MAX);
> 
> here, to handle the INT_MAX saturation?

Yeah, I was torn between the two. My way does keep a somewhat
cyclical nature, so once it wraps, things could still detect
that it's increasing from one observance to the next.

But now that I think about it again, it's not a property of this
count that's worth keeping, I think. Nothing relies on this
behaviour currently, and at best it'll trip up any code that uses
it for a < comparison later down the road.

> > +
> >  	panthor_gem_dev_map_cleanup_locked(bo);
> >  	panthor_gem_backing_cleanup_locked(bo);
> >  	panthor_gem_update_reclaim_state_locked(bo, NULL);
> > @@ -788,6 +792,8 @@ static enum drm_gem_object_status panthor_gem_status(struct drm_gem_object *obj)
> >  
> >  	if (drm_gem_is_imported(&bo->base) || bo->backing.pages)
> >  		res |= DRM_GEM_OBJECT_RESIDENT;
> > +	else if (atomic_read(&bo->reclaimed_count))
> > +		res |= DRM_GEM_OBJECT_EVICTED;
> >  
> >  	return res;
> >  }
> > @@ -1595,6 +1601,7 @@ static void panthor_gem_debugfs_print_flag_names(struct seq_file *m)
> >  	static const char * const gem_state_flags_names[] = {
> >  		[PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT] = "imported",
> >  		[PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT] = "exported",
> > +		[PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT] = "evicted",
> >  	};
> >  
> >  	static const char * const gem_usage_flags_names[] = {
> > @@ -1648,6 +1655,9 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
> >  
> >  	if (drm_gem_is_imported(&bo->base))
> >  		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED;
> > +	else if (!resident_size && atomic_read(&bo->reclaimed_count))
> > +		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED;
> 
> I think it'd be interesting to know the number of times a BO got
> evicted.

Agreed. Should I add that as a separate column? I think I'll keep the
state flag even if I add a column, because even if it's technically
redundant, it'll still be useful to see without having to compare
three different columns.

> > +
> >  	if (bo->base.dma_buf)
> >  		gem_state_flags |= PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED;
> >  
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
> > index ae0491d0b121..1ab573f03330 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.h
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> > @@ -19,12 +19,16 @@ struct panthor_vm;
> >  enum panthor_debugfs_gem_state_flags {
> >  	PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT = 0,
> >  	PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT = 1,
> > +	PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT = 2,
> >  
> >  	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED: GEM BO is PRIME imported. */
> >  	PANTHOR_DEBUGFS_GEM_STATE_FLAG_IMPORTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_IMPORTED_BIT),
> >  
> >  	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED: GEM BO is PRIME exported. */
> >  	PANTHOR_DEBUGFS_GEM_STATE_FLAG_EXPORTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_EXPORTED_BIT),
> > +
> > +	/** @PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED: GEM BO is evicted to swap. */
> > +	PANTHOR_DEBUGFS_GEM_STATE_FLAG_EVICTED = BIT(PANTHOR_DEBUGFS_GEM_STATE_EVICTED_BIT),
> >  };
> >  
> >  enum panthor_debugfs_gem_usage_flags {
> > @@ -172,6 +176,13 @@ struct panthor_gem_object {
> >  	/** @reclaim_state: Cached reclaim state */
> >  	enum panthor_gem_reclaim_state reclaim_state;
> >  
> > +	/**
> > +	 * @reclaimed_count: How many times object has been evicted to swap.
> 
> 	 *
> 
> > +	 * Never returns to 0 once incremented even on wrap-around, but may
> > +	 * become < 0 and < the previous value if wrap-around occurs.
> 
> With the saturation I suggested, I'd just add that when INT_MAX is
> reached, it will stay there.
> 
> > +	 */
> > +	atomic_t reclaimed_count;
> > +
> >  	/**
> >  	 * @exclusive_vm_root_gem: Root GEM of the exclusive VM this GEM object
> >  	 * is attached to.
> > 
> 
> 




