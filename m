Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8B9C55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E7510EED7;
	Thu, 30 Jul 2026 12:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fuQ2h5Cc";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7563710EED7
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 12:49:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16761684;
 Thu, 30 Jul 2026 05:49:50 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC55C3F99C;
 Thu, 30 Jul 2026 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785415794; bh=NBurymF/asdBrcJrwggc3vLnt15vsH6lJZ4iSqlB/ao=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fuQ2h5Ccc429UprZNPgX5Wn8dSsTaTrivj+8utyqq6oiUypwHtbLm/h//95xvP7Zk
 4gkk05QMxZoycUBi2tN/7WqnypeCxRk7B9pkTY72e8dAp4e9m8GkMv87+273+jJl/O
 sRXRorkdDcytKo+Oxo/X//Is3B31r8kmWMk7UwgA=
Message-ID: <48dba7be-6924-4bbc-a249-a62ef5fd5a88@arm.com>
Date: Thu, 30 Jul 2026 13:49:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] drm/panfrost: Fix races between perfcnt and
 reset sequence
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-12-01968f2ec77a@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260729-claude-fixes-v4-12-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 29/07/2026 03:54, Adrián Larumbe wrote:
> Formerly, the reset sequence would race with panfrost_mmu_as_put()
> when tearing down a perfcnt session. On top of that, poking GPU
> registers to program a perfcnt session or obtaining a dump might lead to
> undefined behaviour when done at the same time a reset was ongoing.
> 
> Use the reset r/w semaphore to govern access to the hardware at reset
> time. On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> so that userspace can be made aware of a reset having happened, because
> that means counters will go back to 0 and can no longer be accumulated
> to values previously kept in user space.
> 
> The new perfcnt-aware reset sequence also takes care to reestablish
> perfcnt to its original configuration if there was an enabled session.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |   5 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 207 ++++++++++++++++++++--------
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   2 +
>  include/uapi/drm/panfrost_drm.h             |   3 +-
>  4 files changed, 154 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 926bdf21389f..ae0f10ba7455 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -616,8 +616,10 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>  	int ret;
>  
>  	/* Pre-reset */
> -	if (panfrost_device_started(pfdev))
> +	if (panfrost_device_started(pfdev)) {
>  		down_write(&pfdev->reset.lock);
> +		panfrost_perfcnt_reset(pfdev);
> +	}
>  
>  	/* Do the actual device reset */
>  	ret = panfrost_gpu_soft_reset(pfdev);
> @@ -629,6 +631,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>  		panfrost_jm_reset_interrupts(pfdev);
>  		if (enable_job_int)
>  			panfrost_jm_enable_interrupts(pfdev);
> +		panfrost_perfcnt_postreset(pfdev);
>  		up_write(&pfdev->reset.lock);
>  	}
>  
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index ad1156678e91..b92ad9061893 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -11,6 +11,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/panfrost_drm.h>
> +#include <drm/drm_print.h>
>  
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
> @@ -25,14 +26,17 @@
>  #define BYTES_PER_COUNTER		4
>  #define BLOCKS_PER_COREGROUP		8
>  #define V4_SHADERS_PER_COREGROUP	4
> +#define PERFCNT_DUMP_MAX_RETRIES	5
>  
>  struct panfrost_perfcnt {
>  	struct panfrost_gem_mapping *mapping;
> +	unsigned int counterset;
>  	size_t bosize;
>  	void *buf;
>  	struct panfrost_file_priv *user;
>  	struct mutex lock;
>  	struct completion dump_comp;
> +	bool reset_happened;
>  };
>  
>  static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> @@ -55,38 +59,97 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
>  }
>  
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev,
> +					u64 *reset_happened)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> +	u64 retries = PERFCNT_DUMP_MAX_RETRIES;
>  	int ret;
>  
> -	reinit_completion(&pfdev->perfcnt->dump_comp);
> -	gpuva = pfdev->perfcnt->mapping->mmnode.start << PAGE_SHIFT;
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> -	gpu_write(pfdev, GPU_INT_CLEAR,
> -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +dump_retry:
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*reset_happened = perfcnt->reset_happened;
> +		perfcnt->reset_happened = false;
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
>  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
>  							msecs_to_jiffies(1000));
> -	if (!ret)
> -		ret = -ETIMEDOUT;
> -	else if (ret > 0)
> -		ret = 0;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (ret > 0) {
> +			if (perfcnt->reset_happened) {
> +				if (--retries >= 0)

retries is defined unsigned, so this statement is always true...

> +					goto dump_retry;
> +				else
> +					ret = -EBUSY;
> +			} else {
> +				ret = 0;
> +			}
> +		} else if (!ret) {
> +			ret = -ETIMEDOUT;
> +		}
> +	}
>  
>  	return ret;
>  }
>  
> +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +	u32 cfg, as;
> +	int ret;
> +
> +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret < 0)
> +		return ret;
> +
> +	as = ret;
> +	cfg = GPU_PERFCNT_CFG_AS(as) |
> +	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> +
> +	/*
> +	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> +	 * the first one for now.
> +	 */
> +	if (panfrost_model_is_bifrost(pfdev))
> +		cfg |= GPU_PERFCNT_CFG_SETSEL(perfcnt->counterset);
> +
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> +
> +	/*
> +	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> +	 * counters.
> +	 */
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	else
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +
> +	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> +		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +
> +	return 0;
> +}
> +
>  static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  					  struct drm_file *file_priv,
>  					  unsigned int counterset)
>  {
>  	struct panfrost_file_priv *user = file_priv->driver_priv;
>  	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> -	struct iosys_map map;
>  	struct drm_gem_shmem_object *bo;
> -	u32 cfg, as;
> +	struct iosys_map map;
>  	int ret;
>  
>  	if (user == perfcnt->user)
> @@ -119,7 +182,9 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	ret = drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf = map.vaddr;
> +	perfcnt->counterset = counterset;
>  
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
>  
> @@ -127,60 +192,46 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	 * Invalidate the cache and clear the counters to start from a fresh
>  	 * state.
>  	 */
> -	reinit_completion(&pfdev->perfcnt->dump_comp);
> -	gpu_write(pfdev, GPU_INT_CLEAR,
> -		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> -		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +		gpu_write(pfdev, GPU_INT_CLEAR,
> +			  GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +			  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
> +		perfcnt->reset_happened = false;
> +		perfcnt->user = user;
> +	}
> +
> +	/*
> +	 * If a reset happens during the wait for the IRQ notification that caches
> +	 * are clean and invalidated, then we know the reset sequence did the job
> +	 * for us, even if it takes long enough for the completion to time out.
> +	 */
>  	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
>  					  msecs_to_jiffies(1000));
> -	if (!ret) {
> +	if (!ret && !perfcnt->reset_happened) {
>  		ret = -ETIMEDOUT;
>  		goto err_vunmap;
>  	}
>  
> -	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> -	if (ret < 0)
> -		goto err_vunmap;
> -
> -	as = ret;
> -	cfg = GPU_PERFCNT_CFG_AS(as) |
> -	      GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_MANUAL);
> -
> -	/*
> -	 * Bifrost GPUs have 2 set of counters, but we're only interested by
> -	 * the first one for now.
> -	 */
> -	if (panfrost_model_is_bifrost(pfdev))
> -		cfg |= GPU_PERFCNT_CFG_SETSEL(counterset);
> -
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0xffffffff);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0xffffffff);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0xffffffff);
> -
> -	/*
> -	 * Due to PRLAM-8186 we need to disable the Tiler before we enable HW
> -	 * counters.
> -	 */
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	else
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> -
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> -
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		if (!perfcnt->reset_happened) {
> +			ret = panfrost_perfcnt_hw_enable(pfdev);
> +			if (ret)
> +				goto err_vunmap;
> +		}
> +		perfcnt->reset_happened = false;
> +	}
>  
>  	/* The BO ref is retained by the mapping. */
>  	drm_gem_object_put(&bo->base);
>  
> -	perfcnt->user = user;
> -
>  	return 0;
>  
>  err_vunmap:
> +	scoped_guard(rwsem_read, &pfdev->reset.lock)
> +		perfcnt->user = user;

This looks weird - AFAICT perfcnt->user will already have been set to
'user' above if we ever get to this error case. It also unusual to
assign a pointer like this in an error path - I'd expect at least a
comment explaining the reasoning.

Thanks,
Steve

>  	drm_gem_vunmap(&bo->base, &map);
>  err_put_mapping:
>  	panfrost_gem_mapping_put(perfcnt->mapping);
> @@ -203,13 +254,15 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
>  	if (user != perfcnt->user)
>  		return -EINVAL;
>  
> -	panfrost_perfcnt_gpu_disable(pfdev);
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +		panfrost_perfcnt_gpu_disable(pfdev);
> +		perfcnt->user = NULL;
> +	}
>  
> -	perfcnt->user = NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
>  	perfcnt->buf = NULL;
>  	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  	panfrost_gem_mapping_put(perfcnt->mapping);
>  	perfcnt->mapping = NULL;
>  	pm_runtime_put_autosuspend(pfdev->base.dev);
> @@ -263,7 +316,7 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  		goto out;
>  	}
>  
> -	ret = panfrost_perfcnt_dump_locked(pfdev);
> +	ret = panfrost_perfcnt_dump_locked(pfdev, &req->hw_reset);
>  	if (ret)
>  		goto out;
>  
> @@ -346,3 +399,35 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
>  	/* Disable everything before leaving. */
>  	panfrost_perfcnt_gpu_disable(pfdev);
>  }
> +
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +
> +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> +		return;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +
> +	if (!perfcnt->user)
> +		return;
> +
> +	perfcnt->reset_happened = true;
> +	complete(&perfcnt->dump_comp);
> +	panfrost_perfcnt_gpu_disable(pfdev);
> +}
> +
> +void panfrost_perfcnt_postreset(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +
> +	if (drm_WARN_ON(&pfdev->base, !perfcnt))
> +		return;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +
> +	if (!perfcnt->user)
> +		return;
> +
> +	panfrost_perfcnt_hw_enable(pfdev);
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> index 8bbcf5f5fb33..e14e760641fd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> @@ -14,5 +14,7 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
>  				  struct drm_file *file_priv);
>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
> +void panfrost_perfcnt_postreset(struct panfrost_device *pfdev);
>  
>  #endif
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 50d5337f35ef..3bbf9220103d 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -47,7 +47,7 @@ extern "C" {
>   * them for anything but debugging purpose.
>   */
>  #define DRM_IOCTL_PANFROST_PERFCNT_ENABLE	DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_ENABLE, struct drm_panfrost_perfcnt_enable)
> -#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
> +#define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
>  
>  #define PANFROST_JD_REQ_FS (1 << 0)
>  #define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
> @@ -272,6 +272,7 @@ struct drm_panfrost_perfcnt_enable {
>  
>  struct drm_panfrost_perfcnt_dump {
>  	__u64 buf_ptr;
> +	__u64 hw_reset;
>  };
>  
>  /* madvise provides a way to tell the kernel in case a buffers contents
> 

