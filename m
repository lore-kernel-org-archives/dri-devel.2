Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44839EDB7ED
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B949B10E3C7;
	Tue,  7 Apr 2026 10:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="l18p69LE";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8C76110E3C7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:24:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C43C1BB2
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:24:49 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 CB4163F641
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775557495; bh=P84J4DpPHfNA1XgiSG9LfalCjiIJ7nZCSsvpmJp37fI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l18p69LER0vh+KkRA8J2E5vgAtPW0hJ3Hzxpzo+NVofQwFSy9DOQZ9Zo/mWnOihEm
 LY2mjYxVxRP7bu/D6pWQFonYMqjuoH5piImwV2WiTwsA5UG2ZEI2j9TlD82EPsOiZq
 OacdzwkdJcmzJiztwgWFbrc2mnJoG2bCQfRUUIJQ=
Date: Tue, 7 Apr 2026 11:24:52 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/2] drm/panthor: Extend VM locked region for remap case
 to be a superset
Message-ID: <adTbdH653uY4CxWh@e142607>
References: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260403172116.3424075-1-adrian.larumbe@collabora.com>
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

On Fri, Apr 03, 2026 at 06:21:11PM +0100, Adrián Larumbe wrote:
> In the event of an sm_step_remap() that leads to a partial unmap of a
> transparent huge page, the new locked region required by an extended unmap
> might not be a superset of the original one. Then, if it leaves a portion
> of the initially requested one out, the ensuing map will trigger a warning.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa8b31df85c9..2b96359d3b94 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1709,6 +1709,19 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	    start + size <= vm->locked_region.start + vm->locked_region.size)
>  		return 0;
>  
> +	/* sm_step_remap() may need a locked region that isn't a strict superset
> +	 * of the original one because of having to extend unmap boundaries beyond
> +	 * it to deal with partial unmaps of transparent huge pages. What we want
> +	 * in those cases is to lock the union of both regions.
> +	 */
> +	if (vm->locked_region.size) {

Why is this check needed? We're updating the vm->locked_region.size later anyway, and I think
we can cope with a locked region being of zero size when we are called, unless we consider that
to be a bug and we should check earlier for a zero value.

> +		u64 end = start + size;

Like Boris pointed out, the calculations can be optimized so that we don't need this line.

> +
> +		start = min(start, vm->locked_region.start);
> +		size = max(vm->locked_region.start +
> +			   vm->locked_region.size, end) - start;

If we have something like:

 ..... [start .. start+size] ...... [vm->locked_region.start .. vm->locked_region.start + vm->locked_region.size] ....

we end up locking

 ..... [start ................................................. vm->locked_region.start + vm->locked_region.size] ....

is that intended?

Best regards,
Liviu


> +	}
> +
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
>  		/* Lock the region that needs to be updated */
> 
> base-commit: fb42964e2a76f68a5fb581d382b5d2be2d5bda9b
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
