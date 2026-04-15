Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A75EF4199C
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 12:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8340010E6D6;
	Wed, 15 Apr 2026 12:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qInNfYSP";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9A79D10E6D6
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 12:23:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C3CC1F60
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:23:43 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 181EC3F86F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776255829; bh=Q/OyHcMNUqjlck8nA1mU9pgC+TuOAE5NcAtL3jsbu/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qInNfYSPjhAtrAffz2L9XXckg5niq3vx1KuzZuOD926qKv5TpUTYY8R8F//r3azv1
 PuGPaGB0NXz4m2SVweRUsZAlQ7SCME86p9u5DlvPGDvxs92+yNwVE04WiMFN6ZbYI+
 L1rdDFDmgKItzFsD3dxIy4cIquJGKUwSJnlx0SAA=
Date: Wed, 15 Apr 2026 13:23:47 +0100
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
Subject: Re: [PATCH v2 8/8] drm/panthor: Use a local iomem base for MMU AS
 registers
Message-ID: <ad-DUy5eeBFeDCwj@e142607>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-9-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260412142951.2309135-9-karunika.choo@arm.com>
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

On Sun, Apr 12, 2026 at 03:29:51PM +0100, Karunika Choo wrote:
> Add an MMU_AS_CONTROL local iomem pointer to struct panthor_mmu and
> switch AS register accesses to that base.
> 
> Interrupt accesses remain routed through the IRQ-local iomem base, while
> the MMU register definitions are adjusted so AS registers are expressed
> relative to the local MMU AS window. This completes the conversion away
> from using the global device mapping for MMU AS register accesses.
> 
> No functional change intended.
> 
> v2:
> - Pick up Ack from Boris.
> 
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c      | 35 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h | 10 ++-----
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 501dc0ea3ae7..b2d0d28be2e0 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -55,6 +55,9 @@ struct panthor_as_slot {
>   * struct panthor_mmu - MMU related data
>   */
>  struct panthor_mmu {
> +	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> +	void __iomem *iomem;
> +
>  	/** @irq: The MMU irq. */
>  	struct panthor_irq irq;
>  
> @@ -517,13 +520,14 @@ static void free_pt(void *cookie, void *data, size_t size)
>  
>  static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  {
> +	struct panthor_mmu *mmu = ptdev->mmu;
>  	int ret;
>  	u32 val;
>  
>  	/* Wait for the MMU status to indicate there is no active command, in
>  	 * case one is pending.
>  	 */
> -	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev->iomem, AS_STATUS(as_nr), val,
> +	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
>  						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
>  
>  	if (ret) {
> @@ -541,7 +545,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
>  	/* write AS_COMMAND when MMU is ready to accept another command */
>  	status = wait_ready(ptdev, as_nr);
>  	if (!status) {
> -		gpu_write(ptdev->iomem, AS_COMMAND(as_nr), cmd);
> +		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
>  		status = wait_ready(ptdev, as_nr);
>  	}
>  
> @@ -589,12 +593,14 @@ PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
>  {
> +	struct panthor_mmu *mmu = ptdev->mmu;
> +
>  	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
>  				      panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
> -	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), transtab);
> -	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), memattr);
> -	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), transcfg);
> +	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
> +	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> +	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -602,6 +608,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  				  bool recycle_slot)
>  {
> +	struct panthor_mmu *mmu = ptdev->mmu;
>  	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
>  	int ret;
>  
> @@ -629,9 +636,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  	if (recycle_slot)
>  		return 0;
>  
> -	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), 0);
> -	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), 0);
> -	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> +	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
> +	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
> +	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -784,7 +791,7 @@ int panthor_vm_active(struct panthor_vm *vm)
>  	 */
>  	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
>  	if (ptdev->mmu->as.faulty_mask & fault_mask) {
> -		gpu_write(ptdev->iomem, MMU_INT_CLEAR, fault_mask);
> +		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
>  		ptdev->mmu->as.faulty_mask &= ~fault_mask;
>  	}
>  
> @@ -1712,7 +1719,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> -		gpu_write64(ptdev->iomem, AS_LOCKADDR(vm->as.id),
> +		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
>  			    pack_region_range(ptdev, &start, &size));
>  
>  		/* If the lock succeeded, update the locked_region info. */
> @@ -1761,6 +1768,7 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  
>  static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
> +	struct panthor_mmu *mmu = ptdev->mmu;
>  	bool has_unhandled_faults = false;
>  
>  	status = panthor_mmu_fault_mask(ptdev, status);
> @@ -1773,8 +1781,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		u32 access_type;
>  		u32 source_id;
>  
> -		fault_status = gpu_read(ptdev->iomem, AS_FAULTSTATUS(as));
> -		addr = gpu_read64(ptdev->iomem, AS_FAULTADDRESS(as));
> +		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
> +		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
>  
>  		/* decode the fault status */
>  		exception_type = fault_status & 0xFF;
> @@ -1805,7 +1813,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		 * Note that COMPLETED irqs are never cleared, but this is fine
>  		 * because they are always masked.
>  		 */
> -		gpu_write(ptdev->iomem, MMU_INT_CLEAR, mask);
> +		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
>  
>  		if (ptdev->mmu->as.slots[as].vm)
>  			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
> @@ -3222,6 +3230,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> +	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
>  	ptdev->mmu = mmu;
>  
>  	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> index de460042651d..4e32ab931949 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> @@ -8,16 +8,12 @@
>  
>  #define MMU_INT_BASE					0x2000
>  
> -#define MMU_INT_RAWSTAT					0x2000
> -#define MMU_INT_CLEAR					0x2004
> -#define MMU_INT_MASK					0x2008
> -#define MMU_INT_STAT					0x200c
> -
>  /* AS_COMMAND register commands */
>  
> -#define MMU_BASE					0x2400
> +#define MMU_AS_BASE					0x2400
> +
>  #define MMU_AS_SHIFT					6
> -#define MMU_AS(as)					(MMU_BASE + ((as) << MMU_AS_SHIFT))
> +#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
>  
>  #define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
>  #define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
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
