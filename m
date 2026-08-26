Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C0BC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9252B10EA5A;
	Wed, 26 Aug 2026 18:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="P5/1p3nd";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-133.mta0.migadu.com [91.218.175.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41F910EA5A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:07:39 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=BBuko6an2w0X6q2dChjyrfTu0qhdoAlAoQ59/MakflY=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787767657; v=1; x=1788372457;
 b=P5/1p3ndxJzcWgjzB/IBkbJtTwy8kuVmSgkr8m4243M3zsLdmfO+91nZLGuJEGvtHkVjapFk
 n5rxVGn80NIB0LYxkF2/8gRu0L22R4VxC+QXqYGS190kJ9srJcig1dTAQk9qoXiVA8jkDamwcQx
 pCy4pBBTLKFDsXDRr5FEJvsKNOlirtuno8cwLTVFrmJx95w6OjFVG6P7NGGBeiPgp7/OUAPVmtW
 08A13X6kU8LbNQKBo3Egwmbm9734EDgh0PssMYk098x4zzpvgu/fiQc+lwpyxcDHCxn5QKLGJJw
 RBWgdyVgRCzkb7qRzcv8tvCZXLOECracadnWM4WjYP8cA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from [172.19.0.1] (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 5b995b02bc876705;
 Wed, 26 Aug 2026 18:07:27 +0000
X-Mizu-Trace-ID: 5b995b02bc876705
X-Migadu-Flow: FLOW_OUT
Message-ID: <1737ea78-0056-46ec-8283-45013d93dc92@kaitmazov.com>
Date: Wed, 26 Aug 2026 21:07:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/amdxdna: make the debug BO command wait
 interruptible
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260826150726.126296-1-taimuraz@kaitmazov.com>
 <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
Content-Language: en-US
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
In-Reply-To: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
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

I found out about that fix only after I had created this patch, but I 
still want to state that the fix is not full: it unwedges the device, 
but not the tasks already waiting. Those stay in an uninterruptible 
wait, holding the debug BO and the command, and cannot be killed. 
tdr_timeout_ms bounds that at 2 s by default; with tdr_timeout_ms=0 it 
is unbounded.

I am still researching whether any race conditions can happen in the 
current driver state.

Taimuraz

On 8/26/26 20:34, Lizhi Hou wrote:
> On 8/26/26 08:07, Taimuraz Kaitmazov wrote:
>> aie2_cmd_wait() waits with dma_fence_wait_timeout(..., false,
>> MAX_SCHEDULE_TIMEOUT): uninterruptible and unbounded. Both callers reach
>> it from an ioctl holding xdna->dev_lock, and the only thing that can
>> signal the fence when firmware does not answer is
>> aie2_sched_job_timedout(), which takes that same lock. A debug BO 
>> command
>> that never completes therefore blocks the ioctl forever, leaves the task
>> unkillable, and stalls every other ioctl on the device behind dev_lock.
>>
>> Wait interruptibly and propagate the result. This does not remove the
>> lock dependency, it makes it survivable.
>
> This is fixed by 
> https://lore.kernel.org/all/20260707055732.479103-1-lizhi.hou@amd.com/
>
> could you sync to drm-misc-fixes or the latest upstream kernel?
>
> Thanks,
>
> Lizhi
>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 54486960cbf5..1f910ee4941c 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -897,17 +897,20 @@ static int aie2_hwctx_cu_config(struct 
>> amdxdna_hwctx *hwctx, void *buf, u32 size
>>       return ret;
>>   }
>>   -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>>   {
>>       struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
>> +    long ret;
>>         if (!out_fence) {
>>           XDNA_ERR(hwctx->client->xdna, "Failed to get fence");
>> -        return;
>> +        return -EINVAL;
>>       }
>>   -    dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
>> +    ret = dma_fence_wait_timeout(out_fence, true, 
>> MAX_SCHEDULE_TIMEOUT);
>>       dma_fence_put(out_fence);
>> +
>> +    return ret < 0 ? ret : 0;
>>   }
>>     static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, 
>> u32 bo_hdl,
>> @@ -954,7 +957,10 @@ static int aie2_hwctx_cfg_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 bo_hdl,
>>           goto put_cmd;
>>       }
>>   -    aie2_cmd_wait(hwctx, seq);
>> +    ret = aie2_cmd_wait(hwctx, seq);
>> +    if (ret)
>> +        goto put_cmd;
>> +
>>       if (cmd->result) {
>>           XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>>           ret = -EINVAL;
>> @@ -1014,7 +1020,10 @@ int aie2_hwctx_sync_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>>           goto put_cmd;
>>       }
>>   -    aie2_cmd_wait(hwctx, seq);
>> +    ret = aie2_cmd_wait(hwctx, seq);
>> +    if (ret)
>> +        goto put_cmd;
>> +
>>       if (cmd->result) {
>>           XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>>           ret = -EINVAL;
