Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A15910E292;
	Wed,  1 Jul 2026 22:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tpi/M15P";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1352110E292
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 22:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBBcoWQm2UsSOufTmuMMLCUXVaVtojC6wp0a3xFjAZwNnbOnCUmTQeDd20uGcBi4MJfzdMZW8g6X5+bO/bECO4bdjbwc1oo5FC+KUHH3ISL5ksuNd1tKOZ8GAfWM/kEfUJt7EP501s36pzQ+cOFTE0zmuOj9FP/jpcs5qDfSoElzMuDOykLL20oPsCoeTCx3xpl0aYL1fgbsuPTdDAZ1Z64gOlnJzU7IXYcs14ExHV93gUc9tlrKlc5h49xpcopAlm3bdMFLXAKv3gA3dF0Zg3AGSVjJs3bMURnSnYmNMVJhKqL51Mc6VQwe4fFWql+r/HkU5zD8omz8AQf8lF7IQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP47BSYmKgYiBFS0diBY1Zu53FtdIW8VWzXOg01o4vQ=;
 b=jp2NajADBOJ6cuL8rnlHXuQgqHxj+gn43mr6YGvdDurhpuP2ZeR+XK/l46AYPsQonU7lx3f1h3YGNixtMWECcNL2EpZt2x4AtmHSDwqn0+vM3JNEry2R120cuCI2lBc0nEfFHtt/RcYDaso5RWA79kiNUGhKypwkx+r4W8DEicwvt7dawG0HZ2eLUwHJPfc8jUzwiZVF5iET2uVGk0YMKkWXjfn/kalva1J61z+jawFH07pWSWbCrGhYGkYuSv/q7EcPFm42frtoLoTc3Q9V0aJM2Tgo+eD/MD/a02zsl+5qmJdXMmkPLCw4YLHtE+VX9Vapgo7y4IO/IN4M/UrAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP47BSYmKgYiBFS0diBY1Zu53FtdIW8VWzXOg01o4vQ=;
 b=Tpi/M15PdACfC0afg/bUPT8x20z8DSzy+AIZ0mBhZX1I6KPholl3ybrWGKcWMq9jED9N+3J1LxfQeojYNHDrD5cKD39K8WqYUHmsSD5kVlN8hKAxTTHsXh49I8mybDgbcXigoINWv1oULsIvUojM+xm4a9tS04oVIWjmAXKTylE=
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 22:02:12 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::69) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 22:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 22:02:12 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 17:02:12 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 17:02:11 -0500
Message-ID: <afbddc25-03db-93b4-388b-ca5e0c7edf57@amd.com>
Date: Wed, 1 Jul 2026 15:02:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Fix use-after-free in debug BO command
 handling
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <shuvampandey1@gmail.com>, <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260701155556.663541-1-lizhi.hou@amd.com>
 <9860bb38-5022-4213-9e4e-aecfd6824d04@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <9860bb38-5022-4213-9e4e-aecfd6824d04@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f0bc77-a04b-4589-298f-08ded7bc67b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: PKFF3wJK1gG7n5LK+E1yBSxz7GqN/2pSbLuC9cvMXUUtCpRq2nDIRayNIUexE9BXm2cPHUDTpFvYykYb/fONEG6fxJmgL5lIh6vb44JPLlFjiSKDdoM5aBbvJF7lBSU5WgXvI1qRRE6jGsAHlqXS5ff0YXH2vQul2JS4O107syQfMtXpnFtVSnJ8Gk1QztjdEICp4QP0gFinbqyVVM5YFdtB7FLAniOTBq8WOtfeMV8svbIbRort9GUDpCq3vKKi9pPlN09FCCANtU8htwnGniZoW6Cyt3KYkj3vi0vZMy18IFp53xnVh/Cfg2YMmdwX5lE7nT2+cZdgTOAY/qywpTVQJy4DJsilmvn6PUqQd4WBRajJrcX2MPPd1Jm7B1sHWWkkwn4DegsZyb7tyfprLtLiPO06NRbOJFVJzvKdMXBWAmuY7tXO6IwZYAGSD31YcHCrov0hDYYZdNEh8iDlBTehYm7l9p9O64DlGlMrqYpM00cJUrDh6cSlNgn/USWpnHQa97dCZaB4y0YzkVPc0Wd3h23sL7wP17WW7EL8dxiFTlqLsKFZOcDPp/tIWw6v0sEMxkEi5OMmwyGcXCX5+/TgUBY1D4bDRr6NCOSE9qavNOuTZVVP8mvxD9v3InTrgR5T7V3ccXS+8I5wZJuL8lQC8xpasArD5/DUsHhD4nhsqq+R4rxX3Wd8RMAfV/fSuBPxFkLNyJaz/yZB/CE8mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IKACuuTzMZAt9qdRZeqH2jte+KrrwluopCJP8TqrpvsGB3zC0PyJgFuwrcFg4as2Yscq+AQ3P7CVJGXqlo8xr8D9xyfRvZD1Xa/rguYvDPf3si8M9FLum3o6JvcLhLw0pmtRG8hHjkaCyxLw+K+7Dnl1I9DLT75ZiWPC65A+2V/3tJw5oVoryotRzVOw6uhu7yWLmLkPL+IZod2QA9vnUYUDVRww4d8u6GmuTPbn6HFrolTzNHb1Fo46E+iNN4K8fWfp0NB48KQ2/FJxeEBD4AnW6xl9KQ6KlELrJkwfwcCH39KgaaE2luTyezXoFooM29uPaju9aYERzH7lYhbrpX9MtO2iIIfTcBY0RSzINdfq6h7CsU2vrqR4xIiV32aEWhPTv8cOwSMc1H8330anWdHjxheMn3hguaqL5hE6VmyjqT+RLI4UIavCrK6IXus3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 22:02:12.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f0bc77-a04b-4589-298f-08ded7bc67b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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

Applied to drm-misc-fixes

On 7/1/26 14:28, Mario Limonciello wrote:
>
>
> On 7/1/26 10:55, Lizhi Hou wrote:
>> When a debug BO command completes, job->drv_cmd may already have been
>> freed. Accessing it from aie2_sched_drvcmd_resp_handler() can result in
>> a use-after-free and memory corruption.
>>
>> Fix this by introducing reference counting for drv_cmd objects and
>> transferring ownership to the job while it is in flight. This ensures
>> that the command remains valid until the completion handler finishes
>> processing it.
>>
>> Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviwed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    | 68 +++++++++++++++++++++--------
>>   drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
>>   2 files changed, 51 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 55eb29dece5b..8ec8a4d69b14 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -59,6 +59,18 @@ static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>>       return false;
>>   }
>>   +static void aie2_cmd_release(struct kref *ref)
>> +{
>> +    struct amdxdna_drv_cmd *drv_cmd = container_of(ref, struct 
>> amdxdna_drv_cmd, refcnt);
>> +
>> +    kfree(drv_cmd);
>> +}
>> +
>> +static void aie2_cmd_put(struct amdxdna_drv_cmd *drv_cmd)
>> +{
>> +    kref_put(&drv_cmd->refcnt, aie2_cmd_release);
>> +}
>> +
>>   static void aie2_job_release(struct kref *ref)
>>   {
>>       struct amdxdna_sched_job *job;
>> @@ -70,6 +82,8 @@ static void aie2_job_release(struct kref *ref)
>>       wake_up(&job->hwctx->priv->job_free_wq);
>>       if (job->out_fence)
>>           dma_fence_put(job->out_fence);
>> +    if (job->drv_cmd)
>> +        aie2_cmd_put(job->drv_cmd);
>>       kfree(job->aie2_job_health);
>>       kfree(job);
>>   }
>> @@ -901,7 +915,7 @@ static int aie2_hwctx_cfg_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 bo_hdl,
>>   {
>>       struct amdxdna_client *client = hwctx->client;
>>       struct amdxdna_dev *xdna = client->xdna;
>> -    struct amdxdna_drv_cmd cmd = { 0 };
>> +    struct amdxdna_drv_cmd *cmd;
>>       struct amdxdna_gem_obj *abo;
>>       u64 seq;
>>       int ret;
>> @@ -912,32 +926,39 @@ static int aie2_hwctx_cfg_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 bo_hdl,
>>           return -EINVAL;
>>       }
>>   +    cmd = kzalloc_obj(*cmd);
>> +    if (!cmd) {
>> +        ret = -ENOMEM;
>> +        goto put_obj;
>> +    }
>> +    kref_init(&cmd->refcnt);
>> +
>>       if (attach) {
>>           if (abo->assigned_hwctx != AMDXDNA_INVALID_CTX_HANDLE) {
>>               ret = -EBUSY;
>> -            goto put_obj;
>> +            goto put_cmd;
>>           }
>> -        cmd.opcode = ATTACH_DEBUG_BO;
>> +        cmd->opcode = ATTACH_DEBUG_BO;
>>       } else {
>>           if (abo->assigned_hwctx != hwctx->id) {
>>               ret = -EINVAL;
>> -            goto put_obj;
>> +            goto put_cmd;
>>           }
>> -        cmd.opcode = DETACH_DEBUG_BO;
>> +        cmd->opcode = DETACH_DEBUG_BO;
>>       }
>>   -    ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
>> +    ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
>>                    &bo_hdl, 1, hwctx->id, &seq);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Submit command failed");
>> -        goto put_obj;
>> +        goto put_cmd;
>>       }
>>         aie2_cmd_wait(hwctx, seq);
>> -    if (cmd.result) {
>> -        XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
>> +    if (cmd->result) {
>> +        XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>>           ret = -EINVAL;
>> -        goto put_obj;
>> +        goto put_cmd;
>>       }
>>         if (attach)
>> @@ -947,6 +968,8 @@ static int aie2_hwctx_cfg_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 bo_hdl,
>>         XDNA_DBG(xdna, "Config debug BO %d to %s", bo_hdl, hwctx->name);
>>   +put_cmd:
>> +    aie2_cmd_put(cmd);
>>   put_obj:
>>       amdxdna_gem_put_obj(abo);
>>       return ret;
>> @@ -974,25 +997,32 @@ int aie2_hwctx_sync_debug_bo(struct 
>> amdxdna_hwctx *hwctx, u32 debug_bo_hdl)
>>   {
>>       struct amdxdna_client *client = hwctx->client;
>>       struct amdxdna_dev *xdna = client->xdna;
>> -    struct amdxdna_drv_cmd cmd = { 0 };
>> +    struct amdxdna_drv_cmd *cmd;
>>       u64 seq;
>>       int ret;
>>   -    cmd.opcode = SYNC_DEBUG_BO;
>> -    ret = amdxdna_cmd_submit(client, &cmd, AMDXDNA_INVALID_BO_HANDLE,
>> +    cmd = kzalloc_obj(*cmd);
>> +    if (!cmd)
>> +        return -ENOMEM;
>> +    kref_init(&cmd->refcnt);
>> +
>> +    cmd->opcode = SYNC_DEBUG_BO;
>> +    ret = amdxdna_cmd_submit(client, cmd, AMDXDNA_INVALID_BO_HANDLE,
>>                    &debug_bo_hdl, 1, hwctx->id, &seq);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Submit command failed");
>> -        return ret;
>> +        goto put_cmd;
>>       }
>>         aie2_cmd_wait(hwctx, seq);
>> -    if (cmd.result) {
>> -        XDNA_ERR(xdna, "Response failure 0x%x", cmd.result);
>> -        return -EINVAL;
>> +    if (cmd->result) {
>> +        XDNA_ERR(xdna, "Response failure 0x%x", cmd->result);
>> +        ret = -EINVAL;
>>       }
>>   -    return 0;
>> +put_cmd:
>> +    aie2_cmd_put(cmd);
>> +    return ret;
>>   }
>>     static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>> @@ -1139,6 +1169,8 @@ int aie2_cmd_submit(struct amdxdna_hwctx 
>> *hwctx, struct amdxdna_sched_job *job,
>>           dma_resv_add_fence(job->bos[i]->resv, job->out_fence, 
>> DMA_RESV_USAGE_WRITE);
>>       job->seq = hwctx->priv->seq++;
>>       kref_get(&job->refcnt);
>> +    if (job->drv_cmd)
>> +        kref_get(&job->drv_cmd->refcnt);
>>       drm_sched_entity_push_job(&job->base);
>>         *seq = job->seq;
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index aaae16430466..b6bef3af7dab 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -132,6 +132,7 @@ enum amdxdna_job_opcode {
>>   struct amdxdna_drv_cmd {
>>       enum amdxdna_job_opcode    opcode;
>>       u32            result;
>> +    struct kref        refcnt;
>>   };
>>     struct app_health_report;
>
