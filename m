Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0603606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MF9iso5b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3A5A10E677;
	Wed, 28 Oct 2026 16:03:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A27CA10FD55
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:03:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4FB1756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:03:24 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 E78DE3F59E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793203407; bh=CMZVJ5YT9JJ8tpX8bI1KqzXScFcovvI/hSXWXqZPaDY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MF9iso5biKBj3AceJ9tSunjO2eij7qhMhtnxpwYHR6MrpL71WLvJl6GMPR9Cc4KDt
 VWlQac3RtWDetHreS7sjxe4mb3jgmD/iiJD/ERumGm9MEmNUWqk2STp8+HpavgE8Rb
 ZMTq6mFCmBcRMuvaf9wR8kpipaAErMXkanNn0NRw=
Date: Wed, 28 Oct 2026 16:03:25 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 05/27] drm/panthor: Move register base offsets to the
 HW description
Message-ID: <auIczSl53RK5AG9t@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-6-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-6-karunika.choo@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 22, 2026 at 09:44:59PM +0100, Karunika Choo wrote:
> Mali v15 reorders several register regions, including GPU_CONTROL,
> MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
> fixed base layout across all supported GPUs.
> 
> Add per-GPU register base offsets to the panthor hardware description
> and switch the GPU, FW and PWR local iomem setup to use those stored
> values. With the base addresses now owned by the hardware description,
> drop the corresponding fixed base-offset definitions from the register
> headers.
> 
> This prepares the driver for GPUs with different register layouts
> without changing the existing behaviour on currently supported parts.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v1:
> - rebased on drm-misc-next
> - use a generic panthor_hw_regbank structure for all register offsets.
> 
>  drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
>  drivers/gpu/drm/panthor/panthor_gpu.c      |  4 +--
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
>  drivers/gpu/drm/panthor/panthor_hw.c       | 23 +++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_hw.h       | 29 ++++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_pwr.c      |  2 +-
>  drivers/gpu/drm/panthor/panthor_pwr_regs.h |  2 --
>  8 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 13efed3a2ea72..679ea1d233d53 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1500,7 +1500,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (!fw)
>  		return -ENOMEM;
>  
> -	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
> +	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
>  	ptdev->fw = fw;
>  	init_waitqueue_head(&fw->req_waitqueue);
>  	INIT_LIST_HEAD(&fw->sections);
> diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> index b2e59cfc22b00..a3492f7f913f9 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> @@ -4,8 +4,6 @@
>  #ifndef __PANTHOR_FW_REGS_H__
>  #define __PANTHOR_FW_REGS_H__
>  
> -#define MCU_CONTROL_BASE				0x700
> -
>  #define MCU_CONTROL					0x0
>  #define   MCU_CONTROL_ENABLE				1
>  #define   MCU_CONTROL_AUTO				2
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index ade2646e2caf6..d6534fabc682e 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -158,7 +158,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (!gpu)
>  		return -ENOMEM;
>  
> -	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
> +	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
>  	spin_lock_init(&gpu->reqs_lock);
>  	init_waitqueue_head(&gpu->reqs_acked);
>  	mutex_init(&gpu->cache_flush_lock);
> @@ -175,7 +175,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  		return irq;
>  
>  	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
> -				  ptdev->iomem + GPU_INT_BASE, "gpu",
> +				  gpu->iomem + GPU_INT_BASE, "gpu",
>  				  panthor_gpu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 4c5b953796e4f..753df87009901 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -4,8 +4,6 @@
>  #ifndef __PANTHOR_GPU_REGS_H__
>  #define __PANTHOR_GPU_REGS_H__
>  
> -#define GPU_CONTROL_BASE				0x0
> -
>  #define GPU_ID						0x0
>  #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
>  #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 40012ba7e23ca..2ca5a334f5817 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -37,6 +37,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
>  		.power_changed_off = panthor_gpu_power_changed_off,
>  		.power_changed_on = panthor_gpu_power_changed_on,
>  	},
> +	.regs = {
> +		.gpu_control = {
> +			.offset = 0x0,
> +		},
> +		.mcu_control = {
> +			.offset = 0x700,
> +		},
> +	},
>  };
>  
>  static struct panthor_hw panthor_hw_arch_v14 = {
> @@ -45,6 +53,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>  		.l2_power_off = panthor_pwr_l2_power_off,
>  		.l2_power_on = panthor_pwr_l2_power_on,
>  	},
> +	.regs = {
> +		.gpu_control = {
> +			.offset = 0x0,
> +		},
> +		.mcu_control = {
> +			.offset = 0x700,
> +		},
> +		.pwr_control = {
> +			.offset = 0x800,
> +		},
> +	},
>  };
>  
>  static struct panthor_hw_entry panthor_hw_match[] = {
> @@ -196,7 +215,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> -	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
> +	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
>  
>  	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
>  	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
> @@ -222,7 +241,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
>  
>  	if (panthor_hw_has_pwr_ctrl(ptdev)) {
> -		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
> +		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
>  
>  		/* Introduced in arch 14.x */
>  		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index bdda3b10e660a..9231c18af94d1 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -26,14 +26,39 @@ struct panthor_hw_ops {
>  	void (*power_changed_off)(struct panthor_device *ptdev);
>  };
>  
> +/** struct panthor_hw_regbank - Register offset and instance stride information */
> +struct panthor_hw_regbank {
> +	/** @offset: Register offset relative to &struct panthor_device.iomem */
> +	u32 offset;
> +
> +	/**
> +	 * @stride: Register offset between instances, or 0 for non-instanced
> +	 * registers
> +	 */
> +	u32 stride;
> +};
> +
> +/** struct panthor_hw_regs_layout - Hardware register bank layout */
> +struct panthor_hw_regs_layout {
> +	/** @gpu_control: GPU_CONTROL register bank layout */
> +	struct panthor_hw_regbank gpu_control;
> +
> +	/** @pwr_control: PWR_CONTROL register bank layout */
> +	struct panthor_hw_regbank pwr_control;
> +
> +	/** @mcu_control: MCU_CONTROL register bank layout */
> +	struct panthor_hw_regbank mcu_control;
> +};
> +
>  /**
>   * struct panthor_hw - GPU specific register mapping and functions
>   */
>  struct panthor_hw {
> -	/** @features: Bitmap containing panthor_hw_feature */
> -
>  	/** @ops: Panthor HW specific operations */
>  	struct panthor_hw_ops ops;
> +
> +	/** @regs: Hardware register bank layout */
> +	struct panthor_hw_regs_layout regs;
>  };
>  
>  int panthor_hw_init(struct panthor_device *ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index dd7b6ef8ea209..cc2e01595f23b 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -480,7 +480,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (!pwr)
>  		return -ENOMEM;
>  
> -	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
> +	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
>  	spin_lock_init(&pwr->reqs_lock);
>  	init_waitqueue_head(&pwr->reqs_acked);
>  	ptdev->pwr = pwr;
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> index 9cf7a715066f8..05f5b48e6a39a 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> @@ -4,8 +4,6 @@
>  #ifndef __PANTHOR_PWR_REGS_H__
>  #define __PANTHOR_PWR_REGS_H__
>  
> -#define PWR_CONTROL_BASE				0x800
> -
>  #define PWR_INT_BASE					0x0
>  #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
>  #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
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
