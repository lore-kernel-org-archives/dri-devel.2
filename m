Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0392CCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 18:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1496A88130;
	Wed,  3 Jun 2026 18:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FPn/you4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF2011226A
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 18:34:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F36CB600AE;
 Wed,  3 Jun 2026 18:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8961F00893;
 Wed,  3 Jun 2026 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780511667;
 bh=p9ETdBbN6u+XpLalAf4ddIO0WGDtQDH1OrZzSHmBy/4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FPn/you4rWmcmnRWCoLbeBkMKfZYmlCz+MVriT4ExjdWTPax/zIpygiR8gzgZhb5W
 +eXR+uLdyZix3sugTkrJvNOdYDlA4X8NF+8k2txP6T6FV6eaW3IARpaFG+PYk05hBm
 /+Ql9GLt3P/UwtNLUji7eGf0yv2mSItO4ZZsqkPLBjQXK19xyM4ZwpbTCcjYyaBYXc
 IPjGPFY0b1U11cl3srKW0g6+BLDw21HE2EM9N22p6Pp3bp0iC2FmnOUo9B1NCoq/eq
 lFcJCEtuv+sgrTiCf0GdpqA/43vXusdJJzn0Nauy40+Kf/jWPju20LpQ7YVpuk3H9j
 Rm35ma6CLTc1Q==
Message-ID: <0508697c-d9b6-4691-beaa-d5ea81248cc7@kernel.org>
Date: Wed, 3 Jun 2026 13:34:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Remove drv_cmd tracing from job free
 callback
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260529152837.1973405-1-lizhi.hou@amd.com>
 <dd84217b-d0b0-42b0-b822-cb897b6f71a8@amd.com>
 <f8cce943-4f7b-04e9-8596-fc652ad22398@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <f8cce943-4f7b-04e9-8596-fc652ad22398@amd.com>
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



On 6/1/26 10:18, Lizhi Hou wrote:
> 
> On 5/31/26 07:18, Mario Limonciello wrote:
>>
>>
>> On 5/29/26 17:28, Lizhi Hou wrote:
>>> aie2_sched_job_free() accesses job->drv_cmd for tracing purposes. 
>>> However,
>>> job->drv_cmd is owned by the caller and may already have been freed when
>>> the job free callback runs, leading to a potential use-after-free.
>>>
>>> Remove the job->drv_cmd access from aie2_sched_job_free().
>>>
>>> Fixes: 8711eb2dde2e ("accel/amdxdna: Improve tracing for job 
>>> lifecycle and mailbox RX worker")
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>   drivers/accel/amdxdna/aie2_ctx.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/ 
>>> amdxdna/aie2_ctx.c
>>> index 658a5fb1fda6..2ad343728782 100644
>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>> @@ -437,8 +437,9 @@ static void aie2_sched_job_free(struct 
>>> drm_sched_job *sched_job)
>>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>>   +    /* job->drv_cmd could be freed, so use DEFAULT_IO */
>>>       trace_xdna_job(sched_job, hwctx->name, "job free",
>>> -               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>> DEFAULT_IO);
>>> +               job->seq, DEFAULT_IO);
>>
>> Could this still be a race with dov->drv_cmd being valid when the 
>> first part of the expression is evaluated (job->drv_cmd) but invalid 
>> when job->drv_cmd->opcode is accessed?
> 
> When aie2_sched_job_free() is called, the job->drv_cmd could already be 
> freed. So it should never access job->drv_cmd at all. The entire 
> expression "job->drv_cmd ? job->drv_cmd->opcode :  DEFAULT_IO" is removed.
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Lizhi
> 
>>
>>>       if (!job->job_done)
>>>           up(&hwctx->priv->job_sem);
>>

