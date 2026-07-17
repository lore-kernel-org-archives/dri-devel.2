Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C62C4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 006EA10E774;
	Mon, 20 Jul 2026 07:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.b="B5+jzfS0";
	dkim-atps=neutral
X-Greylist: delayed 414 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 12:02:05 UTC
Received: from devianza.investici.org (devianza.investici.org
 [198.167.222.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3B010E435
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
 s=stigmate; t=1784289309;
 bh=FYVdALvvF/Spz74EP+v9VtOIp0LI6K7x3MeLqwelrgM=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=B5+jzfS09RPjWjGoBqCOATg/z7F4v5yQ49lD+IwcOwGlnG9YjzVDCxnblN05wVnsM
 cj5IRyXDT3/I3/ac5Lati1dCNcvBr2aEHmQho3lcDesAygMEJUHkDC4WuN90DMnMoO
 TfIFJFiWasQwfph7y8OjJXSH8JuFamH+XrYWLT/I=
Received: from mx2.investici.org (unknown [127.0.0.1])
 by devianza.investici.org (Postfix) with ESMTP id 4h1pHx3rBdz6vdL;
 Fri, 17 Jul 2026 11:55:09 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h1pHx0d35z4vyJ;
 Fri, 17 Jul 2026 11:55:09 +0000 (UTC)
Date: Fri, 17 Jul 2026 12:55:10 +0100
From: Bradley Morgan <include@grrlz.net>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 matthew.brost@intel.com, olv@google.com, olvaffe@gmail.com,
 steven.price@arm.com, tj@kernel.org
Subject: Re: [RFC v2 1/2] workqueue: Add support for real-time workers
In-Reply-To: <80afb75b-d2c2-451c-bbbb-d2c0e20d428e@igalia.com>
References: <8AE254BA-D095-4952-A43B-79452280EEFD@grrlz.net>
 <80afb75b-d2c2-451c-bbbb-d2c0e20d428e@igalia.com>
Message-ID: <67463FB3-20A8-4D2D-A4BB-0CEABCBEDA06@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

On July 17, 2026 12:51:06 PM GMT+01:00, Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
>Hi,
>
>Is this a human review, or AI review, or combined?

Human :)


>On 17/07/2026 12:25, Bradley Morgan wrote:
>> Hi Tvrtko,
>> 
>> Applies to master. On linux-next one hunk rejects, the WQ_RTPRI block
>> in __alloc_workqueue(), the rest is clean. Rebase v3 onto the wq tree,
>> please..
>
>Fixed in v3 already.
>
>> 
>> Things to fix:
>> 
>>> +fail_ida:
>>> +	if (pool->attrs->prio == WQ_PRIO_RT)
>>> +		atomic_dec(&total_rtpri_workers);
>>>   fail:
>>>   	ida_free(&pool->worker_ida, id);
>>>   	kfree(worker);
>> 
>> Labels swapped. The ida_alloc() failure falls into fail:, so ida_free()
>> gets a negative id and kfree() an uninitialized pointer, and the
>> later failure paths leak the counter. The fix is something like,
>> 
>> 	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
>> 	if (id < 0)
>> 		goto fail_dec;
>> 	...
>> fail:
>> 	ida_free(&pool->worker_ida, id);
>> 	kfree(worker);
>> fail_dec:
>> 	if (pool->attrs->prio == WQ_PRIO_RT)
>> 		atomic_dec(&total_rtpri_workers);
>> 	return NULL;
>
>Already fixed locally after Sashiko flagged the onion unwind fail.

Thanks.

>> 
>>> +		if (worker->pool->attrs->prio == WQ_PRIO_RT)
>>> +			atomic_dec(&total_rtpri_workers);
>> 
>> worker->pool is NULL here, the WORKER_DIE path clears it before
>> kthread_stop_put() returns, so every cull oopses.
>> 
>> Flag the worker at creation, a bool rtpri in struct worker:
>> 
>> 	worker->rtpri = pool->attrs->prio == WQ_PRIO_RT;
>> 
>> and in reap_dying_workers():
>> 
>> -		if (worker->pool->attrs->prio == WQ_PRIO_RT)
>> +		if (worker->rtpri)
>>   			atomic_dec(&total_rtpri_workers);
>
>Ditto but differently.

Thanks.

>>> +		wq->unbound_attrs->affn_scope = WQ_AFFN_CPU;
>>> +		wq->unbound_attrs->affn_strict = true;
>> 
>> Its a dead store, apply_wqattrs_commit() overwrites both, so the
>headline
>> v2
>> change never engages. Drop these two lines and mark the RT entries in
>> the workqueue_init_early() attrs loops instead, for both
>> unbound_std_wq_attrs and ordered_wq_attrs:
>> 
>> 		attrs->prio = std_prio[i];
>> 		attrs->nice = std_nice[i];
>> 
>> +		if (attrs->prio == WQ_PRIO_RT) {
>> +			attrs->affn_scope = WQ_AFFN_CPU;
>> +			attrs->affn_strict = true;
>> +		}
>
>Already done locally exactly like this.

Thanks.


>> Questions: the changelog says two workers per workqueue, but the code
>clamps max_active, which caps work items, not threads. At the global cap
>create_worker() fails silently and maybe_create_worker() retries forever,
>so the pool stalls; with strict pods the last pod on an N CPU
>> box may never get a worker. pr_warn() or fall back to a normal worker?
>
>Yeah it's a design open. I will probably just drop the global limits if
>Tejun agrees.

Ok.

>> Also the rescuer is not FIFO, so WQ_MEM_RECLAIM plus WQ_RTPRI loses
>> the latency claim exactly under memory pressure.
>
>Sashiko commented on this already. But I don't think latency is super
>relevant under memory pressure.
>
>> Nits: the "R" suffix branch is dead code, RT is unbound only. The
>
>Curiosly lkml Sashiko missed this but I am aware of it. It is leftover
>from v1. And it's not a branch but an extra array element.
>

okay.

>> affinity sysfs files can still undo the forced affinity.
>
>I am opting letting the admins shoot themselves in the foot.

Heh. Fair enough 

>> Id prefer NUM_WQ_PRIO over NR_STD_WORKER_POOLS + 1. workqueue.rst needs
>> WQ_RTPRI.
>
>I was on the fence. Either way is not ideal.
>
>RST noted.

Yeah. Agreed.

>> With the rebase and fixes, please add:
>> 
>> Reviewed-by: Bradley Morgan <include@grrlz.net> # kernel/
>> 
>> Thanks for the patch!
>
>Thank you for reading through it!
>
>Regards,
>
>Tvrtko
>
>
>

Thanks!
