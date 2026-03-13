Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D79107BCD6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185D510EB99;
	Fri, 13 Mar 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2/IwV5T";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2282810EB99
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqH6oIVD/90Jn/XHa1l3m01TD4B7r02APGxLBP5xeT6bxeNJovwjFTc8iWUkLw2PAA9dd2F5pBoajnJStpEFXtRbF1K4/Muisu/AWu086BlKGWNmu9bBkSmoxCBBPpeaI6a6MhZhlo7Ye0GN5ZXX7OzL33LiBvKGHDkNwNUsjlut6STaLmudYAa5+ma9lzhTcM1efNXVfICyndQXLQIB1ei84EWS88zAQJE0aP8/Z/gfQaO9QQ8X6155l12M61oasyYQj6AO1PlRiifow0344DJhaXZfmymMYYo1T6y4FjLywpXPYDk+zFSOguOO4EqOf+bIYVTX8X/P37dCxUibtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbBbb33m/qRF5Sav7I1hfCawJMmNsXIp//ja20D8Twc=;
 b=IcFm62Jhuhp6KGodCt4g559dzzoqZFPL8hejG0TQtksIwNRkGbvFvvkfTVqHi0/oE9xUXKiefkJupzsfSKy50gX1bNn+6u6t8xUYpskf69iKy1HMviUf3HtYhziKbE3oXOqItbK/d51RKHD5BbW3tio7mNpK5uQLoqAn9G5McPirXcOKkm5quQwyQ01XmRnzOEGI9qCrXYPpbq3rdoF+kIdrPOHWw1VsBPRH1fBQXE9fx7oQZl9FYFIO8nJjFWO4Y8XlnrNj1TAalrmxx6IjAiao9uDjvAXAPmLjTLaQwXXwkF43mHPJyFr5VH4rqvJfFl//QSdr233Z2mJq0vqDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbBbb33m/qRF5Sav7I1hfCawJMmNsXIp//ja20D8Twc=;
 b=k2/IwV5TmmK/LeP0amZ5Tc/P1PdVBq2Yy6j2R30aP59ardb48JnPexLLdCROT0hz7ZQJZZANAkfYnh6kMTUra6At/no/kNlOzeN6IwctrGHQI8lqENldylqEkOQiaiIHuKvfi54s+4yvpIM1O3VhnOHaB4ubj0P9GmKlEp5DkNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 18:30:29 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 18:30:29 +0000
Message-ID: <5f7213f8-3daf-4cc0-9422-9ad2de814c8e@amd.com>
Date: Fri, 13 Mar 2026 13:30:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Support retrieving hardware context
 debug information
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260313181413.1108841-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260313181413.1108841-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab006ba-6a0e-4a2d-6622-08de812e9a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5E25l+ZF9i027d3wVGTcR48BOr3bRo/2o17LHgEYOtnnFsUak1I0ABdg9ASiZb0qzOmO0cUd+B3PGoV4Y+FkSlQWPEUd7QQ016Kyb+lJlhiWdYLSubkt0HMYyOUvMyJedmNXeCNgPcUPVIcoAlM4KZBaAwhgZk2dUGI+Q1cbG15wUflFoYMEzjPoRO50OyDUHylijCrAPVxlmn9S4zbe0o9epQEvUntePSuHcDv/yYEn2xuG4HvDDpL8yM5F+IDeIrFDyWQ0H/1Z9nvkEFuGQnsMcAfosO3seZCiAotiL4OvKCENEHzq9QlYiHhHXCVmmGUgSQ77HdX9EBYzJ39aoY3nLtxU1kAOY77EonJHGMPXA9/ySkB19ClR6CbjfY9Jii+fzsxm/RhBRdPEa4uayNAiwyiqb67hrUOyhe5Cs8Rfi06VXKcTe3F6+86s3/3keHSDeeMG3TmLChuIxNPCRwbOraxdIxoB7/vS1sFaOzaFR23KzILKT8o3MPXOH44nec1m12nwD3yWfBlSw1rnnILyJ5qEY6aq31LwnQV+ggJDXVUrZ6tFU5VYWUP6I6TEnP/lcE7U3dVPHBbi2t/mHH5vxw9ltD+S1P0pN0EAUmDA/EIfPkYOnMFBrC0+hLVXpmarDD/k/llnNYQPn3VOal1Ar2av2R9vbgyPYeSJPP3kMqIHPrN7ERZtYr3SWnYnwmiCM24cym61iwPFsdje6MLQm1uAukw5xwgK512YV6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElHbXl3bnFEZGVMQ2Z4cTMxU3ltZVB2UDdTZi9CR0JNUjBkbTlDb2ttcmxQ?=
 =?utf-8?B?UG5XWEFHMmxJbmROV2x4MDN5MVFjODNxd2x2WVVOSHdnNitNaUFSMDFJMVJn?=
 =?utf-8?B?TFFPM09YbG1WTUZpdWd6TzRESkRXYnFJa3FnUEl4NVB6c0tLZFZXVFhmdWNZ?=
 =?utf-8?B?a3RmU1cyQmJDb0NyR1NNaG5pK3ZjNzhkbkJwOVRUMnJUbUpTRTM5Y3poMmpv?=
 =?utf-8?B?V2pQNjJPVVpibURlKzdRTHFlMTdwTklCbjdYVHR0VGRQVGNxc0hGVTYvMVha?=
 =?utf-8?B?d3hOY0w1dVRyNjhiNFZtdWdvNldwMGk5d1VGeVovODk1elQ4bUJHRTAvODBu?=
 =?utf-8?B?Q0JyQWFlZVJxWTdGVkVRSjR6SzU4RUxhVEV4Wll1cEVZa05tcTNPL2Zqcm51?=
 =?utf-8?B?OXE2UFZ1TVZBT1l6QzFtS2JUbU1xNmQybU1NS0xZQllVU0NWNlhjWlA0V2Ey?=
 =?utf-8?B?T1FNR3VQSTBQaVNudWN3Z3ZWeUZmSnBGWnZ0R3Jjd210UjI2K2hRQ0lDanhP?=
 =?utf-8?B?QTlUdXFmSm5MbVdaanBZenBUQXlWQnpUYmJOQ24xNi9GdDNadzJlZXU2bldU?=
 =?utf-8?B?c0FRc2NsdGpybmpMSGVZTDFKUzZudWFtMGFhamZYVDFwMXFrRUU0eXZXNlJT?=
 =?utf-8?B?bFVkWW5qMTl2WUdZaHo5T29MZnQxMHU1d1JDUXFOdnFMaHZBNnB4YlJxcml4?=
 =?utf-8?B?OGlMckh0RDhQUlI0aXFJb2ZjNVZnYVk4dzZodk1qN3dlU0pHckh4WjBZeXZB?=
 =?utf-8?B?dklRY1NRNWswRWF4UWJzWHlNUC9qUW56dER3QzJ0SEdNSTZCejk1M2luTTE0?=
 =?utf-8?B?c3l6b21vRVVrdG5oR0I3QnZ0c2ZjZkl3WVNRcVdFL3k5QzlzK3RRYkFzenA4?=
 =?utf-8?B?d2FxZGhvLytjZDRyZEJzcVlLQTQ2MjBYanZWUW9zTzFVYlM0eG9wMC9mby85?=
 =?utf-8?B?VUw0OHdlSTBmQXJKdWtOMEpWc1lKOGhLcnZCaEJCRG5SdnRTRkY2Mm1ybktW?=
 =?utf-8?B?UEhxMmRDTHJUb1ZucGJNZk5Fem5jWDBoMmo3WDhKN3BHSjk5VHU4QjVMN0tj?=
 =?utf-8?B?SFhOQ0Z0ZDgyb2lkL0NKOU5mUjRVQkp0c2RCL3E0N1VUZ2xmWEhCQ1Y2QUhv?=
 =?utf-8?B?c1FZNHBCc3Q3Q1AzWjJyTFgrNDd6VFVtKy9JYTgrdDRvVXhRem4ycmQ3MHlJ?=
 =?utf-8?B?b2tFazJ6V21jcUhIR0cwbElFMkZ2MWJNWjBFWmoxUXJJRHJSZzJOTks4aWx3?=
 =?utf-8?B?K0YzQ25udjcyaFBna2JtQmRUamlubm9BaklnQ2RZR1lKaHlSRVl3bmN3WlQw?=
 =?utf-8?B?dG8wMGlDa0NBNk1VM3pFVGYxL1RvZHp5WWc1Ni8xcnVsbVlKbG5XRTBCTDJm?=
 =?utf-8?B?S0FLSVJVYlgyVWd1a3hselg2UmN4cGVtUGNIaTFYTkNVZjFlT25VVzljRG1x?=
 =?utf-8?B?UjlzVzN3Rk9LdHFjY3FUTFhpQVo3ekxtdU1pUVAwUTAxWUdxK3p0WVVxUUxW?=
 =?utf-8?B?YWtocDZHZGlGVjluQUthT2RydWdCbDliMDhFeTN1WCs0QVRMdEl3NGdGV1Bj?=
 =?utf-8?B?L0JHVjRjYnQ3c1pZbVhtZU90RDcwMXB2Sm1zSktQZEErKytBM1V0OHp5V25n?=
 =?utf-8?B?aEtITkhyQmZ5WE5YekJkc1RZa01sRjVCZE90TUpqZmhUSk1LcmIxbjU0Um5R?=
 =?utf-8?B?ZmZoNE85ZmZkWlNOTjR4M1cwbzVMeGhkS3kvYlZuQ1daYWE4ZkRObGFxWjRs?=
 =?utf-8?B?cml1L0dhR20zdmlFMHJqczVvb3VCM25BSDdKeGtxRmthODk0VDg3dUI5RDk2?=
 =?utf-8?B?RlltS0JKWHRZcXdCZDdNS2FkZldTbWJBOEJVZHVNdW5JcTBybTJZYkZ1TnR2?=
 =?utf-8?B?TVNIeFF1aklCREZKQ1d4OTVyYy9sT1EwQ1d6dnBTclN2QU1Xa0h5OXlqajBY?=
 =?utf-8?B?aklxMW1ya2Jvd0JUdTlGT0F5Q1R0WWx6cm9ldUdKNUl6OXZMdmhwdm5DbElU?=
 =?utf-8?B?Syt5M045cHBGSEdqUXRFVXRIOXIxQ0xVSkpEVWFDWnJYSTJIRmhUN0c3NURw?=
 =?utf-8?B?OVNrQWd5Q0JmWkZXVkNGRWF2K3NEdFhpcVM4OG5uZkJ5alk4Q2xBY09tNE15?=
 =?utf-8?B?Wko3RG5NVW0vRG5weHFUUXhLVStkdHV6ZFNrQ1Q3RTZTcmU4YWM1ZzE2WjFS?=
 =?utf-8?B?ZmNiV0dacDh1RjkxUXVpaCtkUG1JTy9xS0kwMUVYQnBzOGkrWDZwYlhaMytY?=
 =?utf-8?B?S25lZWU5NDN0V0E2WDYrQlR0byt5QUhoVys5Z2JNWmt5c1pIMUp3ZzJyZUcw?=
 =?utf-8?B?TjB6ZWhvMjdUMmw1N3FBNU5GV0pVSU5VeTdBM2ZLL0dFSFplZnM5Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab006ba-6a0e-4a2d-6622-08de812e9a2a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:30:29.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+ZTTCMhnxvv53Z9+HCYIvAr2xFE3eaBceHjg9onUJOqIJ/kYfkfbHbNzxlgOniY2KYIeQcFPwCpNR8yvhYKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

On 3/13/2026 1:14 PM, Lizhi Hou wrote:
> The firmware implements the GET_APP_HEALTH command to collect debug
> information for a specific hardware context.
> 
> When a command times out, the driver issues this command to collect the
> relevant debug information. User space tools can also retrieve this
> information through the hardware context query IOCTL.

A few thoughts about this.

1) Depending upon the reason the command timed out, it's possible the 
get app health command also fails.

2) I think it would make sense to put this information into devcoredump. 
  Then you don't /need/ a tool to read it.

> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c      | 85 ++++++++++++++++++++++++---
>   drivers/accel/amdxdna/aie2_message.c  | 41 +++++++++++++
>   drivers/accel/amdxdna/aie2_msg_priv.h | 52 ++++++++++++++++
>   drivers/accel/amdxdna/aie2_pci.c      | 14 +++++
>   drivers/accel/amdxdna/aie2_pci.h      |  4 ++
>   drivers/accel/amdxdna/amdxdna_ctx.c   |  6 +-
>   drivers/accel/amdxdna/amdxdna_ctx.h   | 11 +++-
>   drivers/accel/amdxdna/npu4_regs.c     |  3 +-
>   8 files changed, 205 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 779ac70d62d7..8b7375d13e28 100644
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
> +	kfree(job->priv);
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
> +	struct app_health_report *report = job->priv;
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

Basically all of this information -> devcoredump instead

You can reference how amdgpu does it.  Basically it says there is an 
error, and here's where the devcoredump with all the info for the error 
is stored.

Then a process in userspace can monitor (inotify?) and (automatically?) 
evict information from devcoredump.

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

AFAICT you never unlock this mutex.

> +	report = kzalloc_obj(*report);
> +	if (!report)
> +		goto reset_hwctx;
> +
> +	ret = aie2_query_app_health(xdna->dev_handle, hwctx->fw_ctx_id, report);
> +	if (ret)
> +		kfree(report);
> +	else
> +		job->priv = report;
> +
> +reset_hwctx:
>   	aie2_hwctx_stop(xdna, hwctx, sched_job);
>   
>   	aie2_hwctx_restart(xdna, hwctx);
> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
> index fa2f33c322d4..b764c7e8816a 100644
> --- a/drivers/accel/amdxdna/aie2_message.c
> +++ b/drivers/accel/amdxdna/aie2_message.c
> @@ -1161,3 +1161,44 @@ int aie2_config_debug_bo(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *
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
> index 885ae7e6bfc7..6cced8ab936b 100644
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
> @@ -341,6 +343,8 @@ int aie2_query_aie_version(struct amdxdna_dev_hdl *ndev, struct aie_version *ver
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
> index fbdf9d000871..c067688755af 100644
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
> @@ -136,6 +143,7 @@ struct amdxdna_sched_job {
>   	u64			seq;
>   	struct amdxdna_drv_cmd	*drv_cmd;
>   	struct amdxdna_gem_obj	*cmd_bo;
> +	void			*priv;

Are you envisioning overloading the purpose of this member in the 
future?  If not, I think you should explicitly set it as

struct app_health_report *health_report;

That will make the code a lot easier to follow.

>   	size_t			bo_cnt;
>   	struct drm_gem_object	*bos[] __counted_by(bo_cnt);
>   };
> @@ -169,7 +177,8 @@ void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
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
> index ce25eef5fc34..d44fe8fd6cb0 100644
> --- a/drivers/accel/amdxdna/npu4_regs.c
> +++ b/drivers/accel/amdxdna/npu4_regs.c
> @@ -93,7 +93,8 @@ const struct aie2_fw_feature_tbl npu4_fw_feature_table[] = {
>   	{ .features = BIT_U64(AIE2_NPU_COMMAND), .major = 6, .min_minor = 15 },
>   	{ .features = BIT_U64(AIE2_PREEMPT), .major = 6, .min_minor = 12 },
>   	{ .features = BIT_U64(AIE2_TEMPORAL_ONLY), .major = 6, .min_minor = 12 },
> -	{ .features = GENMASK_ULL(AIE2_TEMPORAL_ONLY, AIE2_NPU_COMMAND), .major = 7 },

To avoid bit banging this line in the future, what if you used:

GENMASK_ULL(AIE2_FEATURE_MAX-1)

> +	{ .features = BIT_U64(AIE2_APP_HEALTH), .major = 6, .min_minor = 18 },
> +	{ .features = GENMASK_ULL(AIE2_APP_HEALTH, AIE2_NPU_COMMAND), .major = 7 },
>   	{ 0 }
>   };
>   

