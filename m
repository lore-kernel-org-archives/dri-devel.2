Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94856C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD0A10E461;
	Tue, 11 Aug 2026 14:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="o88gt6Py";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1904610E461
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786458583;
 bh=+4ztnxA/twWVdXr+tbAc5HYUmI+LRY9rG6HYcWFeMd0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=o88gt6PyT9d5oTRMa1Lvrt/XFxvzsp2/A+AC0kAUzKuTp91FSW7uyg+CbiRcjj+81
 iUURpR0/4Pn+AqYNvNATD3kNg4umVigPG7dLom9ZsImI40vE2uJSJz5psYR48gFxha
 Xhy/jVOpcA+TvxlnSPdZAJrMULkcuNp/tnq/taBuu8gOIuxUDG2lkp3kFiL7aDif/W
 uPZ2oYBhCMPcz6je7Y5uqoU3zJTlPXeoy0m2VHCR0u01MdK1ylRfMl8gt3esl41zoQ
 6ORvFNQ+vdSkVVBHVGOUu0Y2CcueVpw//ddbwPoXoEvFn8JUx06jNXgqp9rqFpT/YZ
 3YPp9N6fsD3iw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E3BA17E06DB;
 Tue, 11 Aug 2026 16:29:43 +0200 (CEST)
Date: Tue, 11 Aug 2026 16:29:34 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/3] drm/panthor: Add tracepoints for cache flushing
Message-ID: <20260811162934.340b1f16@fedora-21.home>
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-1-47d2c1bb1dab@collabora.com>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
 <20260811-panthor-cache-flush-fix-v3-1-47d2c1bb1dab@collabora.com>
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

On Tue, 11 Aug 2026 16:08:31 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> Add two new event tracepoints: gpu_cache_flush_start to be emitted after
> acquiring the flush mutex and reqs spinlock, and gpu_cache_flush_end to
> be emitted when leaving the function.
> 
> This allows debugging the duration a flush takes irrespective of initial
> function entry lock contention by subtracting the start tracepoint's
> timestamp from the end tracepoint timestamp, and additionally contains
> information such as which caches were flushed.
> 
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c   |  7 ++++-
>  drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index c013d6bf9a59..68e2dd2527df 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -337,6 +337,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>  
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> +	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
>  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
>  		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> @@ -345,8 +346,10 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	}
>  	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  
> -	if (ret)
> +	if (ret) {
> +		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);

I don't mind having start/end traces, but I still think it'd be
valuable to report failure cases.

>  		return ret;
> +	}
>  
>  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> @@ -360,6 +363,8 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  	}
>  
> +	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> +
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
>  		drm_err(&ptdev->base, "Flush caches timeout");
> diff --git a/drivers/gpu/drm/panthor/panthor_trace.h b/drivers/gpu/drm/panthor/panthor_trace.h
> index 6ffeb4fe6599..6951b95b1de7 100644
> --- a/drivers/gpu/drm/panthor/panthor_trace.h
> +++ b/drivers/gpu/drm/panthor/panthor_trace.h
> @@ -76,6 +76,55 @@ TRACE_EVENT(gpu_job_irq,
>  		  __entry->events, __entry->duration_ns)
>  );
>  
> +DECLARE_EVENT_CLASS(gpu_cache_flush_template,
> +	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> +	TP_ARGS(dev, l2, lsc, other),
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name(dev))
> +		__field(u32, l2)
> +		__field(u32, lsc)
> +		__field(u32, other)
> +	),
> +	TP_fast_assign(
> +		__assign_str(dev_name);
> +		__entry->l2     = l2;
> +		__entry->lsc    = lsc;
> +		__entry->other  = other;
> +	),
> +	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
> +		  __entry->l2, __entry->lsc, __entry->other)
> +);
> +
> +/**
> + * gpu_cache_flush_start - called after cache flush locks taken, before flush
> + * @dev: pointer to the &struct device, for printing the device name
> + * @l2: "l2" flush flags
> + * @lsc: "lsc" flush flags
> + * @other: "other" flush flags
> + *
> + * Fires after any initial lock contention around the locks needed for flushing
> + * caches, but before the actual cache flush is requested.
> + */
> +DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_start,
> +	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> +	     TP_ARGS(dev, l2, lsc, other)
> +);
> +
> +/**
> + * gpu_cache_flush_end - called after cache flush
> + * @dev: pointer to the &struct device, for printing the device name
> + * @l2: "l2" flush flags
> + * @lsc: "lsc" flush flags
> + * @other: "other" flush flags
> + *
> + * Fires after either the cache flush is complete, or has failed. Can be used
> + * together with gpu_cache_flush_start to get how long the flush has taken.
> + */
> +DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_end,
> +	     TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
> +	     TP_ARGS(dev, l2, lsc, other)
> +);
> +
>  #endif /* __PANTHOR_TRACE_H__ */
>  
>  #undef TRACE_INCLUDE_PATH
> 

