Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32DECCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4367B112743;
	Fri, 16 Oct 2026 10:39:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1DC68112738
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:39:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4857114BF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:39:01 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 54BC53F871
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792147144; bh=2B4Z86NfvKmlxyck4uLPlQZc7XMsSM1bkdLs8y9O8Hg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fEZGNxSigfeThGxdIOKiNSyPDgh5FJLm22/Y9RcwKjZNNKIo/3MHT7ENuXCNJ00X5
 0MxAiozAO91jVu+ydlQpz4iEGVM4RulTeWKFrql5rCPAAYCoxkGnWWlGctzMOfNa6N
 2o7CnwHsWj86jM7AzcnTayaYuNilOTgj0ZcarJA0=
Date: Fri, 16 Oct 2026 11:38:54 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/panthor: Fully disable the AS even if it's going
 to be re-assigned
Message-ID: <atH-vsYXtgKOk2D3@e142607>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
 <20260924-panthor-mmu-fixes-v1-2-e25f9b106466@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924-panthor-mmu-fixes-v1-2-e25f9b106466@collabora.com>
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

On Thu, Sep 24, 2026 at 02:30:44PM +0200, Boris Brezillon wrote:
> We're trying to be smart by skipping the UPDATE(UNMAPPED) step, but
> it remains to be proven it adds any noticeable overhead. Moreover, it's
> breaking the assumption that, once the VM is unbound, no access can
> happen on it.
> 
> For instance, say the panthor_mmu_as_enable() call in panthor_vm_active()
> fails after we've called panthor_vm_release_as_locked(), we're now in a
> state where the HW still points to the old page table, but SW slot points
> to the new VM, which is not truly HW-bound.
> 
> If, after the as_slots lock is released, the evicted VM itself is
> released, the HW might have access to memory that has been returned
> to the system until the reset we scheduled (because of the faulty
> AS_COMMAND) is effective.
> 
> Let's make this bullet-proof by doing a full bound -> unbound -> bound
> cycle on AS slot recycling.
> 
> Fixes: 32e593d74c39 ("drm/panthor: Make sure caches are flushed/invalidated when an AS is recycled")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 7e98084b9a1e..038a092fd08c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -620,8 +620,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
>  
> -static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
> -				  bool recycle_slot)
> +static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  {
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  	struct panthor_vm *vm = ptdev->mmu->as.slots[as_nr].vm;
> @@ -645,12 +644,6 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  			return ret;
>  	}
>  
> -	/* If the slot is going to be used immediately, don't bother changing
> -	 * the config.
> -	 */
> -	if (recycle_slot)
> -		return 0;
> -
>  	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
>  	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
>  	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> @@ -777,7 +770,7 @@ int panthor_vm_active(struct panthor_vm *vm)
>  		drm_WARN_ON(&ptdev->base, refcount_read(&lru_vm->as.active_cnt));
>  		as = lru_vm->as.id;
>  
> -		ret = panthor_mmu_as_disable(ptdev, as, true);
> +		ret = panthor_mmu_as_disable(ptdev, as);
>  		if (ret)
>  			goto out_unlock;
>  
> @@ -919,7 +912,7 @@ static void panthor_vm_declare_unusable(struct panthor_vm *vm)
>  	vm->unusable = true;
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && drm_dev_enter(&ptdev->base, &cookie)) {
> -		panthor_mmu_as_disable(ptdev, vm->as.id, false);
> +		panthor_mmu_as_disable(ptdev, vm->as.id);
>  		drm_dev_exit(cookie);
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> @@ -1911,7 +1904,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
>  
>  		/* Disable the MMU to kill jobs on this AS. */
> -		panthor_mmu_as_disable(ptdev, as, false);
> +		panthor_mmu_as_disable(ptdev, as);
>  		mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
>  		status &= ~mask;
> @@ -1940,7 +1933,7 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
>  
>  		if (vm) {
>  			drm_WARN_ON(&ptdev->base,
> -				    panthor_mmu_as_disable(ptdev, i, false));
> +				    panthor_mmu_as_disable(ptdev, i));
>  			panthor_vm_release_as_locked(vm);
>  		}
>  	}
> @@ -2065,7 +2058,7 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
>  		int cookie;
>  
>  		if (drm_dev_enter(&ptdev->base, &cookie)) {
> -			panthor_mmu_as_disable(ptdev, vm->as.id, false);
> +			panthor_mmu_as_disable(ptdev, vm->as.id);
>  			drm_dev_exit(cookie);
>  		}
>  
> @@ -3360,7 +3353,7 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
>  
>  		if (vm) {
>  			drm_WARN_ON(&ptdev->base,
> -				    panthor_mmu_as_disable(ptdev, i, false));
> +				    panthor_mmu_as_disable(ptdev, i));
>  			panthor_vm_release_as_locked(vm);
>  		}
>  	}
> 
> -- 
> 2.55.0
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
