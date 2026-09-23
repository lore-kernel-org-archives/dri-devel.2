Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DFC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C529B10EEE8;
	Wed, 23 Sep 2026 01:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SXDvdPTc";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6013910EEE8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790127556; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kQQbDAT1wWb1K9VEt9qZZjj3vmMX3DtOEiOnwrzhR7SqmScS4LpX63SETiot2n/wK37K78oEPcvBANtTjcb8kB9BGTO34tml4AJkKj0Ra5john7Qe/CszUDNn0/fG4Qy/2fxDZEA1kKXdSmTh8B/h7BMvjGzK/0obEgggpqUtCA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790127556;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uqjVhcVCJXDoL3BPs34TPDJ1IhkVxeBU2FJJpqaLRPs=; 
 b=U1bNEANeEyBO3tBp215SveoBWqP1PpULi3xVCV+X962vNmfvX0yiqhoLyyqMIAKlJnL4jLt8BKt0AdC4j9RWb9/7Xm0woNJwqog1gAz9R0NaFMcB2kr65h8rnhFM5MgdHSblXllZMOkAExMuWm/XrOrZ2hFUDp+xlij+WaNJ5Ns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790127556; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=uqjVhcVCJXDoL3BPs34TPDJ1IhkVxeBU2FJJpqaLRPs=;
 b=SXDvdPTcFUzlFXYnAY6LMESerHVr7JxTZ3Vnf0xhfVi+rBiSy7/TUS4jwtq9Swat
 AIu3zTp0/0DIqLvRg/zzaCgsj+hRESrD2sbTc/ef8Y7I1NaomyiyuUU7orGJuho4yVp
 Z4FWyFFBoLgzuVW2WCDtrypHLsYjQ8hvWN8UYVMc=
Received: by smtp.zohomail.com with SMTPS id 1790127555649833.3052572231342;
 Tue, 22 Sep 2026 18:39:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 02:39:10 +0100
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
Subject: Re: [PATCH v9 15/16] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <arLg_vX52EGl-AMN@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-15-e588feaa61ef@collabora.com>
 <20260914121657.2e9925c9@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914121657.2e9925c9@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.118.66
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

On 14.09.2026 12:16, Boris Brezillon wrote:
> On Sat, 12 Sep 2026 00:28:16 +0100
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
> 
> In GPU_PERFCNT_CFG_MODE_MANUAL mode (which is the one we use), internal
> counters are always cleared after each DUMP request. So, it's not so
> much that counters can't be accumulated after a RESET, it's more that
> we've lost data in the process, making this very sample inaccurate
> (counters lower than they should be).

I wasn't aware of this. I'll rephrase the commit message accordingly. 

> > 
> > The new perfcnt-aware reset sequence also takes care to reestablish
> > perfcnt to its original configuration if there was an enabled session,
> > or else flags the current session as dead if that failed.
> > 
> > Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> > Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 201 +++++++++++++++++++---------
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
> >  include/uapi/drm/panfrost_drm.h             |   8 +-
> >  4 files changed, 151 insertions(+), 61 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 6c65feae63aa..e774f61c642b 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -479,6 +479,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  	panfrost_jm_reset_interrupts(pfdev);
> >  	if (enable_job_int)
> >  		panfrost_jm_enable_interrupts(pfdev);
> > +
> > +	panfrost_perfcnt_reset(pfdev);
> >  }
> >  
> >  static int panfrost_device_runtime_resume(struct device *dev)
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index b3f71d7fd82a..9847657179a5 100644
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
> > @@ -28,11 +29,15 @@
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
> > +	bool dump_finished;
> 
> Why not store the state flags directly instead of these
> dump_finished/reset_happened booleans?

I had thought about this, but didn't do it because up until right before sending the
patch series, there were only two of them (reset_happened and owns_as_ref) and thought
owns_as_ref being set to false implies reset_happened is true, so a state flags variable
seemed like an overkill. However, after adding dump_finished, it'd be best to declare
a single flags variable and the possible values as bitmap values. 

> > +	bool owns_as_ref;
> >  };
> >  
> >  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> > @@ -47,36 +52,113 @@ static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> >  
> >  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
> >  {
> > +	pfdev->perfcnt->dump_finished = true;
> >  	complete(&pfdev->perfcnt->dump_comp);
> >  }
> >  
> >  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  {
> > -	if (pfdev->features.selected_coherency != COHERENCY_ACE)
> > +	if (pfdev->features.selected_coherency != COHERENCY_ACE) {
> >  		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> > -	else
> > +	} else {
> > +		pfdev->perfcnt->dump_finished = true;
> >  		complete(&pfdev->perfcnt->dump_comp);
> > +	}
> > +}
> > +
> > +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> > +{
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u32 cfg, as;
> > +	int ret;
> > +
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
> >  }
> >  
> > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *state)
> >  {
> > -	u64 gpuva;
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
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
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		perfcnt->dump_finished = false;
> > +		*state = 0;
> > +
> > +		if (!perfcnt->owns_as_ref) {
> > +			*state = PANFROST_PERFCNT_SESSION_DEAD;
> > +			return -EIO;
> > +		}
> > +
> > +		if (perfcnt->reset_happened) {
> > +			*state = PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > +			perfcnt->reset_happened = false;
> > +		}
> 
> 		*state = perfcnt->state;

I'm thinking maybe we don't need to set the ioctl output state here. Even if there was
a reset, if we recovered from it and didn't lose the AS reference, we might be able to
go forward as usual. In that case, counters would be measured since the latest reset
rather than the last successful dump, although maybe this is not an issue. 

> 		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> 			return -EIO;
> 
> 		perfcnt->state = 0;

I'll create a bitmap enum for this to work.

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
> > +	 * of a HW reset. Besides, a legitimate reset might be issued during the wait.
> > +	 */
> >  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
> >  							msecs_to_jiffies(1000));
> > -	if (!ret)
> > -		ret = -ETIMEDOUT;
> > -	else if (ret > 0)
> > -		ret = 0;
> > +
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		/* Either sample finished or reset happened */
> > +		if (ret > 0) {
> > +			ret = perfcnt->dump_finished ? 0 :
> > +			      perfcnt->owns_as_ref ? -EAGAIN : -EIO;
> > +
> > +		} else if (!ret) {
> > +			ret = -ETIMEDOUT;
> > +		}
> > +
> > +		if (perfcnt->reset_happened)
> > +			*state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> > +		if (!perfcnt->owns_as_ref)
> > +			*state |= PANFROST_PERFCNT_SESSION_DEAD;
> > +	}
> 
> 	if (!ret)
> 		return -ETIMEDOUT;

I was doing this check inside the guard because, in the time between the completion
is signalled and the semaphore locked, another reset could come right through.
And then because I believed counter values were accumulated rather than reset between
consecutive dumps, it was best to notify the user as soon as possible, even if that
meant losing one legitimate frame.

> 	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> 		u32 new_state = perfcnt->state;
> 
> 		*state |= new_state;
> 		if (new_state & PANFROST_PERFCNT_SESSION_DEAD)
> 			return -EIO;
> 
> 		perfcnt->state = 0;

I think this should not be here, because we're already resetting the state before
running the PERFCNT_SAMPLE GPU command, and also we need to check it right below.

> 		/* If we faced a reset during our SAMPLE, the user needs to try again. */
> 		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> 			return -EAGAIN;
> 	}

The main reason I added the panfrost_perfcnt::dump_finished flag was that when a reset happens,
the GPU IRQ handler might've been already running in response to a finished perfcnt sample
command. However, the reset sequence might come off first and cancel the completion, leaving
us with a ret > 0 despite sampling having succeeded.

I'm thinking rather than trying to sort of patch this up precariously as I did in this revision,
I'll leave it the way you suggested and address the race between the GPU IRQ handler and the
reset sequence in a future series.

> 	return 0;

We still need to return -ERESTARTSYS when wait_for_completion_interruptible_timeout()
is interrupted from UM.

> >  
> >  	return ret;
> >  }
> > @@ -87,9 +169,8 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
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
> > @@ -122,54 +203,31 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	ret = drm_gem_vmap(&bo->base, &map);
> >  	if (ret)
> >  		goto err_put_mapping;
> > +
> >  	perfcnt->buf = map.vaddr;
> > +	perfcnt->counterset = counterset;
> >  
> >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> >  
> > -	/*
> > -	 * Clear the counters to start from a fresh state.
> > -	 */
> > -	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > -
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
> > -
> > -	/*
> > -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> > -	 * counters.
> > -	 */
> > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> > -	else
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		/*
> > +		 * Clear the counters to start from a fresh state.
> > +		 */
> > +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> >  
> > -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> > +		ret = panfrost_perfcnt_hw_enable(pfdev);
> > +		if (ret)
> > +			goto err_vunmap;
> >  
> > -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> > -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> > +		perfcnt->reset_happened = false;
> > +		perfcnt->owns_as_ref = true;
> 
> This should probably be set in panfrost_perfcnt_hw_enable(), just after the 
> panfrost_mmu_as_get() call.

Will do in the next revision.

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
> > @@ -195,13 +253,16 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	if (user != perfcnt->user)
> >  		return -EINVAL;
> >  
> > -	panfrost_perfcnt_hw_disable(pfdev);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		panfrost_perfcnt_hw_disable(pfdev);
> > +		if (perfcnt->owns_as_ref)
> > +			panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> 
> Similarly, I think it'd be preferable to have this as_put() inside
> perfcnt_hw_disable().

Agreed.

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
> > @@ -249,13 +310,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (req->pad)
> > +		return -EINVAL;
> > +
> >  	mutex_lock(&perfcnt->lock);
> >  	if (perfcnt->user != file_priv->driver_priv) {
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> >  
> > -	ret = panfrost_perfcnt_dump_locked(pfdev);
> > +	ret = panfrost_perfcnt_dump_locked(pfdev, &req->state);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -338,3 +402,20 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
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
> > +	perfcnt->owns_as_ref = !panfrost_perfcnt_hw_enable(pfdev);
> > +	perfcnt->reset_happened = true;
> > +	complete(&perfcnt->dump_comp);
> 
> 	/* All active AS are released during the MMU post_reset. */
> 	perfcnt->owns_as_ref = false;

I'm guessing this should go away as soon as I move it into panfrost_perfcnt_hw_enable().

> 	perfcnt->state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> 	if (panfrost_perfcnt_hw_enable(pfdev))
> 		perfcnt->state |= PANFROST_PERFCNT_SESSION_DEAD;
> 
> 	/* Unblock pending sample requests. */
> 	complete(&perfcnt->dump_comp);
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
> > index 50d5337f35ef..97e001040543 100644
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
> > @@ -270,8 +270,14 @@ struct drm_panfrost_perfcnt_enable {
> >  	__u32 counterset;
> >  };
> >  
> > +/* Perfcnt dump state as influenced by a HW reset */
> > +#define PANFROST_PERFCNT_SESSION_DEAD                 (1 << 0)
> > +#define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)
> > +
> >  struct drm_panfrost_perfcnt_dump {
> >  	__u64 buf_ptr;
> > +	__u32 state;
> > +	__u32 pad;		/* MBZ */
> >  };
> >  
> >  /* madvise provides a way to tell the kernel in case a buffers contents
> > 

Adrian Larumbe
