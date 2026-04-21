Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7571FF94CA7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A92BE10E91A;
	Tue, 21 Apr 2026 19:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLgkiznc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9827410E1D9
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 19:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJKsbhiDNfpFI4cdxvHAtlG2pUtgx3lsGo5PcaYZF4SnvJQ/48dAC3/vbyTpzpco79ask7KzntDKN2h2kG/3uG5gNu5jvXdFP4rzaTk5qj5QYodSUaodxykkdn58qzgaLPNIpaYLsRWz5SN82Bj3AHmhxLYeRG3rO7nNmD3CLJx+m43EvBZfMceRayBOkibL4GM+7eTJ0bHei/BgR7z7twfU7cXg6y1sjb7esw/OAuXRpF/dH7GwxPvzJFoKv0my3+cetMPNN/WFLVMsVsu/GHVHbRfxWy3jaWrloZ1ESbVmnoYTVJRHeFR8MWCdRG+n7kRpKXsW9MI8JT14lK58gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue8P2zFtqkKTXXyey3aeJFiHoOXvfzPWM4+XFdhUCng=;
 b=ijqWNFjEARNtBoz1r/rkkDXHc5ZGobJDqOlq/AI2U2mDIPlHkYeOXWZxALFfR++JK0k2YtEOlEHGBlcscpcrjXU+sp6x60yhnJn9uCvWtpuQdXjRBr9vHXtogRssnccqYz8wfWKWvgdj1qxC3ENkoqjU9E7T/OoC2pkA4OI42ONjjIxlf3My8gjqnzwPY6tTVbGNzI9uOQkHOb0H96PKEbMaYn6ppgtYzPXLmQpqkqDk8fo6X5cWwtYpICJ/r6AGsBh1ih5t7ffxFo46IhWNDm4PkhnOCNzW9veuAjwOup7bCza6/3CcBzeD5BfyOrD40Td66VT96vScJO+8af267w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue8P2zFtqkKTXXyey3aeJFiHoOXvfzPWM4+XFdhUCng=;
 b=lLgkizncnmcC7LTiW2y1i3T0dZBTfIREGFxdOePLdwUOoq5UxyJLWftUe3SSonU0Teqv2t5ou0VRTrQkXccZ3p9yBf6LgEi/aZ7p5OwdncqaCR3yOIR8MWnHTCErA7RzanfR1oZx4KaSnt2SIAJqqVeM9OiRKBUOKOi/Rs2d/qY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 19:18:42 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 19:18:42 +0000
Message-ID: <83846da8-0c8f-4eca-bac9-08efe1c0eb2f@amd.com>
Date: Tue, 21 Apr 2026 14:18:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Improve tracing for job lifecycle and
 mailbox RX worker
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com
Cc: Max Zhen <max.zhen@amd.com>, linux-kernel@vger.kernel.org,
 sonal.santan@amd.com
References: <20260421181502.1970263-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260421181502.1970263-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:52c::6) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9c6e7e-827e-4ab9-2867-08de9fdaccd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VCAcKszbwkxn0mY/ewfAtcuHRss3VvbFk2iH/YUHG95gT7db/b53xUE5ikMd3X+I0rDlvdVC6Z9c8xrol29yCJK/l9D4I3lYdiigQNfaFlHKiVkA61ahmBRd88nN90+BEtk7gazWIR8Nv5CsAWQjsekSHcz9fRAvbLXa7J4JYRLJbtxKezUC3KtYL2f82Ib8yU4qqcrDr0VlRaw/JPMM2dz80onxNDcAz+7eUx8MJAILGjoDk2N9WVmR8s7E4Q6v75nzXJdfkneGADwFHuIEyoGPMBwg+BNT4KxBWdkZzLSB9Jjuc8q5kHoWWsIQZ9U1d3TZIcdnUvhOLx92Zi07iy0Y5XXj8dzRTWjY8wq4Vm2sgjRCsATqhVIJ9dFGIL8dkGJ2eCvwlyQxb6yRIFthlEUD0iBfC4GvZbeHFAJoUFD5MJZL9FS+9B67Jis4Bm6lJQCF2Earq/iD4xcdCRbi3H0k7ghpOWKFkzw+8iAY9HzfyxyaSUFjZO2Ad7dyhcc/st2EXAA+RqO9iuyVYhAhlBElORA57gDIHU2CVzeU69zw9NyRGsbks/ltGHk6kV+a3eZ+MiCxwfjXCfxUKtwo92ACsjJijXwzDfk8B8wldr670b1zr+Cdx0mXbiVEfiK94Pv5aDaSWXWN0rEBEmicgvL47jRVptg+1j6Dq9FXx4IsEbaFKi+rDKQJ+r9OB3SFMbKct2a58GcYo1iwOQRZWE3xvio1ZqxEyAM2IUAvlLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlkxUmlVSm9qTHVhc0ZDVndGNzNLaUg5OERuNVRPK2RzemRsZlhJeVNzQ0FV?=
 =?utf-8?B?N2NRaGdDQUdxalBuTUFZTU90SmlpZUZxVDgveTIxQVFUaUUvUG5aekdpc0ZZ?=
 =?utf-8?B?b2h5UTF2RDRWOVNaOVVtMDhHOCthQUhPQ0pSWHI2NnRZYWdmdm5ISmVGSWNF?=
 =?utf-8?B?b0tzUXBrY055Q1Bob1BxMHh1anF3TmpKRlg3amRGa2l1QlBwL2dSeWhyL3V3?=
 =?utf-8?B?R0w2R0JtTFl0bjNzV2FqOER4NVV1MGVicWdJbmhpSmpSbndEV0gwQitLbHVH?=
 =?utf-8?B?SVAzR2FXdG96aWF4Z2YrYnRHRXBZQ3lsNzUwRlovNHFnTjBxQk1nK1Era2NJ?=
 =?utf-8?B?RVhxRlZGaHFNUnh1Qk95ZmEvbTd3UFRLNnoyTXBydUNqYjB0alYrQXhsY05h?=
 =?utf-8?B?ekJ0YysvVnpWUXJKZVE4ZzN2eVVPRmFxR3cyUG9CSWlMVTVncmJjV1I5Nkpv?=
 =?utf-8?B?WGY5a3VWemNickF5Q21mNzZkWG1xd0x0cUJiKzZqa09YeXBOSHZaZTFXQzVl?=
 =?utf-8?B?RGFuWGZLd1ViTHAyNjB3cHFMMXVsMUlRNFRrZUVTcys2Vy8welhGUUh4YUE4?=
 =?utf-8?B?UTR6bkd0d2ZkMnNDZXdLVXppNjkvUksrRUl3ZnZ4M3YrN3o3UFVwc1pFd0Vi?=
 =?utf-8?B?dksvMmd6V01ISEpiMlZ5MXE4Z0xQQUJXUTc0N1ZaV0c5UkVRenkzWnFBR0FJ?=
 =?utf-8?B?ZTFKdmM1RjVPNnMxRVhPYmdZVy9kb2d1Tm9FbUhYdXNjZE1wSzZrVENBYzBj?=
 =?utf-8?B?MXZxLzdwQWhLWDBPMkJrNEZHd1ViWXZlWjJEenBxYUg0ZGNGWXRGb1o5UGh3?=
 =?utf-8?B?bUtzVi9GSzJKVHFuTmMzQXZFL0tIUmthWnFhOXFvNHM5cEdMYVJHeHVZSVdR?=
 =?utf-8?B?OHVEYUFmQTlkRjFjR0ZjamdaVFN4NU1ZVmtwTUR0YW5VTnZUemg1MVJLQ3Mx?=
 =?utf-8?B?OFA3QVhiK3JGTTdRbDVjUklSR3F0b2ZaWUVkc2lCcGE0T0ZHL3JXWks1U1NW?=
 =?utf-8?B?c0tRMVdRT2l6a2l5cnRNQlZzSkpoYVBCdHVvbEM1RmtBZ1BDWnUweWp5U2xC?=
 =?utf-8?B?NHU1UklsMVVKUnQ2dnhYZ2pSd0hIa1BETVBHbTBnYlIyNFZrYzFVSHJQZG1u?=
 =?utf-8?B?dnNBbVA5NTZQaUZvanUxR2JmYTE5Mm5YS0hSeG1jSlhJSWxncklLWGVJVmQy?=
 =?utf-8?B?QjJzVGY3OEZ6aTcyQk1JWXY5TzVpZWF1UjlkVVNiL0pxMllKTXlvZ2x4YThT?=
 =?utf-8?B?R3JETjEyKzU1NWlFRHVzeGFYSzRxTUFyTVluMXpVOU1GTXIyMStGbGtsNG9m?=
 =?utf-8?B?ZUVETndOUkhqeDJIVmVua1hNQkFQOXlCK0tZQVVURkJXeUU4ZE4vQWI5Wmto?=
 =?utf-8?B?UHVsVHorN25kWnV5VXV2N2lVbzV2RkRFYlBkM1lCQmpiNDI3SmZvR3pTa1FC?=
 =?utf-8?B?SS9zUUxlSTc1Qjc5RENXSEY4SVZHblZKSWp2L1N5R25zR2lMYVJTZTY0aUlI?=
 =?utf-8?B?bElrYmE3cnFjOFB2VGpKV0RYRXFJVDZ1TFpiZjFmVnBmWkozYklZZWdISms4?=
 =?utf-8?B?UXVHN0ZvSWRRaWRGdjZjN2JXRlZOazh6cmNWNFlocTNSTkoxSkRhY2xqL1Bo?=
 =?utf-8?B?bjByQ1JneVBGUVpPd2FGY1JQK1ROZDBCYUVnWW9CeEROL0RKTlAyeFpFMGEw?=
 =?utf-8?B?bjlLVkZ4MGJQU1p4ajk4NFIxNDVoV3ZqZ3BYQ2lOTmJXbmJQWlJ2c09wMk00?=
 =?utf-8?B?aFQrV1RFOFFob3ZaQ0JtaXNFalkrY1FtdGtNZFE3SllEVnpiVG9XZmdUdUFF?=
 =?utf-8?B?dEUrZU1XN1kvMElyV25EdHYwOUlxblUwVEpSZXFPSjF6UTJkNjZUSHhReTAz?=
 =?utf-8?B?Njg1QW9WY0h6RHVLYzR4eWpiNlljS0dhaVFHRlcyOEdOeURWbzUveDdBUXB0?=
 =?utf-8?B?M1dvSTRxUnlTNXNSdTE3RDk2SXdjSlZMWGR5NUZxWXhEL2tzbG80VDRGWTZr?=
 =?utf-8?B?NGU4MjdodkloQkhkeGRWUHM3L1VveGttOXUrVFNRckthbTFoLzV2R3A2Kzg1?=
 =?utf-8?B?a1h5R0RqVmR5a2dBSUxVZ3hoTDNGQ3kxWUsvcW54N3FMMEtXNVFoNVVzYW0v?=
 =?utf-8?B?RzNnRE4yVHFTTmZiVGM2Y2l0UVZjK1BESXdzbHhIcGNkenFuMVdUcHptTWFB?=
 =?utf-8?B?UUVwTnFVM1N2c2p4TS9ZWnowV25lWDk4WldjaW1meWJqTXVkYzE1TnlqcjNv?=
 =?utf-8?B?cTdsalJRRXhYZkpGOTc5cTVvZ0FOQ0xsK3lmWHVwbldSZTJXNGZjTDhlRU41?=
 =?utf-8?Q?945VzUgXSkKGgSQKH7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9c6e7e-827e-4ab9-2867-08de9fdaccd9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 19:18:42.3501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN+QgJ9/LMjZx3pCUM+yKVbuLVnow3PgP1b9g3VMA4LAJu0Pl4RoauPumkPRvfADexLG8REfY5MNuOFg69b1eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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



On 4/21/26 13:15, Lizhi Hou wrote:
> From: Max Zhen <max.zhen@amd.com>
> 
> Add more trace coverage to amdxdna job handling and mailbox receive
> processing to make driver execution easier to debug.
> 
> Extend the xdna_job trace event to record the command opcode in
> addition to the job sequence number. Use the enhanced tracepoint in
> the job run, sent-to-device, signaled-fence, and job-free paths so
> that trace output can be correlated with the command being executed.
> 
> Also add debug-point tracing when a command is received through the
> submit ioctl path, and add a trace event when the mailbox RX worker
> runs.
> 
> These changes improve visibility into job lifetime transitions and
> mailbox activity, which helps debug command flow and scheduler issues.
> 
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c        | 14 ++++++---
>   drivers/accel/amdxdna/amdxdna_ctx.c     |  3 +-
>   drivers/accel/amdxdna/amdxdna_ctx.h     |  1 +
>   drivers/accel/amdxdna/amdxdna_mailbox.c |  1 +
>   include/trace/events/amdxdna.h          | 42 ++++++++++++++++---------
>   5 files changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index d37123d925b6..3b0feba448c4 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -64,6 +64,7 @@ static void aie2_job_release(struct kref *ref)
>   	struct amdxdna_sched_job *job;
>   
>   	job = container_of(ref, struct amdxdna_sched_job, refcnt);
> +
>   	amdxdna_sched_job_cleanup(job);
>   	atomic64_inc(&job->hwctx->job_free_cnt);
>   	wake_up(&job->hwctx->priv->job_free_wq);
> @@ -195,7 +196,8 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>   {
>   	struct dma_fence *fence = job->fence;
>   
> -	trace_xdna_job(&job->base, job->hwctx->name, "signaled fence", job->seq);
> +	trace_xdna_job(&job->base, job->hwctx->name, "signaling fence",
> +		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
>   
>   	aie2_tdr_signal(job->hwctx->client->xdna);
>   	job->hwctx->priv->completed++;
> @@ -366,6 +368,9 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence;
>   	int ret;
>   
> +	trace_xdna_job(sched_job, hwctx->name, "job run",
> +		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
> +
>   	if (!hwctx->priv->mbox_chann)
>   		return NULL;
>   
> @@ -409,7 +414,8 @@ aie2_sched_job_run(struct drm_sched_job *sched_job)
>   	} else {
>   		aie2_tdr_signal(hwctx->client->xdna);
>   	}
> -	trace_xdna_job(sched_job, hwctx->name, "sent to device", job->seq);
> +	trace_xdna_job(sched_job, hwctx->name, "sent to device",
> +		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
>   
>   	return fence;
>   }
> @@ -419,7 +425,8 @@ static void aie2_sched_job_free(struct drm_sched_job *sched_job)
>   	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>   	struct amdxdna_hwctx *hwctx = job->hwctx;
>   
> -	trace_xdna_job(sched_job, hwctx->name, "job free", job->seq);
> +	trace_xdna_job(sched_job, hwctx->name, "job free",
> +		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
>   	if (!job->job_done)
>   		up(&hwctx->priv->job_sem);
>   
> @@ -437,7 +444,6 @@ aie2_sched_job_timedout(struct drm_sched_job *sched_job)
>   	int ret;
>   
>   	xdna = hwctx->client->xdna;
> -	trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>   
>   	guard(mutex)(&xdna->dev_lock);
>   
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
> index ff6c3e8e5a15..2c2c21992c87 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
> @@ -514,7 +514,6 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
>   		goto unlock_srcu;
>   	}
>   
> -
>   	job->hwctx = hwctx;
>   	job->mm = current->mm;
>   
> @@ -612,6 +611,8 @@ int amdxdna_drm_submit_cmd_ioctl(struct drm_device *dev, void *data, struct drm_
>   	if (args->ext || args->ext_flags)
>   		return -EINVAL;
>   
> +	trace_amdxdna_debug_point(current->comm, args->type, "job received");
> +
>   	switch (args->type) {
>   	case AMDXDNA_CMD_SUBMIT_EXEC_BUF:
>   		return amdxdna_drm_submit_execbuf(client, args);
> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
> index a8557d7e8923..355798687376 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
> @@ -119,6 +119,7 @@ struct amdxdna_hwctx {
>   	container_of(j, struct amdxdna_sched_job, base)
>   
>   enum amdxdna_job_opcode {
> +	DEFAULT_IO,

Do you really want this at the beginning of the list?  Doesn't that 
break uses of amdxdna_drv_cmd that has the previous indexing?

>   	SYNC_DEBUG_BO,
>   	ATTACH_DEBUG_BO,
>   	DETACH_DEBUG_BO,
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 37771bdb24a1..cc8865f4e79c 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -361,6 +361,7 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>   	int ret;
>   
>   	mb_chann = container_of(rx_work, struct mailbox_channel, rx_work);
> +	trace_mbox_rx_worker(MAILBOX_NAME, mb_chann->msix_irq);
>   
>   	if (READ_ONCE(mb_chann->bad_state)) {
>   		MB_ERR(mb_chann, "Channel in bad state, work aborted");
> diff --git a/include/trace/events/amdxdna.h b/include/trace/events/amdxdna.h
> index c6cb2da7b706..71da24267e52 100644
> --- a/include/trace/events/amdxdna.h
> +++ b/include/trace/events/amdxdna.h
> @@ -30,26 +30,30 @@ TRACE_EVENT(amdxdna_debug_point,
>   );
>   
>   TRACE_EVENT(xdna_job,
> -	    TP_PROTO(struct drm_sched_job *sched_job, const char *name, const char *str, u64 seq),
> +	    TP_PROTO(struct drm_sched_job *sched_job, const char *name,
> +		     const char *str, u64 seq, u32 op),
>   
> -	    TP_ARGS(sched_job, name, str, seq),
> +	    TP_ARGS(sched_job, name, str, seq, op),
>   
>   	    TP_STRUCT__entry(__string(name, name)
>   			     __string(str, str)
>   			     __field(u64, fence_context)
>   			     __field(u64, fence_seqno)
> -			     __field(u64, seq)),
> +			     __field(u64, seq)
> +			     __field(u32, op)),
>   
>   	    TP_fast_assign(__assign_str(name);
>   			   __assign_str(str);
>   			   __entry->fence_context = sched_job->s_fence->finished.context;
>   			   __entry->fence_seqno = sched_job->s_fence->finished.seqno;
> -			   __entry->seq = seq;),
> +			   __entry->seq = seq;
> +			   __entry->op = op;),
>   
> -	    TP_printk("fence=(context:%llu, seqno:%lld), %s seq#:%lld %s",
> +	    TP_printk("fence=(context:%llu, seqno:%llu), %s seq#:%llu %s, op=%u",
>   		      __entry->fence_context, __entry->fence_seqno,
>   		      __get_str(name), __entry->seq,
> -		      __get_str(str))
> +		      __get_str(str),
> +		      __entry->op)
>   );
>   
>   DECLARE_EVENT_CLASS(xdna_mbox_msg,
> @@ -81,18 +85,28 @@ DEFINE_EVENT(xdna_mbox_msg, mbox_set_head,
>   	     TP_ARGS(name, chann_id, opcode, id)
>   );
>   
> -TRACE_EVENT(mbox_irq_handle,
> -	    TP_PROTO(char *name, int irq),
> +DECLARE_EVENT_CLASS(xdna_mbox_name_id,
> +		    TP_PROTO(char *name, int irq),
>   
> -	    TP_ARGS(name, irq),
> +		    TP_ARGS(name, irq),
>   
> -	    TP_STRUCT__entry(__string(name, name)
> -			     __field(int, irq)),
> +		    TP_STRUCT__entry(__string(name, name)
> +				     __field(int, irq)),
>   
> -	    TP_fast_assign(__assign_str(name);
> -			   __entry->irq = irq;),
> +		    TP_fast_assign(__assign_str(name);
> +				   __entry->irq = irq;),
> +
> +		    TP_printk("%s.%d", __get_str(name), __entry->irq)
> +);
> +
> +DEFINE_EVENT(xdna_mbox_name_id, mbox_irq_handle,
> +	     TP_PROTO(char *name, int irq),
> +	     TP_ARGS(name, irq)
> +);
>   
> -	    TP_printk("%s.%d", __get_str(name), __entry->irq)
> +DEFINE_EVENT(xdna_mbox_name_id, mbox_rx_worker,
> +	     TP_PROTO(char *name, int irq),
> +	     TP_ARGS(name, irq)
>   );
>   
>   #endif /* !defined(_TRACE_AMDXDNA_H) || defined(TRACE_HEADER_MULTI_READ) */

