Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E02606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QK0EOSqX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EAB610FEFE;
	Thu, 19 Nov 2026 08:02:01 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2A210FEFE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795075312;
 bh=AU4mJctI511U224cpvsGDqxrYNUOtGR0yYPo1CwERZE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QK0EOSqXaMLiQovxfPod+RFiyvKAHEwORqi/e1sGGOjG8dZqb7iuOy2lcjoM+xMoM
 LmCEeI74raYCC4nKhmUlMWV0zwnsUVl+ZijDfOGftOvS2XerY9QuFMPsmWi35MjZqB
 L1jM1o6NwuYz4hOCeWUx2sekBusqGptYwxkC5jQ2yTxlW0OGgK0cH0bI8lGCip2jg0
 J4elz66I036In5nF6V9TqUUJbZgjI+cOL1hFC8o7icPevznJCwAJJ2MWRLmLFc4+8l
 mntgmMzgQJFbunQ0SlDZ3k701JpGsezELXoEzuQgU0j5AoUOXXKI1n2zywWFSxTkhR
 +CPGOjZ3mu4Iw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 12AEC17E00E8;
 Thu, 19 Nov 2026 09:01:52 +0100 (CET)
Date: Thu, 19 Nov 2026 09:01:47 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 06/10] drm/panthor: Move register base offsets to the
 HW description
Message-ID: <20261119090147.25c4f87a@fedora1.home>
In-Reply-To: <20261118175332.519657-7-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-7-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:53:22 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

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
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v2:
> - Picked up R-b from Liviu
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
> index c5c37f22993d6..ab54119314da0 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -159,7 +159,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (!gpu)
>  		return -ENOMEM;
>  
> -	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
> +	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
>  	spin_lock_init(&gpu->reqs_lock);
>  	init_waitqueue_head(&gpu->reqs_acked);
>  	mutex_init(&gpu->cache_flush_lock);
> @@ -176,7 +176,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  		return irq;
>  
>  	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
> -				  ptdev->iomem + GPU_INT_BASE, "gpu",
> +				  gpu->iomem + GPU_INT_BASE, "gpu",
>  				  panthor_gpu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index c7581b6d4c5be..60819c4ace428 100644
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
> index a26fe42e14f78..f72cff260065e 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -38,6 +38,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
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
> @@ -46,6 +54,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
> @@ -197,7 +216,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> -	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
> +	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
>  
>  	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
>  	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
> @@ -223,7 +242,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
>  	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
>  
>  	if (panthor_hw_has_pwr_ctrl(ptdev)) {
> -		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
> +		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
>  
>  		/* Introduced in arch 14.x */
>  		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index c4a490bc39de6..0a82152d772ad 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -27,14 +27,39 @@ struct panthor_hw_ops {
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
> index b1000001325ea..1cfd4b658c81b 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -502,7 +502,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (!pwr)
>  		return -ENOMEM;
>  
> -	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
> +	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
>  	spin_lock_init(&pwr->reqs_lock);
>  	init_waitqueue_head(&pwr->reqs_acked);
>  	ptdev->pwr = pwr;
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> index 80d8e1e522298..e1f3153285bd7 100644
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

