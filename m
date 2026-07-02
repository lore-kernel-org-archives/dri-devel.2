Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34098C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7E810F18C;
	Thu,  2 Jul 2026 07:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CmkS3uZL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CDC10F18C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFKqC5moOoPvhZ/eUIDnQgCZFmGHi+8z+gRtfx0yD51aCUkhPgOexjDq9dxyLfNPR8eXNQQab/AvWLXlkkHoUF4Ee/ZS2qre5vT2qoR3gtZSdCgJAaH93ddtdZ8bT/gTiizm4+Yqy+cdj4oVHQ6U5/zni5E1HZTzxK7iatT87yVYAZfzj8Bdlpc2XREut31BDnZp23d+sAfC1tkwPFKqWodjB/mNS/YTLGQ9krvjFsXRKYx88uj5ZrgaTMJoNZSHBVU/UtN9IIIeYe+UmlcW1XVSkk3xUNZrA5/dBNZv2AGH13bxE7Bxt/i50rkbY/kmreOsq3R8XlGnMdkV1hpwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlipQuzj+EyXJa7do1GWbClMk5QdF6szI3l0ci9kXFQ=;
 b=BAcb6LZe5Tx3WOaCRU37cMRw3j5yisvbupHzS8LjGTVIsO6ZTzMhp7XYSOMOiBajJX5cg+I5Bs/9BAhhJFjUklTZpIXg/sJtIHt4JcrDYL/ejwJBWhZ6mOMjHdXah9baYL4atcwnAO/bg3U95cZBpdYNDQT6449EK45GWieFI+DN7Mxc9jmMRPknGNtg2YUedTutlWBFDQcdrcsQdTISV4kXAphy+g2ONJba1J4nFHBAAXgijdHv6B5ijsGpA/hRPAuz0Gxc7WUOMIWHcrFuZTGH/F7HfgBxj/5hjGS4iBZc/GDsMFUD56nSQt72Rfiv3kFRWMqlaE0MgPP+y9FJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlipQuzj+EyXJa7do1GWbClMk5QdF6szI3l0ci9kXFQ=;
 b=CmkS3uZLyG4JPhOR4zCkW6A4I1sXGIRBJnjOEVO73MmEpmDgJATTxtby0QhpjSblYyCWcEwmm18KKrHt0vyEdYUkteDdOqIYPbRPjTG7FsARIEKmG5JU/i79FfnFxGK5InYUiJknwjdZoOef7AQ8XFK0nR10no5EUsO9M30Q8EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 07:29:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:29:32 +0000
Message-ID: <018cd3e8-d245-4316-9c8f-821a77165178@amd.com>
Date: Thu, 2 Jul 2026 09:29:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma_buf: change unsigned int and int types into size_t
To: Shahyan Soltani <shahyan.soltani@amd.com>, sumit.semwal@linaro.org
Cc: phasta@mailbox.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260630160401.67544-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260630160401.67544-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6520de-aeba-49a2-418e-08ded80ba89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sRhxhzFGFoOW3+MkZyhBAX+bfCzgRqViAQLLsHWwVXGbElokxqp/GTNGrJ/8/kDXpyI4dRoXf32doUWgEBDdWip8i4hahUpD4RJRE8K+WRwxNV7QptVSCJmDkJGbh8cejI8YZRKmW7lak/ia/ribE4ZzgRE2tjxmVFPp4weWz3Y03C7EkI5pakYsi4tLymnJImRJODB/I7hz9Z5TUwcPHQEdi/Zcn2GfUoJb5R/BZJnVHSxyhaFDI2QwlmYBGTH62IbM9QCnsHQRmDLHJZP3LMqB0b9Qc1BZxsQMv4PO+WQtEXjgVHxdp1FDGpEij3DVw8AkyIH+0t83/aiAJ4aT1KgyFDHZ0vAtCOnD9jLOme+tPffSiVb4lPF+zFPjFMVhYe+4nMw6Z2HgaNXc7KS0CFtJHpVpTr3pm1oP1PAi2wW46wHnOHW9rEZakPTDvukYsMu07c5m45r+kbT9c8BhRKNJkOhHRd0RSRnYn9RhF+Hq+xa0sU5Am74+g5R91TQb39cy63MDbousHUgJnboWbxzIcbjpigmRMo6CMxR842SKLv6+hmvoDuyiiS6pmy2htZDUZnylt43rnYewi0HyPnmiceKOf9X4ilxrESP94P3vCJ/BoPBW4OTXyP622v38IbstsAaUPfcC7Taa/CM8WB29kvVc8bqeksvrf0X7zE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdNczlMWFNXSlJLMnQ0OWFIZDk0Uk16dVNHQSt3YjdOaXl2dXlBVldjU1ho?=
 =?utf-8?B?b09iMnJOODNYYlJ4TDg3azRmTjhGeWw1TXI4RDFiYXd5eWZJOGZ0QndpbkRQ?=
 =?utf-8?B?NVhMeE9HeGZwR1NDcEVDT01xVVpKTE5udzByWWRBL2s3clpGazYxV2x6cE04?=
 =?utf-8?B?emNNRnlBUXVpY21EQmRSRkRzR1VEKzBIYnpPT2JvdlJFUytkcTNCUzhpanpr?=
 =?utf-8?B?WHN3aG45Wk01cWJzbjRSM1pEeEM0SHNndjdKVnoyS2xqOU9VNUdiaDcyeU5l?=
 =?utf-8?B?YXJ1ekIyK0JtMkdnUUU3c1dGNnZYb2RUaEZoUm4vckZNZW5wa2Y3ck9PMWJa?=
 =?utf-8?B?a2NCV295Nk9CUkFFZWdWRVVHNlJ2YmxycXprejRMTGpGYTVoN0dpcHpTR3Jt?=
 =?utf-8?B?SlBSLzdaQncxR3NiVzM5VkMyU2MyVlNaV3NlaDF0NkFtaUdCR3RtZEwrTGMx?=
 =?utf-8?B?Z2FjdHhvT29sRnJYQ0MxdTM2NkRmQW9UcC8rbTZZcmJFNm1EUng5TTJuZEZy?=
 =?utf-8?B?Y1U5WmtrYVNjbldobEhOMzJ4ZjNwcXQzRnZNYlBrMmV4bmdDQ3VRbmxwTlU3?=
 =?utf-8?B?eGdvcWJaL1I3eVpWeks4RzRacTdoN0dGci8rbUJXU3ZNN1ZEaWt0RmxwaXk1?=
 =?utf-8?B?SER1WTRRL1FUMXNsdnM0WFowMVBKOVlPaWxyQVB3ekQ4UEl5YXJOTVpzZzZO?=
 =?utf-8?B?MTYxQ0JublA5bEtOZnJTaTI0dnk5MzRTMVNQc0NvTEZSbGFlV0ZYWEJ6LzRQ?=
 =?utf-8?B?cHBRUFBFSUU4bkppVWxTNVhnNksrSUZwRmpyOWcrQjBhZW55clp5bnplQUJO?=
 =?utf-8?B?dmlMeHQ3WVlYRXlQOXNEWTY5b2plUVlBZlkyRitBWjJuU013bnJEZkxTamlI?=
 =?utf-8?B?WVl2NXQ2OXY1OFJXMlZubmMvNnB2UFlmSlhKNGJmcXJyWitRc2V6UkxPYURN?=
 =?utf-8?B?MkgzbFpTL3Y2VmtFWFlmQTE2RTl6N1k5Z3VsdTNwQ2hGQzNqdExPaEh6b3o0?=
 =?utf-8?B?RXczZk1XUzFqdVJTZDV1ckQvNW10OFFRbVJLcHhUNUU3RlNjNFJ5SWV4MWFJ?=
 =?utf-8?B?UldSblBIeVpmZFRLbERZMGc2djZmZEpQeEZ4R2cwdzJxY0plaXVNeVdzRG5I?=
 =?utf-8?B?S2dpVDFlN0ZmbDB1SFBuOEgxWVdWYWlEaDFmcEpiM3VvL092clIvZE9kUkpF?=
 =?utf-8?B?RFRmWStBSzJmbXpPbzJJb0VldnJUeW9XRWliQVdrM2FZU3hLck82NWVZU3dv?=
 =?utf-8?B?M3FmUjVuYUJ0L3hZZ0EraE5RbStCVDhjdThVU2NzTlAvbkFRZHhRZ1VvM1BQ?=
 =?utf-8?B?aUp3ZTZ6enhHSksyR0Y0dmpER1I0ZTAzY3JoSW5BMG8xWTBCMmR6dUJTQWxZ?=
 =?utf-8?B?RzNoRmwxdllGaTFrZTVFaHNBR1BIMFNZQUVtY3hmaE8ycVZjSFNpcE5zV3VC?=
 =?utf-8?B?TWM3cGk3WHlpbndlT2tkU1NRRDRYTFZ6dk9hWVlnWlVEc3I4Mjd0MDJ2Z0p5?=
 =?utf-8?B?UDBHWDIvTUZTd3IwNVhwR09XVzQrcCtOMXlQZzBQenVOZjQrUWpvZGw4aHFE?=
 =?utf-8?B?Q2xPWkhZclZER2JWdjNyZVpHZUl4L3hhcStaUk8rUjBhK1dvNGRMT2EzR2Vn?=
 =?utf-8?B?bWI4cTVyeVd1K1h1d1krQkFlcW9TanB4RWhRaG9ubDI3YUZzempYVWxLMXNi?=
 =?utf-8?B?Z0ZhNk1PUkR4eExtVHRINVJlTFRmRCtUSVplelk2OXdXTWl3T0JUd3hVb3oz?=
 =?utf-8?B?ZWZPcDJaTjJUaXRCVjhtYmdUN04xdVhlZUR2SURtYStSZnc5Zy9JdEJaSjds?=
 =?utf-8?B?WDRDNHlCZ0pITER2SU1zamV6VHZqc2orQzZNRUQ4cXNZV0d4VlZBcmVPVDB5?=
 =?utf-8?B?eFNBU2J3eFFYTUo4aEpIODFxOVFnK3htOHRLaTh5WnEzY3A2My9tdDYxLzNZ?=
 =?utf-8?B?S05rWEdiVkZLUjlXVmlaSVRreUw5QVJoQko3RVZ3RWdxNUc1NS9mUXArYjNT?=
 =?utf-8?B?c21LdHFvbkkvWnFaZDVUczFIalN5VDBqdUNXckVHb21HZ1BZekJ3SEROMHQ4?=
 =?utf-8?B?ZVByemFkSkFiRmdZYzdhZ05Zb0NOZ2FMeTI5d1NvdDZ6a2w5SFBRWGFGZzk2?=
 =?utf-8?B?ZS84M2VQOUtwNWpqSGxZRjhIYWRpVkFCSnliSUxLUGRiSVBKcFVpVUdYaEV1?=
 =?utf-8?B?Q1V6V3FHWGRNT0F4T0JlMHJQUDFUcE9FaTJQaFI0OTlrL1dxWGo0SVVTZU1N?=
 =?utf-8?B?VkhERFNjb05RRkUvNzNTc010K0N5Wjh5UHVqL3RtdzJIRDBqd0Eyb2Nwc0Rt?=
 =?utf-8?Q?ih4WZqFQNQT4qUluIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6520de-aeba-49a2-418e-08ded80ba89e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:29:32.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpYSj2arzbSXfWotBGVfJ0U98YUAr/bi06CvTX67dDsz5MFgs9nptqanpWbOBEZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

On 6/30/26 18:04, Shahyan Soltani wrote:
> The num_fences, count, i, and j variables in dma_fence_dedup_array() and
> __dma_fence_unwrap_merge() have inconsistent integer types, mixing both
> unsigned int and int.
> 
> Use type size_t consistently for these instead, and update the return
> type of dma_fence_dedup_array() accordingly.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> Suggested-by: Philipp Stanner <phasta@mailbox.org>

Reviewed and pushed to drm-misc-next.

Thanks,
Christian.

> ---
> The rest of the subsystems (dma_resv_reserve_fences, drm_exec, drm_gpuvm,
> xe, nouveau, etc) uses "unsigned int" for num_fences, for example the
> amdgpu caller in amdgpu_userq_fence.c.
> 
>  drivers/dma-buf/dma-fence-unwrap.c | 8 ++++----
>  include/linux/dma-fence-unwrap.h   | 6 ++++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
> index 53bb40e70b27..65e87d263c3a 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -93,9 +93,9 @@ static int fence_cmp(const void *_a, const void *_b)
>   *
>   * Return: Number of unique fences remaining in the array.
>   */
> -int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
> +size_t dma_fence_dedup_array(struct dma_fence **fences, size_t num_fences)
>  {
> -	int i, j;
> +	size_t i, j;
>  
>  	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
>  
> @@ -115,14 +115,14 @@ int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
>  EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
>  
>  /* Implementation for the dma_fence_merge() marco, don't use directly */
> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
>  					   struct dma_fence **fences,
>  					   struct dma_fence_unwrap *iter)
>  {
>  	struct dma_fence *tmp, *unsignaled = NULL, **array;
>  	struct dma_fence_array *result;
>  	ktime_t timestamp;
> -	int i, count;
> +	size_t i, count;
>  
>  	count = 0;
>  	timestamp = ns_to_ktime(0);
> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
> index 62df222fe0f1..7bfacdf79de2 100644
> --- a/include/linux/dma-fence-unwrap.h
> +++ b/include/linux/dma-fence-unwrap.h
> @@ -8,6 +8,8 @@
>  #ifndef __LINUX_DMA_FENCE_UNWRAP_H
>  #define __LINUX_DMA_FENCE_UNWRAP_H
>  
> +#include <linux/types.h>
> +
>  struct dma_fence;
>  
>  /**
> @@ -48,11 +50,11 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
>  	for (fence = dma_fence_unwrap_first(head, cursor); fence;	\
>  	     fence = dma_fence_unwrap_next(cursor))
>  
> -struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
> +struct dma_fence *__dma_fence_unwrap_merge(size_t num_fences,
>  					   struct dma_fence **fences,
>  					   struct dma_fence_unwrap *cursors);
>  
> -int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
> +size_t dma_fence_dedup_array(struct dma_fence **array, size_t num_fences);
>  
>  /**
>   * dma_fence_unwrap_merge - unwrap and merge fences

