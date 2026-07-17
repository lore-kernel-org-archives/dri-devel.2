Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411B7C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7B310E3E4;
	Fri, 17 Jul 2026 11:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SvbxoTot";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3DC10E3E4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=HAjU3fALN0h+MVCKV82nqv+2ZL6XlnWR6KVX6yEh+KQ=; b=SvbxoTot938LOei2iv3eLlRfyw
 KZWnlF58dhC/4qZAMLtEi/1PIlZoFubnmeG20BIytjO7YFqrcdheQg0BDXkauEHbnyD+j9Gbz0t9z
 J5JYuclfvrwtANGc9i0MaqADiHa3mTppfuJheRD/mOg1OSUPQBGTSU2r2JOPCerxX+SRINJPdHnKR
 Uip/fJbhd/KdMEfdFgB9z3rtiLFsXShL6v6xf+CEbc/OlANP3rgopf/HfgRH0Qe2indF9dpGBDF4y
 5QKO+0bYQ9zHCvxjSH07LwWYi38r9YlunGL3K02zMKM9uTRHr0WDbots59fBaxLTpvwj8d9+v8iWC
 x1OrqmrQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wkh5v-00GOFi-OG; Fri, 17 Jul 2026 13:51:07 +0200
Message-ID: <80afb75b-d2c2-451c-bbbb-d2c0e20d428e@igalia.com>
Date: Fri, 17 Jul 2026 12:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] workqueue: Add support for real-time workers
To: Bradley Morgan <include@grrlz.net>
Cc: boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 matthew.brost@intel.com, olv@google.com, olvaffe@gmail.com,
 steven.price@arm.com, tj@kernel.org
References: <8AE254BA-D095-4952-A43B-79452280EEFD@grrlz.net>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <8AE254BA-D095-4952-A43B-79452280EEFD@grrlz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


Hi,

Is this a human review, or AI review, or combined?

On 17/07/2026 12:25, Bradley Morgan wrote:
> Hi Tvrtko,
> 
> Applies to master. On linux-next one hunk rejects, the WQ_RTPRI block
> in __alloc_workqueue(), the rest is clean. Rebase v3 onto the wq tree,
> please..

Fixed in v3 already.

> 
> Things to fix:
> 
>> +fail_ida:
>> +	if (pool->attrs->prio == WQ_PRIO_RT)
>> +		atomic_dec(&total_rtpri_workers);
>>   fail:
>>   	ida_free(&pool->worker_ida, id);
>>   	kfree(worker);
> 
> Labels swapped. The ida_alloc() failure falls into fail:, so ida_free()
> gets a negative id and kfree() an uninitialized pointer, and the
> later failure paths leak the counter. The fix is something like,
> 
> 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
> 	if (id < 0)
> 		goto fail_dec;
> 	...
> fail:
> 	ida_free(&pool->worker_ida, id);
> 	kfree(worker);
> fail_dec:
> 	if (pool->attrs->prio == WQ_PRIO_RT)
> 		atomic_dec(&total_rtpri_workers);
> 	return NULL;

Already fixed locally after Sashiko flagged the onion unwind fail.

> 
>> +		if (worker->pool->attrs->prio == WQ_PRIO_RT)
>> +			atomic_dec(&total_rtpri_workers);
> 
> worker->pool is NULL here, the WORKER_DIE path clears it before
> kthread_stop_put() returns, so every cull oopses.
> 
> Flag the worker at creation, a bool rtpri in struct worker:
> 
> 	worker->rtpri = pool->attrs->prio == WQ_PRIO_RT;
> 
> and in reap_dying_workers():
> 
> -		if (worker->pool->attrs->prio == WQ_PRIO_RT)
> +		if (worker->rtpri)
>   			atomic_dec(&total_rtpri_workers);

Ditto but differently.

>> +		wq->unbound_attrs->affn_scope = WQ_AFFN_CPU;
>> +		wq->unbound_attrs->affn_strict = true;
> 
> Its a dead store, apply_wqattrs_commit() overwrites both, so the headline
> v2
> change never engages. Drop these two lines and mark the RT entries in
> the workqueue_init_early() attrs loops instead, for both
> unbound_std_wq_attrs and ordered_wq_attrs:
> 
> 		attrs->prio = std_prio[i];
> 		attrs->nice = std_nice[i];
> 
> +		if (attrs->prio == WQ_PRIO_RT) {
> +			attrs->affn_scope = WQ_AFFN_CPU;
> +			attrs->affn_strict = true;
> +		}

Already done locally exactly like this.

> Questions: the changelog says two workers per workqueue, but the code clamps max_active, which caps work items, not threads. At the global cap create_worker() fails silently and maybe_create_worker() retries forever, so the pool stalls; with strict pods the last pod on an N CPU
> box may never get a worker. pr_warn() or fall back to a normal worker?

Yeah it's a design open. I will probably just drop the global limits if 
Tejun agrees.

> Also the rescuer is not FIFO, so WQ_MEM_RECLAIM plus WQ_RTPRI loses
> the latency claim exactly under memory pressure.

Sashiko commented on this already. But I don't think latency is super 
relevant under memory pressure.

> Nits: the "R" suffix branch is dead code, RT is unbound only. The

Curiosly lkml Sashiko missed this but I am aware of it. It is leftover 
from v1. And it's not a branch but an extra array element.

> affinity sysfs files can still undo the forced affinity.

I am opting letting the admins shoot themselves in the foot.

> Id prefer NUM_WQ_PRIO over NR_STD_WORKER_POOLS + 1. workqueue.rst needs
> WQ_RTPRI.

I was on the fence. Either way is not ideal.

RST noted.

> With the rebase and fixes, please add:
> 
> Reviewed-by: Bradley Morgan <include@grrlz.net> # kernel/
> 
> Thanks for the patch!

Thank you for reading through it!

Regards,

Tvrtko


