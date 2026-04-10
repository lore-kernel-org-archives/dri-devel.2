Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFF5F45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E4E10E066;
	Fri, 10 Apr 2026 20:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uKhooyd3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3258510E1D5
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 20:38:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A29UkYhcSBNmIrpaJSA+vTgcYpdD7Yp/rZLOegEQXFh57VCUxEX2AxHjLgcuaA/bhuBsiEg5WvmD6z9b6RrWGi5ZAELJyc5EF6JCodLjO0SbPc5cO80dl/FVJNX2rofL3o0gLekvU4qeDE7I9434VnVDXezoa/TypJMt35m2XUmGLeVv6Bb5NJsHa9rY4zHd7yy3U2jd5CCg1cDrhYv+B8//YXOZUprZrfNMz5ZZzBKMIdFLev3FoIEjx6ov0Rw7ZQqUcIkfEHh88mQPcH+kwAkvebkn77oSMdIjWbXYONUO8FXS49FMv4boLF1TgY02DiCkTSVCLmGcDqjjylYPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRjwKJFjNw9BVcsP/D2xm5eKbcLDCiSqpN5w3B7gu0A=;
 b=bo3wDivQDDVagVgNFi9//V37FEoZTJdNIoirA0udttWH+JYMXdKOKrRsnoPvHJHRLpyMZGG5QbHMpKd5ozc03dTJnwHIwYCzs3DmlElVZMr+tl/9ISKOul3pkoilBdxhlwYwP8nO/ICbZiQHxJ/fVfKj0H8Lru54Gb/nUv3huW+CjNQbI4HYpM+nuYezEUg6iuhQCGFAVkGslJDVc2p7g4KyV5rGvxvG+VMiH8Yb9sFrriTRWjP6neJsZdB2yniPfVCNxYwJC7oRTDqnetlHOyqGm9r8Ym4ehY+/XOMis8rxavooOx24M6+1+NERhacSNiEw9zd+qbjf1v6yvDDaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRjwKJFjNw9BVcsP/D2xm5eKbcLDCiSqpN5w3B7gu0A=;
 b=uKhooyd3r61DemJsUa7jmGkUWz4WP7MBuxkYQSDVhvWjTfGblMEzDzgwHNS24rfsR/zRjXTLPRpVvFi+GYgJG0AF4xzjlqrSZRjAq7r96I+SYwdYRa4cgPTF5gGaQYEOzzKzx8FZVGW6AP1ZvCf1SY2Tm4g/kDJFxcd8CzDNJ2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 20:38:01 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 20:38:01 +0000
Message-ID: <561d6991-d83e-40be-8baf-e705e6d5159d@amd.com>
Date: Fri, 10 Apr 2026 15:37:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Check for device hang on job timeout
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260409175826.195665-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260409175826.195665-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::8) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c43725-d48b-4126-d207-08de97410e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: SVnh0TjVbkaKiLB7XZaQ+8O9/Lz1JH/zR1+ZHe9SIO3KdefCFfEJMDLK+wfYrZf0B+LBL3ZuKEQVSyf5+yvGY2FHrk/TBRDImk4HihQq+TcQPCmoV9Jbam1ZCeQPpVS4dt4xKOIUMqiuTKem2NfHYTtSGP97+v6vt3ecljLXA2q4mqP6tIAUyctOzRQj66Ltix4/9Bk9u3FnIa0WpsB8VLlFq5OMf8lw3IwMR+6Fo28KzNKc6KRAzUq5pvZVgECDJNYBuXMHelLJlBEXsn0i7GjMHlIC88hyFUfi4TRDOrUIslUfXjsz63KLaACCnZJ7LM6sjIuNh7TxfrLAmwiJciQlSJkmOV8B85SZc/JvBfkQa3sjjnS5y6Fi9GDcY9Ioc8fZVEf7AIChkMZZLbcssNNRKeHJNmLgH9kreXV48Q/pz1o11CZnhpgyEFNaDWRnN9P0BZHTwnMpz9lbAMVCsnS2ruK/8zHNhjuj48vvWqhv2zWEmWpyD3h07G4BPm+mE6nvNwF9dO2MFWrPvXOaZ8LZo4zCk3kIKJPZfqg1boLBLEGpSFJFk3ii0mOXTkZuKUDjXHJoP9ba5+piPK7YNhQ7VgmdDLGZwAHzxgxv6RP/6IsGvMnJgaJQyR3tHKoTkXDIBWkNu2b4xew7dU1XqzG7ovS3pCx6HtQDdbDYGy5KGJdhxxs6qW2fKvocm2IdnuGfnJHIk2DgEyVRWoU/SGRLImOtffQhvKF6O8kMGWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzUwYjFYNDNVdTlrWElxNGZnVzRCQi9Eenk0dDNBMnhzN2JVNE5ud0tQWnVO?=
 =?utf-8?B?YWIvZk5Dc0Nad0R0TXpyeVV3WWYyZ0NOUkRac1ZiMlZvY252SVpBYzhpVS93?=
 =?utf-8?B?M2xvbnUyMTIwZW1vaDFKajZ1ZmpFb05VTzJqWHcrVkZ3dm1zNTRieTJDODdU?=
 =?utf-8?B?NjFkZnpMYzF6RGpSUWRjcmpvbW9sbjhDblN2NGxDdXlYa1UrcDF1S1A2ZUFJ?=
 =?utf-8?B?WEpUK3Nxb1RHcnRVcEJLbGlVT0RXVmszTGJlSHFUU1dVUGh1OFNkSjVIM0xi?=
 =?utf-8?B?R0ZaSGpXbU8xQTJUZzl6di93VWtIa3RWNGYwNnBBZnhhSWpqQkZSN05tb2l5?=
 =?utf-8?B?bCs2WFZIdWFvR1FpWXgvWTd1S1VoVEF2Y3JDUWhkSmpTKzd1czZUZ0hWalc5?=
 =?utf-8?B?MFVhN09yR2F1aWhlbnBnNlNhTWMvOSs2RXVpVTJMRTVkNFdERUpsVmxrbkdF?=
 =?utf-8?B?eFhXZUh4Z0ZtUEYzWjBxVWMyV0RqYlB1YzRuWlpnMEV2RDcrQzVhajlCVEsx?=
 =?utf-8?B?RGFPZlZTbXN6c3VwVFFaL2pFdi94c2xhckdFTEwvc0JSaDV0UWhyYUo3OElN?=
 =?utf-8?B?dUhIcnFiVlFNNFhoV1VhRWJDRHl0QjVTUzBNNWZqOGk5MGh5VzRFUTlCRGlG?=
 =?utf-8?B?anR5YURuT05CeGcwOU1MaTB1bjYySUwrMkxVaThMYlVVMmtjbS94UGVYdVEv?=
 =?utf-8?B?QkNWTVdyU09VWjUwUHMrdVZ1anEzMmRqOTQvRkZIU0NDV3RHYmtybjcrWnp0?=
 =?utf-8?B?QndZczk0em1OYllaYzJENnVEOHpHTXdaM0JqN1B0TVArV2cwTFhZWWF5enpo?=
 =?utf-8?B?eU5JaUFKZEhoTmFsalNhZndEV1RUZlJZUkYwRzliaHFiVzVZQ0k1MlluaUY3?=
 =?utf-8?B?bWl5cnh5TkVyZUl2R1BaeU9TYi93UlJ4ZHRtRUwxRXVJZXd2UUhDWmpUcERm?=
 =?utf-8?B?ZUwzUVRtSmVzeWZYMGFSMEtQVndmdjdKWWlZd2dnbHRscjV0dFFrUFZmQytD?=
 =?utf-8?B?ZGp5T1Q2a3ZJdnVRSkFWcFZwb2xnRldVYk13REN6Ulp1Vkp0eS9jYjhhQXFw?=
 =?utf-8?B?eGhVNDJQL240UHNJNU5ocGpkNkFwY1cwTGxCekdkM2xOV0J1ZXR2U05rdm1j?=
 =?utf-8?B?RDcvd2JtejAzVHYyY1BzaWhKaWFRdU9qNEhIajJGQU00bW83MnhyTGhMQ0t6?=
 =?utf-8?B?K254M0w0QWZxOXZOQjNFN1h2RWYxTXdCaXdjdnFYV1NTRWlkNXBrRmxPQ3Vl?=
 =?utf-8?B?b1VqQXlwWEpZeDVpbnM1WERQdUM2ZTArMGVoazE1QjdBRzZTK0dIK1BXeS9j?=
 =?utf-8?B?dkZlMUxYS1JtZEhLcytROHpiWTJZYUU1Uk1sR1czS0hsVFRTeHhQSG9Nak1L?=
 =?utf-8?B?SEhyNHBoMTloV0V3SCtoWGN0YjN5UktCTlRPMVd4Z0hFUytqYjM4TDh6aUJk?=
 =?utf-8?B?TmoyWHo5RzJHbDdXamJMVU51alhXa1lDSlNxVUlHNXZEbFJaTCtJYkprZ1l3?=
 =?utf-8?B?SUY5dHhRMWovZExQR21oblB6anhCckhNd25zdzVRdzV5Z250QkhyYzJxckJw?=
 =?utf-8?B?eFoyaDRxOVNtVUhzRkpESERleGZIMmt4M2pId1FzQVlwZnRXU21aeHpEU1dp?=
 =?utf-8?B?Y0tDT1Y4elJubkhUVmNZVHZKbDBKNUpiWkx5YnE5OXluYy84MzNnaXdFYTJE?=
 =?utf-8?B?WGlKcTJnZ1dnaGZOUmxnUC9hODcrYnMvVHZ4TDFZOWRaOExEMTBidlBJL3g1?=
 =?utf-8?B?QkwxeE0zMDJYZFBSd3dFcFM5ODRWc0cySjlpK2VKNnRKWVFDTjJpb2ZKa3dh?=
 =?utf-8?B?SWtza0x6Ujd1TlgrdysxUDREc3B0SUx2dURlV28yU1NkRTRNVm9ZK1lUWnNY?=
 =?utf-8?B?Y3RPNjdYbjMwa0d6dUI2WklUNWVVNnQ4K2lQSzNva2pCZVNXcjZ6MENQTTk3?=
 =?utf-8?B?cFhwU1ZZZk0rOWhyRFpncm9uRTlCYzNORk9ZMXE2VEQrNjNWQjJBdXEzRjdS?=
 =?utf-8?B?QVNhcjB2alprRjVtUDcxN0hjbDh3VWhsWlU1ajZKbXNZNnE4MVJsRWN3NzRW?=
 =?utf-8?B?ZHc0L0V1Y2dHcXNKUmtMcmphTUYzczJJWUZacTRuaE9uM05ha3B0Q05WMzNC?=
 =?utf-8?B?azY1OHlnSzBpOWVnTWtVVFA1T3c2R0p5WVpKYjJ2T0FRTlZsZTVYdmJlck9x?=
 =?utf-8?B?Z1Nic1JIRUg3L3kwVE9YSk5VZ3d4dGZTVCtXL3hZN2drR0JLaXY1anBFWURi?=
 =?utf-8?B?WHlqSlhIU2s2RWMzWi83T2ZVQ0lOUU50a3IvSE9KUStGL2VDRmU2OWN0SllO?=
 =?utf-8?Q?RMbjEyLXyv/ncXQeHY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c43725-d48b-4126-d207-08de97410e7b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 20:38:00.6137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb8uErcCdTkz+DVybJ7w1FUZBSaK9oj56Hti03UwBIWCQ0jhhc98LXk7x0U0shRHRRT3FSh1pjwMVIVoZ6YAWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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



On 4/9/26 12:58, Lizhi Hou wrote:
> A job timeout does not necessarily indicate that the device is hung, as
> it may still be processing other jobs.
> 
> Track whether any jobs have been successfully submitted or completed,
> and use this information to determine if the device is making forward
> progress. If so, return DRM_GPU_SCHED_STAT_NO_HANG instead of treating
> the timeout as a device hang.
> 
> In the meanwhile the timeout interval is changed to 2 seconds which meets
> the userspace requirement.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 36 +++++++++++++++++++++++++++-----
>   drivers/accel/amdxdna/aie2_pci.h |  6 ++++++
>   2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index f97755d60fa3..ddcf06a6b80c 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -27,7 +27,9 @@ static bool force_cmdlist = true;
>   module_param(force_cmdlist, bool, 0600);
>   MODULE_PARM_DESC(force_cmdlist, "Force use command list (Default true)");
>   
> -#define HWCTX_MAX_TIMEOUT	60000 /* milliseconds */
> +uint tdr_timeout_ms = 2000;
> +module_param(tdr_timeout_ms, int, 0400);
> +MODULE_PARM_DESC(tdr_timeout_ms, "TDR (Timeout Detection and Recovery) timeout in milliseconds (0 = disable)");
>   
>   struct aie2_ctx_health {
>   	struct amdxdna_ctx_health header;
> @@ -39,6 +41,24 @@ struct aie2_ctx_health {
>   	u32 fatal_error_app_module;
>   };
>   
> +static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
> +{
> +	WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
> +}
> +
> +static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
> +{
> +	struct amdxdna_dev_hdl *ndev = xdna->dev_handle;
> +
> +	if (READ_ONCE(ndev->tdr_status) == AIE2_TDR_WAIT) {
> +		XDNA_ERR(xdna, "TDR timeout detected");
> +		return true;
> +	}
> +
> +	WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
> +	return false;
> +}
> +
>   static void aie2_job_release(struct kref *ref)
>   {
>   	struct amdxdna_sched_job *job;
> @@ -177,6 +197,7 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>   
>   	trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", job->seq);
>   
> +	aie2_tdr_signal(job->hwctx->client->xdna);
>   	job->hwctx->priv->completed++;
>   	dma_fence_signal(fence);
>   
> @@ -385,6 +406,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   		aie2_job_put(job);
>   		mmput(job->mm);
>   		fence = ERR_PTR(ret);
> +	} else {
> +		aie2_tdr_signal(hwctx->client->xdna);
>   	}
>   	trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
>   
> @@ -415,9 +438,12 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
>   
>   	xdna = hwctx->client->xdna;
>   	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
> -	job->job_timeout = true;
>   
> -	mutex_lock(&xdna->dev_lock);
> +	guard(mutex)(&xdna->dev_lock);
> +
> +	if (!aie2_tdr_detect(xdna))
> +		return DRM_GPU_SCHED_STAT_NO_HANG;
> +
>   	report = kzalloc_obj(*report);
>   	if (!report)
>   		goto reset_hwctx;
> @@ -429,10 +455,10 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
>   		job->aie2_job_health = report;
>   
>   reset_hwctx:
> +	job->job_timeout = true;
>   	aie2_hwctx_stop(xdna, hwctx, sched_job);
>   
>   	aie2_hwctx_restart(xdna, hwctx);
> -	mutex_unlock(&xdna->dev_lock);
>   
>   	return DRM_GPU_SCHED_STAT_RESET;
>   }
> @@ -608,7 +634,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>   		.ops = &sched_ops,
>   		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
>   		.credit_limit = HWCTX_MAX_CMDS,
> -		.timeout = msecs_to_jiffies(HWCTX_MAX_TIMEOUT),
> +		.timeout = msecs_to_jiffies(tdr_timeout_ms),
>   		.name = "amdxdna_js",
>   		.dev = xdna->ddev.dev,
>   	};
> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
> index 7c308672b5fe..81564483cb16 100644
> --- a/drivers/accel/amdxdna/aie2_pci.h
> +++ b/drivers/accel/amdxdna/aie2_pci.h
> @@ -165,6 +165,11 @@ struct aie2_exec_msg_ops {
>   	u32 (*get_chain_msg_op)(u32 cmd_op);
>   };
>   
> +enum aie2_tdr_status {
> +	AIE2_TDR_WAIT,
> +	AIE2_TDR_SIGNALED,
> +};
> +
>   struct amdxdna_dev_hdl {
>   	struct aie_device		aie;
>   	const struct amdxdna_dev_priv	*priv;
> @@ -197,6 +202,7 @@ struct amdxdna_dev_hdl {
>   	u32				hwctx_num;
>   
>   	struct amdxdna_async_error	last_async_err;
> +	enum aie2_tdr_status		tdr_status;
>   };
>   
>   struct aie2_hw_ops {

