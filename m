Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F42CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2CE10E616;
	Fri,  2 Oct 2026 15:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="JUoBeqIs";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 42D3F10E616
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:45:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50F12143D;
 Fri,  2 Oct 2026 08:45:01 -0700 (PDT)
Received: from [10.0.129.26] (e122027.cambridge.arm.com [10.0.129.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DD4F3F85F;
 Fri,  2 Oct 2026 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790955904; bh=SOxNDtvCPLbmOQvC/4eDRF+DMwPHM+bzGLCiBlb/EWs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JUoBeqIsN2oeG3OMxrM371whsgJuiIvASu7p7438H5vTbJNmMNlhiOJd61XAre0Xy
 JlfxT0OxxZw0vmGkrORhw1cBVtM/Ppk8w6Kfg2gikU9D5K8yC2LTqhhwitP+ydH60d
 e0xU46LkIUCMlGvVfWda52+RmTDO3MlU2ShSSD5w=
Message-ID: <b9992315-be8f-4d58-91ea-cc6a8c1e3213@arm.com>
Date: Fri, 2 Oct 2026 16:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/15] drm/panfrost: Fix races between perfcnt and
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
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-15-62beb08de207@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260929-claude-fixes-v12-15-62beb08de207@collabora.com>
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

On 29/09/2026 04:44, Adrián Larumbe wrote:
> Formerly, the reset sequence would race with panfrost_mmu_as_put()
> when tearing down a perfcnt session. On top of that, poking GPU
> registers to program a perfcnt session or obtaining a dump might lead to
> undefined behaviour when done at the same time a reset was ongoing.
> 
> Use the reset r/w semaphore when disabling and re-enabling perfcnt
> configuration, and also in the sections inside the 'enable'and 'dump'
> ioctls where device registers are being accessed.
> 
> On top of that, expand the DRM uAPI for the perfcnt DUMP operation
> so that user space can be made aware of a reset having happened,
> whether it succeeded or failed to restore the original configuration.
> UM needs to know about this condition because counter data is inaccurate
> after a reset, so the best approach might be simply to try again.
> 
> Finally, update driver uAPI documentation to explain the meaning of the
> new perfcnt dump ioctl's state flags, and bump DRM driver minor number
> to reflect the new DUMP IOCTL req field.
> 
> Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c  |   2 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c     |   3 +-
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 272 +++++++++++++++++++---------
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.h |   1 +
>  include/uapi/drm/panfrost_drm.h             |  29 ++-
>  5 files changed, 222 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index 80d8f6aed090..47a869232e10 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -491,6 +491,8 @@ void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
>  	panfrost_jm_reset_interrupts(pfdev);
>  	if (enable_job_int)
>  		panfrost_jm_enable_interrupts(pfdev);
> +
> +	panfrost_perfcnt_reset(pfdev);
>  }
>  
>  static int panfrost_device_runtime_resume(struct device *dev)
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 571a26b84126..de9b1c115181 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
>   * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
>   *	   PANFROST_IOCTL_QUERY_BO_INFO and
>   *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
> + * - 1.7 - adds PERFCNT_DUMP req state field
>   */
>  static const struct drm_driver panfrost_drm_driver = {
>  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
> @@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
>  	.name			= "panfrost",
>  	.desc			= "panfrost DRM",
>  	.major			= 1,
> -	.minor			= 6,
> +	.minor			= 7,
>  
>  	.gem_create_object	= panfrost_gem_create_object,
>  	.gem_prime_import	= panfrost_gem_prime_import,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index b3f71d7fd82a..13521e078ce7 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright 2019 Collabora Ltd */
>  
> +#include "asm-generic/errno-base.h"
>  #include <linux/completion.h>
>  #include <linux/iopoll.h>
>  #include <linux/iosys-map.h>
> @@ -11,6 +12,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem_shmem_helper.h>
>  #include <drm/panfrost_drm.h>
> +#include <drm/drm_print.h>
>  
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
> @@ -28,21 +30,31 @@
>  
>  struct panfrost_perfcnt {
>  	struct panfrost_gem_mapping *mapping;
> +	unsigned int counterset;
>  	size_t bosize;
>  	void *buf;
>  	struct panfrost_file_priv *user;
>  	struct mutex lock;
>  	struct completion dump_comp;
> +	u32 state;
> +	bool owns_as_ref;
>  };
>  
>  static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
>  {
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +
>  	gpu_write(pfdev, GPU_PERFCNT_CFG,
>  		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
>  	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
>  	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
>  	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
>  	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +
> +	if (perfcnt->owns_as_ref) {
> +		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> +		perfcnt->owns_as_ref = false;
> +	}
>  }
>  
>  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
> @@ -58,43 +70,161 @@ void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  		complete(&pfdev->perfcnt->dump_comp);
>  }
>  
> -static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)
> +static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
> +{
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +	u32 cfg, as;
> +	int ret;
> +
> +	lockdep_assert_held(&pfdev->reset.lock);
> +	drm_WARN_ON(&pfdev->base, perfcnt->owns_as_ref);
> +
> +	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
> +	if (ret < 0)
> +		return ret;
> +
> +	perfcnt->owns_as_ref = true;
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
> +static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev, u32 *state)
>  {
> -	u64 gpuva;
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +	u64 gpuva = perfcnt->mapping->mmnode.start << PAGE_SHIFT;
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
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state = perfcnt->state;
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		perfcnt->state = 0;
> +
> +		reinit_completion(&pfdev->perfcnt->dump_comp);
> +
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_LO, lower_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_PERFCNT_BASE_HI, upper_32_bits(gpuva));
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_CLEAN_CACHES_COMPLETED |
> +						GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_SAMPLE);
> +	}
> +
> +	/*
> +	 * Here we release the reset semaphore because perfcnt should not get in the way
> +	 * of a HW reset. Besides, a legitimate reset might be issued during the wait.
> +	 */
>  	ret = wait_for_completion_interruptible_timeout(&pfdev->perfcnt->dump_comp,
>  							msecs_to_jiffies(1000));
> +
> +	/* A reset might come through in the gap between the completion returning and the following
> +	 * check, but because no sample was produced, we don't care to relay the state back to UM.
> +	 */
>  	if (!ret)
> -		ret = -ETIMEDOUT;
> -	else if (ret > 0)
> +		return -ETIMEDOUT;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		*state |= perfcnt->state;
> +
> +		/* UM must re-enable their session before requesting new dumps. */
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD)
> +			return -EIO;
> +
> +		/* If we faced a reset during our SAMPLE, the user needs to try again. */
> +		if (perfcnt->state & PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET)
> +			return -EAGAIN;
> +
> +		/* Only when we know no re-eanble or re-dump is required, we can afford

Typo: s/re-eanble/re-enable/

> +		 * to reset the internal state. Otherwise it must be kept so that later
> +		 * ioctls know about error situations in this DUMP and work around it.
> +		 */
> +		perfcnt->state = 0;

Am I missing something or does the above comment say we only get here
when perfcnt->state is already 0? If either
PANFROST_PERFCNT_SESSION_DEAD or
PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET is set then we return
early. So unless there's some other flag we can't get to this line
unless it's already 0...

It's Friday afternoon so I might well be missing something - perhaps it
will all make sense next week?

Thanks,
Steve

> +	}
> +
> +	if (ret > 0)
>  		ret = 0;
>  
>  	return ret;
>  }
>  
> +static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> +					   struct drm_file *file_priv)
> +{
> +	struct panfrost_file_priv *user = file_priv->driver_priv;
> +	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> +	struct iosys_map map = IOSYS_MAP_INIT_VADDR(perfcnt->buf);
> +
> +	if (user != perfcnt->user)
> +		return -EINVAL;
> +
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		panfrost_perfcnt_hw_disable(pfdev);
> +		perfcnt->user = NULL;
> +	}
> +
> +	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> +	perfcnt->buf = NULL;
> +	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> +	panfrost_gem_mapping_put(perfcnt->mapping);
> +	perfcnt->mapping = NULL;
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
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
> -	if (user == perfcnt->user)
> +	if (perfcnt->user == user) {
> +		scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +			if (perfcnt->state & PANFROST_PERFCNT_SESSION_DEAD) {
> +				ret = panfrost_perfcnt_hw_enable(pfdev);
> +				if (!ret)
> +					perfcnt->state = 0;
> +				return ret;
> +			}
> +		}
> +
>  		return 0;
> -	else if (perfcnt->user)
> +	}
> +
> +	if (perfcnt->user)
>  		return -EBUSY;
>  
>  	ret = pm_runtime_get_sync(pfdev->base.dev);
> @@ -122,54 +252,30 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	ret = drm_gem_vmap(&bo->base, &map);
>  	if (ret)
>  		goto err_put_mapping;
> +
>  	perfcnt->buf = map.vaddr;
> +	perfcnt->counterset = counterset;
>  
>  	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
>  
> -	/*
> -	 * Clear the counters to start from a fresh state.
> -	 */
> -	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
> -
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
> +	scoped_guard(rwsem_read, &pfdev->reset.lock) {
> +		/*
> +		 * Clear the counters to start from a fresh state.
> +		 */
> +		gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
>  
> -	gpu_write(pfdev, GPU_PERFCNT_CFG, cfg);
> +		ret = panfrost_perfcnt_hw_enable(pfdev);
> +		if (ret)
> +			goto err_vunmap;
>  
> -	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_8186))
> -		gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0xffffffff);
> +		perfcnt->user = user;
> +		perfcnt->state = 0;
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
> @@ -185,30 +291,6 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
>  	return ret;
>  }
>  
> -static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
> -					   struct drm_file *file_priv)
> -{
> -	struct panfrost_file_priv *user = file_priv->driver_priv;
> -	struct panfrost_perfcnt *perfcnt = pfdev->perfcnt;
> -	struct iosys_map map = IOSYS_MAP_INIT_VADDR(perfcnt->buf);
> -
> -	if (user != perfcnt->user)
> -		return -EINVAL;
> -
> -	panfrost_perfcnt_hw_disable(pfdev);
> -
> -	perfcnt->user = NULL;
> -	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> -	perfcnt->buf = NULL;
> -	panfrost_gem_close(&perfcnt->mapping->obj->base.base, file_priv);
> -	panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
> -	panfrost_gem_mapping_put(perfcnt->mapping);
> -	perfcnt->mapping = NULL;
> -	pm_runtime_put_autosuspend(pfdev->base.dev);
> -
> -	return 0;
> -}
> -
>  int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
>  				  struct drm_file *file_priv)
>  {
> @@ -249,13 +331,16 @@ int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  	if (ret)
>  		return ret;
>  
> +	if (req->pad)
> +		return -EINVAL;
> +
>  	mutex_lock(&perfcnt->lock);
>  	if (perfcnt->user != file_priv->driver_priv) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	ret = panfrost_perfcnt_dump_locked(pfdev);
> +	ret = panfrost_perfcnt_dump_locked(pfdev, &req->state);
>  	if (ret)
>  		goto out;
>  
> @@ -322,14 +407,13 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
>  		return -ENOMEM;
>  
>  	perfcnt->bosize = size;
> +	pfdev->perfcnt = perfcnt;
> +	mutex_init(&perfcnt->lock);
> +	init_completion(&perfcnt->dump_comp);
>  
>  	/* Start with everything disabled. */
>  	panfrost_perfcnt_hw_disable(pfdev);
>  
> -	init_completion(&perfcnt->dump_comp);
> -	mutex_init(&perfcnt->lock);
> -	pfdev->perfcnt = perfcnt;
> -
>  	return 0;
>  }
>  
> @@ -338,3 +422,25 @@ void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
>  	/* Disable everything before leaving. */
>  	panfrost_perfcnt_hw_disable(pfdev);
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
> +	/* All active AS are released during the MMU post_reset. */
> +	perfcnt->owns_as_ref = false;
> +	perfcnt->state |= PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET;
> +	if (panfrost_perfcnt_hw_enable(pfdev))
> +		perfcnt->state |= PANFROST_PERFCNT_SESSION_DEAD;
> +
> +	/* Unblock pending sample requests. */
> +	complete(&perfcnt->dump_comp);
> +}
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> index 8bbcf5f5fb33..8b9bc704b634 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.h
> @@ -14,5 +14,6 @@ int panfrost_ioctl_perfcnt_enable(struct drm_device *dev, void *data,
>  				  struct drm_file *file_priv);
>  int panfrost_ioctl_perfcnt_dump(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv);
> +void panfrost_perfcnt_reset(struct panfrost_device *pfdev);
>  
>  #endif
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 50d5337f35ef..7831c48c59c0 100644
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
> @@ -270,8 +270,35 @@ struct drm_panfrost_perfcnt_enable {
>  	__u32 counterset;
>  };
>  
> +/*
> + * The next two flags describe the state of a perfcnt dump request
> + * as influenced by a device reset. They are the only values the
> + * perfcnt_dump ioctl state field can take on.
> + * Only certain state and ioctl retval combinations are legitimate.
> + */
> +
> +/* A new perfcnt_enable ioctl should be issued before requesting
> + * more dumps, because a HW reset failed to recreate perfcnt's
> + * original state. Otherwise further perfcnt_dump's will fail.
> + * This flag being set means ioctl's retval is always -EIO.
> + */
> +#define PANFROST_PERFCNT_SESSION_DEAD (1 << 0)
> +
> +/* A HW reset happened before or during a sample request, and
> + * perfcnt's internal state was successfully restored. There
> + * are two possible outcomes depending on the ioctl's retval:
> + *	0: A reset happened before a dump was requested, but did
> + * nonetheless succeed. Counter values are relative to last reset.
> + *	-EAGAIN: A reset happened when a counter values sampling
> + * request was ongoing. Values are undefined so a new dump ioctl
> + * should be issued.
> + */
> +#define PANFROST_PERFCNT_SESSION_INTERRUPTED_BY_RESET (1 << 1)
> +
>  struct drm_panfrost_perfcnt_dump {
>  	__u64 buf_ptr;
> +	__u32 state;
> +	__u32 pad;		/* MBZ */
>  };
>  
>  /* madvise provides a way to tell the kernel in case a buffers contents
> 

