Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37DACCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0994E10E132;
	Fri, 16 Oct 2026 10:41:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5CD9410E1B8
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:41:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B722314BF
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:41:30 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B7FFE3F871
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 03:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792147294; bh=ZXdlfSSPCJTMIh+glpoDkaZxKHJM2I43BiERY+VLHGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hZHMGYMmVR+jcWWLPIbzU16uh2L2hc41VKrn8aQtj2jgz41OThLEJ8+EnMKnLny5C
 9i88P7m5hvmB+Ngf7DQOFMF45tNsIPxmhVzAvCxh7Yz0pnoeRerJl1Nxb0J6kej/Rm
 mC/GRqh8YBDKrcYocS+FvzOVw+NPhGzCrjDB8tFA=
Date: Fri, 16 Oct 2026 11:41:23 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panthor: Move cache-flush after UPDATE(UNMAPPED)
Message-ID: <atH_UwhLuO5len3n@e142607>
References: <20260924-panthor-mmu-fixes-v1-0-e25f9b106466@collabora.com>
 <20260924-panthor-mmu-fixes-v1-3-e25f9b106466@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924-panthor-mmu-fixes-v1-3-e25f9b106466@collabora.com>
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

On Thu, Sep 24, 2026 at 02:30:45PM +0200, Boris Brezillon wrote:
> Right now, there's a theoretical window during which the GPU can populate
> the cache with data from a VM that's about to be evicted through the
> UPDATE(UNMAPPED) command.
> In practice this won't happen (hence the absence of Fixes tag) because
> when panthor_mmu_as_disable() is called, the VM is guaranteed to be idle
> (no active CSG pointing to this VM), but as we say, better safe than
> sorry.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 038a092fd08c..bb71274aa36b 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -631,12 +631,6 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  	panthor_mmu_irq_disable_events(&ptdev->mmu->irq,
>  				       panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
> -	/* Flush+invalidate RW caches, invalidate RO ones. */
> -	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> -				       CACHE_CLEAN | CACHE_INV, 0);
> -	if (ret)
> -		return ret;
> -
>  	if (vm && vm->locked_region.size) {
>  		/* Unlock the region if there's a lock pending. */
>  		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_UNLOCK);
> @@ -648,7 +642,18 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
>  	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
> -	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
> +	ret = as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
> +	if (ret)
> +		return ret;
> +
> +	/* Flush+invalidate RW caches after we've unmapped, to make sure any
> +	 * cacheline eviction is effective before we potentially return
> +	 * memory pointed by this VM to the system. This needs to be done
> +	 * after the UPDATE(UNMAPPED) operation to guarantee that not further
> +	 * PT-walk can pull VM data into the cache.
> +	 */
> +	return panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> +					CACHE_CLEAN | CACHE_INV, 0);
>  }
>  
>  static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
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
