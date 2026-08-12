Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054F4C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D1B10EF80;
	Wed, 12 Aug 2026 12:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AlHITGMZ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CF910EF80
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786537289; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TsaqCtXpEuYMfk/2xrYNbeSM/gQkxXR+ja/Qk3WoOzKv92/QR+brD7fvCVT+6CIc7q1zwK/RGFqGYW1j3eGcAAbYqGmwKmezP7jjjF6SNM+E19kPacd9V+T5cl0TwX/Tjhvtl0xanH96VOXDlN/0OgJifbFLxiVZHufMoUpKw4g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786537289;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Cww7umszZJX86bX7ZQgwUGvlF/SNwN8vULjisHq2MYY=; 
 b=B2GKv4A+4Pb8DqM/KCpKOWdvgWg9o52c1ZFaLmsR60x+YEkwIHzgqHOE9vDT7fxNSUXsmINoth7amhARO67CDy4JqbMLU/R4ZHAvobsVK4WyAk8tPeBwgTQriHf5lGAm37adIyE+YtW9Yn9n2KlMj1K+bIopkMMjtfgPd/S3bB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786537289; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=Cww7umszZJX86bX7ZQgwUGvlF/SNwN8vULjisHq2MYY=;
 b=AlHITGMZxB8TXJTGjbg62vwfXP38VbG3lWhK9Houdy2Qkd+/4fJNCiF22gKfO/Uf
 rpVAum8DcSRCNCteOz7F7joqCB+IHA4BrTWB098FrQ6/qL4VuDwdYvbdo6KbLyGUcSV
 f/+ysa1WatNvtkqvU278KjmzxN99czU/3aHJAeyQ=
Received: by mx.zohomail.com with SMTPS id 178653728777435.800158134030085;
 Wed, 12 Aug 2026 05:21:27 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/3] drm/panthor: Add tracepoints for cache flushing
Date: Wed, 12 Aug 2026 14:21:21 +0200
Message-ID: <9cSuC0ASTeWIz--58OoWZA@collabora.com>
In-Reply-To: <20260811162934.340b1f16@fedora-21.home>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
 <20260811-panthor-cache-flush-fix-v3-1-47d2c1bb1dab@collabora.com>
 <20260811162934.340b1f16@fedora-21.home>
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

On Tuesday, 11 August 2026 16:29:34 Central European Summer Time Boris Brezillon wrote:
> On Tue, 11 Aug 2026 16:08:31 +0200
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> 
> > Add two new event tracepoints: gpu_cache_flush_start to be emitted after
> > acquiring the flush mutex and reqs spinlock, and gpu_cache_flush_end to
> > be emitted when leaving the function.
> > 
> > This allows debugging the duration a flush takes irrespective of initial
> > function entry lock contention by subtracting the start tracepoint's
> > timestamp from the end tracepoint timestamp, and additionally contains
> > information such as which caches were flushed.
> > 
> > Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gpu.c   |  7 ++++-
> >  drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> > index c013d6bf9a59..68e2dd2527df 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > @@ -337,6 +337,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
> >  
> >  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > +	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
> >  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> >  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> >  		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> > @@ -345,8 +346,10 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  	}
> >  	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  
> > -	if (ret)
> > +	if (ret) {
> > +		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> 
> I don't mind having start/end traces, but I still think it'd be
> valuable to report failure cases.

Alright, I think in that case I will get rid of the start/end ones
(since they now need to have different args) and just do one on exit
with a duration arg and an ret arg.

> 
> >  		return ret;
> > +	}
> >  
> >  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> > @@ -360,6 +363,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  	}
> >  
> > +	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> > +
> >  	if (ret) {
> >  		panthor_device_schedule_reset(ptdev);
> >  		drm_err(&ptdev->base, "Flush caches timeout");
> > diff --git a/drivers/gpu/drm/panthor/panthor_trace.h b/drivers/gpu/drm/panthor/panthor_trace.h
> > index 6ffeb4fe6599..6951b95b1de7 100644
> > --- a/drivers/gpu/drm/panthor/panthor_trace.h
> > +++ b/drivers/gpu/drm/panthor/panthor_trace.h
> > @@ -76,6 +76,55 @@ TRACE_EVENT(gpu_job_irq,
> >  		  __entry->events, __entry->duration_ns)
> >  );
> >  
> > +DECLARE_EVENT_CLASS(gpu_cache_flush_template,
> > +	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> > +	TP_ARGS(dev, l2, lsc, other),
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name(dev))
> > +		__field(u32, l2)
> > +		__field(u32, lsc)
> > +		__field(u32, other)
> > +	),
> > +	TP_fast_assign(
> > +		__assign_str(dev_name);
> > +		__entry->l2     = l2;
> > +		__entry->lsc    = lsc;
> > +		__entry->other  = other;
> > +	),
> > +	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
> > +		  __entry->l2, __entry->lsc, __entry->other)
> > +);
> > +
> > +/**
> > + * gpu_cache_flush_start - called after cache flush locks taken, before flush
> > + * @dev: pointer to the &struct device, for printing the device name
> > + * @l2: "l2" flush flags
> > + * @lsc: "lsc" flush flags
> > + * @other: "other" flush flags
> > + *
> > + * Fires after any initial lock contention around the locks needed for flushing
> > + * caches, but before the actual cache flush is requested.
> > + */
> > +DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_start,
> > +	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> > +	     TP_ARGS(dev, l2, lsc, other)
> > +);
> > +
> > +/**
> > + * gpu_cache_flush_end - called after cache flush
> > + * @dev: pointer to the &struct device, for printing the device name
> > + * @l2: "l2" flush flags
> > + * @lsc: "lsc" flush flags
> > + * @other: "other" flush flags
> > + *
> > + * Fires after either the cache flush is complete, or has failed. Can be used
> > + * together with gpu_cache_flush_start to get how long the flush has taken.
> > + */
> > +DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_end,
> > +	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> > +	     TP_ARGS(dev, l2, lsc, other)
> > +);
> > +
> >  #endif /* __PANTHOR_TRACE_H__ */
> >  
> >  #undef TRACE_INCLUDE_PATH
> > 
> 
> 




