Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6391EF94CBE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 15:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FC310EA4F;
	Wed, 22 Apr 2026 15:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kV9FPQEr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9AB10EA4F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 15:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAQoDVrv6EkY+Ah0sn3G0CcOsBRNppMxtDHUGxiPQbqL7ZxZwNEJLb0VDA9flJALVjZYO1bcsXM4JnDiCWEw6Y9rGHcaykDS9bEM7Kkw2txes7vhI9UBrDUyc5xFzKMysbdWTiasju2nVT1bwIfU7g6qFMq+BkmLVjE+uQuKJtieys5zXPlMbwZhOfW4f3rcGlXc9cBa+wlS7YpLdpMyY9VI3pcFKkD8JMpD3FVhr/mw3/0hMHUSVUp8XngA6vOrs4gceTMxlBcJ/JRY6nnNT8VtJsK/VhG5/TTn48KugDH4UyQc+5Wsplk7lRcQJYWHpLe2nv/N2kS3VnNxcdXaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ESkB3fnWp5MBQDEQl+a8WDYjYYe5CozTNi3WB0E8Xo=;
 b=x3vjIxOIp4MBxoQmy4SYVP2e7l8oIkDoe/kRIBEKv8QWselPsQm0RFu7Y4QhzUxr0XNyYqd5nz2Gjj5O3TVwIfIZo2PyvihPGwShDowTBPdx9hMFIzpbdBBmaW9/bpIry2CJp9IKGO+UtyKxxR9tZSoTgO4wtRL1V+gyE4/TRztzoMGxIAr7fvPU2lwXP9dpna7hD383grOk6FdpJGIPQc/DjH9+slQaML9FwDA4rbUL/kz12z3LAf7LLQEoWrKEGZsLZwNNTuNqdYZ4jkGHvw30hQEF55o2fajy7g58jZPnzLnpxbHbAgMgSW/2i8aegG1gmnsrXLeoj6JBFlHvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ESkB3fnWp5MBQDEQl+a8WDYjYYe5CozTNi3WB0E8Xo=;
 b=kV9FPQEr4EOG5KiKUShHa+gNlBM6P5w/Z9MVly1JuMfNsHN/PRRa3TjDTql23WCvCfT75XZR/l3jh6Fzs6H3LiVDVR+5q+rxUU0FkkE+FhERr9qJ9k7TJ6dSyA7v+4c6JMmo9ddOH1vQfQ0EPX8xT/rnjj0J7PCkJYCkzrT6Bhw=
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 15:38:20 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::93) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 15:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 15:38:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 10:38:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 10:38:19 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 10:38:18 -0500
Message-ID: <a405d199-2ce2-c8ed-3ede-4c9495b2d7da@amd.com>
Date: Wed, 22 Apr 2026 08:38:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Improve tracing for job lifecycle and
 mailbox RX worker
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260421181502.1970263-1-lizhi.hou@amd.com>
 <83846da8-0c8f-4eca-bac9-08efe1c0eb2f@amd.com>
 <9bca1ecd-ce16-2703-3a0d-6db208c83b06@amd.com>
 <f3d1b859-e5f2-468c-b957-fc3686457213@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <f3d1b859-e5f2-468c-b957-fc3686457213@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d82da5-1925-47c0-8273-08dea0852e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1XWd726+zqZr4YAHL+qkKnUDXTwsGV85hLSHnWmrUZsAlwUufdfmLJsXnWh+/9ThFheI/q/YlVVYSm09/nJkmUo4GpxFVRciVEVAictc+/huED5G/MrqV4YNuwGNzclaQX2Bjk1hiWxcqkNaWjX7uQPA4YlAGKxGRJdHeZOjMQ7hcKW9eQ7UDeoJh7YSxjoxgZaJHVc7s//SMPM3tTlxdYzXasXjExl/Gk/ZNxPhxh37D1jQkNJDOzt8yq5OKsKjWEuseNfmeAvnKT232fnj+5eyHevtL65M7Hx/lUCdo8uTWhOK1aUiMkMiXQCT8JlxmRkBt1buFDkkUVX3bdfpMYk24xN8vvpNrngWhrpV+GLxbZnT6nAFeC08J5Nv3lVHfxmTtygO9n7tyj5OpJF6XI85h0uWvtrO/oJKQVP1Xe6dIvu+2NswtRNiviMwSir9Q66u4FFNIbsHnXNCiUhxNDpHkOWNawO8oAKvbe7eaRN4W2oT3phoB9irRIoKMr3Kl7iH90eAqGtEOgKj+MEPgfvoAyGtM4TurXoTlgJhQqtxep1jQoAzV9T7jkCJta8OmtxqejEjm8reFV7RN9y6NfXmmlSGfZVOb8jPfO4t7jbeWIhghh+15/lKdSf1cMb/uXY9g4cZTy/yLtZZ3qmevWO8r4Sum6F/cQXH347Bk8vZZRod+EEEYzfWuuEXLM1GNCdTQ3TKbOAk4VNwovqAGuCbpYxT5tO0TItMzXVQ2uwc5dBR7GhTyY1WACx46qnL+d71o1IhOoLCQ2lbK3OgsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KVvPVeB5bDH83tKOtrR8/yb7tiZ3wyzqhBL3mpJJrFMXIlUESoUJjykdFiSrJx8AkuIiu9lILH2WWUVyFz6RAtWkGFFkJU7gOKFHaSocoMMVKfIkeocP2fyn8hTin56oM4vsVUfrdGbG4YG6p5AOzSzP0mh1b3efLacSljF2BAxWxPurXXW/U4l6zCv/eLF+pl43t3BL9GYpCnlO1MU97An0nID4aFqJyRGWZZEmKSmKo8n6W1fNF3qMUHOt0jjYc2HaYawB0FrrMyNEcbKK01JYv7uutH1bBjzoEJMypi3iglTB+D/dS5+TUEAPor/XiTcfp46No1buBo5Czu2fbCbFXUKpb3DjZtGbrbKNFZ0kdyF2IhrFYz6S2iwamPrPF8h9iwKdmVY8vw2pq19lBA3WU6MyQGGtRc44OPS1VHQh3TWpx+42l4WcKooLQuU4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:38:19.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d82da5-1925-47c0-8273-08dea0852e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
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

Applied to drm-misc-next

On 4/21/26 12:45, Mario Limonciello wrote:
>
>
> On 4/21/26 14:39, Lizhi Hou wrote:
>>
>> On 4/21/26 12:18, Mario Limonciello wrote:
>>>
>>>
>>> On 4/21/26 13:15, Lizhi Hou wrote:
>>>> From: Max Zhen <max.zhen@amd.com>
>>>>
>>>> Add more trace coverage to amdxdna job handling and mailbox receive
>>>> processing to make driver execution easier to debug.
>>>>
>>>> Extend the xdna_job trace event to record the command opcode in
>>>> addition to the job sequence number. Use the enhanced tracepoint in
>>>> the job run, sent-to-device, signaled-fence, and job-free paths so
>>>> that trace output can be correlated with the command being executed.
>>>>
>>>> Also add debug-point tracing when a command is received through the
>>>> submit ioctl path, and add a trace event when the mailbox RX worker
>>>> runs.
>>>>
>>>> These changes improve visibility into job lifetime transitions and
>>>> mailbox activity, which helps debug command flow and scheduler issues.
>>>>
>>>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>>   drivers/accel/amdxdna/aie2_ctx.c        | 14 ++++++---
>>>>   drivers/accel/amdxdna/amdxdna_ctx.c     |  3 +-
>>>>   drivers/accel/amdxdna/amdxdna_ctx.h     |  1 +
>>>>   drivers/accel/amdxdna/amdxdna_mailbox.c |  1 +
>>>>   include/trace/events/amdxdna.h          | 42 
>>>> ++++++++++++++++---------
>>>>   5 files changed, 42 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/ 
>>>> amdxdna/aie2_ctx.c
>>>> index d37123d925b6..3b0feba448c4 100644
>>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>>> @@ -64,6 +64,7 @@ static void aie2_job_release(struct kref *ref)
>>>>       struct amdxdna_sched_job *job;
>>>>         job = container_of(ref, struct amdxdna_sched_job, refcnt);
>>>> +
>>>>       amdxdna_sched_job_cleanup(job);
>>>>       atomic64_inc(&job->hwctx->job_free_cnt);
>>>>       wake_up(&job->hwctx->priv->job_free_wq);
>>>> @@ -195,7 +196,8 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>>>   {
>>>>       struct dma_fence *fence = job->fence;
>>>>   -    trace_xdna_job(&job->base, job->hwctx->name, "signaled 
>>>> fence", job->seq);
>>>> +    trace_xdna_job(&job->base, job->hwctx->name, "signaling fence",
>>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>>> DEFAULT_IO);
>>>>         aie2_tdr_signal(job->hwctx->client->xdna);
>>>>       job->hwctx->priv->completed++;
>>>> @@ -366,6 +368,9 @@ aie2_sched_job_run(struct drm_sched_job 
>>>> *sched_job)
>>>>       struct dma_fence *fence;
>>>>       int ret;
>>>>   +    trace_xdna_job(sched_job, hwctx->name, "job run",
>>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>>> DEFAULT_IO);
>>>> +
>>>>       if (!hwctx->priv->mbox_chann)
>>>>           return NULL;
>>>>   @@ -409,7 +414,8 @@ aie2_sched_job_run(struct drm_sched_job 
>>>> *sched_job)
>>>>       } else {
>>>>           aie2_tdr_signal(hwctx->client->xdna);
>>>>       }
>>>> -    trace_xdna_job(sched_job, hwctx->name, "sent to device", 
>>>> job->seq);
>>>> +    trace_xdna_job(sched_job, hwctx->name, "sent to device",
>>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>>> DEFAULT_IO);
>>>>         return fence;
>>>>   }
>>>> @@ -419,7 +425,8 @@ static void aie2_sched_job_free(struct 
>>>> drm_sched_job *sched_job)
>>>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>>>   -    trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
>>>> +    trace_xdna_job(sched_job, hwctx->name, "job free",
>>>> +               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>>> DEFAULT_IO);
>>>>       if (!job->job_done)
>>>>           up(&hwctx->priv->job_sem);
>>>>   @@ -437,7 +444,6 @@ aie2_sched_job_timedout(struct drm_sched_job 
>>>> *sched_job)
>>>>       int ret;
>>>>         xdna = hwctx->client->xdna;
>>>> -    trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>>>>         guard(mutex)(&xdna->dev_lock);
>>>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/ 
>>>> amdxdna/amdxdna_ctx.c
>>>> index ff6c3e8e5a15..2c2c21992c87 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>>>> @@ -514,7 +514,6 @@ int amdxdna_cmd_submit(struct amdxdna_client 
>>>> *client,
>>>>           goto unlock_srcu;
>>>>       }
>>>>   -
>>>>       job->hwctx = hwctx;
>>>>       job->mm = current->mm;
>>>>   @@ -612,6 +611,8 @@ int amdxdna_drm_submit_cmd_ioctl(struct 
>>>> drm_device *dev, void *data, struct drm_
>>>>       if (args->ext || args->ext_flags)
>>>>           return -EINVAL;
>>>>   +    trace_amdxdna_debug_point(current->comm, args->type, "job 
>>>> received");
>>>> +
>>>>       switch (args->type) {
>>>>       case AMDXDNA_CMD_SUBMIT_EXEC_BUF:
>>>>           return amdxdna_drm_submit_execbuf(client, args);
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/ 
>>>> amdxdna/amdxdna_ctx.h
>>>> index a8557d7e8923..355798687376 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>>>> @@ -119,6 +119,7 @@ struct amdxdna_hwctx {
>>>>       container_of(j, struct amdxdna_sched_job, base)
>>>>     enum amdxdna_job_opcode {
>>>> +    DEFAULT_IO,
>>>
>>> Do you really want this at the beginning of the list?  Doesn't that 
>>> break uses of amdxdna_drv_cmd that has the previous indexing?
>>
>> *_DEBUG_BO is driver internal use only. Using 0 here to align with 
>> our current trace scripts.
>>
>> Lizhi
>>
>>>
>>>>       SYNC_DEBUG_BO,
>>>>       ATTACH_DEBUG_BO,
>>>>       DETACH_DEBUG_BO,
>>>> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c 
>>>> b/drivers/accel/ amdxdna/amdxdna_mailbox.c
>>>> index 37771bdb24a1..cc8865f4e79c 100644
>>>> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
>>>> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
>>>> @@ -361,6 +361,7 @@ static void mailbox_rx_worker(struct 
>>>> work_struct *rx_work)
>>>>       int ret;
>>>>         mb_chann = container_of(rx_work, struct mailbox_channel, 
>>>> rx_work);
>>>> +    trace_mbox_rx_worker(MAILBOX_NAME, mb_chann->msix_irq);
>>>>         if (READ_ONCE(mb_chann->bad_state)) {
>>>>           MB_ERR(mb_chann, "Channel in bad state, work aborted");
>>>> diff --git a/include/trace/events/amdxdna.h b/include/trace/events/ 
>>>> amdxdna.h
>>>> index c6cb2da7b706..71da24267e52 100644
>>>> --- a/include/trace/events/amdxdna.h
>>>> +++ b/include/trace/events/amdxdna.h
>>>> @@ -30,26 +30,30 @@ TRACE_EVENT(amdxdna_debug_point,
>>>>   );
>>>>     TRACE_EVENT(xdna_job,
>>>> -        TP_PROTO(struct drm_sched_job *sched_job, const char 
>>>> *name, const char *str, u64 seq),
>>>> +        TP_PROTO(struct drm_sched_job *sched_job, const char *name,
>>>> +             const char *str, u64 seq, u32 op),
>>>>   -        TP_ARGS(sched_job, name, str, seq),
>>>> +        TP_ARGS(sched_job, name, str, seq, op),
>>>>             TP_STRUCT__entry(__string(name, name)
>>>>                    __string(str, str)
>>>>                    __field(u64, fence_context)
>>>>                    __field(u64, fence_seqno)
>>>> -                 __field(u64, seq)),
>>>> +                 __field(u64, seq)
>>>> +                 __field(u32, op)),
>>>>             TP_fast_assign(__assign_str(name);
>>>>                  __assign_str(str);
>>>>                  __entry->fence_context = sched_job->s_fence- 
>>>> >finished.context;
>>>>                  __entry->fence_seqno = sched_job->s_fence- 
>>>> >finished.seqno;
>>>> -               __entry->seq = seq;),
>>>> +               __entry->seq = seq;
>>>> +               __entry->op = op;),
>>>>   -        TP_printk("fence=(context:%llu, seqno:%lld), %s 
>>>> seq#:%lld %s",
>>>> +        TP_printk("fence=(context:%llu, seqno:%llu), %s seq#:%llu 
>>>> %s, op=%u",
>>>>                 __entry->fence_context, __entry->fence_seqno,
>>>>                 __get_str(name), __entry->seq,
>>>> -              __get_str(str))
>>>> +              __get_str(str),
>>>> +              __entry->op)
>>>>   );
>>>>     DECLARE_EVENT_CLASS(xdna_mbox_msg,
>>>> @@ -81,18 +85,28 @@ DEFINE_EVENT(xdna_mbox_msg, mbox_set_head,
>>>>            TP_ARGS(name, chann_id, opcode, id)
>>>>   );
>>>>   -TRACE_EVENT(mbox_irq_handle,
>>>> -        TP_PROTO(char *name, int irq),
>>>> +DECLARE_EVENT_CLASS(xdna_mbox_name_id,
>>>> +            TP_PROTO(char *name, int irq),
>>>>   -        TP_ARGS(name, irq),
>>>> +            TP_ARGS(name, irq),
>>>>   -        TP_STRUCT__entry(__string(name, name)
>>>> -                 __field(int, irq)),
>>>> +            TP_STRUCT__entry(__string(name, name)
>>>> +                     __field(int, irq)),
>>>>   -        TP_fast_assign(__assign_str(name);
>>>> -               __entry->irq = irq;),
>>>> +            TP_fast_assign(__assign_str(name);
>>>> +                   __entry->irq = irq;),
>>>> +
>>>> +            TP_printk("%s.%d", __get_str(name), __entry->irq)
>>>> +);
>>>> +
>>>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_irq_handle,
>>>> +         TP_PROTO(char *name, int irq),
>>>> +         TP_ARGS(name, irq)
>>>> +);
>>>>   -        TP_printk("%s.%d", __get_str(name), __entry->irq)
>>>> +DEFINE_EVENT(xdna_mbox_name_id, mbox_rx_worker,
>>>> +         TP_PROTO(char *name, int irq),
>>>> +         TP_ARGS(name, irq)
>>>>   );
>>>>     #endif /* !defined(_TRACE_AMDXDNA_H) || 
>>>> defined(TRACE_HEADER_MULTI_READ) */
>>>
>
