Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA88CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C15710E60E;
	Wed,  7 Oct 2026 22:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PEWAzmTV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030D110E60E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 22:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjEnhNJ+JNsZxLBX6krSKsuiYF3lllK6TwQtWtX8/OoICLsoF4o8EBM3WanR7cH8O6Zq8J7bRBtg54O6oR1BfLAu0oHrTX1CNfrTs/t7OJ8zkiRxMn8GNUComJ+Wr6kXsTGh1RdeC/W+481MnieS4T4i+36iTAj2tNDOa86XQuO/fPLETnuLjyfr8n4oWGw2gJmlu+1S/Y2ect9jzZGh0ywIUGQjEg29dcdk1szZoSNm7xI33gXqQt90B+tqu5Hx8Sd3J81H1MCf40C0feXag9Jg2N1YaYaMhmd60jYmN4wWnGLSL1zkpMcgHVhke4/mPxqUS9aymJZ+CDlHCeqOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVWMVmPC1+rtgb86s3LNrhdE0iCl1BR74LWikVSRZW8=;
 b=HGZxNYY7uiCXAzFie+wW9u9xL0fGVqXskW4jbKujx9yXn5XVlD0w+X20tjwwl/wHWDa3z0PA3IpLWw1h6VwtZ68k+bJsc6BFr84RJwQFX/W8ZWNG+bboBY8jyVHuDbasjrF/kCILyPpPwfOBS0MjPq5bQJszvI0+t9KLn7eeE8CcvHzr1+sFLFZta2y/k80I/IAo0dEx0kq1rsQvI+SVxUS3CpUKQLRnHV/MR0bn3IPHa+7jUcS7UpOUJ1xYLBdezqyIbJVjSFieUseyVPZklzJAurmudHslvYEEmqVIq2s5w9afKJXrBq5iMlqRb+FsQbjy2LTjl+LX/uL5uoiguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVWMVmPC1+rtgb86s3LNrhdE0iCl1BR74LWikVSRZW8=;
 b=PEWAzmTVseGZSr6Bt+XBum1FTMGsLKwPHvtKkkPAkk6VBj8Zh+qpsi3RBB2IJLhjqCHfktz/207AfxRkkDbAW+Tbt2gD747fdgTPXisFhrit9oRM6XDK7N2rmaZ4ivBFDvxsRSGwsE9qFwItsNSNK38qnOU8RzXsm+82702YIOU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 22:54:21 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%6]) with mapi id 15.21.0496.015; Wed, 7 Oct 2026
 22:54:21 +0000
Message-ID: <c97f9acf-79e3-4e02-9e54-1f0db0a72fc4@amd.com>
Date: Wed, 7 Oct 2026 15:54:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 14/20] accel/amdxdna: Implement AIE4 command packet
 building and submission
To: Eva Crystal <0xiviel@gmail.com>, quic_jhugo@quicinc.com,
 karol.wachowski@linux.intel.com, max.zhen@amd.com, lizhi.hou@amd.com,
 ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: sonal.santan@amd.com, mario.limonciello@amd.com, wendy.liang@amd.com
References: <20261006042230.547807-15-yidong.zhang@amd.com>
 <20261006071245.197376-1-0xiviel@gmail.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20261006071245.197376-1-0xiviel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cede6e8-5dc5-499b-598e-08df24c5ecec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|5023799004|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: AqdbNWjRN/FAJM8jqB5eBrOti5fH0wQ4Bcfmwd2Rw7Fs2fa2r+M+an8+XOZ+biZdAV9aBmg2IFkCQYxw3TB5mMj+476pNbMa447Ra+7l0KLtfMnXEqcah+uG8n0QO6ZkZtWP3CSiT4sWs/+DJV934STmAhGFuVpN8VgebedTw71IpLirs/92uwVR1cPzekajMTgrBvCGNtW0rWHhx3CmZjhUiol37Ioyle2bU/Ri5OmHtQB4gAiFteq4bpkiCgp0ZIiCgfxE9AywL/NG8Uu8BOpbn9xwZkrU3kiOcmdx6JTZVIV/OyqaPwxbdihpcmkGGVC9oqn/DWtnXx364k6BA4X0QPOJgfpVhbkmwsp5TcdBxcoMxgF5izEZKINUACxJ4rS3qRvofMl6yNkcVRhUZpqoQzAATAmhsE5MNwtmJBt7kU5SLvQJBeUTnMtHZcGF39gXOw5YPhOKSd+A4fqiKrDKIpaItAuBi/cq7D4Ld2U8uW3OvOHLdUU14YEwgm+instoM3VaYJ+2mB/Luq88rb0yNZp2wI6Cwjcn1pfHOvfXKZLcqqqiZXu4inrCs4xYG3rm4q6RXWH9B/KyYuKu85JVNH1j11+p2AwQwI9rimA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdLUng4UHNRZ3IxclVyUmwwRmtOcy9Bd1pDSTFKMEdSNVdzODREemNVS0N2?=
 =?utf-8?B?UDRYUzJ6c3ZMZXRvWVdzc3cwMkpmWkdvRlZNamlwVUFvbDZUWVIvOG5XYmdo?=
 =?utf-8?B?VktsNFFuMkFndWN6NFEyTlNWWXdEcWM1S3poSTRWNlJXelAzQ0RaV2c4bHZh?=
 =?utf-8?B?TXpvSWE2R0VkYkYzNWlFZnVVMGd2dzRDdDNpSkdTNjJvRzBmY1RBSEh0Z0k4?=
 =?utf-8?B?VVZITkFVaUFoRXRLdy9ma2lVc2E2UXhYdm1vZEdXcHBMNWc1S3JzcmJpK1lq?=
 =?utf-8?B?cDA0N2RDTnAwdHR4NmdKN2w2cTkyUlh5VkhJL0JjNjNNODFHcVN2RDYxUWFx?=
 =?utf-8?B?VXNsRithS0Q5WUJrUy91YzBNTUVOYmNDYjJXZkpDbEV2YVIrZVpWL0J5TXJ2?=
 =?utf-8?B?STMvVVNOTFB6TTBFbFMvRVN3OGdZZCtMeG9tZlFyNUdLWTJFb0dGbXVjdklH?=
 =?utf-8?B?RU40azFYUlVqVWZBVWlQNkVLb1hlMEVIT09paWlLNzIvcjV6cHZEWDB4Nm9G?=
 =?utf-8?B?Uk5NVmhmVUQzbzVtcWhMYmcwbCtlN01xTTllV1d6Tm94bUxTV0hNQjVsS3Bi?=
 =?utf-8?B?czdrQzRFSnRmait0SmN5V3hjYks0cmEzRW1mWm4rODVaYm1GZDlieE1aVU5z?=
 =?utf-8?B?dzJ4TzEwWU9rd0Y0YXBRT09jYXZ6N3o4TFM4YUpKNEo3N20ydFBMVTJNVTVq?=
 =?utf-8?B?OXgzbVZPd25sQ1RSaWVpd2ovdnNlaGxMV3FMRWpFYnIrdFFjdFpBbjlhNWJk?=
 =?utf-8?B?Y2tGaU42M0JWZmM2Tm1xeTUyMjEwaWp6UjQ0MlpiL3B4ZVN4ZEY5NnFkSEpa?=
 =?utf-8?B?RncxNjUySjlmdkE3MFM0bDAyYkMvTWJCRFpKaUFoN2N0bnM1b2FYRk1xN3JI?=
 =?utf-8?B?YUllSlRRUFZFb3VWcXNmU2FTR1k1bFptbFEyeTRRQnAyMHZYKzVVZTBkVlY4?=
 =?utf-8?B?cHVHMUNZSFZaOGRONEJkU25CN2lLT2tSZ25jOW9nZHlwZHJrU0krVS9WRDEx?=
 =?utf-8?B?QSs5Wmt3dXRiazZxMUFQYmxaNERWQ3FudmtwemJjQWRKb3hWVDQ0a05SSXUz?=
 =?utf-8?B?dFRDWHQ2N1V5QWl4MlpvWFR0UTBGQ29HWEU0cGozUU1uZDFpc2ZnbDQ1d1Ir?=
 =?utf-8?B?TDNqYUR6SlByWlhuN1dxNkhnRGFaZVU1RDNOOGRjYUJVTVNoTkhhdFc4Ukhu?=
 =?utf-8?B?WjlQM3VZYWlqMmsvS3J2UHpGcVBPeEdoWVNKU0hTSlVYblRZaGFwdE1nYWUr?=
 =?utf-8?B?WW9MaWR6YnJ1SVd5bGZNNlhkVkdGZlpEeXo5Y2RPN29LcXBBWWgybmFvUjls?=
 =?utf-8?B?eXJJbFk2L25CRnpGcU4xMFF6bXJ1QSt2Q0NpRG56Z2NOSkVkd05VWHVnV3pV?=
 =?utf-8?B?ZW1hYUQ4TktTLzRCRVF6SXNPcHNoOGJkWG9tUmxjNGFkY2JVZ0QzRXg2Q2dN?=
 =?utf-8?B?VmtRTmxwZ21mb3kraGJNbGM2dUpjeU42bndKcTJmU0N3MmltWlAvTUNUNyt2?=
 =?utf-8?B?OVk4akhaMHhnQVZpVVJ0RWtSb3Zhc2hwTDZ5YlNsTTAzVlFONkplYkg4azRj?=
 =?utf-8?B?U25xalNhV1pCVmhwS1NYeWNFbGpYQ1c3VEwvazNsdkthMm5JS0ZIYlBDdGc0?=
 =?utf-8?B?RnMwMGd0VlM5eW5TNW8vMGJkMThRRTBVVjYyMWw0M0RsUG4zM29uZENGREpS?=
 =?utf-8?B?VWJpRTd1WkZSNHozVEg5eE1Obko0dHhQR0xxbnZ4NjBObmpVTXB2ZjZjOTNk?=
 =?utf-8?B?a1BqYUw0Tzg2Y2FEQ2QrUzZKVEhXdlpob0FtblFPSmxpa1cxUngxWWVIdWtG?=
 =?utf-8?B?SVkxQzVKVFVIUGtNY0gvSElkLzJsNFFFcy9zVWZIWDNzMXozNWtuV3ptUFN6?=
 =?utf-8?B?M2lsdFpUWTV5WHc4bTRESmNad2JsZUh6cUdhcm1sWXdDU21udEs2ZWhkSm16?=
 =?utf-8?B?ZXBoTGdTMnVsSTRnZURodktTOGRtOXVQT0pPRENPaWNqZTRyNFFSRGdhSzhC?=
 =?utf-8?B?SEF4UlowOTE5R2RzRkYzVFhTUFlUbVV0UXpqMTJoVkltM1VPY1BoMkNBbEM0?=
 =?utf-8?B?bzRQdHRmcytpdDh6S1B4Yng3cWVudUtVZGpPelBNam5MVUF0bW94Qy9UUlcx?=
 =?utf-8?B?MktKUE1GaExLeHU3emdyakIwWW9neUx6STBZRk5hUmkrZ21CQStJME9iV0hy?=
 =?utf-8?B?MUhCQ1hhTHY5elg5YWVLc1laYjRDNDc5cHZDeXRlRUNiYTczNDVDZ0hja1ly?=
 =?utf-8?B?SDE1YlBueXJEOXhJN0hmUy90S09NdFkrQXNYRXpZcjhmSWtmaDlRUEh3cXM3?=
 =?utf-8?B?L0tTSkJIMStlSDdFaDRIWTdpUnRCNWNYWmZDL0Q3VXJ3dkVmRkhDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cede6e8-5dc5-499b-598e-08df24c5ecec
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 22:54:21.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+eIfr5OPq7LweWDBtawk2NGOiuX438XWnL3FIGnw5cZtHK23R8JNtK4Mf3WeMJ77cAPGHuuAX6YyIE+9hsOxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
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


On 10/6/2026 12:12 AM, Eva Crystal wrote:
> On Mon, Oct 05, 2026 at 09:22:24PM -0700, David Zhang wrote:
>
>> +/* Job timeout detection (TDR) will guarantee the fence signalling */
>> +static void job_worker(struct work_struct *work)
>> +{
>> +	struct amdxdna_hwctx_priv *priv =
>> +		container_of(work, struct amdxdna_hwctx_priv, job_work);
>> +	struct amdxdna_hwctx *hwctx = priv->hwctx;
>> +	struct amdxdna_sched_job *job;
>> +
>> +	while ((job = peek_running_job(hwctx))) {
>> +		wait_till_seq_completed(hwctx, job->seq);
>> +		if (get_read_index(hwctx) > job->seq) {
>> +			dequeue_running_job(hwctx, job);
>> +			/* Abort partially submitted jobs; complete fully submitted ones. */
>> +			if (job->aie4_job_state != AIE4_JOB_STATE_SUBMITTED)
>> +				job_abort(job);
>> +			else
>> +				job_complete(job);
>> +static void job_done(struct amdxdna_sched_job *job)
>> +{
>> +	job->aie4_job_state = AIE4_JOB_STATE_DONE;
>> +	dma_fence_signal(job->fence);
>> +	/* Release submitter mm reference taken at submit. */
>> +	mmput_async(job->mm);
>> +	kref_put(&job->refcnt, aie4_job_release);
>> +}
> The get_read_index(hwctx) > job->seq test here reads a value userspace can write, and this patch is the first to let it release resources rather than just end a wait.
>
> priv->umq_read_index = &qhdr->read_index is already in drm-misc-next (drivers/accel/amdxdna/aie4_ctx.c:212 at 34e9ab018249), but there its only consumer was check_cmd_done() from aie4_cmd_wait() and aie4_vf_ops had no .cmd_submit, so forging it only ended your own wait early. Here it decides dma_fence_signal(), mmput_async() and the BO reference drops in aie4_job_release().
>
> The queue is userspace's own BO: hwctx->umq_bo_hdl is args->umq_bo from CREATE_HWCTX (drivers/accel/amdxdna/amdxdna_ctx.c:252) and is mmappable read-write (drivers/accel/amdxdna/amdxdna_gem.c:1409), so the submitter shares the pages the driver vmaps. valid_queue_index() bounds it only against the kernel copy priv->write_index, so any value in [write_index - 32, write_index] passes and one store retires every outstanding job. Nothing else is consulted: cert_comp_isr() (drivers/accel/amdxdna/aie4_pci.c:114) only calls wake_up_all(), and aie4 has no per-job mailbox handler.
>
> I may be overstating the impact. I found no kernel memory corruption: no driver allocation's free is gated on a job fence, and the queue BO reference drops in aie4_hwctx_fini(), after hwctx_stop() has done the synchronous aie4_msg_destroy_context(). User pages look covered, since SVA is the default and the core invalidates device TLBs on every mm invalidation (drivers/iommu/iommu-sva.c:341). What is left is cross-process integrity: job->out_fence sits in every argument BO's reservation as DMA_RESV_USAGE_WRITE and those export as dma-buf (drivers/accel/amdxdna/amdxdna_gem.c:680), so an importer is told the NPU is done when it is not. I cannot tell from source whether CERT keeps executing packets it already fetched once the host moves read_index past them; if it stops, this is self inflicted only. You have the hardware.
>
> Would a driver owned completion word work, device mapped but not user mapped? Or could CERT report the count in a register or mailbox message the ISR reads?
Hi Eva,

The forging read_index only signals that process's own job fences, the 
impact is self-inflicted.
We cannot change the hw/fw at this moment. The CERT fw access memory 
with user space address, thus the memory need to be user mapped.

>
> Separately: abo->mem.map_invalid is set in the MMU notifier (drivers/accel/amdxdna/amdxdna_gem.c:247) and at mmap time for imported BOs (drivers/accel/amdxdna/amdxdna_gem.c:505), but cleared only in aie2_populate_range() (drivers/accel/amdxdna/aie2_ctx.c:1145), static and called only from aie2_cmd_submit(). On aie4 it is never cleared, so aie4_cmd_submit() returns -EINVAL for that BO's remaining life. An imported dma-buf argument BO that userspace mmapped starts with the flag set and can never be submitted.

I missed merge one patch which rename the aie2_populate_range to 
amdxdna_populate_range. I got this patch in V3 that both aie2 and aie4 
both call this common API.

/David

> Eva Crystal (0xiviel)
> XSource Security
> https://xsourcesec.com
>
