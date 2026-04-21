Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0CF94CA9
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2BE10E168;
	Tue, 21 Apr 2026 19:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NDrrAmJE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C15510E168
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 19:45:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 57D7D60172;
 Tue, 21 Apr 2026 19:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B8C2BCB0;
 Tue, 21 Apr 2026 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776800756;
 bh=hm/z7m642SSms8DuycPWedMgrZhlsol5e0DI+vAf0q8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NDrrAmJEW55Vezbk5OaPKZayer8LC/OnvDp1acSQPsYNIRAzoJxeNDMFe0J7mXsuA
 1aiBZNm+8BerqYAhdb+K82nkLXDg7qwztts9+pU2E+jsalH56odYv2jraYLxiSr/Nv
 G8cR3sljB1FEAPX6d42pNdJInG1Bq9a8d9sTfbb/Tjj8f1dgcQ3LKn9C8sh6/UmiZA
 gfBnMDgzpOQHXS7OwgdVE+la45fUpVFeG8gPY82wu8QV6eGaZPj8Ysan46DYojKjbE
 xRX06iKsyuDLiJFUkvoqwfuoc499Rjk+vnDhugctDLwT44X8mCccoYVX2Y4DDqf7Sq
 wv/iqX1TfnFGg==
Message-ID: <f3d1b859-e5f2-468c-b957-fc3686457213@kernel.org>
Date: Tue, 21 Apr 2026 14:45:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Improve tracing for job lifecycle and
 mailbox RX worker
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260421181502.1970263-1-lizhi.hou@amd.com>
 <83846da8-0c8f-4eca-bac9-08efe1c0eb2f@amd.com>
 <9bca1ecd-ce16-2703-3a0d-6db208c83b06@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <9bca1ecd-ce16-2703-3a0d-6db208c83b06@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 4/21/26 14:39, Lizhi Hou wrote:
> 
> On 4/21/26 12:18, Mario Limonciello wrote:
>>
>>
>> On 4/21/26 13:15, Lizhi Hou wrote:
>>> From: Max Zhen <max.zhen@amd.com>
>>>
>>> Add more trace coverage to amdxdna job handling and mailbox receive
>>> processing to make driver execution easier to debug.
>>>
>>> Extend the xdna_job trace event to record the command opcode in
>>> addition to the job sequence number. Use the enhanced tracepoint in
>>> the job run, sent-to-device, signaled-fence, and job-free paths so
>>> that trace output can be correlated with the command being executed.
>>>
>>> Also add debug-point tracing when a command is received through the
>>> submit ioctl path, and add a trace event when the mailbox RX worker
>>> runs.
>>>
>>> These changes improve visibility into job lifetime transitions and
>>> mailbox activity, which helps debug command flow and scheduler issues.
>>>
>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>>   drivers/accel/amdxdna/aie2_ctx.c        | 14 ++++++---
>>>   drivers/accel/amdxdna/amdxdna_ctx.c     |  3 +-
>>>   drivers/accel/amdxdna/amdxdna_ctx.h     |  1 +
>>>   drivers/accel/amdxdna/amdxdna_mailbox.c |  1 +
>>>   include/trace/events/amdxdna.h          | 42 ++++++++++++++++---------
>>>   5 files changed, 42 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/ 
>>> amdxdna/aie2_ctx.c
>>> index d37123d925b6..3b0feba448c4 100644
>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>> @@ -64,6 +64,7 @@ static void aie2_job_release(struct kref *ref)
>>>       struct amdxdna_sched_job *job;
>>>         job = container_of(ref, struct amdxdna_sched_job, refcnt);
>>> +
>>>       amdxdna_sched_job_cleanup(job);
>>>       atomic64_inc(&job->hwctx->job_free_cnt);
>>>       wake_up(&job->hwctx->priv->job_free_wq);
>>> @@ -195,7 +196,8 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>>   {
>>>       struct dma_fence *fence = job->fence;
>>>   -    trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", 
>>> job->seq);
>>> +    trace_xdna_job(&job->base, job->hwctx->name, "signaling fence",
>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>> DEFAULT_IO);
>>>         aie2_tdr_signal(job->hwctx->client->xdna);
>>>       job->hwctx->priv->completed++;
>>> @@ -366,6 +368,9 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>>       struct dma_fence *fence;
>>>       int ret;
>>>   +    trace_xdna_job(sched_job, hwctx->name, "job run",
>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>> DEFAULT_IO);
>>> +
>>>       if (!hwctx->priv->mbox_chann)
>>>           return NULL;
>>>   @@ -409,7 +414,8 @@ aie2_sched_job_run(struct drm_sched_job 
>>> *sched_job)
>>>       } else {
>>>           aie2_tdr_signal(hwctx->client->xdna);
>>>       }
>>> -    trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
>>> +    trace_xdna_job(sched_job, hwctx->name, "sent to device",
>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>> DEFAULT_IO);
>>>         return fence;
>>>   }
>>> @@ -419,7 +425,8 @@ static void aie2_sched_job_free(struct 
>>> drm_sched_job *sched_job)
>>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>>   -    trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
>>> +    trace_xdna_job(sched_job, hwctx->name, "job free",
>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>> DEFAULT_IO);
>>>       if (!job->job_done)
>>>           up(&hwctx->priv->job_sem);
>>>   @@ -437,7 +444,6 @@ aie2_sched_job_timedout(struct drm_sched_job 
>>> *sched_job)
>>>       int ret;
>>>         xdna = hwctx->client->xdna;
>>> -    trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>>>         guard(mutex)(&xdna->dev_lock);
>>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/ 
>>> amdxdna/amdxdna_ctx.c
>>> index ff6c3e8e5a15..2c2c21992c87 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>>> @@ -514,7 +514,6 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>>> *client,
>>>           goto unlock_srcu;
>>>       }
>>>   -
>>>       job->hwctx = hwctx;
>>>       job->mm = current->mm;
>>>   @@ -612,6 +611,8 @@ int amdxdna_drm_submit_cmd_ioctl(struct 
>>> drm_device *dev, void *data, struct drm_
>>>       if (args->ext || args->ext_flags)
>>>           return -EINVAL;
>>>   +    trace_amdxdna_debug_point(current->comm, args->type, "job 
>>> received");
>>> +
>>>       switch (args->type) {
>>>       case AMDXDNA_CMD_SUBMIT_EXEC_BUF:
>>>           return amdxdna_drm_submit_execbuf(client, args);
>>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/ 
>>> amdxdna/amdxdna_ctx.h
>>> index a8557d7e8923..355798687376 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>>> @@ -119,6 +119,7 @@ struct amdxdna_hwctx {
>>>       container_of(j, struct amdxdna_sched_job, base)
>>>     enum amdxdna_job_opcode {
>>> +    DEFAULT_IO,
>>
>> Do you really want this at the beginning of the list?  Doesn't that 
>> break uses of amdxdna_drv_cmd that has the previous indexing?
> 
> *_DEBUG_BO is driver internal use only. Using 0 here to align with our 
> current trace scripts.
> 
> Lizhi
> 
>>
>>>       SYNC_DEBUG_BO,
>>>       ATTACH_DEBUG_BO,
>>>       DETACH_DEBUG_BO,
>>> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/ 
>>> amdxdna/amdxdna_mailbox.c
>>> index 37771bdb24a1..cc8865f4e79c 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
>>> @@ -361,6 +361,7 @@ static void mailbox_rx_worker(struct work_struct 
>>> *rx_work)
>>>       int ret;
>>>         mb_chann = container_of(rx_work, struct mailbox_channel, 
>>> rx_work);
>>> +    trace_mbox_rx_worker(MAILBOX_NAME, mb_chann->msix_irq);
>>>         if (READ_ONCE(mb_chann->bad_state)) {
>>>           MB_ERR(mb_chann, "Channel in bad state, work aborted");
>>> diff --git a/include/trace/events/amdxdna.h b/include/trace/events/ 
>>> amdxdna.h
>>> index c6cb2da7b706..71da24267e52 100644
>>> --- a/include/trace/events/amdxdna.h
>>> +++ b/include/trace/events/amdxdna.h
>>> @@ -30,26 +30,30 @@ TRACE_EVENT(amdxdna_debug_point,
>>>   );
>>>     TRACE_EVENT(xdna_job,
>>> -        TP_PROTO(struct drm_sched_job *sched_job, const char *name, 
>>> const char *str, u64 seq),
>>> +        TP_PROTO(struct drm_sched_job *sched_job, const char *name,
>>> +             const char *str, u64 seq, u32 op),
>>>   -        TP_ARGS(sched_job, name, str, seq),
>>> +        TP_ARGS(sched_job, name, str, seq, op),
>>>             TP_STRUCT__entry(__string(name, name)
>>>                    __string(str, str)
>>>                    __field(u64, fence_context)
>>>                    __field(u64, fence_seqno)
>>> -                 __field(u64, seq)),
>>> +                 __field(u64, seq)
>>> +                 __field(u32, op)),
>>>             TP_fast_assign(__assign_str(name);
>>>                  __assign_str(str);
>>>                  __entry->fence_context = sched_job->s_fence- 
>>> >finished.context;
>>>                  __entry->fence_seqno = sched_job->s_fence- 
>>> >finished.seqno;
>>> -               __entry->seq = seq;),
>>> +               __entry->seq = seq;
>>> +               __entry->op = op;),
>>>   -        TP_printk("fence=(context:%llu, seqno:%lld), %s seq#:%lld 
>>> %s",
>>> +        TP_printk("fence=(context:%llu, seqno:%llu), %s seq#:%llu 
>>> %s, op=%u",
>>>                 __entry->fence_context, __entry->fence_seqno,
>>>                 __get_str(name), __entry->seq,
>>> -              __get_str(str))
>>> +              __get_str(str),
>>> +              __entry->op)
>>>   );
>>>     DECLARE_EVENT_CLASS(xdna_mbox_msg,
>>> @@ -81,18 +85,28 @@ DEFINE_EVENT(xdna_mbox_msg, mbox_set_head,
>>>            TP_ARGS(name, chann_id, opcode, id)
>>>   );
>>>   -TRACE_EVENT(mbox_irq_handle,
>>> -        TP_PROTO(char *name, int irq),
>>> +DECLARE_EVENT_CLASS(xdna_mbox_name_id,
>>> +            TP_PROTO(char *name, int irq),
>>>   -        TP_ARGS(name, irq),
>>> +            TP_ARGS(name, irq),
>>>   -        TP_STRUCT__entry(__string(name, name)
>>> -                 __field(int, irq)),
>>> +            TP_STRUCT__entry(__string(name, name)
>>> +                     __field(int, irq)),
>>>   -        TP_fast_assign(__assign_str(name);
>>> -               __entry->irq = irq;),
>>> +            TP_fast_assign(__assign_str(name);
>>> +                   __entry->irq = irq;),
>>> +
>>> +            TP_printk("%s.%d", __get_str(name), __entry->irq)
>>> +);
>>> +
>>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_irq_handle,
>>> +         TP_PROTO(char *name, int irq),
>>> +         TP_ARGS(name, irq)
>>> +);
>>>   -        TP_printk("%s.%d", __get_str(name), __entry->irq)
>>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_rx_worker,
>>> +         TP_PROTO(char *name, int irq),
>>> +         TP_ARGS(name, irq)
>>>   );
>>>     #endif /* !defined(_TRACE_AMDXDNA_H) || 
>>> defined(TRACE_HEADER_MULTI_READ) */
>>

