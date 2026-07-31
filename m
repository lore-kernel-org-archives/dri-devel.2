Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7AFC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE8510E0DE;
	Fri, 31 Jul 2026 08:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="k2cCQb/5";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3E06E10E0DE
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:01:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A132620E3;
 Fri, 31 Jul 2026 01:01:20 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5903F7B4;
 Fri, 31 Jul 2026 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785484884; bh=FGxwfJAUBwhCq/7ROi+0BbOdS2wTWRDrlbk9/c+bwXA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k2cCQb/5SSlhgpJ+YCZWOaemONKjq80m/XCHHNPLPg62Xt3Ybro08g4GBjQDLTki6
 8mZs1OWFWbmXCq/26RFpwSBHCjySUcI7mkwk/yBiHUOesbQHX3cjzFuFAQ+PggH8Db
 CWx/FP7qhdpsau0lTMhEtyIgWbTZGg71XQVkDaLA=
Message-ID: <80bb0e4c-630b-49d2-af7d-4fbf6927d513@arm.com>
Date: Fri, 31 Jul 2026 09:01:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
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

On 30/07/2026 12:45, Nicolas Frattaroli wrote:
> panthor_gpu_flush_caches() and panthor_gpu_soft_reset() would read (and
> even reset) the contents of the pending_reqs register outside of holding
> the reqs_lock. Additionally, when it did hold the lock, it did so with
> the irqsave/irqrestore variants, even though the spinlock was never
> acquired in an atomic context, just the threaded handler.
> 
> Use the new wait_event_lock_timeout() macro to check pending_reqs under
> the lock, and only do so without disabling interrupts.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index c013d6bf9a59..f015bde80abf 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -330,35 +330,34 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
> -	unsigned long flags;
>  	int ret = 0;
>  
>  	/* Serialize cache flush operations. */
>  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>  
> -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +	spin_lock(&ptdev->gpu->reqs_lock);
>  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
>  		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
>  	} else {
>  		ret = -EIO;
>  	}
> -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  
> -	if (ret)
> +	if (ret) {
> +		spin_unlock(&ptdev->gpu->reqs_lock);
>  		return ret;
> +	}
>  
> -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> -				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +				ptdev->gpu->reqs_lock, msecs_to_jiffies(100))) {
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
>  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
>  			ret = -ETIMEDOUT;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}
> +	spin_unlock(&ptdev->gpu->reqs_lock);
>  
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
> @@ -378,27 +377,25 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
>  	bool timedout = false;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +	guard(spinlock)(&ptdev->gpu->reqs_lock);
> +
>  	if (!drm_WARN_ON(&ptdev->base,
>  			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
>  		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
>  		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
>  	}
> -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  
> -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
> +				ptdev->gpu->reqs_lock,
>  				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
>  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
>  			timedout = true;
>  		else
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}
>  
>  	if (timedout) {
> 

