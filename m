Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00366E9DE6C
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CAB10E38B;
	Thu,  9 Apr 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HEOxRhll";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A7D3210E38B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:55:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DD0D4453
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 01:55:33 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 F32013F641
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775724939; bh=FQwh7ifOeKNUZinqOs+C2D/V3SfMnaMEU4gnoF8mfF4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HEOxRhllmbaSyRlKg4CNcIxT0vpqaCjSqx/hH7KC1VXvlD6YLrukS2OajM5lPUvl4
 VROniKlTA0L1xI9har36uqNx2jU1kX40mt7fzQDdC13MiFl49GNuIyDlA1zvUUCfQR
 SPVEUsqbeJfPYfOSnVqv1WlmaOt1BpWmR1aEqGoM=
Date: Thu, 9 Apr 2026 09:55:35 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 1/2] drm/panthor: Extend VM locked region for remap
 case to be a superset
Message-ID: <addph5bUfrUieW49@e142607>
References: <20260408191228.537625-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408191228.537625-1-adrian.larumbe@collabora.com>
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

On Wed, Apr 08, 2026 at 08:12:23PM +0100, Adrián Larumbe wrote:
> In the event of an sm_step_remap() that leads to a partial unmap of a
> transparent huge page, the new locked region required by an extended unmap
> might not be a superset of the original one. Then, if it leaves a portion
> of the initially requested one out, the ensuing map will trigger a warning.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa8b31df85c9..bd41c892beb7 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1709,6 +1709,25 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	    start + size <= vm->locked_region.start + vm->locked_region.size)
>  		return 0;
>  
> +	/* sm_step_remap() may need a locked region that isn't a strict superset
> +	 * of the original one because of having to extend unmap boundaries beyond
> +	 * it to deal with partial unmaps of transparent huge pages. What we want
> +	 * in those cases is to lock the union of both regions. The new region must
> +	 * always overlap with the original one, because the upper and lower unmap
> +	 * boundaries in a remap operation can only shift up or down respectively,
> +	 * but never otherwise.
> +	 */
> +	if (vm->locked_region.size) {
> +		u64 end = max(vm->locked_region.start + vm->locked_region.size,
> +			      start + size);
> +
> +		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
> +				 (start >= vm->locked_region.start + vm->locked_region.size));
> +
> +		start = min(start, vm->locked_region.start);
> +		size = end - start;
> +	}
> +
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> -- 
> 2.53.0
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
