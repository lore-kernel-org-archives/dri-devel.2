Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4A7CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7CD10E7EE;
	Thu, 11 Jun 2026 14:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SbxJiP5q";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F410510E7EE
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 14:45:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAA9D1CDD;
 Thu, 11 Jun 2026 07:45:19 -0700 (PDT)
Received: from [10.1.29.27] (e122027.cambridge.arm.com [10.1.29.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E3613FBB1;
 Thu, 11 Jun 2026 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781189124; bh=Dha1hQ5ZypCG97F7WqNf2dEwQXM/9ZNMQfVzQgfQNEw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SbxJiP5qvN8allsvXr6nLzlP4e/CTwhOK2jKRMwQg8TRq9Jv4E8PmU0n02UZsSdyI
 lj7F3ySDQjeki5mn2MYNOSl3I5mRQZV++b4CTqJqOCVQ3fAIv1uNHGJNq3lBLQT4AE
 GDWrWanCarsoK66lxjyHrmxfEMUWfkgUvrX89yiU=
Message-ID: <ca983479-efcf-4b8d-825d-69b5ab54d92e@arm.com>
Date: Thu, 11 Jun 2026 15:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/18] drm/panthor: Derive MMU AS register addresses
 from base and stride
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-7-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528150546.3168527-7-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/05/2026 16:05, Karunika Choo wrote:
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
> ---
>  drivers/gpu/drm/panthor/panthor_hw.c       |  8 +++++
>  drivers/gpu/drm/panthor/panthor_hw.h       |  8 +++++
>  drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 ++++++--------
>  4 files changed, 47 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 1f7fab4caf4d..e677f1a8f488 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -41,6 +41,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
>  	.map = {
>  		.gpu_control_base = 0x0,
>  		.mcu_control_base = 0x700,
> +		.mmu_as = {
> +			.base = 0x2400,
> +			.stride = 0x40,
> +		},
>  	},
>  };
>  
> @@ -54,6 +58,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
>  		.gpu_control_base = 0x0,
>  		.pwr_control_base = 0x800,
>  		.mcu_control_base = 0x700,
> +		.mmu_as = {
> +			.base = 0x2400,
> +			.stride = 0x40,
> +		},
>  	},
>  };
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 58673a427bc9..0ae11b78c77e 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -38,6 +38,14 @@ struct panthor_hw_regmap {
>  
>  	/** @mcu_control_base: MCU_CONTROL base address */
>  	u32 mcu_control_base;
> +
> +	struct {
> +		/** @mmu_as.base: MMU_AS base address */
> +		u32 base;
> +
> +		/** @mmu_as.stride: Stride between subsequent MMU_AS register blocks */
> +		u32 stride;
> +	} mmu_as;
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 48127313332f..9a64f977d28c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -36,6 +36,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_heap.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_mmu_regs.h"
>  #include "panthor_sched.h"
> @@ -57,7 +58,7 @@ struct panthor_as_slot {
>   */
>  struct panthor_mmu {
>  	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> -	void __iomem *iomem;
> +	void __iomem *iomem[MAX_AS_SLOTS];

I'm not convinced that having a iomem pointer per AS is worth it. It 
seems excessive.

Boris's suggestion of moving it to panthor_as_slot at least avoids the 
array indexing, but I did wonder about just having a helper function. AI 
cooked up the below diff (untested, applies on top) which demonstrates
the idea.

I think the AI was a bit over the top with the as_present check in the
helper, although that would clearly indicate a serious bug if it
triggered.

What do you think?

Thanks,
Steve

----8<-----
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 53c5744609fa..6127df893476 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -58,7 +58,7 @@ struct panthor_as_slot {
  */
 struct panthor_mmu {
 	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem[MAX_AS_SLOTS];
+	void __iomem *iomem;
 
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
@@ -112,6 +112,20 @@ struct panthor_mmu {
 	} vm;
 };
 
+static void __iomem *
+panthor_mmu_as_iomem(struct panthor_device *ptdev, u32 as_nr)
+{
+	struct panthor_mmu *mmu = ptdev->mmu;
+
+	if (drm_WARN_ON(&ptdev->base, as_nr >= MAX_AS_SLOTS))
+		return mmu->iomem;
+
+	if (drm_WARN_ON(&ptdev->base, !(ptdev->gpu_info.as_present & BIT(as_nr))))
+		return mmu->iomem;
+
+	return mmu->iomem + (ptdev->hw->map.mmu_as.stride * as_nr);
+}
+
 /**
  * struct panthor_vm_pool - VM pool object
  */
@@ -522,14 +536,14 @@ static void free_pt(void *cookie, void *data, size_t size)
 
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
-	struct panthor_mmu *mmu = ptdev->mmu;
+	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
 	int ret;
 	u32 val;
 
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem[as_nr], AS_STATUS, val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem, AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -542,12 +556,13 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 
 static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
 {
+	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
 	int status;
 
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem[as_nr], AS_COMMAND, cmd);
+		gpu_write(as_iomem, AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -595,14 +610,14 @@ PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
-	struct panthor_mmu *mmu = ptdev->mmu;
+	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
 
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
 				      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, transtab);
-	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, memattr);
-	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, transcfg);
+	gpu_write64(as_iomem, AS_TRANSTAB, transtab);
+	gpu_write64(as_iomem, AS_MEMATTR, memattr);
+	gpu_write64(as_iomem, AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -610,8 +625,8 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 				  bool recycle_slot)
 {
-	struct panthor_mmu *mmu = ptdev->mmu;
 	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
+	void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as_nr);
 	int ret;
 
 	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
@@ -638,9 +653,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(mmu->iomem[as_nr], AS_TRANSTAB, 0);
-	gpu_write64(mmu->iomem[as_nr], AS_MEMATTR, 0);
-	gpu_write64(mmu->iomem[as_nr], AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(as_iomem, AS_TRANSTAB, 0);
+	gpu_write64(as_iomem, AS_MEMATTR, 0);
+	gpu_write64(as_iomem, AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -1740,7 +1755,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem[vm->as.id], AS_LOCKADDR,
+		gpu_write64(panthor_mmu_as_iomem(ptdev, vm->as.id), AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1789,21 +1804,21 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
 
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
-	struct panthor_mmu *mmu = ptdev->mmu;
 	bool has_unhandled_faults = false;
 
 	status = panthor_mmu_fault_mask(ptdev, status);
 	while (status) {
 		u32 as = ffs(status | (status >> 16)) - 1;
 		u32 mask = panthor_mmu_as_fault_mask(ptdev, as);
+		void __iomem *as_iomem = panthor_mmu_as_iomem(ptdev, as);
 		u64 addr;
 		u32 fault_status;
 		u32 exception_type;
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem[as], AS_FAULTSTATUS);
-		addr = gpu_read64(mmu->iomem[as], AS_FAULTADDRESS);
+		fault_status = gpu_read(as_iomem, AS_FAULTSTATUS);
+		addr = gpu_read64(as_iomem, AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -1834,7 +1849,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		 * Note that COMPLETED irqs are never cleared, but this is fine
 		 * because they are always masked.
 		 */
-		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
+		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, mask);
 
 		if (ptdev->mmu->as.slots[as].vm)
 			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
@@ -3239,11 +3254,8 @@ static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
-	unsigned long as_present_mask = ptdev->gpu_info.as_present;
-	struct panthor_hw_regmap *regmap = &ptdev->hw->map;
 	struct panthor_mmu *mmu;
 	int ret, irq;
-	u32 as_id;
 
 	mmu = drmm_kzalloc(&ptdev->base, sizeof(*mmu), GFP_KERNEL);
 	if (!mmu)
@@ -3260,12 +3272,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
-		u64 offset = regmap->mmu_as.base + (regmap->mmu_as.stride * as_id);
-
-		mmu->iomem[as_id] = ptdev->iomem + offset;
-	}
-
+	mmu->iomem = ptdev->iomem + ptdev->hw->map.mmu_as.base;
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");

