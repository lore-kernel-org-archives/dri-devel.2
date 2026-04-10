Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5095FF459F7
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0C610E9B1;
	Fri, 10 Apr 2026 18:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OQ2GKSro";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235C510E9B1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775844715;
 bh=yAoYlW8mhdQwZ2bZymjtdr3V6UjjrthD/cUbXQEWu5c=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OQ2GKSroki7LEMA4jMm65lvR0uI2jlcjkmMIBDNgoS8kwi1wcpJrFKN9RV2hm6OiG
 TGOarbw221qcf3HmaOPA7M/tjt/PwVGZz7SLqZ3DCos15HrHpi5VPwKQqBQn46IibX
 4E0xQa6B54dKjnW4YFt6dm+KU0gYLr+pcn1IWp9icZ2jeJvKsfHpzH5t0aDwjY75ye
 FZCGZOc1EifQTqmVMXQyZIXgCCs48MKHQv41szX1MwRVQUorTb865H5lJd77zcsQXR
 KP6Nuv5PcG7SHKy/dtdtq9IuZkOMoUzHhGado9Dd4xB54sNF54C+zBBWDAOdePRH/q
 ivVJpqtCC08xA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7534A17E09AC;
 Fri, 10 Apr 2026 20:11:55 +0200 (CEST)
Date: Fri, 10 Apr 2026 20:11:53 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/panthor: Use a local iomem base for GPU registers
Message-ID: <20260410201153.1e61d880@fedora>
In-Reply-To: <20260410164637.549145-6-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
 <20260410164637.549145-6-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Fri, 10 Apr 2026 17:46:34 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Add a GPU_CONTROL-local iomem pointer to struct panthor_gpu and use it
> for GPU register accesses.
> 
> This limits GPU register accesses to the GPU block instead of using the
> device-wide MMIO mapping directly. Interrupt register accesses continue
> to use the IRQ-local base provided by the common IRQ helpers.
> 
> This is a refactoring only and does not change behaviour.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c      | 61 +++++++++++++---------
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  6 +--
>  2 files changed, 38 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 3ddce35ed8b5..abd94de5d15d 100644
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
> @@ -202,10 +209,11 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
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
> @@ -214,9 +222,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
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
> @@ -245,10 +253,11 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
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
> @@ -257,9 +266,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
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
> @@ -318,6 +327,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
>  int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	unsigned long flags;
>  	int ret = 0;
>  
> @@ -327,7 +337,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> +		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
>  	} else {
>  		ret = -EIO;
>  	}
> @@ -341,7 +351,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  				msecs_to_jiffies(100))) {
>  		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> -		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> +		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
>  			ret = -ETIMEDOUT;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> @@ -364,6 +374,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>   */
>  int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  {
> +	struct panthor_gpu *gpu = ptdev->gpu;
>  	bool timedout = false;
>  	unsigned long flags;
>  
> @@ -371,8 +382,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
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
> @@ -381,7 +392,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  				msecs_to_jiffies(100))) {
>  		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> -		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> +		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
>  			timedout = true;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> @@ -430,17 +441,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
>  
>  u64 panthor_gpu_get_timestap(struct panthor_device *ptdev)
>  {
> -	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
> +	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
>  }
>  
>  u64 panthor_gpu_get_timestap_offset(struct panthor_device *ptdev)
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
> @@ -459,7 +470,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
>  	 * ACE protocol has never been supported for command stream frontend GPUs.
>  	 */
> -	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
> +	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
>  		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
>  		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
>  		return 0;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index d7cf5165e987..f64e7661f765 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -4,6 +4,8 @@
>  #ifndef __PANTHOR_GPU_REGS_H__
>  #define __PANTHOR_GPU_REGS_H__
>  
> +#define GPU_CONTROL_BASE				0x0
> +
>  #define GPU_L2_FEATURES					0x4
>  #define  GPU_L2_FEATURES_LINE_SIZE(x)			(1 << ((x) & GENMASK(7, 0)))
>  
> @@ -20,10 +22,6 @@
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

