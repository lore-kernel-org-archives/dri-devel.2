Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4656CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004F510E1C9;
	Wed,  6 May 2026 15:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="a1+q1uJj";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C9410E1C9
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778080805; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ccnp9lLYXkWiV/1a8ryN+Ss+TqSFhqUNh4xFO9aotk0X82kVW8Ojoni4EJ2xNiF2A2rXf4G2584cVJ4hsrsxJtggfW1yh5RpN6c927Jy8ipbP5WNgqx+xOkgFGeCrFK56ewfx2qvh+auKmH2y34E7FbfHvZEuH7/L11fnRDo4a8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778080805;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mtMZ9EQALc5pJHEUStF4pqAx6HGSH8n0LEuG9ncFJTU=; 
 b=iU3j/vbKEdsrSbNtgJ6C+GLOD4u4f+kFAelbsvnv7Pkwnzh7u5DvLEAUkiGHoZpGSM4yE9QVBXpRqzVdCcm3kWpPwMhDAxS2Cm+mz70h2EkC+3fOv4DkubupCd3nqzOkK7LvxBJqP+76Ph9yrC46mg4mf3Lj21euUEdyHDMUiBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778080805; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=mtMZ9EQALc5pJHEUStF4pqAx6HGSH8n0LEuG9ncFJTU=;
 b=a1+q1uJjtnu7tN3y0mSCBvEXsb6m92i5aw/ypTWX4AuH0ylRG+IZBKipgKyU0wVQ
 YU/XUO9ejPyQUJK6Qz/lV8pTkPVp6Iod7wXlhPeMa5D5GS0KAegwkvza33LvTJue/ZZ
 NFUsYI83RhQktEHqC1XFSvyMNbkKj1WX+gIm9LdU=
Received: by mx.zohomail.com with SMTPS id 177808080434751.147007267912386;
 Wed, 6 May 2026 08:20:04 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 1/4] drm/panthor: Add freed_sz parameter to
 reclaim_priv_bos
Date: Wed, 06 May 2026 17:19:59 +0200
Message-ID: <uhheTk9bTneBzwQGdN_KPA@collabora.com>
In-Reply-To: <ed1b0be1-cf6e-4318-b040-12d315eae3f0@arm.com>
References: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
 <20260506-panthor-explicit-reclaim-v1-1-44f82ac147ce@collabora.com>
 <ed1b0be1-cf6e-4318-b040-12d315eae3f0@arm.com>
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

On Wednesday, 6 May 2026 17:06:57 Central European Summer Time Steven Price wrote:
> On 06/05/2026 11:45, Nicolas Frattaroli wrote:
> > panthor_mmu_reclaim_priv_bos returns the number of freed pages. However,
> > how many bytes of freed memory this translates to can't generally be
> > deduced from the number of pages, as the page size is a per-VM property.
> > 
> > It may be useful to know the exact number of bytes that have been freed
> 
> The "useful" aspect seems to just be a drm_dbg() message from what I can
> see with this series?

Correct.

> Am I missing something or is it not actually that useful?

I wanted to know how much memory I'm actually reclaiming without
making any assumptions about page sizes, and figured the change is
innocent enough. If it's deemed too pointless, then I'll just drop
the size in bytes from the debug message.

Kind regards,
Nicolas Frattaroli

> 
> Thanks,
> Steve
> 
> > for observability and debugging purposes. To that end, add a new
> > parameter "freed_sz", which is a pointer to a size_t where this
> > information will be stored. It may be NULL, in which case the
> > information isn't stored at all.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gem.c |  3 ++-
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 12 ++++++++++--
> >  drivers/gpu/drm/panthor/panthor_mmu.h |  1 +
> >  3 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> > index 13295d7a593d..80e82238f3c5 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -1511,7 +1511,8 @@ panthor_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
> >  		goto out;
> >  
> >  	freed += panthor_mmu_reclaim_priv_bos(ptdev, sc->nr_to_scan - freed,
> > -					      &remaining, panthor_gem_try_evict);
> > +					      &remaining, NULL,
> > +					      panthor_gem_try_evict);
> >  	if (freed >= sc->nr_to_scan)
> >  		goto out;
> >  
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index a7ee14986849..b81388b35a58 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -3127,13 +3127,18 @@ int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec, struct panthor_vm
> >  unsigned long
> >  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
> >  			     unsigned int nr_to_scan, unsigned long *remaining,
> > +			     size_t *freed_sz,
> >  			     bool (*shrink)(struct drm_gem_object *,
> >  					    struct ww_acquire_ctx *))
> >  {
> > +	unsigned long newly_freed;
> >  	unsigned long freed = 0;
> >  	LIST_HEAD(remaining_vms);
> >  	LIST_HEAD(vms);
> >  
> > +	if (freed_sz)
> > +		*freed_sz = 0;
> > +
> >  	mutex_lock(&ptdev->reclaim.lock);
> >  	list_splice_init(&ptdev->reclaim.vms, &vms);
> >  
> > @@ -3152,8 +3157,11 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
> >  
> >  		mutex_unlock(&ptdev->reclaim.lock);
> >  
> > -		freed += drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
> > -					  remaining, shrink, NULL);
> > +		newly_freed = drm_gem_lru_scan(&vm->reclaim.lru, nr_to_scan - freed,
> > +					       remaining, shrink, NULL);
> > +		if (freed_sz)
> > +			*freed_sz += panthor_vm_page_size(vm) * newly_freed;
> > +		freed += newly_freed;
> >  
> >  		mutex_lock(&ptdev->reclaim.lock);
> >  
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> > index 3522fbbce369..12b18b5f90e1 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> > @@ -52,6 +52,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo);
> >  unsigned long
> >  panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
> >  			     unsigned int nr_to_scan, unsigned long *remaining,
> > +			     size_t *freed_sz,
> >  			     bool (*shrink)(struct drm_gem_object *,
> >  					    struct ww_acquire_ctx *));
> >  int panthor_vm_prepare_mapped_bos_resvs(struct drm_exec *exec,
> > 
> 
> 




