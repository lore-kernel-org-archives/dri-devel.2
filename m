Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50B7F4199B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BB5410E6D3;
	Wed, 15 Apr 2026 12:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VAyfx/xw";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7206A10E6D3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:19:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41BA2339A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:19:44 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 802DB3F86F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776255589; bh=VZ5KRyPiDH13u+mLCvg2412IC6lFys4xEnMiZARTLr8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VAyfx/xwU68qJWX7/DI90bgmwxMf2qqJxQPWiz2XjaV+ULMyrHjiARnoxw5aNPJYv
 tVLO6kNtj0VVCAaboKjhi4NBPm0xF78aKn0HewwTWPrMmDaDxsKOgUGj/BFHkjVMQ9
 klQrft6D7AKycR43PlbYwiDcPmRaRwp3WIiEfsMU=
Date: Wed, 15 Apr 2026 13:19:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] drm/panthor: Use a local iomem base for GPU
 registers
Message-ID: <ad-CY5sUncJvhdYB@e142607>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-6-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412142951.2309135-6-karunika.choo@arm.com>
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

On Sun, Apr 12, 2026 at 03:29:48PM +0100, Karunika Choo wrote:
> Add a GPU_CONTROL-local iomem pointer to struct panthor_gpu and use it
> for GPU register accesses.
> 
> This limits GPU register accesses to the GPU block instead of using the
> device-wide MMIO mapping directly. Interrupt register accesses continue
> to use the IRQ-local base provided by the common IRQ helpers. Update
> panthor_gpu_info_init() to also use a local iomem offset for GPU
> features and capability.
> 
> This is a refactoring only and does not change behaviour.
> 
> v2:
> - Update panthor_gpu_info_init() to use block-local iomem pointer.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c      | 61 +++++++++++++---------
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  4 --
>  drivers/gpu/drm/panthor/panthor_hw.c       | 38 +++++++-------
>  3 files changed, 56 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index f00f3d9be240..e52c5675981f 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -29,6 +29,9 @@
>   * struct panthor_gpu - GPU block management data.
>   */
>  struct panthor_gpu {
> +	/** @iomem: CPU mapping of GPU_CONTROL iomem region */
> +	void __iomem *iomem;
> +
>  	/** @irq: GPU irq. */
>  	struct panthor_irq irq;
>  
> @@ -56,12 +59,13 @@ struct panthor_gpu {
>  
>  static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
>  {
> -	gpu_write(ptdev->iomem, GPU_COHERENCY_PROTOCOL,
> +	gpu_write(ptdev->gpu->iomem, GPU_COHERENCY_PROTOCOL,
>  		  ptdev->gpu_info.selected_coherency);
>  }
>  
>  static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	const struct panthor_soc_data *data = ptdev->soc_data;
>  	u32 l2_config;
>  	u32 i;
> @@ -75,26 +79,28 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
> -		gpu_write(ptdev->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
> +		gpu_write(gpu->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
>  
> -	l2_config = gpu_read(ptdev->iomem, GPU_L2_CONFIG);
> +	l2_config = gpu_read(gpu->iomem, GPU_L2_CONFIG);
>  	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
> -	gpu_write(ptdev->iomem, GPU_L2_CONFIG, l2_config);
> +	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
>  }
>  
>  static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
> -	gpu_write(ptdev->iomem, GPU_INT_CLEAR, status);
> +	struct panthor_gpu *gpu = ptdev->gpu;
> +
> +	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
>  
>  	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
>  		trace_gpu_power_status(ptdev->base.dev,
> -				       gpu_read64(ptdev->iomem, SHADER_READY),
> -				       gpu_read64(ptdev->iomem, TILER_READY),
> -				       gpu_read64(ptdev->iomem, L2_READY));
> +				       gpu_read64(gpu->iomem, SHADER_READY),
> +				       gpu_read64(gpu->iomem, TILER_READY),
> +				       gpu_read64(gpu->iomem, L2_READY));
>  
>  	if (status & GPU_IRQ_FAULT) {
> -		u32 fault_status = gpu_read(ptdev->iomem, GPU_FAULT_STATUS);
> -		u64 address = gpu_read64(ptdev->iomem, GPU_FAULT_ADDR);
> +		u32 fault_status = gpu_read(gpu->iomem, GPU_FAULT_STATUS);
> +		u64 address = gpu_read64(gpu->iomem, GPU_FAULT_ADDR);
>  
>  		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
>  			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
> @@ -147,6 +153,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (!gpu)
>  		return -ENOMEM;
>  
> +	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
>  	spin_lock_init(&gpu->reqs_lock);
>  	init_waitqueue_head(&gpu->reqs_acked);
>  	mutex_init(&gpu->cache_flush_lock);
> @@ -203,10 +210,11 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
>  				u32 pwroff_reg, u32 pwrtrans_reg,
>  				u64 mask, u32 timeout_us)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	u32 val;
>  	int ret;
>  
> -	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
> +	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
>  					      !(mask & val), 100, timeout_us);
>  	if (ret) {
>  		drm_err(&ptdev->base,
> @@ -215,9 +223,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
>  		return ret;
>  	}
>  
> -	gpu_write64(ptdev->iomem, pwroff_reg, mask);
> +	gpu_write64(gpu->iomem, pwroff_reg, mask);
>  
> -	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
> +	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
>  					      !(mask & val), 100, timeout_us);
>  	if (ret) {
>  		drm_err(&ptdev->base,
> @@ -246,10 +254,11 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
>  			       u32 pwron_reg, u32 pwrtrans_reg,
>  			       u32 rdy_reg, u64 mask, u32 timeout_us)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	u32 val;
>  	int ret;
>  
> -	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
> +	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
>  					      !(mask & val), 100, timeout_us);
>  	if (ret) {
>  		drm_err(&ptdev->base,
> @@ -258,9 +267,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
>  		return ret;
>  	}
>  
> -	gpu_write64(ptdev->iomem, pwron_reg, mask);
> +	gpu_write64(gpu->iomem, pwron_reg, mask);
>  
> -	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, rdy_reg, val,
> +	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, rdy_reg, val,
>  					      (mask & val) == val,
>  					      100, timeout_us);
>  	if (ret) {
> @@ -319,6 +328,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
>  int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -328,7 +338,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> +		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
>  	} else {
>  		ret = -EIO;
>  	}
> @@ -342,7 +352,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  				msecs_to_jiffies(100))) {
>  		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> -		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> +		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
>  			ret = -ETIMEDOUT;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> @@ -365,6 +375,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>   */
>  int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	bool timedout = false;
>  	unsigned long flags;
>  
> @@ -372,8 +383,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  	if (!drm_WARN_ON(&ptdev->base,
>  			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> -		gpu_write(ptdev->iomem, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> -		gpu_write(ptdev->iomem, GPU_CMD, GPU_SOFT_RESET);
> +		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> +		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
>  	}
>  	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  
> @@ -382,7 +393,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  				msecs_to_jiffies(100))) {
>  		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> -		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> +		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
>  			timedout = true;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> @@ -431,17 +442,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
>  
>  u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
>  {
> -	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
> +	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
>  }
>  
>  u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
>  {
> -	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
> +	return gpu_read64(ptdev->gpu->iomem, GPU_TIMESTAMP_OFFSET);
>  }
>  
>  u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
>  {
> -	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
> +	return gpu_read64_counter(ptdev->gpu->iomem, GPU_CYCLE_COUNT);
>  }
>  
>  int panthor_gpu_coherency_init(struct panthor_device *ptdev)
> @@ -460,7 +471,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
>  	 * ACE protocol has never been supported for command stream frontend GPUs.
>  	 */
> -	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
> +	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
>  		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
>  		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
>  		return 0;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 3f60c45985a7..4c5b953796e4 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -31,10 +31,6 @@
>  #define GPU_CSF_ID					0x1C
>  
>  #define GPU_INT_BASE					0x20
> -#define GPU_INT_RAWSTAT					0x20
> -#define GPU_INT_CLEAR					0x24
> -#define GPU_INT_MASK					0x28
> -#define GPU_INT_STAT					0x2c
>  #define   GPU_IRQ_FAULT					BIT(0)
>  #define   GPU_IRQ_PROTM_FAULT				BIT(1)
>  #define   GPU_IRQ_RESET_COMPLETED			BIT(8)
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 9431f16d950f..80aa151d5936 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -195,28 +195,30 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> -	ptdev->gpu_info.csf_id = gpu_read(ptdev->iomem, GPU_CSF_ID);
> -	ptdev->gpu_info.gpu_rev = gpu_read(ptdev->iomem, GPU_REVID);
> -	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, GPU_CORE_FEATURES);
> -	ptdev->gpu_info.l2_features = gpu_read(ptdev->iomem, GPU_L2_FEATURES);
> -	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, GPU_TILER_FEATURES);
> -	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, GPU_MEM_FEATURES);
> -	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, GPU_MMU_FEATURES);
> -	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, GPU_THREAD_FEATURES);
> -	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, GPU_THREAD_MAX_THREADS);
> +	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
> +
> +	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
> +	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
> +	ptdev->gpu_info.core_features = gpu_read(gpu_iomem, GPU_CORE_FEATURES);
> +	ptdev->gpu_info.l2_features = gpu_read(gpu_iomem, GPU_L2_FEATURES);
> +	ptdev->gpu_info.tiler_features = gpu_read(gpu_iomem, GPU_TILER_FEATURES);
> +	ptdev->gpu_info.mem_features = gpu_read(gpu_iomem, GPU_MEM_FEATURES);
> +	ptdev->gpu_info.mmu_features = gpu_read(gpu_iomem, GPU_MMU_FEATURES);
> +	ptdev->gpu_info.thread_features = gpu_read(gpu_iomem, GPU_THREAD_FEATURES);
> +	ptdev->gpu_info.max_threads = gpu_read(gpu_iomem, GPU_THREAD_MAX_THREADS);
>  	ptdev->gpu_info.thread_max_workgroup_size =
> -		gpu_read(ptdev->iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
> +		gpu_read(gpu_iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
>  	ptdev->gpu_info.thread_max_barrier_size =
> -		gpu_read(ptdev->iomem, GPU_THREAD_MAX_BARRIER_SIZE);
> -	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES);
> +		gpu_read(gpu_iomem, GPU_THREAD_MAX_BARRIER_SIZE);
> +	ptdev->gpu_info.coherency_features = gpu_read(gpu_iomem, GPU_COHERENCY_FEATURES);
>  	for (i = 0; i < 4; i++)
>  		ptdev->gpu_info.texture_features[i] =
> -			gpu_read(ptdev->iomem, GPU_TEXTURE_FEATURES(i));
> +			gpu_read(gpu_iomem, GPU_TEXTURE_FEATURES(i));
>  
> -	ptdev->gpu_info.as_present = gpu_read(ptdev->iomem, GPU_AS_PRESENT);
> +	ptdev->gpu_info.as_present = gpu_read(gpu_iomem, GPU_AS_PRESENT);
>  
>  	/* Introduced in arch 11.x */
> -	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, GPU_FEATURES);
> +	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
>  
>  	if (panthor_hw_has_pwr_ctrl(ptdev)) {
>  		/* Introduced in arch 14.x */
> @@ -224,9 +226,9 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
>  		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
>  	} else {
> -		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, GPU_SHADER_PRESENT);
> -		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, GPU_TILER_PRESENT);
> -		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, GPU_L2_PRESENT);
> +		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
> +		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
> +		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
>  	}
>  
>  	return overload_shader_present(ptdev);
> -- 
> 2.43.0
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
