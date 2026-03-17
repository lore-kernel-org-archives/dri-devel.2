Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68AAFEDA0D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 19:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB25010E045;
	Tue, 17 Mar 2026 19:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mongh2Kq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE91C10E045
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 19:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZa7ugxcW4hAmovLnLK3sicamR2ujcYK9bkhYSRprFZJefvNip+xo6mCoyfDQ0a1f+QcjMeVsTTkwtgf4NEoLqR+yG0k8f/QENJVyahurzzL+OD/Px+4q+Xn2en5Cpt6xmWLjNDh03RoW6An7V2yrdL3foN7BlR+JT66k7dUDekAZqMwzIv8sg0qyH836n/pii1CDePrX9ZPt4sT07F5f1gNmgo68/XAgLULEcFlZXv4HjNAtLNMSixayfAw1Kr5LR19G0yuSl4mPnM420E3MKTLWoyFkXWmx+Mn8S1LBYT8DlERAabksAf4P1wq0ykavLNcc83C1zvo6BatNJSNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZpFGFcgRZJpaLVjq5aNJVjkPJ7k2vhZ+kxyZ6xdLNU=;
 b=rigpdYKE0huRGz7U3tkMTEV8oaMoD1Hk56OBaLJdgdnYGwjQCUDWx6LIHFiQmBVYwez3+GgASygU/gnSTEAIpgRM6VJaJK8PLf5zH6Z+1EHZb84IzFNOA1UPONicDnLaUew+KSGqlkuIG+ysg5NNdkscFWMVItQF1TVOQKymqkqaUiIYxENs+s5eFWsLIi923oYlW342SbllaMsv0x09N87RsO2Z38lF/zswZqlWcjYiN8mxnp2839tKpB9G39SyXYNALIK2B9y5VrGtacL6FSAv2tJWditS0hxV2aOini2dr34W+ERJnu7h/n/gluwnTYC/RtFplwpC3FKj0JhFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZpFGFcgRZJpaLVjq5aNJVjkPJ7k2vhZ+kxyZ6xdLNU=;
 b=mongh2KqVfvQ7VctEqc2CzAO2Nal15Kd215jWV1MnIFRm12fTufIvswyvGs+Z7v+eHvz6DnhIyQwRVOftMxY1jhZH13jDKepwTKHKNKuSSehEE/5czMKf2QAlI3TKCUmlmUd3jX4y8enFfAmaNHuE8RRTsyv6RtRdWH2aOCJMK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 19:25:09 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 19:25:09 +0000
Message-ID: <65849b9e-6a94-458b-b389-c6a9b418d2a1@amd.com>
Date: Tue, 17 Mar 2026 14:25:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Support retrieving hardware context
 debug information
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260317044906.1513133-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260317044906.1513133-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: f7be3df2-131d-4612-954a-08de845ae745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5L6eqw9MFU4Mp0P9RB1aPQyjJ6weAHI2P9SIFv9bAxbaDNf7OZqwD6mzwknsZXqzkTVabwgbZgNbY4flISnPydmrPWLT1QOSNviviHzs69XKCLL6cTNL3vEB6meYwNO+cLawIPUF8UNUXR8XFWHqLEK+8P4ZXwme/DSNohX6ztXOSlZuj5VBZ7xAQjN+Uf7zAXe/tToqvLCYHPW95BXHmmh5XH8EUCGmbiGv2SE2OHnuSZR5nGytMtEmRozqJx91wVX/kNVLSDRYFvHgT3LB4xg3TrU7d1tB4HNm+XrKPkMvB3C9Vtbx5IGWR+sqrZ0Gcgrxb1pCVf8on9rzQpV2RM253p86IGm7Up0jH4+CwGdEEvMj9TALjkM4omtYtqn87HcdKRwg+Sw3cCjh7v5RLhhF1ssBadnOqutYdbobcll56hTTi1IFPuIcnHLkmFxL16IlWz6U1ijH+Y5Xd5naPjsrLVppHPWdkgAwZ646PCTCTOm0LNsb1jx2o9IAgp6jPspXqie5ijS5PT6GauF0yJ7KzpazQ7UfSkwXcQXor2sq2nkjdvOQDWTaNWIj7FcRSIeZa4LEHbd7ks0xN3VfnVqeIMfds2HwhsN4YsnSSN42pkCqZ3BCm/zBtxcRPf17U94sKwwOXLWLRdiNXVWmE/Wdbn1kB+UNUS+V+kTYBF1Z0t4J/5iLAZR8R723J0s+JqOu0qyyryW/sWr+1qNoHf+jMu429EcM/olpoUeUbWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFmY3ZpZ1lQbFJzQzAydldveXdTOVkrQ1RSelNCd1BRakg2dEhoQ1BvT3dw?=
 =?utf-8?B?d0VkN1ZUZVhyQ1FRVGdYdVF5MDU4dmh4eXA5MkhhMVlkM0lUNzBueHZFaDFx?=
 =?utf-8?B?bEhuYTYyWWtpcnpzYkN1ZzZxdWlWQW14SWNrVzVDcW45SmUzdEREd2c5bXFK?=
 =?utf-8?B?QllTVHNrK2Fod0Jtc3RLVjB1dDdIcFBXdWNITUsyQzVHMVZ2RDRQSE1BOVBm?=
 =?utf-8?B?cU5xcXZmd09HZXFwbUhJQ3MyOGNzTm5hcHF2WWltTTFGV3oxQnJHaWhyaGN5?=
 =?utf-8?B?ejBvSVNsKzRPOC9lVzhMNmI0MjNJUkFiRGNJdGZndmpKVTQ5OEtjMHdxVjFH?=
 =?utf-8?B?TFhab3I1Znh2QnlGNHpYcXFoNWljL1lDaTNOeDVLalZCRU1vdVRDaHNyb2xZ?=
 =?utf-8?B?R2U3Q0lINEVzbEVKSzdjRUdPZXJGMXpwQWF4bTRlZ3RBR0xaMzJIdmxWZ2U0?=
 =?utf-8?B?V3p1MUJyQVVETkZqbGRaY01TQ3JUQXB2YVZFaEU5RjRoU2EzMXVEWXZKaXhD?=
 =?utf-8?B?eEpHTkhwN0k1NERnM1ptYmw2SlFublZHcnMraXdXaDZSKzhremdheXd6VHpl?=
 =?utf-8?B?bnNsZlpSUVVENDBTdjJEN2kvbWttSS9rZTNuSUt2WWp3amlkWFRrVmFtanpn?=
 =?utf-8?B?RHk5dmV1clo2VjFkWHdpYk9ra2NvYmovalR5Y3V5MXIvZHFzbjdmOGpvM1FL?=
 =?utf-8?B?UkpUOWRJSzQvL3JuMVJtdy9YSlF4blZua3lDZkkyZ0JYdit5dnp1TGR1VnQ1?=
 =?utf-8?B?M3JZTkttMWR5aFBGNFNqbG1UMjdnSTBGVUxha3pySWNicEFIVVhXR3Z0VTJW?=
 =?utf-8?B?SEE0b2JOQUliTjYzTDJ6U0VWUGd4MlgvRXVPanJOMW90WldOam52T01kajRt?=
 =?utf-8?B?ZDNMRjRaa3BWOVVPSTIwWUNXQU52RS91N2llWTFJZ3ZxWnZzQVlXNXl2cW10?=
 =?utf-8?B?T1hySTdBdER4aGlIUkFOWVZVYm8ydlZLR0Zibnl0dHdhMzJTRmtGYUhSOHJ1?=
 =?utf-8?B?S2JiSHBkQm9tQVJVeEkrYUdJNkxjMUxOeFpyV0sxS0xmOW15UGtpeGxkbndJ?=
 =?utf-8?B?NGtuWFRtRmNTN3ExVWRrcU56QnRjUlMvSXVXTklMcE82eDRlY0EwY21XcDBy?=
 =?utf-8?B?SXJ5aVFNOG5OempkbEV0MmlrNHlJTCtVMHdFYlh3c0QrN1BSQ241VjJ4MFgz?=
 =?utf-8?B?dlh4dHJoalpCbTc2TmRDMGRMdDJBVktPVWsxWDExakljOERXcWtsVW8xcUZL?=
 =?utf-8?B?NmJtREZKcS9USVk1Q3pGQ09ZVHVXdGdoZ1FibksxMTcyQXZoYkJFMkFybWpq?=
 =?utf-8?B?d2NFNzVSUWZNSEl2N29SQzhtUEZZOFJjQlF5M3RpMkV3RUFoUkN0SFNSMmFQ?=
 =?utf-8?B?Z0RndGFjT09jeHFzK3F1TzhkSnJPNFRYOEdlazNtMmp5eXVGNnY3bFkwSUZN?=
 =?utf-8?B?RUtLU2VLN2svNmdmeE1rTFhRNm50VDEwN2FjMEozNm9Hei9qQ05pT081YnQ2?=
 =?utf-8?B?bCtIaVhEYmE5a05tL0s0TTluQmRYaVNUK0dQTE1aL0kzWEJjUjgrTDMyanEr?=
 =?utf-8?B?Yzcwa1htRG12NzBPUDhlNjRZOXV1eS9oaTFSZGlmcVVOLzRWTjBBZjNLMEpL?=
 =?utf-8?B?MzJOTXJod3pLRGhOazZSYUg2Tnl0bzNPSmoxbXdZKzkyb0F4NW5UOGp3T1pG?=
 =?utf-8?B?VlVSSHRzZVBFaUcraFROL292Q0t4WnNyOUhncE1MNUQrclk1NU03TVJuQ29p?=
 =?utf-8?B?YWZyc1hpWXlYMWUrS1lVaWd6djBoUUxxeDA0TE9UZDdid3RVTEtGQXI1VExz?=
 =?utf-8?B?UU5aRlZIT09xUjVZWExOdVJYZnNtNldaL2hYMTV6T2ZDTkltY1p3QTl0MnZ5?=
 =?utf-8?B?WkZkZzQ1NXd2WGdhR3JrLzZQYkRRVFl0cWNicWhVSngvMU5oZ3dYclhFNWti?=
 =?utf-8?B?STJDV054TzVraUxSNnVvSS9ncnZKeGc0NnZnSUJmRDBFWEtYYW1LRlJ4REdu?=
 =?utf-8?B?alV6S2I4cjkxNHJTVDhGVmpMK0U1V0txUnpWV1oxWDNiTUp3VFczV1F3ZkNP?=
 =?utf-8?B?cEdYd1F4QVdlOGZkMXJGVklSa0tSMU92N3pvUUsyT2ZEaEdvMFg3emxaaDc3?=
 =?utf-8?B?UnovWkdsWkIrNlFSRnkvTHZ5RnhyYW1DbXozak1hbUtGQXY5V25mVlFYTm9x?=
 =?utf-8?B?a3JIWlZ4MWxVMC9ESmpVb05JdlVnVW1va3BleU10Z04rWTBXRzNiMG1lenZ4?=
 =?utf-8?B?MnhMOHJ2QnV5UTdOd2dJOGRqVnVqTUpjWDVwZWxHM0ZLWWZweGVDT1JhYTlT?=
 =?utf-8?B?N080S3QvYXlGbUxVWjFoRytzSDFZRzJKOGlNSlhCQWw1QzIvcEZhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7be3df2-131d-4612-954a-08de845ae745
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 19:25:09.6465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yCvOV2hzaYCpaM2jgh0ngCgO/b7DWqVzUiCmZl+CnqPDKPxOcDFQU7u/3uUYDCk9WtkdTG6onHiD3N0/5MovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732
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



On 3/16/26 23:49, Lizhi Hou wrote:
> The firmware implements the GET_APP_HEALTH command to collect debug
> information for a specific hardware context.
> 
> When a command times out, the driver issues this command to collect the
> relevant debug information. User space tools can also retrieve this
> information through the hardware context query IOCTL.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c      | 85 ++++++++++++++++++++++++---
>   drivers/accel/amdxdna/aie2_message.c  | 41 +++++++++++++
>   drivers/accel/amdxdna/aie2_msg_priv.h | 52 ++++++++++++++++
>   drivers/accel/amdxdna/aie2_pci.c      | 14 +++++
>   drivers/accel/amdxdna/aie2_pci.h      |  5 ++
>   drivers/accel/amdxdna/amdxdna_ctx.c   |  6 +-
>   drivers/accel/amdxdna/amdxdna_ctx.h   | 18 +++++-
>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>   8 files changed, 213 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 779ac70d62d7..6292349868c5 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -29,6 +29,16 @@ MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default true)");
>   
>   #define HWCTX_MAX_TIMEOUT	60000 /* milliseconds */
>   
> +struct aie2_ctx_health {
> +	struct amdxdna_ctx_health header;
> +	u32 txn_op_idx;
> +	u32 ctx_pc;
> +	u32 fatal_error_type;
> +	u32 fatal_error_exception_type;
> +	u32 fatal_error_exception_pc;
> +	u32 fatal_error_app_module;
> +};
> +
>   static void aie2_job_release(struct kref *ref)
>   {
>   	struct amdxdna_sched_job *job;
> @@ -39,6 +49,7 @@ static void aie2_job_release(struct kref *ref)
>   	wake_up(&job->hwctx->priv->job_free_wq);
>   	if (job->out_fence)
>   		dma_fence_put(job->out_fence);
> +	kfree(job->aie2_job_health);
>   	kfree(job);
>   }
>   
> @@ -176,6 +187,50 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>   	aie2_job_put(job);
>   }
>   
> +static void aie2_set_cmd_timeout(struct amdxdna_sched_job *job)
> +{
> +	struct aie2_ctx_health *aie2_health __free(kfree) = NULL;
> +	struct amdxdna_dev *xdna = job->hwctx->client->xdna;
> +	struct amdxdna_gem_obj *cmd_abo = job->cmd_bo;
> +	struct app_health_report *report = job->aie2_job_health;
> +	u32 fail_cmd_idx = 0;
> +
> +	if (!report)
> +		goto set_timeout;
> +
> +	XDNA_ERR(xdna, "Firmware timeout state capture:");
> +	XDNA_ERR(xdna, "\tVersion: %d.%d", report->major, report->minor);
> +	XDNA_ERR(xdna, "\tReport size: 0x%x", report->size);
> +	XDNA_ERR(xdna, "\tContext ID: %d", report->context_id);
> +	XDNA_ERR(xdna, "\tDPU PC: 0x%x", report->dpu_pc);
> +	XDNA_ERR(xdna, "\tTXN OP ID: 0x%x", report->txn_op_id);
> +	XDNA_ERR(xdna, "\tContext PC: 0x%x", report->ctx_pc);
> +	XDNA_ERR(xdna, "\tFatal error type: 0x%x", report->fatal_info.fatal_type);
> +	XDNA_ERR(xdna, "\tFatal error exception type: 0x%x", report->fatal_info.exception_type);
> +	XDNA_ERR(xdna, "\tFatal error exception PC: 0x%x", report->fatal_info.exception_pc);
> +	XDNA_ERR(xdna, "\tFatal error app module: 0x%x", report->fatal_info.app_module);
> +	XDNA_ERR(xdna, "\tFatal error task ID: %d", report->fatal_info.task_index);
> +	XDNA_ERR(xdna, "\tTimed out sub command ID: %d", report->run_list_id);
> +
> +	fail_cmd_idx = report->run_list_id;
> +	aie2_health = kzalloc_obj(*aie2_health);
> +	if (!aie2_health)
> +		goto set_timeout;
> +
> +	aie2_health->header.version = AMDXDNA_CMD_CTX_HEALTH_V1;
> +	aie2_health->header.npu_gen = AMDXDNA_CMD_CTX_HEALTH_AIE2;
> +	aie2_health->txn_op_idx = report->txn_op_id;
> +	aie2_health->ctx_pc = report->ctx_pc;
> +	aie2_health->fatal_error_type = report->fatal_info.fatal_type;
> +	aie2_health->fatal_error_exception_type = report->fatal_info.exception_type;
> +	aie2_health->fatal_error_exception_pc = report->fatal_info.exception_pc;
> +	aie2_health->fatal_error_app_module = report->fatal_info.app_module;
> +
> +set_timeout:
> +	amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_TIMEOUT,
> +			      aie2_health, sizeof(*aie2_health));
> +}
> +
>   static int
>   aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>   {
> @@ -187,13 +242,13 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>   	cmd_abo = job->cmd_bo;
>   
>   	if (unlikely(job->job_timeout)) {
> -		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
> +		aie2_set_cmd_timeout(job);
>   		ret = -EINVAL;
>   		goto out;
>   	}
>   
>   	if (unlikely(!data) || unlikely(size != sizeof(u32))) {
> -		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
> +		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, NULL, 0);
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -203,7 +258,7 @@ aie2_sched_resp_handler(void *handle, void __iomem *data, size_t size)
>   	if (status == AIE2_STATUS_SUCCESS)
>   		amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_COMPLETED);
>   	else
> -		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR);
> +		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ERROR, NULL, 0);
>   
>   out:
>   	aie2_sched_notify(job);
> @@ -237,21 +292,21 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
>   	struct amdxdna_sched_job *job = handle;
>   	struct amdxdna_gem_obj *cmd_abo;
>   	struct amdxdna_dev *xdna;
> +	u32 fail_cmd_idx = 0;
>   	u32 fail_cmd_status;
> -	u32 fail_cmd_idx;
>   	u32 cmd_status;
>   	int ret = 0;
>   
>   	cmd_abo = job->cmd_bo;
>   
>   	if (unlikely(job->job_timeout)) {
> -		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_TIMEOUT);
> +		aie2_set_cmd_timeout(job);
>   		ret = -EINVAL;
>   		goto out;
>   	}
>   
>   	if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
> -		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT);
> +		amdxdna_cmd_set_error(cmd_abo, job, 0, ERT_CMD_STATE_ABORT, NULL, 0);
>   		ret = -EINVAL;
>   		goto out;
>   	}
> @@ -271,10 +326,10 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
>   		 fail_cmd_idx, fail_cmd_status);
>   
>   	if (fail_cmd_status == AIE2_STATUS_SUCCESS) {
> -		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ABORT);
> +		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ABORT, NULL, 0);
>   		ret = -EINVAL;
>   	} else {
> -		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ERROR);
> +		amdxdna_cmd_set_error(cmd_abo, job, fail_cmd_idx, ERT_CMD_STATE_ERROR, NULL, 0);
>   	}
>   
>   out:
> @@ -363,12 +418,26 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
>   {
>   	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>   	struct amdxdna_hwctx *hwctx = job->hwctx;
> +	struct app_health_report *report;
>   	struct amdxdna_dev *xdna;
> +	int ret;
>   
>   	xdna = hwctx->client->xdna;
>   	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>   	job->job_timeout = true;
> +
>   	mutex_lock(&xdna->dev_lock);
> +	report = kzalloc_obj(*report);
> +	if (!report)
> +		goto reset_hwctx;
> +
> +	ret = aie2_query_app_health(xdna->dev_handle, hwctx->fw_ctx_id, report);
> +	if (ret)
> +		kfree(report);
> +	else
> +		job->aie2_job_health = report;
> +
> +reset_hwctx:
>   	aie2_hwctx_stop(xdna, hwctx, sched_job);
>   
>   	aie2_hwctx_restart(xdna, hwctx);
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index 798128b6b7b7..4ec591306854 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -1185,3 +1185,44 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
>   
>   	return xdna_mailbox_send_msg(chann, &msg, TX_TIMEOUT);
>   }
> +
> +int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
> +			  struct app_health_report *report)
> +{
> +	DECLARE_AIE2_MSG(get_app_health, MSG_OP_GET_APP_HEALTH);
> +	struct amdxdna_dev *xdna = ndev->xdna;
> +	struct app_health_report *buf;
> +	dma_addr_t dma_addr;
> +	u32 buf_size;
> +	int ret;
> +
> +	if (!AIE2_FEATURE_ON(ndev, AIE2_APP_HEALTH)) {
> +		XDNA_DBG(xdna, "App health feature not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	buf_size = sizeof(*report);
> +	buf = aie2_alloc_msg_buffer(ndev, &buf_size, &dma_addr);
> +	if (IS_ERR(buf)) {
> +		XDNA_ERR(xdna, "Failed to allocate buffer for app health");
> +		return PTR_ERR(buf);
> +	}
> +
> +	req.buf_addr = dma_addr;
> +	req.context_id = context_id;
> +	req.buf_size = buf_size;
> +
> +	drm_clflush_virt_range(buf, sizeof(*report));
> +	ret = aie2_send_mgmt_msg_wait(ndev, &msg);
> +	if (ret) {
> +		XDNA_ERR(xdna, "Get app health failed, ret %d status 0x%x", ret, resp.status);
> +		goto free_buf;
> +	}
> +
> +	/* Copy the report to caller's buffer */
> +	memcpy(report, buf, sizeof(*report));
> +
> +free_buf:
> +	aie2_free_msg_buffer(ndev, buf_size, buf, dma_addr);
> +	return ret;
> +}
> diff --git a/drivers/accel/amdxdna/aie2_msg_priv.h b/drivers/accel/amdxdna/aie2_msg_priv.h
> index 728ef56f7f0a..f18e89a39e35 100644
> --- a/drivers/accel/amdxdna/aie2_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie2_msg_priv.h
> @@ -31,6 +31,7 @@ enum aie2_msg_opcode {
>   	MSG_OP_SET_RUNTIME_CONFIG          = 0x10A,
>   	MSG_OP_GET_RUNTIME_CONFIG          = 0x10B,
>   	MSG_OP_REGISTER_ASYNC_EVENT_MSG    = 0x10C,
> +	MSG_OP_GET_APP_HEALTH              = 0x114,
>   	MSG_OP_MAX_DRV_OPCODE,
>   	MSG_OP_GET_PROTOCOL_VERSION        = 0x301,
>   	MSG_OP_MAX_OPCODE
> @@ -451,4 +452,55 @@ struct config_debug_bo_req {
>   struct config_debug_bo_resp {
>   	enum aie2_msg_status	status;
>   } __packed;
> +
> +struct fatal_error_info {
> +	__u32 fatal_type;         /* Fatal error type */
> +	__u32 exception_type;     /* Only valid if fatal_type is a specific value */
> +	__u32 exception_argument; /* Argument based on exception type */
> +	__u32 exception_pc;       /* Program Counter at the time of the exception */
> +	__u32 app_module;         /* Error module name */
> +	__u32 task_index;         /* Index of the task in which the error occurred */
> +	__u32 reserved[128];
> +};
> +
> +struct app_health_report {
> +	__u16 major;
> +	__u16 minor;
> +	__u32 size;
> +	__u32 context_id;
> +	/*
> +	 * Program Counter (PC) of the last initiated DPU opcode, as reported by the ERT
> +	 * application. Before execution begins or after successful completion, the value is set
> +	 * to UINT_MAX. If execution halts prematurely due to an error, this field retains the
> +	 * opcode's PC value.
> +	 * Note: To optimize performance, the ERT may simplify certain aspects of reporting.
> +	 * Proper interpretation requires familiarity with the implementation details.
> +	 */
> +	__u32 dpu_pc;
> +	/*
> +	 * Index of the last initiated TXN opcode.
> +	 * Before execution starts or after successful completion, the value is set to UINT_MAX.
> +	 * If execution halts prematurely due to an error, this field retains the opcode's ID.
> +	 * Note: To optimize performance, the ERT may simplify certain aspects of reporting.
> +	 * Proper interpretation requires familiarity with the implementation details.
> +	 */
> +	__u32 txn_op_id;
> +	/* The PC of the context at the time of the report */
> +	__u32 ctx_pc;
> +	struct fatal_error_info		fatal_info;
> +	/* Index of the most recently executed run list entry. */
> +	__u32 run_list_id;
> +};
> +
> +struct get_app_health_req {
> +	__u32 context_id;
> +	__u32 buf_size;
> +	__u64 buf_addr;
> +} __packed;
> +
> +struct get_app_health_resp {
> +	enum aie2_msg_status status;
> +	__u32 required_buffer_size;
> +	__u32 reserved[7];
> +} __packed;
>   #endif /* _AIE2_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index ddd3d82f3426..9e39bfe75971 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -846,7 +846,10 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
>   	struct amdxdna_drm_hwctx_entry *tmp __free(kfree) = NULL;
>   	struct amdxdna_drm_get_array *array_args = arg;
>   	struct amdxdna_drm_hwctx_entry __user *buf;
> +	struct app_health_report report;
> +	struct amdxdna_dev_hdl *ndev;
>   	u32 size;
> +	int ret;
>   
>   	if (!array_args->num_element)
>   		return -EINVAL;
> @@ -869,6 +872,17 @@ static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
>   	tmp->latency = hwctx->qos.latency;
>   	tmp->frame_exec_time = hwctx->qos.frame_exec_time;
>   	tmp->state = AMDXDNA_HWCTX_STATE_ACTIVE;
> +	ndev = hwctx->client->xdna->dev_handle;
> +	ret = aie2_query_app_health(ndev, hwctx->fw_ctx_id, &report);
> +	if (!ret) {
> +		/* Fill in app health report fields */
> +		tmp->txn_op_idx = report.txn_op_id;
> +		tmp->ctx_pc = report.ctx_pc;
> +		tmp->fatal_error_type = report.fatal_info.fatal_type;
> +		tmp->fatal_error_exception_type = report.fatal_info.exception_type;
> +		tmp->fatal_error_exception_pc = report.fatal_info.exception_pc;
> +		tmp->fatal_error_app_module = report.fatal_info.app_module;
> +	}
>   
>   	buf = u64_to_user_ptr(array_args->buffer);
>   	size = min(sizeof(*tmp), array_args->element_size);
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 885ae7e6bfc7..efcf4be035f0 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -10,6 +10,7 @@
>   #include <linux/limits.h>
>   #include <linux/semaphore.h>
>   
> +#include "aie2_msg_priv.h"
>   #include "amdxdna_mailbox.h"
>   
>   #define AIE2_INTERVAL	20000	/* us */
> @@ -261,6 +262,7 @@ enum aie2_fw_feature {
>   	AIE2_NPU_COMMAND,
>   	AIE2_PREEMPT,
>   	AIE2_TEMPORAL_ONLY,
> +	AIE2_APP_HEALTH,
>   	AIE2_FEATURE_MAX
>   };
>   
> @@ -271,6 +273,7 @@ struct aie2_fw_feature_tbl {
>   	u32 min_minor;
>   };
>   
> +#define AIE2_ALL_FEATURES	GENMASK_ULL(AIE2_FEATURE_MAX - 1, AIE2_NPU_COMMAND)
>   #define AIE2_FEATURE_ON(ndev, feature)	test_bit(feature, &(ndev)->feature_mask)
>   
>   struct amdxdna_dev_priv {
> @@ -341,6 +344,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
>   int aie2_query_aie_metadata(struct amdxdna_dev_hdl *ndev, struct aie_metadata *metadata);
>   int aie2_query_firmware_version(struct amdxdna_dev_hdl *ndev,
>   				struct amdxdna_fw_ver *fw_ver);
> +int aie2_query_app_health(struct amdxdna_dev_hdl *ndev, u32 context_id,
> +			  struct app_health_report *report);
>   int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
>   int aie2_destroy_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwctx);
>   int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, u64 addr, u64 size);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index 666dfd7b2a80..4b921715176d 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -137,7 +137,8 @@ u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo)
>   
>   int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   			  struct amdxdna_sched_job *job, u32 cmd_idx,
> -			  enum ert_cmd_state error_state)
> +			  enum ert_cmd_state error_state,
> +			  void *err_data, size_t size)
>   {
>   	struct amdxdna_client *client = job->hwctx->client;
>   	struct amdxdna_cmd *cmd = abo->mem.kva;
> @@ -156,6 +157,9 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   	}
>   
>   	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
> +	if (err_data)
> +		memcpy(cmd->data, err_data, min(size, abo->mem.size - sizeof(*cmd)));
> +
>   	if (cc)
>   		amdxdna_gem_put_obj(abo);
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index fbdf9d000871..57db1527a93b 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -72,6 +72,13 @@ struct amdxdna_cmd_preempt_data {
>   	u32 prop_args[];    /* properties and regular kernel arguments */
>   };
>   
> +#define AMDXDNA_CMD_CTX_HEALTH_V1	1
> +#define AMDXDNA_CMD_CTX_HEALTH_AIE2	0
> +struct amdxdna_ctx_health {
> +	u32 version;
> +	u32 npu_gen;
> +};
> +
>   /* Exec buffer command header format */
>   #define AMDXDNA_CMD_STATE		GENMASK(3, 0)
>   #define AMDXDNA_CMD_EXTRA_CU_MASK	GENMASK(11, 10)
> @@ -122,6 +129,11 @@ struct amdxdna_drv_cmd {
>   	u32			result;
>   };
>   
> +struct app_health_report;
> +union amdxdna_job_priv {
> +	struct app_health_report *aie2_health;
> +};
> +
>   struct amdxdna_sched_job {
>   	struct drm_sched_job	base;
>   	struct kref		refcnt;
> @@ -136,10 +148,13 @@ struct amdxdna_sched_job {
>   	u64			seq;
>   	struct amdxdna_drv_cmd	*drv_cmd;
>   	struct amdxdna_gem_obj	*cmd_bo;
> +	union amdxdna_job_priv	priv;
>   	size_t			bo_cnt;
>   	struct drm_gem_object	*bos[] __counted_by(bo_cnt);
>   };
>   
> +#define aie2_job_health priv.aie2_health
> +
>   static inline u32
>   amdxdna_cmd_get_op(struct amdxdna_gem_obj *abo)
>   {
> @@ -169,7 +184,8 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
>   u32 amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
>   int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
>   			  struct amdxdna_sched_job *job, u32 cmd_idx,
> -			  enum ert_cmd_state error_state);
> +			  enum ert_cmd_state error_state,
> +			  void *err_data, size_t size);
>   
>   void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
>   void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
> diff --git a/drivers/accel/amdxdna/npu4_regs.c b/drivers/accel/amdxdna/npu4_regs.c
> index ce25eef5fc34..619bff042e52 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -93,7 +93,8 @@ const struct aie2_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
>   	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
>   	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
> -	{ .features = GENMASK_ULL(AIE2_TEMPORAL_ONLY, AIE2_NPU_COMMAND), .major = 7 },
> +	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
> +	{ .features = AIE2_ALL_FEATURES, .major = 7 },
>   	{ 0 }
>   };
>   

