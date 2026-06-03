Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7802CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA30B112344;
	Wed,  3 Jun 2026 20:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVS5yEJz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013066.outbound.protection.outlook.com
 [40.93.196.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50712112344
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 20:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmPo31j5OUQq8Rc8fDq5apgDN/WnX6bAll83CqXfASUJWNS1E9q0Ni0LhcTBW/A10En0L2voJp/oNEXf7TaLptZzhf7Jw4bgqJaI3vo13zh01P/azYJxvEY9JGb8WN79HJNsevZEsjKJHGaqTzfHSGOb/zpo860TpRKAE6xzm2hAKyNHtJweVU1EDIDbNgNi6jjceiddmn3lHBsm8FwgWM1qVrCYmGXAgRDc8tS4dMWXtEbNNWIiFEYn/gx8Hv094VojTvDy3H7x9YOIaTsDM5/wBLsn1VHjHWpHrroFgtx7LqkO9WLeJ3QXja9oLNbToB7Z8QOzK1WlV02nMwShIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fNiYkPc+mRSnUKPTf7pTRzsB+ofijRA1F80mwcdYnM=;
 b=kBYt+XHUq+jyXMUiP7mne0yYZi1ua5D///jZa2UkJBtShb7pjVxHAuugBcNd5P3grxuhHyouTvBiqZcDLox+bge3vZ9GbHw/tN0FHm+dzD0HaZW7xyIQC3pVg8OPT8w71Tp1nxC4405v78PY99fJWdzAK50tGB4vw8xMljfYN3/9qLqgLUJY+pGl1QQdn9dRTE5e/ps1Iay1NABWz8kWCT1rz+J0Mw7rGG6158fm6fvgDsyNPwt8iB3uBeWX7f5a+zsur03m/7JfGVnBu+QgzNu3IUKvwxorDK5e+bkfnH3UvOh0oMkRdqgOF66mFrMnaxoGDXVW39MHB1r4bDMvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fNiYkPc+mRSnUKPTf7pTRzsB+ofijRA1F80mwcdYnM=;
 b=dVS5yEJza0xRJGxjIO2/Gq0cnZ9QRcvOFYn1ohSlxWd99oIA+KLC4s1O0QCigz9o+CqSQlcR7UlySNXrpTJQHzfX0gEh0CtuhkObu1E1AcRbB0VCfZkqcdipnFUtvyNROJtY0/4b94gn9/JjLlE2fiCNNQNQyfwduzA2ejSun/g=
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 20:17:27 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::85) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 20:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 20:17:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 15:17:26 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 15:17:25 -0500
Message-ID: <e6ca8450-0c4e-6ea9-8b7c-9a311310bdc7@amd.com>
Date: Wed, 3 Jun 2026 13:17:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Remove drv_cmd tracing from job free
 callback
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260529152837.1973405-1-lizhi.hou@amd.com>
 <dd84217b-d0b0-42b0-b822-cb897b6f71a8@amd.com>
 <f8cce943-4f7b-04e9-8596-fc652ad22398@amd.com>
 <0508697c-d9b6-4691-beaa-d5ea81248cc7@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <0508697c-d9b6-4691-beaa-d5ea81248cc7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e34834-d997-4877-522b-08dec1ad2155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: xPhpcyO0tmZf5jLCP+2hS27nfMSG8U9GMuqzQmRDdtnk66ttwIQDfh2lLIo7s+tsmTvyCB536o8pb2bvTCZJLfhf5Y0Ar+S2N3dP70w6UXWKVQila6UFRdh0BUg1tSdEYYKZRG+6fgXcTJ56POYwzEf1Kpfsq/EF7OMRWc6iHuaai/WDj3XNbPO3RvilBOZKa/zczCRL+T/EmQnQFavYlsfUDB8o0G/YjenSjIPcaD3YqIdKMX0mTsSAFgBAg+s9Svi6wdKSEmCWTZheiolOacOW5R5seMn3hfCPNsLXdupL+OAsmIgbU+3KPwT1t4D4lZrXfz10ww396cluzHqMcyguymo1vOoTlpVE27X/i/FlFgauz5RtSE2y+Qrh0GTTvvsPBZ692262DPqclef/U5Qfj7ce57l80ytPdy4MgJuRRKDTlX31uPpKL75X8zyixj6OLfgf+s75LLnzTD7O5x2WtojHn3rZLLbm9qSoQ31KvSoSicALeTfQfQcIUkxItMj9765S45dy7K+pZVI1J84wfTWxiJi16nZVdlAdAgSsobeWWbSGlNYrc2qZmjcJfs4CRuHm0Vmhw0HxOSQdX95eALd9umR10TC1KqSoPKlYTQjSXOVgyH6IkQkf8M/0eF7bas+o/WCvOuZoItCDbUBfH5KntSLv7mgRQVUqkhbEh37AVG5MsrEry6D+26E+Xggs0FXLyFV6QEN6gCfKz/9MNeZxBp/Opj5s8hkG4Pk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g9/DVors3WNBOtKXe5JXe77EPNY3zFITyMyyDaqRVL8w3dovtUzSUsaBzvnX7t9iHak3bylI6wjLk4k35bUGrUtHqpuJRDGAa6Jzxc5AC3wJRVmA7wBfg6xtL0q0DTaR9fOVdngLa5WRvIAu95Zg1kXkaPH31qcXcgqGNwNd3Hae79zcU4/cGZ4i+xxD6jW8MKPEkZAPMdlutYbA8kHiQVvsdDNPYKg0HoQjUJdCvRRLDI5XnVHbsG/a5R7wkVYLYDYMKfJeL765vG3zz0ohXv9JRYvFFCh9Cwh7+nTYv1dJeJyaVoJF9Wd/wnYlCUOfhra8vGFPHbnHLFlLsK90RByCZcGDmJMPMz+dJvnpZ9ZqiKePKaD8xCLL3bSFqyy/wDiuWpUzr6x2NXxXsf/K18C0vvwOh4sUDGgvf665N33CYv0w9AUTHVgClhALuXfx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 20:17:26.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e34834-d997-4877-522b-08dec1ad2155
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
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

Applied to drm-misc-next-fixes

On 6/3/26 11:34, Mario Limonciello wrote:
>
>
> On 6/1/26 10:18, Lizhi Hou wrote:
>>
>> On 5/31/26 07:18, Mario Limonciello wrote:
>>>
>>>
>>> On 5/29/26 17:28, Lizhi Hou wrote:
>>>> aie2_sched_job_free() accesses job->drv_cmd for tracing purposes. 
>>>> However,
>>>> job->drv_cmd is owned by the caller and may already have been freed 
>>>> when
>>>> the job free callback runs, leading to a potential use-after-free.
>>>>
>>>> Remove the job->drv_cmd access from aie2_sched_job_free().
>>>>
>>>> Fixes: 8711eb2dde2e ("accel/amdxdna: Improve tracing for job 
>>>> lifecycle and mailbox RX worker")
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>>> ---
>>>>   drivers/accel/amdxdna/aie2_ctx.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/ 
>>>> amdxdna/aie2_ctx.c
>>>> index 658a5fb1fda6..2ad343728782 100644
>>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>>> @@ -437,8 +437,9 @@ static void aie2_sched_job_free(struct 
>>>> drm_sched_job *sched_job)
>>>>       struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>>>>       struct amdxdna_hwctx *hwctx = job->hwctx;
>>>>   +    /* job->drv_cmd could be freed, so use DEFAULT_IO */
>>>>       trace_xdna_job(sched_job, hwctx->name, "job free",
>>>> -               job->seq, job->drv_cmd ? job->drv_cmd->opcode : 
>>>> DEFAULT_IO);
>>>> +               job->seq, DEFAULT_IO);
>>>
>>> Could this still be a race with dov->drv_cmd being valid when the 
>>> first part of the expression is evaluated (job->drv_cmd) but invalid 
>>> when job->drv_cmd->opcode is accessed?
>>
>> When aie2_sched_job_free() is called, the job->drv_cmd could already 
>> be freed. So it should never access job->drv_cmd at all. The entire 
>> expression "job->drv_cmd ? job->drv_cmd->opcode :  DEFAULT_IO" is 
>> removed.
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> Lizhi
>>
>>>
>>>>       if (!job->job_done)
>>>>           up(&hwctx->priv->job_sem);
>>>
>
