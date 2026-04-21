Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C553F94CA8
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C689E10E214;
	Tue, 21 Apr 2026 19:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qp7bz5Bs";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAFA10E16B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 19:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J060sd3xHfOgOllck+P3WAbUq0J2IsARGZsYhEjN3UEJwM+6IyX1Kfk1it7fLrJvruwZBMDO8ETHHk0lAug0QSAbPQp1YBmbSraRt1FgTEchWeGlgJnXvP3UtJigc6B1+I3gRV+aThKodfBDRlpydl8jSjlLO/CCRVWcfW/Df+u2PxHAWqHuKFQNTMU/04mSbcLREkZncBgHVa7sJiSdMHVmtllVKIXKQ4uUnxkpgFOKhGaWmksK+5NiqTUZBVFevs54ZzP7A3PokTzAoKEx3VfL05gb3USH4y9I0rKvXycXiduSSWCKP6ACU8xINEmjGW/JBt9ACI39nDHC3G2/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYQL1dQZTLop6GXqeRp1aQqikMZTPVlybqVvKnMvLl8=;
 b=CkHgC8UfLdRqa65WMFg/qVjxIiQ67fxJNz8G+9bdi87LFZFdS62vHEKPg3aDUmdxrEhUfA2AAX3z5EQzJOMfheILrYzE9koKPWmeiXKEHNsESs0+sx4uOq8nQ4Py3otDhk8nSnu3NSjOtVE5AOqEsxHET9vXcPvCUCYwojcIJTGmZzQnzJ163xFomrJ8sistjKN4JghAyXkn3WB2jrJXvPmi/W5VSAzDS2JWdgDq1uNU/AqrjzhjmCfxsqxbljEjJuhmuLXHk/bnBd8nN8Nru5QYveP/VNheIVp+tmVU0tnCTtTA71UEMdwejysrE0U9EwSJ/VuRtu2XgZeuC+oA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYQL1dQZTLop6GXqeRp1aQqikMZTPVlybqVvKnMvLl8=;
 b=Qp7bz5BsMIAFm0skavbaEoxxLvrG7NL5TW2yme7P8JR080pKlafUN5uC1ASaQbP62oIIWZFLIY4eG0jcja/t2xfhbOQtuD/QuVzhhvDQPVC71bdak+kMHvTjPWxZkXlNZpz5np9Vo+6g3tW7fbRKSxgooZgE1XrdIik42VCnVVs=
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:40:00 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::b9) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 19:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 19:40:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 14:39:59 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 14:39:59 -0500
Message-ID: <9bca1ecd-ce16-2703-3a0d-6db208c83b06@amd.com>
Date: Tue, 21 Apr 2026 12:39:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Improve tracing for job lifecycle and
 mailbox RX worker
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260421181502.1970263-1-lizhi.hou@amd.com>
 <83846da8-0c8f-4eca-bac9-08efe1c0eb2f@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <83846da8-0c8f-4eca-bac9-08efe1c0eb2f@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f15508-d905-47a1-8406-08de9fddc6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fxvgkh1QcTRAoyA1uOfmC4aMZHKfBBZUYQeOqWcxzwzO6kk5yuLX2gjVFMQZziDM0K5C+41nUC980xdocSrLeezmGnCayEEL5pv33vURcGWOp9CAUchPmyXgvy6K/DbLSpFo5n8QopYeS99UPOO2/cLC8zU2qf5fMCBF+gXrXlx29dX9NMLQnGHBxOfEpKhniLhRcAX5CCseEFr9Jx3/raV6PvCwh9HHp3VjQtqS8K2rmeOv/UlMrmoe/nRiVJJgapqsQGv5ZIk3lVfrhZiQpmOGTL+sqIpahoGcJJ9uaM5A9Rm+f9lBcj55BYcDn1lK1B+yeAghFVxEUN9KC7XzaPLZgmJQ8GvWKHtFlg/PYZIZDeJBCVwikmVCW5P16XwgzQ7EETg0SXDjc+m2aBEm+QmD5whPADAKWGYP9CaBLHh0Tr/8/vP67jOQg1CWHFvDFFflcE3GCEgs4o+otH66/IKuCKrpf1T14R4DQYkbSvS6XP+SaGOqg6fnDxp7nPiBXtxJ9JqwS4B5PZ2nkDScacXwuaq77n/Iq+VQbQ7FyF06Atrwt+kmzRx9butQSNYSM55SqD/jVNjBHzZtKXJ45yvvoAECcbgRtDt+ku1TrYqkCfjlxsEsjyBbgcZBv+qE6x4xKfLyRcjB5p2CYPPq0gJqC19bB8btGNYFChKdjQH4atknWCCo7jKlMQAnLoroncrwELR/L+YmGsRbelIb0aCkNH32p4Ng4uic7Qju5T4AnSFFW0cXMTW1dAAoSmwc0nDqA9t2CnN2YSYC41sD+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TocwK+8pW8dHcFqpr3h0jRkNmO7f9nkZxT1bBAEWx61rGSaNdpjk7iLDyY+LWTx2rXnO62W4CQSFSSwN9B7BCv/nkBLDFE53JXN+ookLF+kvAfb2an+cCNFoXTSxZ3X4oh6GpAczNUEj3vSjdytZLp4i9oGO19sO+w7nsWupZRLCih7/7Q9sQd4s474o95N4BiHLRd+jefVnHP1UZ5whD//wMJAuzBpn+9sDuvxl61x+/jYVp6SzVxFyH0tux6LvR1cHX+v1noXAR7A2r0Ucrk9iGYJdTxFpEY7rjF47O1fRvWeuCIHBL8uFQbOtmb++pqopZ4BqSSYCVgeloE4zbSEifVQIlc0VBbeEhnUeooZ4wAsI3pCQtjknuTVI203TZHP/rOv0HuFrbnjUum0zXNSm2labaqLGsX4eJb3UlaOKiiKY3wpwP4Hry79PkVgZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 19:40:00.1849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f15508-d905-47a1-8406-08de9fddc6a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
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


On 4/21/26 12:18, Mario Limonciello wrote:
>
>
> On 4/21/26 13:15, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> Add more trace coverage to amdxdna job handling and mailbox receive
>> processing to make driver execution easier to debug.
>>
>> Extend the xdna_job trace event to record the command opcode in
>> addition to the job sequence number. Use the enhanced tracepoint in
>> the job run, sent-to-device, signaled-fence, and job-free paths so
>> that trace output can be correlated with the command being executed.
>>
>> Also add debug-point tracing when a command is received through the
>> submit ioctl path, and add a trace event when the mailbox RX worker
>> runs.
>>
>> These changes improve visibility into job lifetime transitions and
>> mailbox activity, which helps debug command flow and scheduler issues.
>>
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c        | 14 ++++++---
>>   drivers/accel/amdxdna/amdxdna_ctx.c     |  3 +-
>>   drivers/accel/amdxdna/amdxdna_ctx.h     |  1 +
>>   drivers/accel/amdxdna/amdxdna_mailbox.c |  1 +
>>   include/trace/events/amdxdna.h          | 42 ++++++++++++++++---------
>>   5 files changed, 42 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index d37123d925b6..3b0feba448c4 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -64,6 +64,7 @@ static void aie2_job_release(struct kref *ref)
>>       struct amdxdna_sched_job *job;
>>         job = container_of(ref, struct amdxdna_sched_job, refcnt);
>> +
>>       amdxdna_sched_job_cleanup(job);
>>       atomic64_inc(&job->hwctx->job_free_cnt);
>>       wake_up(&job->hwctx->priv->job_free_wq);
>> @@ -195,7 +196,8 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>   {
>>       struct dma_fence *fence = job->fence;
>>   -    trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", 
>> job->seq);
>> +    trace_xdna_job(&job->base, job->hwctx->name, "signaling fence",
>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>> DEFAULT_IO);
>>         aie2_tdr_signal(job->hwctx->client->xdna);
>>       job->hwctx->priv->completed++;
>> @@ -366,6 +368,9 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>>       struct dma_fence *fence;
>>       int ret;
>>   +    trace_xdna_job(sched_job, hwctx->name, "job run",
>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>> DEFAULT_IO);
>> +
>>       if (!hwctx->priv->mbox_chann)
>>           return NULL;
>>   @@ -409,7 +414,8 @@ aie2_sched_job_run(struct drm_sched_job 
>> *sched_job)
>>       } else {
>>           aie2_tdr_signal(hwctx->client->xdna);
>>       }
>> -    trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
>> +    trace_xdna_job(sched_job, hwctx->name, "sent to device",
>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>> DEFAULT_IO);
>>         return fence;
>>   }
>> @@ -419,7 +425,8 @@ static void aie2_sched_job_free(struct 
>> drm_sched_job *sched_job)
>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>   -    trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
>> +    trace_xdna_job(sched_job, hwctx->name, "job free",
>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>> DEFAULT_IO);
>>       if (!job->job_done)
>>           up(&hwctx->priv->job_sem);
>>   @@ -437,7 +444,6 @@ aie2_sched_job_timedout(struct drm_sched_job 
>> *sched_job)
>>       int ret;
>>         xdna = hwctx->client->xdna;
>> -    trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>>         guard(mutex)(&xdna->dev_lock);
>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index ff6c3e8e5a15..2c2c21992c87 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -514,7 +514,6 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>> *client,
>>           goto unlock_srcu;
>>       }
>>   -
>>       job->hwctx = hwctx;
>>       job->mm = current->mm;
>>   @@ -612,6 +611,8 @@ int amdxdna_drm_submit_cmd_ioctl(struct 
>> drm_device *dev, void *data, struct drm_
>>       if (args->ext || args->ext_flags)
>>           return -EINVAL;
>>   +    trace_amdxdna_debug_point(current->comm, args->type, "job 
>> received");
>> +
>>       switch (args->type) {
>>       case AMDXDNA_CMD_SUBMIT_EXEC_BUF:
>>           return amdxdna_drm_submit_execbuf(client, args);
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index a8557d7e8923..355798687376 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -119,6 +119,7 @@ struct amdxdna_hwctx {
>>       container_of(j, struct amdxdna_sched_job, base)
>>     enum amdxdna_job_opcode {
>> +    DEFAULT_IO,
>
> Do you really want this at the beginning of the list?  Doesn't that 
> break uses of amdxdna_drv_cmd that has the previous indexing?

*_DEBUG_BO is driver internal use only. Using 0 here to align with our 
current trace scripts.

Lizhi

>
>>       SYNC_DEBUG_BO,
>>       ATTACH_DEBUG_BO,
>>       DETACH_DEBUG_BO,
>> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c 
>> b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> index 37771bdb24a1..cc8865f4e79c 100644
>> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
>> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> @@ -361,6 +361,7 @@ static void mailbox_rx_worker(struct work_struct 
>> *rx_work)
>>       int ret;
>>         mb_chann = container_of(rx_work, struct mailbox_channel, 
>> rx_work);
>> +    trace_mbox_rx_worker(MAILBOX_NAME, mb_chann->msix_irq);
>>         if (READ_ONCE(mb_chann->bad_state)) {
>>           MB_ERR(mb_chann, "Channel in bad state, work aborted");
>> diff --git a/include/trace/events/amdxdna.h 
>> b/include/trace/events/amdxdna.h
>> index c6cb2da7b706..71da24267e52 100644
>> --- a/include/trace/events/amdxdna.h
>> +++ b/include/trace/events/amdxdna.h
>> @@ -30,26 +30,30 @@ TRACE_EVENT(amdxdna_debug_point,
>>   );
>>     TRACE_EVENT(xdna_job,
>> -        TP_PROTO(struct drm_sched_job *sched_job, const char *name, 
>> const char *str, u64 seq),
>> +        TP_PROTO(struct drm_sched_job *sched_job, const char *name,
>> +             const char *str, u64 seq, u32 op),
>>   -        TP_ARGS(sched_job, name, str, seq),
>> +        TP_ARGS(sched_job, name, str, seq, op),
>>             TP_STRUCT__entry(__string(name, name)
>>                    __string(str, str)
>>                    __field(u64, fence_context)
>>                    __field(u64, fence_seqno)
>> -                 __field(u64, seq)),
>> +                 __field(u64, seq)
>> +                 __field(u32, op)),
>>             TP_fast_assign(__assign_str(name);
>>                  __assign_str(str);
>>                  __entry->fence_context = 
>> sched_job->s_fence->finished.context;
>>                  __entry->fence_seqno = 
>> sched_job->s_fence->finished.seqno;
>> -               __entry->seq = seq;),
>> +               __entry->seq = seq;
>> +               __entry->op = op;),
>>   -        TP_printk("fence=(context:%llu, seqno:%lld), %s seq#:%lld 
>> %s",
>> +        TP_printk("fence=(context:%llu, seqno:%llu), %s seq#:%llu 
>> %s, op=%u",
>>                 __entry->fence_context, __entry->fence_seqno,
>>                 __get_str(name), __entry->seq,
>> -              __get_str(str))
>> +              __get_str(str),
>> +              __entry->op)
>>   );
>>     DECLARE_EVENT_CLASS(xdna_mbox_msg,
>> @@ -81,18 +85,28 @@ DEFINE_EVENT(xdna_mbox_msg, mbox_set_head,
>>            TP_ARGS(name, chann_id, opcode, id)
>>   );
>>   -TRACE_EVENT(mbox_irq_handle,
>> -        TP_PROTO(char *name, int irq),
>> +DECLARE_EVENT_CLASS(xdna_mbox_name_id,
>> +            TP_PROTO(char *name, int irq),
>>   -        TP_ARGS(name, irq),
>> +            TP_ARGS(name, irq),
>>   -        TP_STRUCT__entry(__string(name, name)
>> -                 __field(int, irq)),
>> +            TP_STRUCT__entry(__string(name, name)
>> +                     __field(int, irq)),
>>   -        TP_fast_assign(__assign_str(name);
>> -               __entry->irq = irq;),
>> +            TP_fast_assign(__assign_str(name);
>> +                   __entry->irq = irq;),
>> +
>> +            TP_printk("%s.%d", __get_str(name), __entry->irq)
>> +);
>> +
>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_irq_handle,
>> +         TP_PROTO(char *name, int irq),
>> +         TP_ARGS(name, irq)
>> +);
>>   -        TP_printk("%s.%d", __get_str(name), __entry->irq)
>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_rx_worker,
>> +         TP_PROTO(char *name, int irq),
>> +         TP_ARGS(name, irq)
>>   );
>>     #endif /* !defined(_TRACE_AMDXDNA_H) || 
>> defined(TRACE_HEADER_MULTI_READ) */
>
