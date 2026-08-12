Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B22EC5AC67
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFB710E3D2;
	Wed, 12 Aug 2026 01:35:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="aMXQzvFx";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8949B10E3D2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 01:35:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786498550; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ebt/KpgoRAPQ26dM92yv+AdGNnHRXpniuIcUnIQr1+UiaHBlq+2YJQytQxuzjQxMz+406Dig/vqq6zk+ng6qyZzUnHsLv23nHj5f9Dl1ii98Cz7PlmYo9yoOJo0aUUgDm2CfXw06ynC2cTd2LVaYFLOyHqSlDkoLQziMEh9w9iE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786498550;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uLlnH2akaTMMeNJoWB7D5DjbIdJCWtOYZAhy/xxT0+U=; 
 b=UUtNhWU+5trBGuCxAD+k3i9UjDBaKOt5RF2rPKH1no4GGon8rbL9qdtZHyVo5CqkT8i0bUU4hp/J9l9ecytkfiGL9ufhcclMsxMqKRpGmJOaUZEX/hUMphWUBrS87m7j/XnER1htuuTlTJ42hb4LAwarfHc/7Vdf/UdHKJED3QA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786498550; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=uLlnH2akaTMMeNJoWB7D5DjbIdJCWtOYZAhy/xxT0+U=;
 b=aMXQzvFxY/GViQjIjBOqXa8cL7LASpLizntA1Gjd+pCAH85Youu1hxx+p6TcvbzU
 INeTCpBnko56lf/3g9EoQIncbokLrzNTzKE+sUZwJxrZr8VM4yaFT1iTWnYEV2V2exC
 viQ0g/u55wmhck6G/n8TEEDggT5XWlD3Kc4LdJZM=
Received: by mx.zohomail.com with SMTPS id 1786498547837601.5797601316431;
 Tue, 11 Aug 2026 18:35:47 -0700 (PDT)
Date: Wed, 12 Aug 2026 02:35:42 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 12/13] drm/panfrost: Fix races between perfcnt and
 reset sequence
Message-ID: <anvMYtg86gTRRpK3@sobremesa>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-12-01968f2ec77a@collabora.com>
 <48dba7be-6924-4bbc-a249-a62ef5fd5a88@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48dba7be-6924-4bbc-a249-a62ef5fd5a88@arm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.485.37
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

On 30.07.2026 13:49, Steven Price wrote:
> On 29/07/2026 03:54, Adrián Larumbe wrote:
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
> >  drivers/gpu/drm/panfrost/panfrost_device.c  |   5 +-
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 207 ++++++++++++++++++++--------
> >  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   2 +
> >  include/uapi/drm/panfrost_drm.h             |   3 +-
> >  4 files changed, 154 insertions(+), 63 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 926bdf21389f..ae0f10ba7455 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -616,8 +616,10 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  	int ret;
> >  
> >  	/* Pre-reset */
> > -	if (panfrost_device_started(pfdev))
> > +	if (panfrost_device_started(pfdev)) {
> >  		down_write(&pfdev->reset.lock);
> > +		panfrost_perfcnt_reset(pfdev);
> > +	}
> >  
> >  	/* Do the actual device reset */
> >  	ret = panfrost_gpu_soft_reset(pfdev);
> > @@ -629,6 +631,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  		panfrost_jm_reset_interrupts(pfdev);
> >  		if (enable_job_int)
> >  			panfrost_jm_enable_interrupts(pfdev);
> > +		panfrost_perfcnt_postreset(pfdev);
> >  		up_write(&pfdev->reset.lock);
> >  	}
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> > index ad1156678e91..b92ad9061893 100644
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
> > @@ -25,14 +26,17 @@
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
> >  };
> >  
> >  static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> > @@ -55,38 +59,97 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
> >  	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> >  }
> >  
> > -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> > +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> > +					u64 *reset_happened)
> >  {
> > -	u64 gpuva;
> > +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> > +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> > +	u64 retries = PERFCNT_DUMP_MAX_RETRIES;
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
> > +dump_retry:
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		*reset_happened = perfcnt->reset_happened;
> > +		perfcnt->reset_happened = false;
> > +		reinit_completion(&pfdev->perfcnt->dump_comp);
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> > +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> > +	}
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
> 
> retries is defined unsigned, so this statement is always true...

Sashiko had caught this in a previous iteration and then I forgot to fix it for this one :-/
Anyway, it's already fixed for v5, replaced with an s64.

> > +					goto dump_retry;
> > +				else
> > +					ret = -EBUSY;
> > +			} else {
> > +				ret = 0;
> > +			}
> > +		} else if (!ret) {
> > +			ret = -ETIMEDOUT;
> > +		}
> > +	}
> >  
> >  	return ret;
> >  }
> >  
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
> > +}
> > +
> >  static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  					  struct drm_file *file_priv,
> >  					  unsigned int counterset)
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
> > @@ -119,7 +182,9 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	ret = drm_gem_vmap(&bo->base, &map);
> >  	if (ret)
> >  		goto err_put_mapping;
> > +
> >  	perfcnt->buf = map.vaddr;
> > +	perfcnt->counterset = counterset;
> >  
> >  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
> >  
> > @@ -127,60 +192,46 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
> >  	 * Invalidate the cache and clear the counters to start from a fresh
> >  	 * state.
> >  	 */
> > -	reinit_completion(&pfdev->perfcnt->dump_comp);
> > -	gpu_write(pfdev, GPU_INT_CLEAR,
> > -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		reinit_completion(&pfdev->perfcnt->dump_comp);
> > +		gpu_write(pfdev, GPU_INT_CLEAR,
> > +			  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> > +			  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> > +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> > +		perfcnt->reset_happened = false;
> > +		perfcnt->user = user;
> > +	}
> > +
> > +	/*
> > +	 * If a reset happens during the wait for the IRQ notification that caches
> > +	 * are clean and invalidated, then we know the reset sequence did the job
> > +	 * for us, even if it takes long enough for the completion to time out.
> > +	 */
> >  	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
> >  					  msecs_to_jiffies(1000));
> > -	if (!ret) {
> > +	if (!ret && !perfcnt->reset_happened) {
> >  		ret = -ETIMEDOUT;
> >  		goto err_vunmap;
> >  	}
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
> > -
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
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		if (!perfcnt->reset_happened) {
> > +			ret = panfrost_perfcnt_hw_enable(pfdev);
> > +			if (ret)
> > +				goto err_vunmap;
> > +		}
> > +		perfcnt->reset_happened = false;
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
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock)
> > +		perfcnt->user = user;
> 
> This looks weird - AFAICT perfcnt->user will already have been set to
> 'user' above if we ever get to this error case. It also unusual to
> assign a pointer like this in an error path - I'd expect at least a
> comment explaining the reasoning.

This was a typo, it was meant to be 'perfcnt->user = NULL. However, I think you're right
that this kind of error path assignment looks rather uncomely. I had fixed the assignment,
but then in v5 Sashiko complained of another error this handling introduces, so for v6
I'll take the semaphore right after the completion is either waited on or expires, reset
the user pointer in the latter case and jump to err_vunmap.

> Thanks,
> Steve
> 
> >  	drm_gem_vunmap(&bo->base, &map);
> >  err_put_mapping:
> >  	panfrost_gem_mapping_put(perfcnt->mapping);
> > @@ -203,13 +254,15 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> >  	if (user != perfcnt->user)
> >  		return -EINVAL;
> >  
> > -	panfrost_perfcnt_gpu_disable(pfdev);
> > +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> > +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> > +		panfrost_perfcnt_gpu_disable(pfdev);
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
> > @@ -263,7 +316,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
> >  		goto out;
> >  	}
> >  
> > -	ret = panfrost_perfcnt_dump_locked(pfdev);
> > +	ret = panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -346,3 +399,35 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
> >  	/* Disable everything before leaving. */
> >  	panfrost_perfcnt_gpu_disable(pfdev);
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
> > +	perfcnt->reset_happened = true;
> > +	complete(&perfcnt->dump_comp);
> > +	panfrost_perfcnt_gpu_disable(pfdev);
> > +}
> > +
> > +void panfrost_perfcnt_postreset(struct panfrost_device *pfdev)
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
> > +	panfrost_perfcnt_hw_enable(pfdev);
> > +}
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > index 8bbcf5f5fb33..e14e760641fd 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> > @@ -14,5 +14,7 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
> >  				  struct drm_file *file_priv);
> >  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
> >  				struct drm_file *file_priv);
> > +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
> > +void panfrost_perfcnt_postreset(struct panfrost_device *pfdev);
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
> >  };
> >  
> >  /* madvise provides a way to tell the kernel in case a buffers contents
> > 

Regards,
Adrian Larumbe
