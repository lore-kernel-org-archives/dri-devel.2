Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577B1C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972CD10F29E;
	Wed,  2 Sep 2026 15:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="FtaN2LnQ";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E9710F29E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363947; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UhFFlt1i5mKz6DMTn7K6k+P0CkuyNtLl30G3qsFNlX6Y811Meeqi4MSEZwQgwT6cXX7Y1sBZUqOVeX0VM/JpJMVS4EsSSmhFngFHyMVDVv81kjyo7ONcvPlQOCbYi3awWSgLBXNdm4Mt9cB82EK3ciSyhxmO0fS4riNAc/j/P0s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363947;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=95laa3vYcjrSW4DJqqk5UrSEzIoZlEr7RoiA5ZBZ34o=; 
 b=b+JFGkaP0H1xOjfcyCjB5gaCq6uQdHdllFE+r5YP5kElcQK8malNJo7Bt19S4m9qJdpQvUAMPSgxLcO8I/5cEBq6P6j1wrzf/z4T3LR3crU6lY5wAAjLrecaEwq4g8W2CUHD9qqy/uJQq1ZzyOYHa9F/VL3rlcReuNoRzoNw4iY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363947; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=95laa3vYcjrSW4DJqqk5UrSEzIoZlEr7RoiA5ZBZ34o=;
 b=FtaN2LnQExAfGPnwvVFfpUcpdpsozrLH3a3fvnyPaGSF5P6QeQazimQ+H+Yfdvaf
 BxFpTn0RXpHFtqsOLbA/jcHDoMlIgY57sNgG4jCJ4zh3GpsPjes2gsi2ZPipo3D5mTB
 foyJ+a/UNMr79LpKGXviI71UTe44ZhFBh5as7wHw=
Received: by mx.zohomail.com with SMTPS id 17883639444531010.3453912836795;
 Wed, 2 Sep 2026 08:45:44 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:45:38 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 16/17] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <aphEYmFOxITYikRU@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-16-72a13b2c125d@collabora.com>
 <20260901160344.586a2295@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901160344.586a2295@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 16:03, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:56 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Formerly, the reset sequence would race with panfrost_mmu_as_put()
> > when tearing down a perfcnt session. On top of that, poking GPU
> > registers to program a perfcnt session or obtaining a dump might lead to
> > undefined behaviour when done at the same time a reset was ongoing.
> > 
> > Use the reset r/w semaphore to govern access to the hardware at reset
> > time. On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> > so that userspace can be made aware of a reset having happened, because
> > that means counters will go back to 0 and can no longer be accumulated
> > to values previously kept in user space.
> > 
> > The new perfcnt-aware reset sequence also takes care to reestablish
> > perfcnt to its original configuration if there was an enabled session.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c  |   1 +
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 189 ++++++++++++++++++++--------
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
> >  include/uapi/drm/panfrost_drm.h             |   3 +-
> >  4 files changed, 140 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index c8c5dc26b03d..471bd4b037e6 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -498,6 +498,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev)
> >  	panfrost_gpu_power_on(pfdev);
> >  	panfrost_mmu_reset(pfdev);
> >  	panfrost_jm_reset_interrupts(pfdev);
> > +	panfrost_perfcnt_reset(pfdev);
> >  }
> >  
> >  static int panfrost_device_runtime_resume(struct device *dev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index b3f71d7fd82a..0564aa2753f9 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > @@ -11,6 +11,7 @@
> >  #include <drm/drm_file.h>
> >  #include <drm/drm_gem_shmem_helper.h>
> >  #include <drm/panfrost_drm.h>
> > +#include <drm/drm_print.h>
> >  
> >  #include "panfrost_device.h"
> >  #include "panfrost_features.h"
> > @@ -25,14 +26,18 @@
> >  #define BYTES_PER_COUNTER		4
> >  #define BLOCKS_PER_COREGROUP		8
> >  #define V4_SHADERS_PER_COREGROUP	4
> > +#define PERFCNT_DUMP_MAX_RETRIES	5
> >  
> >  struct panfrost_perfcnt {
> >  	struct panfrost_gem_mapping *mapping;
> > +	unsigned int counterset;
> >  	size_t bosize;
> >  	void *buf;
> >  	struct panfrost_file_priv *user;
> >  	struct mutex lock;
> >  	struct completion dump_comp;
> > +	bool reset_happened;
> > +	bool reset_failed;
> >  };
> >  
> >  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> > @@ -58,25 +63,107 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  		complete(&pfdev->perfcnt->dump_comp);
> >  }
> >  
> > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> >  {
> > -	u64 gpuva;
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u32 cfg, as;
> >  	int ret;
> >  
> > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > -	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	as = ret;
> > +	cfg = GPU_PERFCNT_CFG_AS(as) |
> > +	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> > +
> > +	/*
> > +	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> > +	 * the first one for now.
> > +	 */
> > +	if (panfrost_model_is_bifrost(pfdev))
> > +		cfg |= GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
> > +
> > +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> > +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> > +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> > +
> > +	/*
> > +	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> > +	 * counters.
> > +	 */
> > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > +	else
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +
> > +	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > +
> > +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +
> > +	return 0;
> > +}
> > +
> > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> > +					u64 *reset_happened)
> > +{
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > +	s64 retries = PERFCNT_DUMP_MAX_RETRIES;
> > +	bool retry;
> > +	int ret;
> > +
> > +dump_retry:
> > +	retry = false;
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		*reset_happened = perfcnt->reset_happened;
> > +		perfcnt->reset_happened = false;
> > +		if (perfcnt->reset_failed) {
> 
> I'd rather treat that as a terminal fault (returning -EIO, and maybe
> reflecting the perf session as dead through some state flag) in order
> to force the user to re-create a session. The only case where it would
> fail is if as_get() fails, and it's not supposed to fail after a reset.
> This should simplify the dump logic quite a bit.

Does that mean forcing the user to go through the disable/enable dance?
I thought because in the event of a reset, UM would still like to claim ownership
of perfcnt, recovering within the dump ioctl itself and notifying that a reset happened
so that it can respond to counters also being reset was the quickest way around.

> > +			ret = panfrost_perfcnt_hw_enable(pfdev);
> > +			if (ret)
> > +				return ret;
> > +			perfcnt->reset_failed = false;
> > +		}
> > +
> > +		reinit_completion(&pfdev->perfcnt->dump_comp);
> > +
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > +	}
> > +
> > +	/*
> > +	 * Here we release the reset semaphore because perfcnt should not get in the way
> > +	 * of a HW reset. The downside is in the gap between the completion is flagged
> > +	 * by the GPU IRQ handler and the sempahore taken once again, yet another reset
> > +	 * could happen, which would lead to a valid sample being discarded. This is
> > +	 * a solution of compromise between ensuring synchronisation with the reset
> > +	 * sequence and letting it happen as quickly as possible for jobs to be rerun.
> > +	 */
> > +
> >  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
> >  							msecs_to_jiffies(1000));
> > -	if (!ret)
> > -		ret = -ETIMEDOUT;
> > -	else if (ret > 0)
> > -		ret = 0;
> > +
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		if (ret > 0) {
> > +			if (perfcnt->reset_happened) {
> > +				if (--retries >= 0)
> > +					retry = true;
> > +				else
> > +					ret = -EBUSY;
> > +			} else {
> > +				ret = 0;
> > +			}
> > +		} else if (!ret) {
> > +			ret = -ETIMEDOUT;
> > +		}
> > +	}
> 
> I think it's fine to return -EAGAIN here and skip the retry, because
> what's important is the re-enable part: get the counting running again
> as soon as we can, so that, if the user-side sampling is done at a low
> rate, we still get non-zero values between two dumps when a reset
> occurred in the middle.

I'm a bit confused about the uAPI you have in mind. When would we return -EAGAIN and when -EIO?
I guess the former would signal that a dump ioctl can be re-attempted, while the latter that
a whole perfcnt_disable/enable cycle needs to happen before issuing a new dump.

> > +
> > +	if (retry)
> > +		goto dump_retry;
> >  
> >  	return ret;
> >  }
> > @@ -87,9 +174,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  {
> >  	struct panfrost_file_priv *user = file_priv->driver_priv;
> >  	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > -	struct iosys_map map;
> >  	struct drm_gem_shmem_object *bo;
> > -	u32 cfg, as;
> > +	struct iosys_map map;
> >  	int ret;
> >  
> >  	if (user == perfcnt->user)
> > @@ -122,7 +208,9 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	ret = drm_gem_vmap(&bo->base, &map);
> >  	if (ret)
> >  		goto err_put_mapping;
> > +
> >  	perfcnt->buf = map.vaddr;
> > +	perfcnt->counterset = counterset;
> >  
> >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> >  
> > @@ -132,44 +220,19 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> >  	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> >  
> > -	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> > -	if (ret < 0)
> > -		goto err_vunmap;
> > -
> > -	as = ret;
> > -	cfg = GPU_PERFCNT_CFG_AS(as) |
> > -	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> > -
> > -	/*
> > -	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> > -	 * the first one for now.
> > -	 */
> > -	if (panfrost_model_is_bifrost(pfdev))
> > -		cfg |= GPU_PERFCNT_CFG_SETSEL(counterset);
> > -
> > -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> > -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> > -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		ret = panfrost_perfcnt_hw_enable(pfdev);
> > +		if (ret)
> > +			goto err_vunmap;
> >  
> > -	/*
> > -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> > -	 * counters.
> > -	 */
> > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > -	else
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > -
> > -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > -
> > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +		perfcnt->reset_happened = false;
> > +		perfcnt->reset_failed = false;
> > +		perfcnt->user = user;
> > +	}
> >  
> >  	/* The BO ref is retained by the mapping. */
> >  	drm_gem_object_put(&bo->base);
> >  
> > -	perfcnt->user = user;
> > -
> >  	return 0;
> >  
> >  err_vunmap:
> > @@ -195,13 +258,16 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	if (user != perfcnt->user)
> >  		return -EINVAL;
> >  
> > -	panfrost_perfcnt_hw_disable(pfdev);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		panfrost_perfcnt_hw_disable(pfdev);
> > +		if (!perfcnt->reset_failed)
> > +			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> 
> Let's not conflate !reset_failed and owns_as_slot, even if they are
> related in practice.

I did this so that mmu->as_count would be kept balanced in case a reset happened but
panfrost_mmu_as_get() for perfcnt's AS failed during recovery in panfrost_perfcnt_hw_enable().
Because mmu->as_count can only be 0 during perfcnt_disabled when perfcnt_reset has failed,
I thought this conflation was reasonable. Alternatively I could just poke into mmu->as_count
to make sure it's greater than 0, but that sounds like inspecting private MMU implementation
details from the perfcnt subsystem and it doesn't look good.

> > +		perfcnt->user = NULL;
> > +	}
> >  
> > -	perfcnt->user = NULL;
> >  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> >  	perfcnt->buf = NULL;
> >  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> > -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> >  	panfrost_gem_mapping_put(perfcnt->mapping);
> >  	perfcnt->mapping = NULL;
> >  	pm_runtime_put_autosuspend(pfdev->base.dev);
> > @@ -255,7 +321,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
> >  		goto out;
> >  	}
> >  
> > -	ret = panfrost_perfcnt_dump_locked(pfdev);
> > +	ret = panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -338,3 +404,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
> >  	/* Disable everything before leaving. */
> >  	panfrost_perfcnt_hw_disable(pfdev);
> >  }
> > +
> > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> > +{
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +
> > +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> > +		return;
> > +
> > +	lockdep_assert_held(&pfdev->reset.lock);
> > +
> > +	if (!perfcnt->user)
> > +		return;
> > +
> > +	perfcnt->reset_failed = !!panfrost_perfcnt_hw_enable(pfdev);
> > +	perfcnt->reset_happened = true;
> > +	complete(&perfcnt->dump_comp);
> > +}
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > index 8bbcf5f5fb33..8b9bc704b634 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > @@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
> >  				  struct drm_file *file_priv);
> >  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
> >  				struct drm_file *file_priv);
> > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
> >  
> >  #endif
> > diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> > index 50d5337f35ef..3bbf9220103d 100644
> > --- a/include/uapi/drm/panfrost_drm.h
> > +++ b/include/uapi/drm/panfrost_drm.h
> > @@ -47,7 +47,7 @@ extern "C" {
> >   * them for anything but debugging purpose.
> >   */
> >  #define DRM_IOCTL_PANFROST_PERFCNT_ENABLE	DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_ENABLE, struct drm_panfrost_perfcnt_enable)
> > -#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
> > +#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
> >  
> >  #define PANFROST_JD_REQ_FS (1 << 0)
> >  #define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
> > @@ -272,6 +272,7 @@ struct drm_panfrost_perfcnt_enable {
> >  
> >  struct drm_panfrost_perfcnt_dump {
> >  	__u64 buf_ptr;
> > +	__u64 hw_reset;
> 
> Let's make this a
> 
> 	__u32 state;
> 	__u32 pad;
> 
> and define state flags like:
> 
> #define PANFROST_PERFCNT_SESSION_DEAD                 (1 << 0)
> #define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)
> 
> so we can easily extend the thing without introducing new fields or
> renaming hw_reset.
> 
> >  };
> >  
> >  /* madvise provides a way to tell the kernel in case a buffers contents
> > 

Adrian Larumbe
