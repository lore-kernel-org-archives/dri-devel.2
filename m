Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80E606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Waw554nP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA04112AFD;
	Fri, 23 Oct 2026 12:11:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4E3E6112AFD
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 12:11:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D23C315D;
 Fri, 23 Oct 2026 05:10:58 -0700 (PDT)
Received: from [10.0.129.88] (e122027.cambridge.arm.com [10.0.129.88])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 424473F959;
 Fri, 23 Oct 2026 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792757461; bh=e3nOKKshkGpaVcsMCvIPEkQz+ejbnU26T8m1HT2VYKY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Waw554nPMBR8h/6dnh+6YZagICCCfiOEaTxOBwS4rnQ6OEGh4Wjd7fR06Ib9ND6j3
 zlc8ruw00W0Ed/fmUMh8zBMap/iKDuIyO+lvW17cvcQFwfb2Q7r4veT0tuPNskYpY/
 SdNb0Ic2BQkscq4lOuHZBB4u3EZduxp9HI+J0aPA=
Message-ID: <667186ce-ee42-48b7-a31a-29dad25ac1de@arm.com>
Date: Fri, 23 Oct 2026 13:10:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: Replace panthor_mmu_as_fault_mask() with a
 macro
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20261022-panthor-as-mask-v1-1-6aba7ad8cb9f@igalia.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261022-panthor-as-mask-v1-1-6aba7ad8cb9f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 14:42, Maíra Canal wrote:
> panthor_mmu_as_fault_mask() ignores its ptdev argument and only returns
> the per-AS fault bit, which is fixed in the MMU interrupt registers.
> Replace it with the macro MMU_INT_AS_FAULT(), which is defined next to
> the other MMU register definitions.
> 
> No functional change.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c      | 17 +++++------------
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  1 +
>  2 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d4b968ab094e..1109959dadc6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -596,18 +596,12 @@ static u64 pack_region_range(struct panthor_device *ptdev, u64 *region_start, u6
>  	return region_width | *region_start;
>  }
>  
> -static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
> -{
> -	return BIT(as);
> -}
> -
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
>  {
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  
> -	panthor_irq_enable_events(&ptdev->mmu->irq,
> -				  panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
>  
>  	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
>  	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> @@ -625,8 +619,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  
>  	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_irq_disable_events(&ptdev->mmu->irq,
> -				   panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_disable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
>  
>  	/* Flush+invalidate RW caches, invalidate RO ones. */
>  	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> @@ -745,7 +738,7 @@ int panthor_vm_active(struct panthor_vm *vm)
>  		/* Unhandled pagefault on this AS, the MMU was disabled. We need to
>  		 * re-enable the MMU after clearing+unmasking the AS interrupts.
>  		 */
> -		if (ptdev->mmu->as.faulty_mask & panthor_mmu_as_fault_mask(ptdev, as))
> +		if (ptdev->mmu->as.faulty_mask & MMU_INT_AS_FAULT(as))
>  			goto out_enable_as;
>  
>  		goto out_make_active;
> @@ -800,7 +793,7 @@ int panthor_vm_active(struct panthor_vm *vm)
>  	/* Unhandled pagefault on this AS, clear the fault and enable the AS,
>  	 * which re-enables interrupts.
>  	 */
> -	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
> +	fault_mask = MMU_INT_AS_FAULT(as);
>  	if (ptdev->mmu->as.faulty_mask & fault_mask) {
>  		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
>  		ptdev->mmu->as.faulty_mask &= ~fault_mask;
> @@ -1864,7 +1857,7 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  	status = panthor_mmu_fault_mask(ptdev, status);
>  	while (status) {
>  		u32 as = ffs(status | (status >> 16)) - 1;
> -		u32 mask = panthor_mmu_as_fault_mask(ptdev, as);
> +		u32 mask = MMU_INT_AS_FAULT(as);
>  		u64 addr;
>  		u32 fault_status;
>  		u32 exception_type;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> index 4e32ab931949..1ec7f5ef2b19 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> @@ -7,6 +7,7 @@
>  /* MMU regs */
>  
>  #define MMU_INT_BASE					0x2000
> +#define   MMU_INT_AS_FAULT(as)				BIT(as)
>  
>  /* AS_COMMAND register commands */
>  
> 
> ---
> base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
> change-id: 20261022-panthor-as-mask-129688951377
> 

