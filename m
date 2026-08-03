Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05CDC55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5063B10E6CE;
	Mon,  3 Aug 2026 13:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SpWOuJ9o";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9CA10E6CE
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785762815; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X2RGGrH6X0p40j6P5GsvcI077cVNKqngBmAHZT+sutqRyln1thDi5pi9OK1tLzHab5+p+vCX0udOKdgA+q4JhsLYXSYYBRvtVceHu/TdDSte5vW0BYC/xMDIvgOQbn8/iinATZaEgahBuzqDGkORmuXDIUyIBsg/PTB0Z84Tsoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785762815;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zVXSwH8+djZtg6NK2PcvJsNWXZsYp4BAKkUN1gzLYis=; 
 b=Wn7zwCL20mvBKz9TunuWbPsOyyBzzwWQIeTRhoy1EE5r+qHtOPVxM6UcnqW20eivdSzYYs0N+qbJCUWnEaeLEFErKqNyszDMqJPTOaIwGsB4pczURKZTvTGQE76E3xgsQsJ8LXvUhksNaeBAGmLW/YGn/Yi4Qsp9YU39TvPzKBg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785762815; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=zVXSwH8+djZtg6NK2PcvJsNWXZsYp4BAKkUN1gzLYis=;
 b=SpWOuJ9oWh75STCAf/2FoaB89scgzCZJsG3RnN1qi2RHueEgnIgVT1VuC2dJ2flK
 9IhfpQqoHnCsqsyxuEeN/lqdntBGTwJ8vDcI+I3uSsKIjuJn934Q0oW1mcRhTz88ijG
 iXfLVogKMiT8/o4ouAuBp4scmIMMnY2XAlumgvLM=
Received: by mx.zohomail.com with SMTPS id 1785762813731974.4351775481138;
 Mon, 3 Aug 2026 06:13:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Date: Mon, 03 Aug 2026 15:13:25 +0200
Message-ID: <fiUy-cD0Q9OOQiaEoz9UeA@collabora.com>
In-Reply-To: <20260803105324.478ed594@fedora1.home>
References: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
 <20260730-panthor-cache-flush-fix-v2-2-28790478bfff@collabora.com>
 <20260803105324.478ed594@fedora1.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Monday, 3 August 2026 10:53:24 Central European Summer Time Boris Brezillon wrote:
> Hello Nicolas,
> 
> On Thu, 30 Jul 2026 13:45:15 +0200
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > panthor_gpu_flush_caches() and panthor_gpu_soft_reset() would read (and
> > even reset) the contents of the pending_reqs register outside of holding
> > the reqs_lock.
> 
> Can you elaborate a bit on the race being fixed here? If pending_reqs bits
> are truly cleared before the wake_up_all() call (which would require a
> WRITE_ONCE() to be enforced, admittedly), there's no risk for the
> wait_event() call to do a test before the bits have been updated,
> and this holds even if the test is done without the lock held.
> 
> The other race I could think of is two threads calling
> panthor_gpu_flush_caches() concurrently, and the second one stealing
> the FLUSH_COMPLETED event the first thread waits on and re-issuing a
> second flush on top, thus delaying the completion for the first thread.
> But that should be covered by the cache_flush_lock.

panthor_gpu_flush_caches() is not the only thing that sets/gets
pending_reqs. Notably, the threaded interrupt handler does, as
well as any other functionality using the same member for reqs
tracking (e.g. the soft reset).

Consider the following serialisation of events:
1. T1 asks to flush caches by writing GPU_CMD and setting pending_reqs
2. T1 drops reqs_lock.
3. T2 enters IRQ handler for flush complete, spins lock waiting for
   reqs_lock
4. T1 sleeps at wait_event_timeout
5. T2 updates pending_reqs and wakes up the waiter in any order, since
   the effects of those two can't consistently be observed as sequential
   logic without the outer reqs_lock being held by the observer
6. T1 wakes up, checks pending_reqs, but since pending_reqs is checked
   without holding any lock, so we implictly depend on the synchronisation
   point that is the waitqueue's lock rather than the reqs_lock spinlock,
   which says nothing about whether the pending_reqs change materialised
   on T1's side yet as far as I can tell?
7. T1 sees that pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED is still != 0,
   so goes back to sleep for some future wake-up of reqs_acked or a timeout.

I'm not 100% sure, but I think 6. means that the memory model would permit
T1 to re-use the pending_reqs it previously set, rather than the updated
one set by T2, since there's nothing stopping us from being woken up before
the pending_reqs change has made itself known to observers not serialising
with the reqs_lock being released by T2 in panthor_gpu_irq_handler after.

If you check lock_stat before the change, you see that the reqs_lock is
actually never contended. This isn't a good sign because it means
whatever situation it exists to protect against never occurs, so either
the lock is pointless or the lock is non-functional.

> > Additionally, when it did hold the lock, it did so with
> > the irqsave/irqrestore variants, even though the spinlock was never
> > acquired in an atomic context, just the threaded handler.
> > 
> > Use the new wait_event_lock_timeout() macro to check pending_reqs under
> > the lock, and only do so without disabling interrupts.
> > 
> > Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gpu.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> > index c013d6bf9a59..f015bde80abf 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > @@ -330,35 +330,34 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  			     u32 l2, u32 lsc, u32 other)
> >  {
> >  	struct panthor_gpu *gpu = ptdev->gpu;
> > -	unsigned long flags;
> >  	int ret = 0;
> >  
> >  	/* Serialize cache flush operations. */
> >  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
> >  
> > -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > +	spin_lock(&ptdev->gpu->reqs_lock);
> 
> Can we make the _irq{save,restore}-drop its own patch?

I'm not sure it's fine to drop the IRQ disabling without fixing the read of
pending_reqs outside its lock.

> 
> >  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> >  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> >  		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> >  	} else {
> >  		ret = -EIO;
> >  	}
> > -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  
> > -	if (ret)
> > +	if (ret) {
> > +		spin_unlock(&ptdev->gpu->reqs_lock);
> >  		return ret;
> > +	}
> >  
> > -	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> > +	if (!wait_event_lock_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> 
> Assuming we really need to do the test with the lock held, could we add
> a patch at the beginning of the series that fixes the race without depending
> on the new wait macro, so that we have a version that can easily be backported?

It's either backporting the prerequisite new macro or still doing this all
with IRQs disabled using the pre-existing wait_event_lock_irq_timeout macro,
and the IRQ disabled thing is what caused problems.

> 
> > -				msecs_to_jiffies(100))) {
> > -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > +				ptdev->gpu->reqs_lock, msecs_to_jiffies(100))) {
> >  		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> >  		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> >  			ret = -ETIMEDOUT;
> >  		else
> >  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> > -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  	}
> > +	spin_unlock(&ptdev->gpu->reqs_lock);
> 
> I think a scoped_guard() could make things a bit cleaner, and given you
> already turn the regular lock/unlock sequence into a guard in
> panthor_gpu_soft_reset(), I'd do that here as well.

That would add an additional layer of indentation, which I'm wary of.
We can't use a non-scoped guard due to the reset at the end of the
function.

I'll see if I can reshuffle the code to make it not as ugly to use a
scoped_guard here. Will also slightly change the semantics of the
_end tracepoint, since it'll then fire it before dropping the lock,
but that's not much of a change.

Kind regards,
Nicolas Frattaroli

> 
> Regards,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/v7.2-rc5/source/drivers/gpu/drm/panthor/panthor_gpu.c#L114
> 




