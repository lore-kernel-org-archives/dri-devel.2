Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DD8C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 17:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF35110E052;
	Wed, 29 Jul 2026 17:24:47 +0000 (UTC)
X-Greylist: delayed 893 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jul 2026 17:24:46 UTC
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com
 [216.40.44.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101CB10E052
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 17:24:46 +0000 (UTC)
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay09.hostedemail.com (Postfix) with ESMTP id 0783F80688;
 Wed, 29 Jul 2026 17:09:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf16.hostedemail.com (Postfix) with ESMTPA id 4E7B520018; 
 Wed, 29 Jul 2026 17:09:45 +0000 (UTC)
Date: Wed, 29 Jul 2026 13:10:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH 3/3] drm/panthor: Add tracepoints for cache flushing
Message-ID: <20260729131015.394eaf4e@gandalf.local.home>
In-Reply-To: <20260729-panthor-cache-flush-fix-v1-3-205921ed3c81@collabora.com>
References: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
 <20260729-panthor-cache-flush-fix-v1-3-205921ed3c81@collabora.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4E7B520018
X-Stat-Signature: kfq6mfekxfipk1air44raypccozoopo4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UOHH5w2anfq4dLE6BbwdPdb9GugFnW2o=
X-HE-Tag: 1785344985-944712
X-HE-Meta: U2FsdGVkX19P2gfBapu1gESArfPkaYgMofX4xgmUWKuUkdqa9aE/5+UDdwTQ1je6X5AzSeB16yHb1FgL/HmGfGpyBx/W2aqzYeG2NkPqoFCBhjxa0nA5XpioZ0lV+X07IXKEeffGXoetgiTQK4ACxBFhbnPsVUzT3vHYEBZGGIzqBhyZrPajQAvjl0jw2jb+p1ba5L8+MFSo3w15p1IGOYCiZCTt+51elPf0JZDeMGl17R9cFka1SBnjfwfjLVxT20nisd54glMf/oLp5nS3kpM8q3Eq354sTGOX1AQcyyRjlr8qIs8tICN6RxQfgI78o2mp+mo5lq3KDrdKcbB4Wp1g9AMupbvEYsLw3B68UZLdjsEHNFq/6AMREXGqn0HR
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

On Wed, 29 Jul 2026 08:19:51 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> diff --git a/drivers/gpu/drm/panthor/panthor_trace.h b/drivers/gpu/drm/panthor/panthor_trace.h
> index 6ffeb4fe6599..5e2a9b8d0481 100644
> --- a/drivers/gpu/drm/panthor/panthor_trace.h
> +++ b/drivers/gpu/drm/panthor/panthor_trace.h
> @@ -76,6 +76,64 @@ TRACE_EVENT(gpu_job_irq,
>  		  __entry->events, __entry->duration_ns)
>  );
>  
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
> +TRACE_EVENT(gpu_cache_flush_start,
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
> +		__entry->l2	= l2;
> +		__entry->lsc	= lsc;
> +		__entry->other	= other;
> +	),
> +	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
> +		  __entry->l2, __entry->lsc, __entry->other)
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
> +TRACE_EVENT(gpu_cache_flush_end,
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
> +		__entry->l2	= l2;
> +		__entry->lsc	= lsc;
> +		__entry->other	= other;
> +	),
> +	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
> +		  __entry->l2, __entry->lsc, __entry->other)
> +);
> +
>  #endif /* __PANTHOR_TRACE_H__ */

The above two are identical. You'll save memory by using a template instead:

DECLARE_EVENT_CLASS(gpu_cache_flush_template,
	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
	TP_ARGS(dev, l2, lsc, other),
	TP_STRUCT__entry(
		__string(dev_name, dev_name(dev))
		__field(u32, l2)
		__field(u32, lsc)
		__field(u32, other)
	),
	TP_fast_assign(
		__assign_str(dev_name);
		__entry->l2	= l2;
		__entry->lsc	= lsc;
		__entry->other	= other;
	),
	TP_printk("%s: l2=0x%x lsc=0x%x other=0x%x", __get_str(dev_name),
		  __entry->l2, __entry->lsc, __entry->other)
);

DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_start,
	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
	TP_ARGS(dev, l2, lsc, other)
);

DEFINE_EVENT(gpu_cache_flush_template, gpu_cache_flush_end,
	TP_PROTO(const struct device *dev, u32 l2, u32 lsc, u32 other),
	TP_ARGS(dev, l2, lsc, other)
);

-- Steve
