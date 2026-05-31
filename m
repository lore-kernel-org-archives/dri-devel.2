Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E19CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5DB112B7F;
	Sun, 31 May 2026 14:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4dpipTY4";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A42112B7F
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 14:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTtkdGd4Sagt3f1eoGBACZh8TvKzFlPDLdmOmJR5LwUTK/WR0E1K8Kwvit8g2tgwrdN08yUbN+rEQLBtrJcIFVzBQtwVPkZmMMKNbyPCCd/7u0bHnMhAoZLf5Sfm8nBKePyuzIbguJMIPPJTU0NcnOvcwbP4xi0rpkGleZTi87sJjmv0BHNGAWxCCJATfOHjCKenkfx8bW5VCayp/zKDEYBglRFhk52Q0aL9GuuQUcEOilRmvftFW2Xg5lfpqt4NuoOXFEJ2g6Ostxv2+J1u6YaZE+YkXSGFVTOu2hJDYuukToglM/9l7eRNKoA4RlfPdm+u1Y6hJ4JhSaJZVt+QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of6JTepq373/DhejAnz8dHv29IvY/6D18xht8+lJ83s=;
 b=BmJkS9leR0srXUwUlDFmv97siKy5tSoKWHxqySiIH6bLHNs2Pkfi5uKNG6cBzi4EcUWNzC+EPzr7i+XyGdcoqWpBb8cTPtW5657WsJ+ztoTiXUYASlpTjTe/EQdbHyXWGzwCYfznvqxjIrDBG6N7Am//G/C27W/nx1dZxT4sP27coHBIxYWk/MEt+zSAk6lhLJXApq4ffK4bzg3vWSH0XZDxfexgoHgT9ECpNz/ZjlS2Gh3xDex2T8b8FL3e1lbgUTdjr91lZbR7+kvPevrrHxyMLDq23EPye3Keu1oNTgYZduKTmid5rD/cfu03znf0whTqoGNPOU9kB7DM88/XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Of6JTepq373/DhejAnz8dHv29IvY/6D18xht8+lJ83s=;
 b=4dpipTY4DNLoWO4B113IOiVh3hHHZeLcwJySPDu0BKlwRfLtVWbw2sZ8VXRpkBTmJ7+zD/XLnxd3TJQxEKM7gbnU5pZb9+fEgysmSKQb8MDdf9Y3PzNkjB46qROq8+gdvizWbHk3z5Fq7DpZJMX4gZQvNQw2PGVHxo6xSFkR35A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Sun, 31 May
 2026 14:19:01 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 14:19:00 +0000
Message-ID: <dd84217b-d0b0-42b0-b822-cb897b6f71a8@amd.com>
Date: Sun, 31 May 2026 16:18:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Remove drv_cmd tracing from job free
 callback
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260529152837.1973405-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260529152837.1973405-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a678ab8-a467-4346-4bf4-08debf1f8f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d+exezMGEtJUod7mKjfH8zj9EN2r+dv2HrAzy8D3WVVFksDR80zU237ry5zAvzs+AEO6ArcvNIg6Hwp2+5ixJ8LThWNKSOCKNJliQaV3vtIT/2NnGkwwxLj/i7PWzJBbgSfJ3XrO1HCybQTMZ566vs+zYTU8mAji6iVm2O/c1E0TF/QYovxtd3dcuZAFs1V3Iiz01ClEfrjlj2sHQpw8Zja0evh/4qbDS5dhF26OUGaW0CzV0PuhnzCLygOT/FGq57XqLiqs2ClgfCpe/W4xX9gJo2XtLynh+JgvVYngG/g2u9PmZ45Cg71g/NmSibLGvMIMcED1R2zVfssrrslFwQ2IiDgWFyfqoOhmfQbxdhDMylKgCYR3dXN6Z4upDd+o0gW2kII4PnIe1/qtchq2JLWP8IUmNKEMuj7SIEsohJZF11217AgkIZ8BgrHlmF/qyrhiWq3pFmj8Z5keQaAtvCjftPp4CzRKueNEyOIg0/0pW9ohUvcTaQDkTVT1Apl9ppORZH3Qjbv4f78p4SS0XIYvKAt/ufDSyI90uY637P38mu4FxvtkfP2ov3pEWTVsrSZ0OFvj9Uo5qT8uuQQmWP6eauBRxAE+1dUv6BAVjmbvpiCH5XB/gNA/KdSDsazOUfZd9OJL3zgo7eVJ1SROo9E6th7lq2V1GL7ggBHVyN7yDKhya1qSqDSkXfSzT1O1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VNTGo0aC9UMG4xd004c1pNRDdVaXUrZGlVaHJGaExMOWp4VnY3MndHQk5v?=
 =?utf-8?B?cVpidEJ2R3lKQ1lVb0dHL3JFelFVTXZUMXJGeENObFJFWll5QkZQbjFFZHBp?=
 =?utf-8?B?d1pmd0g2Vk1RbExHZWowL2FhbWIra1BjU2dBclpiRjJuNTNpYmdjalliSkZl?=
 =?utf-8?B?dmNiOEg5M3JKeDBzbWNXNURsbFNMV3ZOZGdkZnlyOFF1Z3VFNlBRMytZTEp2?=
 =?utf-8?B?MXdpNXVQZnNNU295Qzg4YkZnUXBwTS9TWXM1b2pRaTM2V3pEenA3dktoeEhK?=
 =?utf-8?B?NWl5bFJnMTR3Qk9UU1pXSnVpUklwREZKRlc0WTlXdldIWEhOWDJwS0lPZEww?=
 =?utf-8?B?YU85MlgwMXppc2lXZmJ3dnRKNmFvWU5uQWZNK3laWUxMaVBmUHVzY2RoRWJW?=
 =?utf-8?B?d3hmSlBzWDllbFQxQnpZcVRCU0xBSFcvTW1iYW52T1dxcGRWbGV6dlB6akpt?=
 =?utf-8?B?Y1BuY1puM2FzL1FHdTdqckRYdGw1dWNxTHZ1Nk1xOUF0Z2ZSQjJOYWJ0TE4x?=
 =?utf-8?B?Vm0vS2M3RjVxSGg2Y1oyTmU5ZzJqTWdPS1JkSEdOOFpLMnN4bmhNRXNYa1BQ?=
 =?utf-8?B?aEFDSk1UNGJrclZLSS94Slg1UU9sVk9EZzJMWE1WSGorRHZyQnFuNUdDbWxD?=
 =?utf-8?B?eWpRYUIyZWVpS0pDSnQrcGFYMGI2RGpjMWJmdDFrOFMyZEFPY0Nka0lqNUJa?=
 =?utf-8?B?dWlVcDZvT1pjVTY3QmZSMFloRjRUZDVJYnBxbFNpOHBwNmFlYUxOaFpCSk9t?=
 =?utf-8?B?Z285N2hvMHFycWV6MWlUR0pOWlN2MHVwRmNWbk9RbGZiL01xaGhJK2lnYXlh?=
 =?utf-8?B?eWJKZkpIL1JBWWdxamd6UC90dHFwOHgzWGJ0bE1COTZZa05ZRlJ0SkcyK0wv?=
 =?utf-8?B?SEY2L3RLR2dpNkluOXI2VUI3Z1RuRzVDRENpWGlVdCs4MDkwZWxOdE1jc0J4?=
 =?utf-8?B?MHdEYmZJemorUXR0RGo5VnFJRHJ5WlBQdmVNdUFtWWdCNnBGd1VQajlIYmo2?=
 =?utf-8?B?cjV2SHUyc05jZG13TnI3MXhlZVdVZmJVcWhlNUFjS29OV3Q3aW1ZbWZiUGxQ?=
 =?utf-8?B?Mll4SktxekVEeitzNG9pUExwY2QzcVdOUFovV3o0MDY0YzlUM1p0MnlERmlU?=
 =?utf-8?B?RjlYeHFObFpWdUJzNFNLcXJsaTZmMWtlZG56K3prZTVDem9MWDZGck9Sclli?=
 =?utf-8?B?d05rTGU2enFCdm5yWUQxcC8xRGQ5TXA5UGpJNEs4S1dIcHJTaC9uWjN6SWRm?=
 =?utf-8?B?T0hoeTNYaEJQZkRZek1EMXRHQmt1bEJBaEMyNU44R0drbXZuMnlPTlhzZXdt?=
 =?utf-8?B?WjhMM3lpVDh0WFhpMjJ2cVpFQmQrNC9ZbW1LalpCNnNtTW4yQksxUWpsMkY5?=
 =?utf-8?B?SjVka3haMHd3RGFkQjZPRThTQ3NvNWIzcHNWT2ZKd21NVFBsa0hRRkRKa1lK?=
 =?utf-8?B?NFltWHdMdDZZVjZoT1RjRlBQR0hXM0U1ejRUTUF6NXNVa1JONld3RzFTdjA0?=
 =?utf-8?B?N29UUWd6b2dmZ01BQW9KcDdoMHBacktWZGJ1Y0lFdThKUzI1SFovdnRLNkJz?=
 =?utf-8?B?Unl4U2ZtaGIxZ1lONG1hR2lHeXMxTVk4Qkg0Vjg5N3hKd05FQkVRN2toMElW?=
 =?utf-8?B?K3gzQlVocnB6VXpyeTJnMkgydkR4eWlYNERTS3ZiZmRhVEpWSzgvZ1ZWRUlp?=
 =?utf-8?B?OTFPSmM2WFZiODNwSVp6amZBbUhoWFpIWW0vYm9iblpPWlBuL1FTREJ2Tlg5?=
 =?utf-8?B?MHVKSW1XNHlxY1Zpb0h0ejBBcGRTRzdRRmpFRmlsc0pvOG90V3owS1IrV2FG?=
 =?utf-8?B?WGFkVXpNN2ZNc0ZuVXpucjJKVXZydVFQUnFoVU04c1QwNjg3T1JGbHhJbTl6?=
 =?utf-8?B?cXJUcnpBZi9Udkh3eUp4dDdpdC9DL0x4NldYdVg1YU5OaDVPWm9xS1ZoWkxN?=
 =?utf-8?B?R0d4V2RxWTVvNCt1aEtISFhsbnB5Y0N4MnRGSktKUWVkS21MdGVOZHB6OUYw?=
 =?utf-8?B?OE1GV0IrS0FsalBZSGQxN2NXNGdKaWl3ajlCTDZvM3RrZTFGUkc3eFZPNXdm?=
 =?utf-8?B?cFZ1TXA4bXEwV2I4SWkyVU5qdVRORHpMQzRHWEd4UHpmOCtYTDZGcW1EZEZ3?=
 =?utf-8?B?VTVyMXkzWWlZd1doRXdQN3UzcHZOVFZYZkpoWXVrQ0E3dVdDdld5OUJ1ckJx?=
 =?utf-8?B?a3VhSlc0Lzl4cWI3V0RPT3g3Z3JVNW0vNVp6V00vYnpGSFU0ME1sNDRxUGpT?=
 =?utf-8?B?aWJka0hRck84Y3BUQmd1M0JYdmhqT1ZsSTlmTWRaTVB4T0RiQklaSnVKalpm?=
 =?utf-8?Q?sqBECK+vZEV13d6l/8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a678ab8-a467-4346-4bf4-08debf1f8f6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 14:19:00.7218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4slJPK4DFeNrFT9sd1Xln+pRCPeoZT12nXDFLeWy9lpdu2x1oGFCT7JspTX2Mjx/ctV2A3DWZGr5Xdk0qp7EyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
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



On 5/29/26 17:28, Lizhi Hou wrote:
> aie2_sched_job_free() accesses job->drv_cmd for tracing purposes. However,
> job->drv_cmd is owned by the caller and may already have been freed when
> the job free callback runs, leading to a potential use-after-free.
> 
> Remove the job->drv_cmd access from aie2_sched_job_free().
> 
> Fixes: 8711eb2dde2e ("accel/amdxdna: Improve tracing for job lifecycle and mailbox RX worker")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_ctx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
> index 658a5fb1fda6..2ad343728782 100644
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -437,8 +437,9 @@ static void aie2_sched_job_free(struct drm_sched_job *sched_job)
>   	struct amdxdna_sched_job *job = drm_job_to_xdna_job(sched_job);
>   	struct amdxdna_hwctx *hwctx = job->hwctx;
>   
> +	/* job->drv_cmd could be freed, so use DEFAULT_IO */
>   	trace_xdna_job(sched_job, hwctx->name, "job free",
> -		       job->seq, job->drv_cmd ? job->drv_cmd->opcode : DEFAULT_IO);
> +		       job->seq, DEFAULT_IO);

Could this still be a race with dov->drv_cmd being valid when the first 
part of the expression is evaluated (job->drv_cmd) but invalid when 
job->drv_cmd->opcode is accessed?

>   	if (!job->job_done)
>   		up(&hwctx->priv->job_sem);
>   

