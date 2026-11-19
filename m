Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4D606A33A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M/LDee9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC96B112081;
	Thu, 19 Nov 2026 11:26:17 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58EC0112081;
 Thu, 19 Nov 2026 11:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR/x0vxcu28duU9KumfPHmSm06QGEhANj5lCmEinvUDw2NuD8KROeW9/Q9L8Upw98R/BnB211vnsBKPUQar3ozYiBhFcUknIjiYeihd3SfUqt6Fl6AzQpsOA1cZXRa/Dlsz48KEugKUSAoDT5aUnPCsikmie63LovAE5zbuErOEQNVgadN291tNBPKsOLTz9u/vGyFd9g0rHVGCNntyLxL+JwzhCVLwbV7FDoO1NM0nbUu4qpNYUPOAodsBiTJyWEPEIOmsRCF+gH5jxaKcIQDPHgLJY+kNfEox+JtWS3fwJsIn8qUYqYHCe2lQftfofIifAyKMdt99x3+QUA54pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxW5/WHav1F8MdO1v00R5Cbofk5g5KCKfAABMFXs7fc=;
 b=f1LomhV/Lgr3QRxU6yrCjqKx6IhyhvSieafZU2gi+KD5NAumz0X7pMlfzd3xZvHLioTg50c9/PWrqF2GGyx6p8L7U/Tmo9gbRseBveMwbEHUiq4HvNVDtYLetvUVaKW09vS7t7wzISNNyp7IouHRWprdJHGg8sxGQLQz5S9uhasOTGesvz3zQIJEGLTPrsSi4ty8KIPDDrR6mGYd5vrFJ+XiQCGh9nNjkeOVIegNQ+QJpxiPdTa2zyz94Hs0qIRQtzJi/efqk0zQQkyXBQBm9z5B/Pch06vOFNoDXuUSUiVV1z39Bqs3egf739qic5VwpAeT6cTEDbSdWiua/ilRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxW5/WHav1F8MdO1v00R5Cbofk5g5KCKfAABMFXs7fc=;
 b=M/LDee9qeyaihdtnrLh+r3DetdArwG64ofTjpO/4Ib81Iy3437n09b0jnsj+BacTz+n18n21ApBxHfO6F9IBNp6mNbxevMzhO5rGPm1fO4vvSLb3NSHIUQVVz0uSrMEOp49Ng2zey3ZRCkdaVP8jGx8AIspvCZPu1QX8PRSU+So=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:26:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 11:26:07 +0000
Message-ID: <61b93f96-b935-43f5-975d-ae92b99f5ee9@amd.com>
Date: Thu, 19 Nov 2026 12:26:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: use a single clear entity on some chips
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:52f::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebeb18e-a37e-4870-f64d-08df462fe7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C0Xz4LeV8birO/8lKsQReQpQRR7qKT7NTJBv138k9UG6g+pdBdfwXgjlKmQambZR1wY/xUp/aVL1AvlRgmE+Do7PT1LV0KliQ91IdUWg5H8TsH4Emp3BuUO3CMvbl6B5riGpoC/aTOfUTaXZ0F3r74Bj0za/lb36IeeImor0et2tKBZtHF4wcABO93sDyNs2ZRsysRsT2h9SpnWXG2tDqjPqjiST/O32st0KsULJ/ktLEV15q4q9Ef1z0hX8agoTdGQ+aODtWXqDANbzVT+Xihtb42bStnyj/Qk0+wQMT3R/cWze4qWBbi6ZST+j3nH/r82x9qNny3jz5LRKsBD3Q3E1bNJIqa0iBo5AAWawIH9y1DkRl7293tL+ghWfnvIfUdrePVmihzOF9OfLFdTV2wN5egKDNnhqS+XOW1JoE+Z35j+1mRXWak7/xG5/1RBA2LuKbiRhi6AhZCYlKtOClQUkF4X1P5E/lSwVG1tlZEVk5Ro5B64Ts+u+D4QWg0pSwjGhjWj2snVLGGCRGskkirBJ59nmVH1xu4FBvBDpBqsjvqEmSDf+H4MNkW4rIibcwQa0qFQWOs65yaJ1BlOEIjPrOgleka/V7fR7WbD8Mh1CHBvO2wUhlM3FEAyi8JONFyHuTNgW8zPg9U+M6dQYOqCwfUY2CkbwV1xiCF9ok+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJzWDVCeXVFZWZmQzJ2ZU42eHZ3Y0dlbkwrQ2k5WTV6YlNvanNjVWVRN2ZW?=
 =?utf-8?B?MDNlSWxBVURqVk1OSmNzMlFidFNTNEZsVEk1bVMveFBJWlAzMFRWSU14YkpI?=
 =?utf-8?B?TEJmanJ3WGZvQTFqS09LWkdZVkJsUUdodkxxd281czRzVlF4bHBTbnFEUWU5?=
 =?utf-8?B?NTZRQVppODRXRDNBTndCVkF2MFJ2bE9udEpjUFd5cmdrTzlTaXF0SndtWmVB?=
 =?utf-8?B?STRQZDcweWlUdmJvb0dJeFZxOVNpZU8rQ29WdEVtT0FPMlBycFVXcWpjUE5Q?=
 =?utf-8?B?TjZmaTQyS3QvR0dMS25XQncvL2ttdG5ET05DZ05kZURuM0lqdEdHb1NjQXVk?=
 =?utf-8?B?VWsrSFZHSUgxeHZGMHhrcXErOFZvMk1YZWdXSm9UNDlxV2Uvd2I5VllJcG0r?=
 =?utf-8?B?VWducndSVG5rS1g4VlJOV3VlcmtLeGhQOGljaVkwZW5xeUExRlUvMDZSUlhY?=
 =?utf-8?B?by83eitvVWlyYW1NZmV0ZDZQOVgzRW1BMlRac0VoR1pPVEJ0clp3SG1wY1pI?=
 =?utf-8?B?WTNseWZjNWVIRm9nZlc5Lzh3SzVqbEpLb00wL2FSVGx1eFNCQkVTZUZiNzha?=
 =?utf-8?B?dnJQQ0s3dEVQOWhJNnh6YjRFY1VnNFJDWGhvb29mbHFyYlZxdzhhQWxOaHRs?=
 =?utf-8?B?cHNjT2lDd09DaXhjS3pSL0tGRHc1M0taSjYvckRNZld1dmR6d3FSSWQwcC9D?=
 =?utf-8?B?MkkyRXRra2ltVFE2Q3Z6eDd5YjB3b056aHMxUGF0VUdYTTBBajEydk52Tkpr?=
 =?utf-8?B?NDE4aS8rbGltT2ZWMFFUT2ppWjM0UEZRS0xEclVZelJHemtSRUhYTVJaVThr?=
 =?utf-8?B?bm5yK05aRmVxSjNSRWdiT3ZneGJUbFpxb05VV0FmdmdvbGpnUE54SHFNZC9M?=
 =?utf-8?B?Z09iRi80dEthK1pXOUVIWXcxWnZKR3BqcmpZY25sTDRRbG1HaHJwZVpZRTRo?=
 =?utf-8?B?dXgyVDJDRzNEejd1NzFibE1NRFR2cUMvdnBHcCswdjBhbDJRa3JoMTFiTGxT?=
 =?utf-8?B?NEtxam43ekprOWtBVDJlODljMElaSyt6ZFhiOTlKdE5EbStQTTBBN2hVRkJL?=
 =?utf-8?B?RFA1eUQ5WXAyNmxQK09NNXlWMW9qdkx0eEJyV0tGTVNPRVRjampHK1lNWkYv?=
 =?utf-8?B?bkxoWUc4UThMWFhXVDZGUCtaZ0FhZmIwdDdGcUZMMDQ5aWpuT1NGbFRBaE5O?=
 =?utf-8?B?Vkp6ekxnQm9TNzVRNWozTlBCSEUrMFFQSVVicUI0T2l6clpONEs0NVFhR0wx?=
 =?utf-8?B?Ym1qeVhsdlVCWElRS1drakhXVW1EZ01BTkZOdkdIVnJTWm9BM1JTTllpdWNy?=
 =?utf-8?B?Y3BpVmtuZjhUSW5zQlYvQUNaZlZoZG92a2dBaXNXZHYwSXUxdy9kVm53akds?=
 =?utf-8?B?RFdZYlRISGFrUHlMMTM0bGx2TFBJT2lxVVUvY2pZelI5dlBGWUdjRnV6M2Yy?=
 =?utf-8?B?RTVacWlqaWRyNXFWdXlMMHlMSFdjc1B2NE9qZFlXcy8vSUNUMi90NWorU0t2?=
 =?utf-8?B?RXN3T3hVWHlWVjZXZVNPSG95aElwbWlGMzlXdEs0eUhuQ0tCNWdyaWNBUVAx?=
 =?utf-8?B?aEY4TlE0L1FvazdlNGNYanZNcjRSWUNESEQ2REpBTUwvWFBveUtFOTdMU3g2?=
 =?utf-8?B?alZpUitWNksrUlhFQUpLMGQ2N3loU0VKZEJPb2RyeW5MWitiMFBxdkJydDJy?=
 =?utf-8?B?b2hSUy9rdUdsWDdCM010SG9DVnV5NUxPeWw5c3Q0UEJyNnpzeFZmUEcrV2lP?=
 =?utf-8?B?SHp3QWtML0V6YmMzMHpEbkh1cmhMc3ZtS0xlT0MzbUdkNEY1OTZuY3Z6V1dS?=
 =?utf-8?B?SHVMRFlFNkxiKzh5a2NCV0VCUzU3U0RvVGRCS2pqU0I2VW1RWXBtSmhjdmU1?=
 =?utf-8?B?MGtpWFYzWWp4L24wdG5KckcxYkEwZzR4NUJJUDFybkVsRXZnRGdGaVlIQ3NI?=
 =?utf-8?B?L09uNDdCeTRMS3MzY1orOFVsRVJkZjV4Wk12MnlKMXVzY2drWjBaWnVTZWZD?=
 =?utf-8?B?bDNtQkw1RWt1RTZZdXpXNzM2alZBQVB5QjY3ekFZSjBpM0ZXV0JLNHd4Ry93?=
 =?utf-8?B?ZHVPNk1jV25GYVBFdmIwQzRqeERheWhBZGhWQzhmbWlqTVI2eVZwZkpZZk56?=
 =?utf-8?B?VHlxYnQvYnFQWElNOHA4VmMrekdOMjJYN3NTUXQzbTE0TjREczF3cHNjNVVx?=
 =?utf-8?B?RXBCbkJuejBjSkpWZzR2eFRIdUtVakFNd2l3N29lemNodUVHd2FzSm05V3JI?=
 =?utf-8?B?RVJ3M2h3MXBpMGlkQTRWdFhDdFVqdFNMYkh0WHNMTFE2U0ZKOXh0OVVGYlZQ?=
 =?utf-8?Q?wGrZIFdUhHHz7SmgPN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebeb18e-a37e-4870-f64d-08df462fe7a5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:26:07.6757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afsB+EZ+p0Ejrq3q4tnS+wFL1RRRBghbgz32kXfdlCYUKJlrN5R9aFC17vpIcuQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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

On 11/18/26 15:49, Pierre-Eric Pelloux-Prayer wrote:
> Workaround to fix failing tests until the root cause is
> understood and fixed.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8dfa92967b63..d5c1d044403e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2411,6 +2411,13 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  	sdma_ip_version = amdgpu_ip_version(adev, SDMA0_HWIP, 0);
>  	if (sdma_ip_version == IP_VERSION(7, 0, 0) || sdma_ip_version == IP_VERSION(7, 0, 1))
>  		num_move_entities = 1;
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
> +	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
> +		num_clear_entities = 1;
>  
>  	adev->mman.clear_entities = kcalloc(num_clear_entities,
>  						sizeof(struct amdgpu_ttm_buffer_entity),

