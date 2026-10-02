Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E1ACA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5940910E6A0;
	Fri,  2 Oct 2026 19:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m83Je5hq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0626210E690
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 19:30:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D99D24083D;
 Fri,  2 Oct 2026 19:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9224F1F00893;
 Fri,  2 Oct 2026 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790969452;
 bh=ZXZkgGAz533Z8jH6/5qDdcZBmIR8T/pOLzRqxMIqK34=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=m83Je5hqTZXM/SKRtjzNlb2whHUmgtiXISGuGKXdRZLa4p9lTFH9cQOeWySkXH2wa
 jv3v+a9UpafAi7lKy/Rnz1BDbbvmtKWDiakBqqKbx0WoXanbsdl/JmlnrjBytMKtUq
 KCJeOocPtwX0Ip9S+mJKfr5j3dg9TtNYhYzWFiyXWHCQLvU5O9gY5dgEengN/YG+zk
 iiwnZCBLUdlpRTQRHc3o5x7lnJMWJ4rphl/Rzj63jkfWcL5QDtv2f1Di2Mz/gQqS5Y
 gDcULO4SWgvQXoEg5urnuAqN66KNT4iY79YsiTi7wwrkwGLM2b5KZTS6hs1oXkcHDu
 iKDQFPz+bFeZA==
Date: Fri, 02 Oct 2026 09:30:51 -1000
Message-ID: <3a139a32135c149f51bac4f2bd58ad56@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Breno Leitao <leitao@debian.org>
Subject: Re: [RFC v6.1 2/3] workqueue: Add support for real-time workers
In-Reply-To: <20261001184848.61776-1-tvrtko.ursulin@igalia.com>
References: <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
 <20261001184848.61776-1-tvrtko.ursulin@igalia.com>
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

Hello,

The following is a Claude-generated review.

On Thu, Oct 01, 2026 at 07:48:48PM +0100, Tvrtko Ursulin wrote:
> For use cases such as the DRM scheduler submitting work to the GPU on
> behalf of low latency userspace applications, where latter have sufficient
> privileges to have had successfully obtained realtime Vulkan global
> priority, competing with random background CPU load can create large
> latency spikes which gets in the way of a smooth user experience.

Can you add the compositor / DRM master usage model from the v5 discussion
here? The cover letter also still says CAP_SYS_NICE is required while
group_priority_permit() accepts DRM master too.

> +	HIGHPRI_PRIORITY	= NICE_TO_PRIO(MIN_NICE),
> +	RT_PRIORITY		= MAX_RT_PRIO - 1,

MAX_RT_PRIO - 1 is what rt_priority 0 would map to, while
sched_set_fifo_low() gives the workers prio 98. Nothing depends on it today,
but maybe MAX_RT_PRIO - 2 with a comment tying it to sched_set_fifo_low(),
or soften the kerneldoc which says the encoding matches task_struct->prio?
Also, s/analoguous/analogous/ there.

> +	if (wq->flags & WQ_RT) {
> +		attrs->prio = RT_PRIORITY;
> +		/*
> +		 * RT workqueues have strict CPU affinity for low
> +		 * latency execution.
> +		 */
> +		attrs->affn_scope = WQ_AFFN_CPU;
> +		attrs->affn_strict = true;

apply_workqueue_attrs() is unrestricted, so a caller can hand a WQ_RT wq the
attrs from alloc_workqueue_attrs() and turn it into a normal non-strict wq
while the flag stays set. Maybe apply_wqattrs_prepare() should force prio
and affinity for WQ_RT instead of restricting only the sysfs side?

> +	if (flags & WQ_RT) {
> +		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=
> +			         WQ_UNBOUND))
> +			return NULL;
> +	}

alloc_ordered_workqueue() with WQ_RT passes this and ends up with a single
pool spanning all CPUs because ordered wqs use dfl_pwq everywhere, while the
doc and sysfs say strict per-CPU. Should __WQ_ORDERED be rejected too? The
nested ifs can also be a single condition.

> -		pr_cont(" nice=%d", pool->attrs->nice);
> +		pr_cont(" nice=%d", PRIO_TO_NICE(pool->attrs->prio));

This prints nice=-21 for RT pools. Can you show "rt" here like nice_show()?

> +	/* Do not allow cpumask changes for RT workers. */
> +	if (wq->flags & WQ_RT)
> +		return -EINVAL;

The three stores check WQ_RT and return -EINVAL while nice goes read-only
through is_visible below. Can all four go through
wq_sysfs_unbound_group_visible() returning 0444 for WQ_RT? That drops the
three store checks. Note that the global cpumask still applies to WQ_RT wqs
through workqueue_apply_unbound_cpumask(), so the comment overstates a bit.
The interface comment at the top of the sysfs section also still says nice
is RW int.

> +	/* Do not allow priority changes for RT workers. */
> +	if ((wq->flags & WQ_RT) && !strcmp(attr->name, "nice"))
> +		return 0444;

attr == &dev_attr_nice.attr would avoid the strcmp.

> +    prio = pool.attrs.prio.value_()
> +    if prio == rt_prio:
> +        prio = 'rt'
> +    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} prio={prio:3} ', end='')

Can we keep printing nice for non-RT pools? prio=120 is the internal
encoding, sysfs and the pool dumps print nice, and the example output in
workqueue.rst would go stale. prog['RT_PRIORITY'] would match the rest of
the file too.

One more thing which isn't in the diff. The rescuer of a WQ_RT |
WQ_MEM_RECLAIM wq, which is what panthor-drm-rt is, still runs at nice -20,
so under memory pressure the RT wq's work items run as CFS. Should
rescuer_thread() use sched_set_fifo_low() for WQ_RT?

Thanks.

--
tejun
