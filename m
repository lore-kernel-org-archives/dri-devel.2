Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E9EC55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFEA410E4A2;
	Mon,  3 Aug 2026 08:53:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pN+10Pm6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC6510E4A2
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785747213;
 bh=fHyg4SxQfGroYY8Z6cFPEXyX60KEci0W3NHVSflRpkM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pN+10Pm6TqFKpc2wBHFr5/r2dPS4hSEjor/v9NO4FxIMPWJ0W/fYWbVk0m/eDiE+Z
 CL7+LOI2gMwhtjzTjJQTOx6U0r7A4ez4k5QJiPNrzOux3KfsUZ8cBFav3caolXU3zB
 oWC996EgxCYavijg0ITAb0IB/p/Z+a3OmMiWWEZPa4kOEd8EQWsvnixTaOrRaI+Zq6
 dMF/5tINU+oqqYBAj+9J8N6OUpmUvwDEYD8aupIq1H0IhnvcuykbVSo03msiIoP9+k
 Vou9IoZXeuVfswwn+n0M8k3nL5ltRKjOKTYupZFaODsu+3BnAub75TI1DN1JMZhzA9
 Qwm4EHtSP/5Og==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E79917E0177;
 Mon, 03 Aug 2026 10:53:32 +0200 (CEST)
Date: Mon, 3 Aug 2026 10:53:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Message-ID: <20260803105324.478ed594@fedora1.home>
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hello Nicolas,

On Thu, 30 Jul 2026 13:45:15 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> panthor_gpu_flush_caches() and panthor_gpu_soft_reset() would read (and
> even reset) the contents of the pending_reqs register outside of holding
> the reqs_lock.

Can you elaborate a bit on the race being fixed here? If pending_reqs bits
are truly cleared before the wake_up_all() call (which would require a
WRITE_ONCE() to be enforced, admittedly), there's no risk for the
wait_event() call to do a test before the bits have been updated,
and this holds even if the test is done without the lock held.

The other race I could think of is two threads calling
panthor_gpu_flush_caches() concurrently, and the second one stealing
the FLUSH_COMPLETED event the first thread waits on and re-issuing a
second flush on top, thus delaying the completion for the first thread.
But that should be covered by the cache_flush_lock.


> Additionally, when it did hold the lock, it did so with
> the irqsave/irqrestore variants, even though the spinlock was never
> acquired in an atomic context, just the threaded handler.
> 
> Use the new wait_event_lock_timeout() macro to check pending_reqs under
> the lock, and only do so without disabling interrupts.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

Can we make the _irq{save,restore}-drop its own patch?

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

Assuming we really need to do the test with the lock held, could we add
a patch at the beginning of the series that fixes the race without depending
on the new wait macro, so that we have a version that can easily be backported?

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

I think a scoped_guard() could make things a bit cleaner, and given you
already turn the regular lock/unlock sequence into a guard in
panthor_gpu_soft_reset(), I'd do that here as well.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/gpu/drm/panthor/panthor_gpu.c#L114
