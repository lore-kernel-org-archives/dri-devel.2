Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B05EC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DAD910E986;
	Wed, 26 Aug 2026 21:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="x8T3ZE3b";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF3410E986
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:23:20 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=OXMrBtwvyJDesPuXiIW0Wy9dpeReoGFDTEQPcAAIx7o=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787779399; v=1; x=1788384199;
 b=x8T3ZE3b+WvupSvr4rjj/IZTc9/6CZFcuAmgvOQZMkTJRNas6gyiOa2Nz12zQTuqcNopWk1E
 pWq+nRrW3T2yeeI6B5BMSwSrBSPdZyQdT3L2nOd04gp2JxWd8mLons6FO/Co3CLiKlNkTFBGogd
 VMBdOPKPP0ZtZWRzAF52hspK61Zr7NL0KvxbDArsDzeaWV+JI+AX5La8iL7qjVj3S5xWAdjQCYk
 OGfLJ/vdlyTmLbtEyE6bp6u/To5SlibTG2zPtiW1MdUMea3J08FKkS2dbo6OfvWTC/XOPS44p3c
 F7PnoGB1br7ZmCNDi+JAZE9NYGYgfo8Shsayfdf/2JFtg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from [172.19.0.1] (193.42.110.63)
 by smtp.migadu.com with ESMTPS id cf6781e9a90ed6f2;
 Wed, 26 Aug 2026 21:23:09 +0000
X-Mizu-Trace-ID: cf6781e9a90ed6f2
X-Migadu-Flow: FLOW_OUT
Message-ID: <a196e0e3-d830-4e06-8488-72803cf613a7@kaitmazov.com>
Date: Thu, 27 Aug 2026 00:23:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/amdxdna: make the debug BO command wait
 interruptible
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <b7e8caf7-18de-fcbb-ee42-1b49b67b5eef@amd.com>
 <20260826184503.282106-1-taimuraz@kaitmazov.com>
 <fffd0a2c-9cc8-247e-578c-7ddbdf4ee881@amd.com>
Content-Language: en-US
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
In-Reply-To: <fffd0a2c-9cc8-247e-578c-7ddbdf4ee881@amd.com>
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

Thanks for the response. I agree on the design: interrupting the wait 
does not stop the command, so returning from the ioctl while firmware 
still owns the BO trades one problem for another. Dropping this patch.

Still, one more thing which might be useful. The 2 s bound holds only 
while the device is otherwise idle: last_signal_ts is per device and 
refreshed on every dispatch, so a busy neighbour keeps aie2_tdr_detect() 
returning false and the job is never reset. The comment there reasons 
from the per-hwctx credit limit, but the timestamp lives on the device.

Taimuraz

On 8/26/26 23:04, Lizhi Hou wrote:
>
> On 8/26/26 11:45, Taimuraz Kaitmazov wrote:
>> aie2_cmd_wait() waits uninterruptibly and without a timeout. Commit
>> c8d2530791cb ("accel/amdxdna: Fix deadlock on debug BO command timeout")
>> drops dev_lock around that wait, but the callers still hold client_lock,
>> and that one is device wide. So while a debug BO command is outstanding,
>> nobody can open the device, nobody can close their DRM file and exit, 
>> and
>> the module cannot be unloaded.
>
> That is expected. It relies on the 2 seconds timeout to remove the 
> context, kill the job and return. Exiting earlier and allowing other 
> operations like open/close/remove module while firmware is dealing 
> with command may cause other issues. And It should never happen that 
> the command runs more than 2 seconds unless a firmware/hardware issue.
>
>>
>> Normally the scheduler timeout ends it: tdr_timeout_ms defaults to 2000.
>> But with tdr_timeout_ms=0 there is no scheduler timeout at all, the wait
>> never ends, and since it is uninterruptible you cannot even kill the
>> stuck task to get client_lock back.
>
> tdr_timeout_ms is used for debugging. User should never change it.
>
> Lizhi
>
>>
>> So wait interruptibly and pass the result up. I return -EINTR and not
>> -ERESTARTSYS on purpose: the command is still in flight, and a restarted
>> ioctl would just submit a second one.
>>
>> If the wait is interrupted we do not know what firmware did, so
>> aie2_hwctx_cfg_debug_bo() cannot tell whether the BO got attached. It
>> records it as attached, because DETACH is refused for a BO that is not
>> assigned to the context, and the other way round would leave a BO
>> attached in firmware with no way to detach it. 
>> aie2_hwctx_sync_debug_bo()
>> does not touch that state, so it needs nothing here.
>>
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>> v2:
>> - Rebased onto drm-misc-fixes, as you asked. v1 was against
>>    drm-misc-next, which does not carry that commit, so the deadlock
>>    reasoning in its message is gone. Please also disregard my follow-up
>>    question on the v1 thread: it asked which of two shapes you would
>>    prefer, and one of them was what you had already done.
>> - Return -EINTR instead of -ERESTARTSYS.
>> - Record the debug BO as attached when the wait is interrupted.
>> - Leave the !out_fence path returning success as before, so this patch
>>    changes only the wait.
>>
>>   drivers/accel/amdxdna/aie2_ctx.c | 33 +++++++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index b713a57b3a3b..175fceea5c8f 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -908,20 +908,30 @@ static int aie2_hwctx_cu_config(struct 
>> amdxdna_hwctx *hwctx, void *buf, u32 size
>>       return ret;
>>   }
>>   -static void aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>> +static int aie2_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq)
>>   {
>>       struct dma_fence *out_fence = aie2_cmd_get_out_fence(hwctx, seq);
>>       struct amdxdna_dev *xdna = hwctx->client->xdna;
>> +    long ret;
>>         if (!out_fence) {
>>           XDNA_ERR(xdna, "Failed to get fence");
>> -        return;
>> +        return 0;
>>       }
>>         mutex_unlock(&xdna->dev_lock);
>> -    dma_fence_wait_timeout(out_fence, false, MAX_SCHEDULE_TIMEOUT);
>> +    ret = dma_fence_wait_timeout(out_fence, true, 
>> MAX_SCHEDULE_TIMEOUT);
>>       mutex_lock(&xdna->dev_lock);
>>       dma_fence_put(out_fence);
>> +
>> +    /*
>> +     * The command is still in flight. If the ioctl were restarted it
>> +     * would submit a second one.
>> +     */
>> +    if (ret == -ERESTARTSYS)
>> +        return -EINTR;
>> +
>> +    return ret < 0 ? ret : 0;
>>   }
>>     static int aie2_hwctx_cfg_debug_bo(struct amdxdna_hwctx *hwctx, 
>> u32 bo_hdl,
>> @@ -968,7 +978,17 @@ static int aie2_hwctx_cfg_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 bo_hdl,
>>           goto put_cmd;
>>       }
>>   -    aie2_cmd_wait(hwctx, seq);
>> +    ret = aie2_cmd_wait(hwctx, seq);
>> +    if (ret) {
>> +        /*
>> +         * The command may still attach the BO. Record it as attached,
>> +         * or DETACH will refuse it and there is no way back.
>> +         */
>> +        if (attach)
>> +            abo->assigned_hwctx = hwctx->id;
>> +        goto put_cmd;
>> +    }
>> +
>>       if (cmd->result) {
>>           XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>>           ret = -EINVAL;
>> @@ -1028,7 +1048,10 @@ int aie2_hwctx_sync_debug_bo(struct 
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
