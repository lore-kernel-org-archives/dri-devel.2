Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B647F34C65
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F5710E4D6;
	Mon, 13 Apr 2026 16:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTqD32rz";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19FD10E4D6
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 16:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfdmiriI6SWW+ixlgSMlmZwgfs1psk5dfQKLo/nhlsyK8VsdOVaTZFeon++pnUezpFgvnFLLY7/v4a6vbsbFr+Q9uHaPaqclwkod2bRD+1vM0dB1H3Xa7hGPdD/RU++3G1usQbv6fM3bsu9jblY2WRwUsiextwkRb/FKJckyt8UYGKQuC0GER1yQjqqF4ICNpdH7v+CoNwkG0wczugmVgwT26rzg/T6La7wF3S0d1nb7QcC1OPQwfA/D3i8PsO/7KC48ph8MDnM/Ms7Bprdq71EKy/irXHJH2CfPwIrKdHb1E/NqBsm9KXqOGPfdE6Mim31OUeiMCo88SSL2uqBCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9+h3swGANB5IH6ucUaVgA/kLAFgPpbyLYXEeKN9DPI=;
 b=rvVAxAEn00wel4oTNQPakMnLyWgeuW3DwGdgj9QYJ2UPbO0QAxsQNMsR4aiOkaEbw9lUg1lcHEyRNBl1vZypXG5hJdscTQUjhSHcn17ut/9QbyDAsiERDmpAosNjYcWz5Bw4rWMY8MtwkwGmyhrfE0h6D41dTtiu80FYaun8iAjrkSjUmU6780sKtVxfihG8tbofuSOlMdMhfhJ0NAMUPXIuqErvEP1/zaVRPGWB1rkLm64shkhm4+zcBOrdB3CullWaawNENv+UjEMAVM8x4hKzSivhmFWevDxl5YhESUNrikOY4hYhvIV5k1ORxpuoMjziC1/+VYkMr3PZ/DtcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9+h3swGANB5IH6ucUaVgA/kLAFgPpbyLYXEeKN9DPI=;
 b=xTqD32rzQXwiumPvaUmU3CNxV/tgDNRGT3PYjdIPzDyCgxxLkoDIX+mUlnoq0tPp4Icn8VpgZ4SKBHbviPxPQd5SOo9h1AdO5gVauxT7N/c+43BvwvWQ312wJwMb5JoIvI/RM0cbvyaBdmlh6P4Bb+D+2lj9BPhBwCTM2lLmdws=
Received: from DM6PR08CA0031.namprd08.prod.outlook.com (2603:10b6:5:80::44) by
 DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Mon, 13 Apr 2026 16:45:19 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::2f) by DM6PR08CA0031.outlook.office365.com
 (2603:10b6:5:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 16:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 16:45:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 11:45:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:45:18 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 11:45:18 -0500
Message-ID: <fe1efb3a-179f-e31d-b7fc-2b57096a138b@amd.com>
Date: Mon, 13 Apr 2026 09:45:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Check for device hang on job timeout
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260409175826.195665-1-lizhi.hou@amd.com>
 <561d6991-d83e-40be-8baf-e705e6d5159d@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <561d6991-d83e-40be-8baf-e705e6d5159d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a56fbc0-7822-42f8-a872-08de997c0c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eGx9u8/DKdnlsLVrs+ZUjomL00V9Mm38aYZFj+p+Q16r6sg24rnB1WZ5KKeXB1QN6c8LVJke+pBvbPiF+tEIHIufsW5UJ7SCcc/37VeWDUZGdz0iN0gGVVJNJEW37NSMT4M/II69Z4xehGci86PNX2lbszUh8LxXhAc6XfkQpMmNBFCR+76jvKImOfvDB7EJayqzhGcfDAd/nXloP3lqSPZq3iCM/K7OfJRzcJdzjSSs0yfsChP25nNawQBuY2u1HQufZk7E+t568YlEgJy//3NOSl/Fj49JagvEzLQ1gFausyyE/mwikGJTZG2KkKBgWyS7khXWrLljItB7F5WqpfDqJlk9Cox4OlkbpHAawdBkoQtsHfVF+yaV/AmeeHD29JT/O6pLS9GatTq+jgXuV7DNez37fhJagSWtaCpdORf1h1vzvlKYnAYS2lKImtBw1Qfp7BuTEeihjNsF4NOtuGNnG0RsJm3M1UaABQahVLxaocwSq9/QjPCGux8U6QEubDMOtuyq6DvKWlnLnUER/ylFI/o8ZFv5IsuH7D82I0OGdmOKMje6RDyFA2yGTxXR/+QiJRQP2CHzyVPMqCuBXGcTGZ17sfG/1DRchGIS6uyJfXUQOTj0hTsL30WdF6PoVhC1OvA2lJyelzyiOvkHCkvRn5aJwVIGubUkYigkRRiOAZlaRlEsQ8lEDhEy1lZ0xJy2Sg4zNGOo0MZzYGQSku38NiOsQ87xg58tvCGHmMycjvkdzjgScIdCF2loIp1aN9kyyBk7PZEFbEW4FxPG1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 00o3TNK2AkG/BlO4ViqPPdnz4gokZtbnkylcrBiz3tyt9GIK4FoUID99pIF+2ex0R4RNg0NGVlHERKjocvC1Om4BTsEjSslCsB2DjCx1AmGAe956ndXo4S4j8auHweMWbCUUdDnUj6NUeo17BBni21ASI+N7M2spKoYGbHHLELeHwlkpUJL8qiDz7d4IMxr4CxNaRhrMFXhKmdOUBY0LJ45BIYqkoXraJNq2UxZHsINifc1yzSveQtDqlrTUdvk+iTrmVylABspTzpcef2arl029MbOE3Dln1jwq/BSjuQfK8CHPB/Q2zFa8VnVSRCtV03fO+ZXNsW2bYCuNjTXjQXQBuIH8AhMcdzRewVQMr9a/PJYcfsNVHpUx7Fle2TjpkPkm7ph5nClRAEdjREQJX2GzxLUtHAHd67/VZz6YvtQ/sZHz+fa4W4Xxc/dnF76T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 16:45:19.3775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a56fbc0-7822-42f8-a872-08de997c0c46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

On 4/10/26 13:37, Mario Limonciello wrote:
>
>
> On 4/9/26 12:58, Lizhi Hou wrote:
>> A job timeout does not necessarily indicate that the device is hung, as
>> it may still be processing other jobs.
>>
>> Track whether any jobs have been successfully submitted or completed,
>> and use this information to determine if the device is making forward
>> progress. If so, return DRM_GPU_SCHED_STAT_NO_HANG instead of treating
>> the timeout as a device hang.
>>
>> In the meanwhile the timeout interval is changed to 2 seconds which 
>> meets
>> the userspace requirement.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 36 +++++++++++++++++++++++++++-----
>>   drivers/accel/amdxdna/aie2_pci.h |  6 ++++++
>>   2 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index f97755d60fa3..ddcf06a6b80c 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -27,7 +27,9 @@ static bool force_cmdlist = true;
>>   module_param(force_cmdlist, bool, 0600);
>>   MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default 
>> true)");
>>   -#define HWCTX_MAX_TIMEOUT    60000 /* milliseconds */
>> +uint tdr_timeout_ms = 2000;
>> +module_param(tdr_timeout_ms, int, 0400);
>> +MODULE_PARM_DESC(tdr_timeout_ms, "TDR (Timeout Detection and 
>> Recovery) timeout in milliseconds (0 = disable)");
>>     struct aie2_ctx_health {
>>       struct amdxdna_ctx_health header;
>> @@ -39,6 +41,24 @@ struct aie2_ctx_health {
>>       u32 fatal_error_app_module;
>>   };
>>   +static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
>> +{
>> +    WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
>> +}
>> +
>> +static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>> +{
>> +    struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
>> +
>> +    if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
>> +        XDNA_ERR(xdna, "TDR timeout detected");
>> +        return true;
>> +    }
>> +
>> +    WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
>> +    return false;
>> +}
>> +
>>   static void aie2_job_release(struct kref *ref)
>>   {
>>       struct amdxdna_sched_job *job;
>> @@ -177,6 +197,7 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>         trace_xdna_job(&job->base, job->hwctx->name, "signaled 
>> fence", job->seq);
>>   +    aie2_tdr_signal(job->hwctx->client->xdna);
>>       job->hwctx->priv->completed++;
>>       dma_fence_signal(fence);
>>   @@ -385,6 +406,8 @@ aie2_sched_job_run(struct drm_sched_job 
>> *sched_job)
>>           aie2_job_put(job);
>>           mmput(job->mm);
>>           fence = ERR_PTR(ret);
>> +    } else {
>> +        aie2_tdr_signal(hwctx->client->xdna);
>>       }
>>       trace_xdna_job(sched_job, hwctx->name, "sent to device", 
>> job->seq);
>>   @@ -415,9 +438,12 @@ aie2_sched_job_timedout(struct drm_sched_job 
>> *sched_job)
>>         xdna = hwctx->client->xdna;
>>       trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>> -    job->job_timeout = true;
>>   -    mutex_lock(&xdna->dev_lock);
>> +    guard(mutex)(&xdna->dev_lock);
>> +
>> +    if (!aie2_tdr_detect(xdna))
>> +        return DRM_GPU_SCHED_STAT_NO_HANG;
>> +
>>       report = kzalloc_obj(*report);
>>       if (!report)
>>           goto reset_hwctx;
>> @@ -429,10 +455,10 @@ aie2_sched_job_timedout(struct drm_sched_job 
>> *sched_job)
>>           job->aie2_job_health = report;
>>     reset_hwctx:
>> +    job->job_timeout = true;
>>       aie2_hwctx_stop(xdna, hwctx, sched_job);
>>         aie2_hwctx_restart(xdna, hwctx);
>> -    mutex_unlock(&xdna->dev_lock);
>>         return DRM_GPU_SCHED_STAT_RESET;
>>   }
>> @@ -608,7 +634,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>           .ops = &sched_ops,
>>           .num_rqs = DRM_SCHED_PRIORITY_COUNT,
>>           .credit_limit = HWCTX_MAX_CMDS,
>> -        .timeout = msecs_to_jiffies(HWCTX_MAX_TIMEOUT),
>> +        .timeout = msecs_to_jiffies(tdr_timeout_ms),
>>           .name = "amdxdna_js",
>>           .dev = xdna->ddev.dev,
>>       };
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h 
>> b/drivers/accel/amdxdna/aie2_pci.h
>> index 7c308672b5fe..81564483cb16 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -165,6 +165,11 @@ struct aie2_exec_msg_ops {
>>       u32 (*get_chain_msg_op)(u32 cmd_op);
>>   };
>>   +enum aie2_tdr_status {
>> +    AIE2_TDR_WAIT,
>> +    AIE2_TDR_SIGNALED,
>> +};
>> +
>>   struct amdxdna_dev_hdl {
>>       struct aie_device        aie;
>>       const struct amdxdna_dev_priv    *priv;
>> @@ -197,6 +202,7 @@ struct amdxdna_dev_hdl {
>>       u32                hwctx_num;
>>         struct amdxdna_async_error    last_async_err;
>> +    enum aie2_tdr_status        tdr_status;
>>   };
>>     struct aie2_hw_ops {
>
