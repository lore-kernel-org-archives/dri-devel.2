Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1175C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1201310F1B0;
	Fri, 31 Jul 2026 08:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ag/GvXDV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DCF2210F1B0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:03:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E3C22C7;
 Fri, 31 Jul 2026 01:03:53 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA443F86F;
 Fri, 31 Jul 2026 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785485037; bh=9LdX6Nm67lXUyl4q3SLgatLosZbxqQtQKhJxaZEsWLk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ag/GvXDVyHye6G78FxGeZSttVsUGbfJdVkLB7m+aemJ5gXei9MSJ61Nt8DVtrCKFD
 4vCo24/2nE30/+nGDiyA56OKTcwg9ArSgHC9hjOHKu18/DohIGYO0vb7A07BFrs5r2
 XQ5Th65wWKrISij0RmW5t60Qzp53gUO4+xaFIKmI=
Message-ID: <af9cca4f-cdf9-452c-b8ca-b29087400d51@arm.com>
Date: Fri, 31 Jul 2026 09:03:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/panthor: Add tracepoints for cache flushing
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
 <20260730-panthor-cache-flush-fix-v2-3-28790478bfff@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260730-panthor-cache-flush-fix-v2-3-28790478bfff@collabora.com>
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
> Add two new event tracepoints: gpu_cache_flush_start to be emitted after
> acquiring the flush mutex and reqs spinlock, and gpu_cache_flush_end to
> be emitted when leaving the function.
> 
> This allows debugging the duration a flush takes irrespective of initial
> function entry lock contention by subtracting the start tracepoint's
> timestamp from the end tracepoint timestamp, and additionally contains
> information such as which caches were flushed.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c   |  3 ++
>  drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index f015bde80abf..a25955ad668b 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -336,6 +336,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>  
>  	spin_lock(&ptdev->gpu->reqs_lock);
> +	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
>  	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>  		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
>  		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> @@ -345,6 +346,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  
>  	if (ret) {
>  		spin_unlock(&ptdev->gpu->reqs_lock);
> +		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
>  		return ret;
>  	}
>  
> @@ -358,6 +360,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
>  	}
>  	spin_unlock(&ptdev->gpu->reqs_lock);
> +	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
>  
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
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

