Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E368606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OMh8I76C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABDB10FF23;
	Thu, 19 Nov 2026 08:03:19 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A2210FF23
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795075392;
 bh=JUx+ahJsVl5bK77Tiqnfd+1agHKZt2qBi8Fm/lCcC5s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OMh8I76CCdK/PKOWsf5dskhS7aUviW2m5kKgSZu8K/0OIJcT6SMNhpkTUZgiiM/iI
 yV+sjMxXJ+xxuP6vhsv9L6NJ24C4A6opqfxIgEaYIDkGFoIZFQf6jkjAG1ncTK9NOJ
 U4Le0CvvFQSpe1OG+XDuWOemzDwLIksh3XcQOJocggFtTs5iJ32nt1ONZRR8JJJBUr
 D2GEqJ7wrW592Hv0J2OK3kmLmoFmvDH0L8e69bEreWr5ZyerO9jqH6Q3uQPRdIVvGn
 dnxhNP73AmP0hzjaBhrqZ8V36TIAY5XOJ2x2RCmPie9DsAm2veVvLKVu2tph9OKgcg
 QXcaBrevDNTDg==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EF9D817E00E8;
 Thu, 19 Nov 2026 09:03:11 +0100 (CET)
Date: Thu, 19 Nov 2026 09:03:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 07/10] drm/panthor: Derive MMU AS register addresses
 from base and stride
Message-ID: <20261119090309.77aa58da@fedora1.home>
In-Reply-To: <20261118175332.519657-8-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-8-karunika.choo@arm.com>
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

On Wed, 18 Nov 2026 17:53:23 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Move the MMU address-space register layout into the hardware description
> by storing the MMU_AS base offset and per-AS stride in the Panthor HW
> map.
> 
> Use those values to compute the iomem pointer for each AS slot and make
> the MMU AS register definitions relative to the per-slot register window
> instead of hard-coding the slot offset in every register macro.
> 
> This prepares the MMU code for GPUs where the MMU AS register region is
> not at a fixed offset while keeping the existing register accesses
> scoped to a single AS window.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v2:
> - Picked up R-b from Liviu
> - Avoid enabling all AS IRQs on init and replace with explicit IRQ clear
>   to preserve init behaviour. AS IRQs are enabled as part of
>   panthor_mmu_as_enable(). This also prevents accessing NULL iomem
>   pointers for initialized AS during init per sashiko's comment.
> - Link: https://lore.kernel.org/all/20260922210016.0C0961F000FF@smtp.kernel.org/
> v1:
> - align with updated panthor_hw_regbank structure.
> - moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
>   to retrieve it.
> 
>  drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
>  drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c      | 47 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
>  4 files changed, 51 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index f72cff260065e..6a8645bda1e7d 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -45,6 +45,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
>  		.mcu_control = {
>  			.offset = 0x700,
>  		},
> +		.mmu_as_control = {
> +			.offset = 0x2400,
> +			.stride = 0x40,
> +		},
>  	},
>  };
>  
> @@ -64,6 +68,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>  		.pwr_control = {
>  			.offset = 0x800,
>  		},
> +		.mmu_as_control = {
> +			.offset = 0x2400,
> +			.stride = 0x40,
> +		},
>  	},
>  };
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 0a82152d772ad..4cb603a3acef6 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -49,6 +49,9 @@ struct panthor_hw_regs_layout {
>  
>  	/** @mcu_control: MCU_CONTROL register bank layout */
>  	struct panthor_hw_regbank mcu_control;
> +
> +	/** @mmu_as_control: MMU_AS_CONTROL register bank layout */
> +	struct panthor_hw_regbank mmu_as_control;
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d1c29eec46f21..718160c0779ae 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -35,6 +35,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_heap.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_mmu_regs.h"
>  #include "panthor_sched.h"
> @@ -49,15 +50,15 @@ struct panthor_vm;
>  struct panthor_as_slot {
>  	/** @vm: VM bound to this slot. NULL is no VM is bound. */
>  	struct panthor_vm *vm;
> +
> +	/** @iomem: CPU mapping for MMU_AS_CONTROL iomem region */
> +	void __iomem *iomem;
>  };
>  
>  /**
>   * struct panthor_mmu - MMU related data
>   */
>  struct panthor_mmu {
> -	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> -	void __iomem *iomem;
> -
>  	/** @irq: The MMU irq. */
>  	struct panthor_irq irq;
>  
> @@ -533,6 +534,11 @@ static void free_pt(void *cookie, void *data, size_t size)
>  	kmem_cache_free(pt_cache, data);
>  }
>  
> +static void __iomem *as_iomem(struct panthor_mmu *mmu, u32 as_nr)
> +{
> +	return mmu->as.slots[as_nr].iomem;
> +}
> +
>  static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  {
>  	struct panthor_mmu *mmu = ptdev->mmu;
> @@ -542,7 +548,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  	/* Wait for the MMU status to indicate there is no active command, in
>  	 * case one is pending.
>  	 */
> -	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
> +	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem(mmu, as_nr), AS_STATUS, val,
>  						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
>  
>  	if (ret) {
> @@ -560,7 +566,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
>  	/* write AS_COMMAND when MMU is ready to accept another command */
>  	status = wait_ready(ptdev, as_nr);
>  	if (!status) {
> -		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
> +		gpu_write(as_iomem(ptdev->mmu, as_nr), AS_COMMAND, cmd);
>  		status = wait_ready(ptdev, as_nr);
>  	}
>  
> @@ -603,9 +609,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  
>  	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
>  
> -	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
> -	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> -	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, transtab);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, memattr);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, transcfg);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -627,9 +633,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  			return ret;
>  	}
>  
> -	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
> -	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
> -	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
>  	ret = as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  	if (ret)
> @@ -1799,7 +1805,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> -		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
> +		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
>  			    pack_region_range(ptdev, &start, &size));
>  
>  		/* If the lock succeeded, update the locked_region info. */
> @@ -1861,8 +1867,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  		u32 access_type;
>  		u32 source_id;
>  
> -		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
> -		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
> +		fault_status = gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
> +		addr = gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);
>  
>  		/* decode the fault status */
>  		exception_type = fault_status & 0xFF;
> @@ -3429,8 +3435,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
>  int panthor_mmu_init(struct panthor_device *ptdev)
>  {
>  	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
> +	unsigned long as_present_mask = ptdev->gpu_info.as_present;
> +	struct panthor_hw_regbank *regbank = &ptdev->hw->regs.mmu_as_control;
>  	struct panthor_mmu *mmu;
>  	int ret, irq;
> +	u32 as_id;
>  
>  	panthor_mmu_info_init(ptdev);
>  
> @@ -3449,7 +3458,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
> +	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
> +		u64 offset = regbank->offset + (regbank->stride * as_id);
> +
> +		guard(mutex)(&mmu->as.slots_lock);
> +		mmu->as.slots[as_id].iomem = ptdev->iomem + offset;
> +	}
> +
>  	ptdev->mmu = mmu;
>  
>  	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
> @@ -3479,7 +3494,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	panthor_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
> +	gpu_write(mmu->irq.iomem, INT_CLEAR, panthor_mmu_fault_mask(ptdev, ~0));
>  	panthor_irq_resume(&mmu->irq);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> index 1ec7f5ef2b196..82661283b46ab 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> @@ -11,13 +11,8 @@
>  
>  /* AS_COMMAND register commands */
>  
> -#define MMU_AS_BASE					0x2400
> -
> -#define MMU_AS_SHIFT					6
> -#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
> -
> -#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
> -#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
> +#define AS_TRANSTAB					0x0
> +#define AS_MEMATTR					0x8
>  #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
>  #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
>  							 ((w) ? BIT(0) : 0) | \
> @@ -29,8 +24,8 @@
>  #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
>  #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
>  #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
> -#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
> -#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
> +#define AS_LOCKADDR					0x10
> +#define AS_COMMAND					0x18
>  #define   AS_COMMAND_NOP				0
>  #define   AS_COMMAND_UPDATE				1
>  #define   AS_COMMAND_LOCK				2
> @@ -38,16 +33,16 @@
>  #define   AS_COMMAND_FLUSH_PT				4
>  #define   AS_COMMAND_FLUSH_MEM				5
>  #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
> -#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
> +#define AS_FAULTSTATUS					0x1C
>  #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
>  #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
>  #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
>  #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
>  #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
> -#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
> -#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
> +#define AS_FAULTADDRESS					0x20
> +#define AS_STATUS					0x28
>  #define   AS_STATUS_AS_ACTIVE				BIT(0)
> -#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
> +#define AS_TRANSCFG					0x30
>  #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
>  #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
>  #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
> @@ -65,6 +60,6 @@
>  #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
>  #define   AS_TRANSCFG_WXN				BIT(35)
>  #define   AS_TRANSCFG_XREADABLE				BIT(36)
> -#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
> +#define AS_FAULTEXTRA					0x38
>  
>  #endif /* __PANTHOR_MMU_REGS_H__ */

