Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13531E9DE76
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB4710E739;
	Thu,  9 Apr 2026 09:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="atf9O2pC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D9D5B10E739
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:16:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B70273517;
 Thu,  9 Apr 2026 02:15:56 -0700 (PDT)
Received: from [10.1.29.18] (e122027.cambridge.arm.com [10.1.29.18])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 746583F641;
 Thu,  9 Apr 2026 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775726162; bh=Pkk4wD3nozGv3YZCYGo6W2Lp4SEFTmUk5vfvxArMIB8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=atf9O2pCgckiJkdQlILE5ADJtggeCuRw48kf6GCzOKgnMh4x9w1hbx6SMNk+DuBjd
 rPKErN3Xm5y0GRkUwcryObEL5w/cI4bTGyGk24EYZzbhIdgc652l8Vpe5TLjrE+fOu
 4R0wrb2/0ufWOxWrgDAMU/dfHZAd78RRf3ZWqsTM=
Message-ID: <e90993ec-9a22-4591-a1bb-b1ff29735c26@arm.com>
Date: Thu, 9 Apr 2026 10:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panthor: Extend VM locked region for remap
 case to be a superset
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260408191228.537625-1-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260408191228.537625-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 08/04/2026 20:12, Adrián Larumbe wrote:
> In the event of an sm_step_remap() that leads to a partial unmap of a
> transparent huge page, the new locked region required by an extended unmap
> might not be a superset of the original one. Then, if it leaves a portion
> of the initially requested one out, the ensuing map will trigger a warning.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although I'm starting to wonder if we should split this into an "initial
lock" and an "expand lock" function. Still as a minimal fix this is good.

Thanks,
Steve

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

