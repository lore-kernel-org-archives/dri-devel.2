Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6160A6F59
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FHNxKLWs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C65010E6A9;
	Wed, 28 Oct 2026 16:06:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E66AA10E692
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:06:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58C071756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:06:30 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 47DBC3F59E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793203593; bh=3qcnl684PVu1J+bPAecWbEqHH7JxoBDU9tDfr23e3yI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FHNxKLWsB+zVDpH+yw6HxWJq5aFV8cyT6/tnW6mdRh+/zGkO3GJrqeHx9Za8nMaKH
 PusqMlHh8HlgZbmBopuVcK7td3vlFQoHra3z5sA8D7U1oQN4FddYI/m4ZBhjrXEg5s
 zyU2B22E9dzQ75mSgJleYMDE4mAfMihGKCPfgm1c=
Date: Wed, 28 Oct 2026 16:06:13 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 06/27] drm/panthor: Derive MMU AS register addresses
 from base and stride
Message-ID: <auIdddtRvEYNH88u@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-7-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-7-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:00PM +0100, Karunika Choo wrote:
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
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v1:
> - align with updated panthor_hw_regbank structure.
> - moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
>   to retrieve it.
> 
>  drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
>  drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c      | 45 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
>  4 files changed, 50 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 2ca5a334f5817..13090ff6db7b5 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -44,6 +44,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
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
> @@ -63,6 +67,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
> index 9231c18af94d1..68627f0df7f95 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -48,6 +48,9 @@ struct panthor_hw_regs_layout {
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
> index d75d575473da4..169550413a1a5 100644
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
> @@ -609,9 +615,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  	panthor_irq_enable_events(&ptdev->mmu->irq,
>  				  panthor_mmu_as_fault_mask(ptdev, as_nr));
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
> @@ -647,9 +653,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  	if (recycle_slot)
>  		return 0;
>  
> -	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
> -	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
> -	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
> +	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -1808,7 +1814,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> -		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
> +		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
>  			    pack_region_range(ptdev, &start, &size));
>  
>  		/* If the lock succeeded, update the locked_region info. */
> @@ -1871,8 +1877,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
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
> @@ -3388,8 +3394,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
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
> @@ -3408,7 +3417,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
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
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> index 4e32ab931949c..9d3747601e698 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> @@ -10,13 +10,8 @@
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
> @@ -28,8 +23,8 @@
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
> @@ -37,16 +32,16 @@
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
> @@ -64,6 +59,6 @@
>  #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
>  #define   AS_TRANSCFG_WXN				BIT(35)
>  #define   AS_TRANSCFG_XREADABLE				BIT(36)
> -#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
> +#define AS_FAULTEXTRA					0x38
>  
>  #endif /* __PANTHOR_MMU_REGS_H__ */
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
