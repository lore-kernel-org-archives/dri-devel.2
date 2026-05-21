Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DE6CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 04:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CED10E45D;
	Thu, 21 May 2026 04:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2+TyGSI";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A1110E45D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 04:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT//BEi2deVghozlkyqmm7ECka6Rc9loKQjQEl83xu2ssB749M6VuLKJ+SS7x7cHZPi0GXiXhEHEjvObIqIf9H2/V8qRPvmBSIfpt1NHpRhaFcavMUYMavrR67nEhGFzy2H8fD/Ya1jMRiwnw4X7eRF5O6C1JRiXw+HrHeAKpw0YYV2NIPkAyaJKKYxYtOQc5EUJGJbNCBTqADDZCUPDF348fLfX/sDCCXpRhD74EFqVYBTxVa4ZigCyAcLnzzbFNy+44+EgCq9An9/jM1w+0YNvQk2AolmDSfyeom/l5cvAvAdnq3QNK1WKQ7At7D52Yy7qSTLCSaasHjj6V0yGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0dOMyBd62R5JmTfEqFv4CvH2p7MYw7FESFpdRCdid8=;
 b=RjaGQYChy1QCjbFMR6aSGuCMdB9LEn/q2cnj4jB80eMec9EIxYIXg0PXJXSTq2JL9ehpe4d4YgcjM0WTMIaM5G2FcRfTcr2TLBo4B0fCVRHXhG36Q5ohSIUT06+LFYCQn+Jse9nyP7AlxbLxCNMEGRSEFGWa4hXldGhJZUXJ3J+tJ2fHyMnBYqI+p+6XZkq//9cAcSAAmYbna3Qku+LpfdNP+mTIrbAwnqbiEvipgjOOPO/JZjAoOEMuP3cOC6APHsE94KY4jPaAA+Xj3zmt/EQYd9X6zs4o0ECfIjG4ug3PFGWeJ0cIS9/QouLM+SsNHWb9Nyruldd9Zx7fe5KJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0dOMyBd62R5JmTfEqFv4CvH2p7MYw7FESFpdRCdid8=;
 b=I2+TyGSITX8LebTrkt1c1bLWT/MJAwR41zeBeAOzFSDGqqKEOaWsBF81MsJBfbM0d/uyELsInzGia7kAAZWNxhZvVEcq/vuc5p0GH3uO3B0g8ZDGb60fw00Nbje6H00jrrMH/A6UqZe0VTwmFIqXNHfPJIeIX5YSBHbnrzHnviE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 04:30:18 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Thu, 21 May 2026
 04:30:17 +0000
Message-ID: <8c2c205c-1930-4f4a-a44a-d51163ae5648@amd.com>
Date: Wed, 20 May 2026 23:30:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ttm/pool: Use sentinels in debugfs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
References: <20260427162253.682415-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260427162253.682415-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:5:3af::12) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 467d8431-34d5-4224-10e2-08deb6f1a934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: zOO9KQzbIG8LFJCg/jyN6GedPgzfiRaE0Q6rqVbjbTnWkJmVHQAf87U2Sp+1ZtN3ar6/XjLN3nQ39jsCmFrb87FD/jzPOvJmC/EYJMH3a5fFr4I7BEMh+23pJw4x/b7BzfQlR8uWG02t0VW7m8SRA9vTl0cIht193bDmYd4D2oakKwTUumCcZJyBP0qVqKX8aMYGoTbUKSQJIm5O8qP6bsNgasZjW68FcuaV86ekBJ+/pUZI+kXjTo5cFFDsIbvAYDCLhYt6sozoAfiZ2L+8yEbfc8QwlPVwHQi04jObX9uY27t52SWZcrrEIWYqZzXZa3hky9VmGewEMqw8G9JyJgZnv+a0qgPESysqgDk075AuKmJV7/4pCRgptLKvfTI1w/HIv8LOy10jOwognLMMBespZ8iwmqH0gzAtoB/9O/kqfv2Ihg+VdJzhsIztn0SLc8/nIwkO/9C/vjXNXjEOr4BFR4KeBAdT7thJx27umNGaii+RPi5FXqXCYZehUTn1jhRR468o87OgR63WGF0MMjusaZ0PlNZCXvuGru3mvb+az/bId0JS4Cx0/htp0bB2BY2SIT0h+IUXv/atC+ZHRxEx1OAqzelkQb3ZexJSkC54VwmkCQzBLuHZ0wITKcFWYAEHeZcxiDqd69n/eEH3vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB999147.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmFiMHJLSXQ1YzhXeUpRcmpjSndrSEF6ZU9uWFZaWlRrWit6UkZuUmJ5THNt?=
 =?utf-8?B?WklxZlRScTdSVmVzWUx6YjVmWmxCdlA4dDlJUFF3aEtHMzlVSENHQlBlYkdS?=
 =?utf-8?B?RDQ5aEZhZDEyZHFRTTNsRkJQT2xNaGZHVDg2YjI2ZkEzRmhKS0RJM1R1Z2Rz?=
 =?utf-8?B?dGxUSWRRU1NXelBFTDFnaWl3U0VyQWk1Uy9WdGhFQUUyMUVpUmEwMjNKUUZH?=
 =?utf-8?B?VzEyUm53eVhHZzU4OUI1azJxTEVnS3ArRzkwbWJndC9xR3lnMWtBb2pTSWY2?=
 =?utf-8?B?RWt2ZHArQTA0MjRET1FHNWxKN29IWHJJZWYvaTA4c0lTaXp3ZDA3UmNzSkdz?=
 =?utf-8?B?TjRjMjVjVTZQNVU1dWYwZ1J5TGtpTktWYVdhR0RJSDg3MnNIRWR2RnE4NnhZ?=
 =?utf-8?B?SWl6dXpYWmVMY2VTNWZCOWo4RzJ6Qm1CN29sdUVWcm5xU2svVVdCcDRZNjBv?=
 =?utf-8?B?dEVDWE55ZVdNR210MHJOK1NuSHBjTHBvOUZKZkVOS3Qvek9salhIaUUxcVh4?=
 =?utf-8?B?d2dMaG96dHBEaUtFZGpkZlpnUHRUWVpuZlZHQzhDSWlkRENXcHJTMUg2MWhl?=
 =?utf-8?B?NDhBbWlTUm1adHVOZGwwT0ZETWp1b0FxdjJlYjFXM1VUYTJ3VTVUMnEzZll5?=
 =?utf-8?B?d055L3BPV2oxL1ZPdWZENUs2UjRWei9Zc1VNOVR3WlpXUHZ4WEE4OXcvWW9E?=
 =?utf-8?B?ZTV6QmtUVlNRU2VUTkpoNmpOMUUzT2I1T2FaeVFLMGFYbXpONmRGS0I1bzYx?=
 =?utf-8?B?UlRjSURWUisxWnZtR3I1bDJlV1RzZXFDMkVuVGtUUUNKZ1JGeVBVb1NhRElo?=
 =?utf-8?B?NjRvcDRJNWErZ0FVYjFXVjZaUC9wRVY1MHBqbHhqbmVXcU9WUUh0RiszZFBt?=
 =?utf-8?B?MUozaVpHdWtCaEthT2x4RVlvRXZpcTJTVGtabTVROVUyM3FhN2NYYXVBaUVL?=
 =?utf-8?B?MHBSSDFGeHZSbmloSS9mczY2WGlEbzVoNjhHNWlDMXhORGZaN05aT0hxQzhO?=
 =?utf-8?B?aVBDT2FlNGVTZGdHZFk4N25sVFlCdXFvdTREQU1sUERoRWk5YlIwbjBSUjA2?=
 =?utf-8?B?YnhzUDduQnJtQ2lPY3R3R3Vmd0RZUVNXSFVNWmxHSkswV2ovcld3SlI1NUUz?=
 =?utf-8?B?RXpuSWJqZGkrU0RSU2VZcm0zZCs2ZDN0Tk5hVTJWYlMvWGxBSGdUYjMvRUhD?=
 =?utf-8?B?WDVISUlCci9jWFpKdUIraC85TlFzYTV3U3grZE40ejVJVUl2eTJKOXUwcGZ0?=
 =?utf-8?B?Tkx6cU9Kazl3TkR0WEM1cG1rdG9WMGg3TjhTbzJQS3k1L1VHVVFKOTRKNTZw?=
 =?utf-8?B?a0szL2dIMmh6QkpGSGUzU2lrODJOUzNlVzVuOTA1MUoxN2xiZ3pmcnFKZTYw?=
 =?utf-8?B?MjlFQVY1Uld6QzAxaks4VnVudEh5OUVhZjRGR0NIUE9nZTBsd0J3c2NYSjNB?=
 =?utf-8?B?ZjYxTm5MM2hGTWZiMHQ4bFVEVWxGb1JwVmJkdEd2Q1FLdU1EOEdMc3JGNDdo?=
 =?utf-8?B?NURZdGloTEJlL2wrTFE0dlRFWXNoWWt6WlNKVk9YZ1h6ZFVlYXovQlFaeDhB?=
 =?utf-8?B?bitsb0EzbWNueHNURFVPUmdCVnp0bFZrVEtTZjhpZmM2bmZWOWV2NjBZc1VP?=
 =?utf-8?B?OFBxNWt6KzlrM09DTzlUSnJxaXBDeS95anAvZnVyOElpblhkdVZpUTZCVDJo?=
 =?utf-8?B?UFBNcXRzR0hzekpOVWNQMEpyVlVpOGZjWEVXMnAzVWFSekNVRFN1bnVicEE2?=
 =?utf-8?B?K2tFSUMrbkR6QzdVSVphcWJGa3BIb29vYnpEWTZ2alNYY3FabjRXMk1iKzZt?=
 =?utf-8?B?K2E4QTl4N21wZ2F5UDJ6SUtnZ2x4SjkyOWRJUEdmTlpGMk5pNGVQNVV2Q3JH?=
 =?utf-8?B?dngwbEtMUW9nRFptZWdIbGxrK3J6UEhRbzZyOVVJa0h5UUpkeUtLSUhPMUlp?=
 =?utf-8?B?UDlONzZQaE8zMXYzTGFpeGRIVUc5UG1IUlVYSTV6MGhhTG1OTG5ZcWNNYUFE?=
 =?utf-8?B?M3psZnRhWTR3MGVRWmZpNk96SVh2ZGx5ZU5sUklBM1JqUURibWxUZEwvVHE1?=
 =?utf-8?B?YS9sTEw1UGNhWFhJMXhYMldkRGVFbWE1TGIwWXlhMlNPTG5TdloxMmNiT0dT?=
 =?utf-8?B?QVBVbi92a0dxbWtjNmo1REJGRllITTlyL0x4dTFONzBkVUNNVUVmSjE4L2xX?=
 =?utf-8?B?RzlRblpyTVd5SW5ReGxPeWtoN1ZiWkdBcE84SndyNDZDcTJOam1MSkRoNU1w?=
 =?utf-8?B?bDFHRWNkUlZSMmtGcFg1blZjT3V0K1ZCaDBKRmM0STQxeFBoYjFmcjJaRW9L?=
 =?utf-8?B?RE80RkNScTg1bko2bDZPVm0zR1ExbTJmN2sra2Q5Szk2bDRvdXI5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467d8431-34d5-4224-10e2-08deb6f1a934
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 04:30:17.7490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHbWQ9/ll6hZ+whG77WgVJtbSoqtVx6ka1VVUZZWU8ej0LX44rtcmL7Dmczrk+N4xC7DAn9Jc6K/OU56BjSNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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



On 4/27/26 11:22, Mario Limonciello wrote:
> The values in the `page_pool_shrink` debugfs file should recognize
> the sentinels rather than causing an underflow.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5218
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
ping?

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd90..4e83f4978b136 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1335,15 +1335,22 @@ static int ttm_pool_debugfs_shrink_show(struct seq_file *m, void *data)
>   		.gfp_mask = GFP_NOFS,
>   		.nr_to_scan = TTM_SHRINKER_BATCH,
>   	};
> -	unsigned long count;
> +	unsigned long count, scanned;
>   	int nid;
>   
>   	fs_reclaim_acquire(GFP_KERNEL);
>   	for_each_node(nid) {
>   		sc.nid = nid;
>   		count = ttm_pool_shrinker_count(mm_shrinker, &sc);
> -		seq_printf(m, "%d: %lu/%lu\n", nid, count,
> -			   ttm_pool_shrinker_scan(mm_shrinker, &sc));
> +		scanned = ttm_pool_shrinker_scan(mm_shrinker, &sc);
> +
> +		/* Convert shrinker API sentinel values to 0 for debugfs output */
> +		if (count == SHRINK_EMPTY)
> +			count = 0;
> +		if (scanned == SHRINK_STOP)
> +			scanned = 0;
> +
> +		seq_printf(m, "%d: %lu/%lu\n", nid, count, scanned);
>   	}
>   	fs_reclaim_release(GFP_KERNEL);
>   

