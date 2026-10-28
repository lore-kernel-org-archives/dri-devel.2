Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD59606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GwzQWL65
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E3C10FB26;
	Wed, 28 Oct 2026 10:34:23 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ECB10FB26;
 Wed, 28 Oct 2026 10:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZDN/KIqLY29S0yon46RFd39TRZwrdG+48Y8JL437h5MZyB/36pJldeb8yIfc198wQJ1jLj5FNyZ5rohjjKhF/jZfDEiOcj+QPNGzzLystlmvWsrFbPcIJfXnM/K33K7p1M8ZpqQjP1w9O/gsB2M6yzsXLk9vT874zywGVwQ1Ku0EA3JLDP2u+JdXBKGrA3jUdBmKWeL6tZOdx8cG3MzacTKv3xDIGB0z36BZ0dN1Hks0UrInxuBFIcYM7DQrQaWerDN4Tx5G81RYmXxbI2rJcskrckCd1HxHS3LjajmdP+wZtBbDbu8SGLNnO4Mg4rhTIX1pYKJPganb4uRhvw+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVA1VxWfZ0VC+92J2lxSDdPXKWag7/J8EOAPDnGSWA0=;
 b=wFm+CVr/atrkNCFn+kJb37m8qxj/6pcgf8ni63tj+8eMJeQDeT1Lv39wL8EJdpYXX/7sihplq1c+/BIghp94NNmKfNVRPbANhtlVkNUhdB4iChZ3JhZC3jM8TCoqVt/VAqMFsC5wqwgDF6RjiE4GbgRqmvPSq1DXM3biUoOn/jQEUyl8TwKyFerD4UsI9cKIzH7Rn802sc6Nw5ELLSV0OM8c/WjwjBsVncHjFuK10whYeJnC64cYpTIqxEB0EiArn14wsFbJKOjrqA/jrsve+UggP387EuiFNe+5ylUEBaH3zle68rolaZ4ri5A+XTcQf33gI+CpbD2h68Bmf373+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVA1VxWfZ0VC+92J2lxSDdPXKWag7/J8EOAPDnGSWA0=;
 b=GwzQWL65iH5vsFcBts0amUhM4kQTm4I8oIBO9x4Dm8OvfOVowYqZRZcJG7eaKSWuzx5NPjEAUB0e2F7TKpcxfO77+tO7ZHkUNcObrclTzKC1ss9fNAh+JtGlrXqBLWYA5Xj8JwLuk0Lp+xMyG7tK+EvuV0xT3gqtVB0Oh7KSJP8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:34:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:34:13 +0000
Message-ID: <3222891f-754b-4879-8c36-ff9b606811d1@amd.com>
Date: Wed, 28 Oct 2026 11:34:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/etnaviv: etnaviv_fence: Put base class first
To: Philipp Stanner <phasta@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20261028103129.1036380-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261028103129.1036380-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 68877d4a-68c2-4899-5b60-08df34df0266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|261026140227099003|56012099006|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 0wm4VUoPBBAIGN1+mIgd7GaQ1BYkHzOii/MTQ91hyb/cOnrqnJaTRhubeVs0LsoDcFxtONDPJHty8TV7x9SGptHoQR4xkRgoK0/YYiJ6t1gTmW5rg/886od+HG/MOH35I/mjHJw7s190YiZk8ixqAwpm0L3bgnTlo2Oqkm2eLn3xIDBPmLf09O29m5m+UI/H0vPlv5GxCUs5lGHAKXRLZbb81JCoDerFEyIdueHUaIv/nXWBspN975L3vzuiG8wykjJ2uRhfnE6jCuWIHzcIi969jw4PmNSyfEpOvkrZCfKgU+H8M/etTdN09yPWAa2w1xyYev0oiAKal3NhEdEmsyh0XI+Ylfr5aqZDwyjvYiJyit5j5UZ5aPahBlr+DD4jbZFU9CRMohVjjD34jio4GuIcEocsdNwOfXxAkqf7B65ahrq0kLc9kFI0XsB70GgkTs+HqKwWUvp7OiiX0S8Pog3nMkpAnIbJHONyAUf7KZqfni/rx2+sI6gx2P7eM1HSTJrn4AUnw4WYr6/j/LWww8j59Ukb0ISDbQdLauTQ5dHjubutlGiqW2lLVR9p92hjQgnWyWLriQL00mKEf8S6iBsiWRgj/EYI8LVU541D65K81H5aRhjEhbI1cuWCPnJACiSFVeAmbXiVbtircBINP9urAzmi7kyMO2OVQjYnpbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(261026140227099003)(56012099006)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmF1SldvMjlPSVFhYmNIU3R1VnMxbk5jUUFmK2hVSUpIc1ZPQmVKSmQ5RTIx?=
 =?utf-8?B?MjBVNWUxSXA3VWdMUnloZ0pGM0piRE83dUtMUHRoVWhGeDhheEQ1NlRIWW9G?=
 =?utf-8?B?dlVpd2kwQ0ppTFVlQm5QV01VK3ZpZG82VXJJZ1FzdGZ3YXJ1WE5SdUtkbnFD?=
 =?utf-8?B?ckFzSldiMkFTYTVnUE5WeDJndGgzQVVLbS9abmhKckFsV0hwaHY3Z2hBZDJp?=
 =?utf-8?B?aFF5Vm9IeXRjMFpPRitCQkJQSlNDeDllOHBIY2hHd1FLQVRtTHRwTklkdnc2?=
 =?utf-8?B?ZW1tb01DeEFpbXhheW4xbjJodXpLUGVkTGtrN3lEd0NzNzYrODd2VEJCSHVQ?=
 =?utf-8?B?RHpBK3FNMkFjZDdnK2JnUVo0amozNTNGRjZmazcrV0Fnb1hPblFOcFFmSi9Y?=
 =?utf-8?B?TUo5OFlDS2oydEwzN0dnaXVhMy9nTTRaQ3BGcnM2bml3NmVQeWZONndzblNM?=
 =?utf-8?B?UVg3NEI4eXl0YTh4K1ZBanZ2TWpKdWE5bWtiQnZMcUo0czY3d3BUeFZ3Rytx?=
 =?utf-8?B?Nk9Fc3k4SEpTb1M1ekhHL1NJZmJNcTI0VnZvWXFuUXN3VGxYVGJLc1Rsc1k0?=
 =?utf-8?B?WW50em41alFDVzNLT1haQjR4QXhyRFZFaFdndmo1UmNTV1VRamEyK1FHMXIz?=
 =?utf-8?B?aTJsNi91ODZKZmVLUU5XUGtEUGlSTjFlYUNSS21XZStqWUc0Ry9LbTkzSS8w?=
 =?utf-8?B?cE81OUtPLzk2RVB1S2I4NEtxU2kzZ2dOdEM2R2I5R1VydEx6YldEVzd2TWRL?=
 =?utf-8?B?eFdWVzRwWFNlL3hxODlJTGNiY1dOQXB6Y2VZaUtncFhkR0F3ajM3NFpCQVJC?=
 =?utf-8?B?UTJPMFU3Sm1ySFB2ZjN4a0tpVnNSK2NrUDNtY1Y3L0xmUDkyZndPTEY1LzU1?=
 =?utf-8?B?dm1jSHFiMnR5WFE1czJWMHZlSE1RSVU2QWVncjVzYVJ2bHJ5VFB1eU9MeVpK?=
 =?utf-8?B?eElIQzFxK040UlFsS1h3YWJzUjBwSDFKV0dQb1d4MFZ5c2VqdmRubmQyK05J?=
 =?utf-8?B?Rkg2cG5nMi9KVHhqSUVQSkVrOXhCNm5KaHNXNkNZTEF5d05JbFk0YmZGUFhF?=
 =?utf-8?B?RWdtSFhPaGZWU3Vyc01TOHA1UmZEQ0NTM2lzekJJUFVSLzJmaGRMdS9wdkJ6?=
 =?utf-8?B?WnBoQ1VWdjRpTjhQYy9HeFgwc0RwMWFaVTg2aXBaTjNwK2VKQUUvRlJBQ3pR?=
 =?utf-8?B?RnY2ZW80czBBUkdZY3UvZ3I3OWpjK09ycHlXSEpVUzA5amhZL21FbTJTNXd5?=
 =?utf-8?B?Q3ptSm9pMVFER25PbkhTMmhyRDRxck1TT0d3OEtKbWhveUdXeSswWFRsQ3pJ?=
 =?utf-8?B?RGg2V3NtWnFUM2J3RjhNZ2t2d1RhMmVPekQrUVpmT01LR2REQW8vL3JnVjA0?=
 =?utf-8?B?bUl3M1haUEx0SEJTY3E0RHB0R1dwK3N3MnY3QVFjeE96aVprN2srbzgwalZF?=
 =?utf-8?B?VFdaTDVYTXY1QVdxcVVXQzZDeVRQSkU4bDBNbjRtZzVZbnF1bDZjMHhYNnh6?=
 =?utf-8?B?ZGx6NzdqN1hBTDZJcUpCVTRybDVBVkt4VWdod1NCbnVRTjFlNjZOMW9WeHQ1?=
 =?utf-8?B?ZWZTZUFwVHB6Mzk4UHdoVTl2S00xYUJ6dy95RHI0TnVxQkZoZTQxOEpPcTg4?=
 =?utf-8?B?Y3VFSy82eE1LNnRJeHhzQ3E4UkhCMmE2akRpTVdhcTU3K05lVlkzelFTNXpX?=
 =?utf-8?B?enlMNWJrNS8wVUlLWHJTWFFwRUVlb0dBbnBhNHJjUkJ3K0ZDdWo2Z1F4Y0JK?=
 =?utf-8?B?SmlYTVN1NjRXV1FJTDlQc1NUMm5zVnVhUXZKSC9qdnBTOXlmVmg2YUhoV1V1?=
 =?utf-8?B?bEl1M0ZuWkRqQ2E1bStCWWJJS3RwVjdQK0p4VVdmRldtUVNlYkEzYWVoQmlr?=
 =?utf-8?B?bkFzeVpIKzNIM0pKL1dleng5dnRLRU5YT0Vta1psY0hwWEQ0U2w0dHFVRHIz?=
 =?utf-8?B?ekFVOTM0N1dwSlg1cnpxZ1krSVloWUpoMDZhckZOTFVwUTRzTE43R0NwRStz?=
 =?utf-8?B?dnIwZmJ2UzhnTVA4K0tvYmpBU2VyRUJBeUVZaUN3VThYVlpGTkkvaFNnWEV1?=
 =?utf-8?B?ME4yM3I5Tk5qMGJ6U1lnS3RPS1BHalNRZTZpWjl4NVZpRnNFVjIvdTc4b3JP?=
 =?utf-8?B?STJFZ3pQanJicU9NUGZjTllVa0NGeTdIOS85MVpyZWNDL0oyOU8wdlozeXRy?=
 =?utf-8?B?YmZxQTE5U2Uvb2tKVSswYzBxSXYxYXAwdm5ySnArN2pMS3NVNDBidXRMK0dx?=
 =?utf-8?B?dm1oNWM5VFM3a2gyd244dGtaTUhSdlA1blFCcE5HK0JZSHhUQVNnLzYrWkJl?=
 =?utf-8?Q?jlsME0nNpLTQZQYn+n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68877d4a-68c2-4899-5b60-08df34df0266
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:34:13.3650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fKJYt0kxW8Oim5DLFxbgsw3W5wfQAABXNjmkjXoZkRmv1ojAetJp6LKOFhZphkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 11:31, Philipp Stanner wrote:
> struct etnaviv_fence contains a struct dma_fence, which is its base
> class. The base class should always be the first member of a class.
> 
> This allows for removing a deprecated callback in a subsequent patch.
> 
> Make struct dma_fence base the first member of struct etnaviv_fence.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 5c23182f4d33..e51a310c8d70 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1148,8 +1148,8 @@ int etnaviv_gpu_debugfs(struct etnaviv_gpu *gpu, struct seq_file *m)
>  
>  /* fence object management */
>  struct etnaviv_fence {
> -	struct etnaviv_gpu *gpu;
>  	struct dma_fence base;
> +	struct etnaviv_gpu *gpu;
>  };
>  
>  static inline struct etnaviv_fence *to_etnaviv_fence(struct dma_fence *fence)
> 
> base-commit: 731ba09867520c047c7de53f92e384808e0b638e

