Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF36606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=THIMCGWo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DBB10FF87;
	Thu, 26 Nov 2026 12:16:07 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747B310FF87
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndDCag3E84yNt47y63Hd9UJdKcfJ1Nxkd3pD81D+8kEMVW5J8Btc2mxwRVWPiLyBX9i2TPt8ABIRM057a2Z7jldwZfcDdTbTKI/AoKW/pkopcaAOcjiiF+yL4BQuXZtYoqnsoXPHW6CiRErC/3TgYG5cCyLMJj1dfaFRF62qTFWtVR9shYMJ9pBEGPQ0upkksUMjJm3QCOtIZHBa0rE+dPahfvJo74Yu10vaVRXyXvWAPTRjMp7aGLCZH8Wjt6pUmMrfeQbM+xhRv6l9f2etbQIdc/ILfZC/Zyuj5aWo5oEAOQrCs3cH9douLFmrLphvokWk1Do6Et4ekMXBbMml+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPz6cQX0DOetvBBypDj3Te39eXI4fXieWQUkRMoJAsM=;
 b=Y9NQLywswHAeHMPvSTz7F8419fJUyaCUjwEbvgaxP5L3HvtVEv3GkfnYns64lJ+viIwGdd9qkAl8x287Mt1/6W179oA2VdCsL0HFtEsKD80DO5mm43jNgpKI75bJRElZCVC5KCCkIAXBNIAEX2KTd1iPDriqqKGsvAykXGNNWCxmfopDx2Yt2A4qY/isR2aOx4l6n6ZUyiR2Uxnxrl7zl2Stt+J0PA6p2Rzdb1bIpQiqZ8+Qxpag9OMNTNXX/l2HlRnxSbACrysvySiY+tl4mvvDumvvAWYzQBPatW6567mF2EC+ox0fD7z15icnuPHAcG2WyGRUZYvBEvbJsdiJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPz6cQX0DOetvBBypDj3Te39eXI4fXieWQUkRMoJAsM=;
 b=THIMCGWoBeUSFLKa73cHYkporJ4KFxUxsJ0ADoW9FVI6uI39bcoVY3enLgX6D/zr45wW/PBmubiDB0K9GP/0dnl08NLrQCc5sGo5/f1fzF7m6uKFIZfjOqyo68d8EhgDHg27xUH6IU1EKnBuPVI3Ut5RfUwjBvpN/iDT7GEXvXE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 12:15:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:15:55 +0000
Message-ID: <f2d72796-b6b4-4181-9a8e-a9817dad6d88@amd.com>
Date: Thu, 26 Nov 2026 13:15:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_timeline_signal_ioctl points
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-5-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126111117.67342-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:52d::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: d5498576-9983-4356-e654-08df4bb705b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|6133799003|261009223027099003|261009221227099003|22082099003|18002099003|10067099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: xcP4aP7kaV2eUqVgAPChloa4TwSXAo1my47itDMdC9LcYyml0fv1Uqqz23upKq9iaufb3iskmMNZBgNZndYH1XJwcjBlsOJldoeIoCjBZubaAaXZQgZ+zZgmhYxBtdnpGrI8l7xdGbuzXGKYDd2q73rde0XC4Kj5EcsQjfLoerwRU4BttZF7otX6q+ufZel6+3tPiQg+qZTw3idJSFpHYUjwcV5lF4yvuPpqxd7XCSuxfizldPxRVpJ8VbICEoDzux2PxcaodwBLc0wrfjl8n99/82/A2hNybp+IR2cIyLqTppjsGTpf1WU6DfQdYojuJcpTSLi6hI5SuRCHH0phww/0FFOItX8VRZ3QP/iKok1y9CQmX9OqnxBmahZCaoMt0b6KnsE+GwnWTvfRNJ/XJ23mgsig9EpuQdNOw2YZQ7gFwUMwFReP4ZV+i9s/MDyiBfpsXiLL5rRugDBrDJfdPobBVhQ+kXP7yuaH1/OFia/j5Ty8yRc3PlhZljXm1c2fdUqOp7hF8LOjMHo2st8mMXvrCBuU1F7dsljc0umUQbnKQyvWaSdatOKQVW8khYzIY6zfBZfMrC3Z8aNglHS4EOZaetdsTWjHXdkmVzqVvwZCLYTD0NsDl5Th8ctMbOML7scxKk4lObRud0cljMTTM8+z0u5CJO3KxjBLwH7SRgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(6133799003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUMrWGRYK2RVZVQweWhWcUNTaTg1akpIamRwK2UxRzlnV1dDODRGL2JKUGla?=
 =?utf-8?B?WUhXT3M4amJpbmViSzQ2K1dSTThrandQRGZ2dlJ0YXYwY3RtWkRwdkFsOW5j?=
 =?utf-8?B?Q21CeHlTRDk1dGdVT1FCNXlic1ZyUjBhMzN1WUlqMWdSTHZYazVnOFEwWXkx?=
 =?utf-8?B?V01GSVpiVlJJUDBYYTZJNk1hMnVjRkc0ZGpWU1A5QTQzRHlXTW1BWER3SVpq?=
 =?utf-8?B?M3ZHQ0NwYkZIYlJrNUdCVGtvbDZySmgreVhFUVF0N2J2REh0ZzYxTVYxQlQ0?=
 =?utf-8?B?YWVsZittenIrVkFGd28zK0RVQnp5bHV0dHZBUWhDaHhVbWZqdFFJU1h1WEkx?=
 =?utf-8?B?OW16SGNCb0dPNlFteCt4a21rOWcramdpMytUT3liVWNYa1N0ZXRKOUgyWWts?=
 =?utf-8?B?MDJXL0I3dG1LRHRDbk9WNHU4YXd3ZVVWcXllbCt2K3g5ekFRR1kzUm1ZNFI3?=
 =?utf-8?B?Wi9meXR5T3RJVERoWHF4NEo3WURNSkdacm91cGtLNkN1VmsxeUNUSVZlWTRN?=
 =?utf-8?B?Ylp6YmVxdE9NSE9MWU1DMVlLOHYvNWtuZDEwVEZNRDlNbWN6dU52VGc3UEZ1?=
 =?utf-8?B?c3Z5a05UVFVvaXRxVm82UXpXSFh4LzFiZ284R3haU1UyYk1Sb2Q3VU1JeG5Z?=
 =?utf-8?B?UWd0Q2k3SkxzN1dlYjFPMGZTWGhrSUpkeU5BbGl4RmRxOFFoRlgvMUhLSGtz?=
 =?utf-8?B?VkZkZERaWGVHZGFEYTloT3A4SjJaZzBaeGpPL2tzNFRCRUxsbzhPd1FaS0J2?=
 =?utf-8?B?eG9sd0lxS1lwTk9PdHdnNWFMTzJkMkdMRGh5SXl2bEdMRlppNDBLQ0tPVXBy?=
 =?utf-8?B?L2JjTkdJUWFVUUlJcWRoaFE1WU9xeUdUclZ4TFk0MGxqU01EVFQycmRySkpB?=
 =?utf-8?B?a3FrWFBzZmNmenRKL21pMXpIaUp0TWF0OFBIZVZDL1o0cmpOTThxUFFNRkNR?=
 =?utf-8?B?QS9SMEtlb2JaUTJYNXFTUTNDMDA1U2FBZjFvUXJXaDhYUEpKMzU4Wmkrd1VF?=
 =?utf-8?B?TzMxekJjcHFJeFpjSmVvZzJmUWRjc1h3b282NkcwdkY2Q01LSlZyamlRSEpp?=
 =?utf-8?B?dGZzbnBjL3pMMENaNEdBRktYWlo5cnpZRzU4bHJ3ZlJwT1R2eWNhR1RsZXlu?=
 =?utf-8?B?b2ozeUw1TFpvalZQQzhuU2JzTEZUOExVc2FBZ2RrbVEyRW52bUxEYTBaSGRz?=
 =?utf-8?B?TStncFpTeHZCWTJDQ3g4Qkowc2VMdzloYldPNjJmK0NqWlR4ek5FWEF1TzhJ?=
 =?utf-8?B?dUdoWThYUTVOZGNPOWdMRmVwK2JmYWNyTHNIOU9EN0g5YzVhMGtFOXlSM2N1?=
 =?utf-8?B?eE8rNENEYVYwUVVPMUlXY1JVUHE4b0VMWEFIYjU2SkZvTGhPSXBGajY0SDY3?=
 =?utf-8?B?WlhpNGhhZWJ1NVRnSUtnTmhpdTBsLzFyOHNxajBVUnFraUxlaWNCT0hXY21a?=
 =?utf-8?B?VU9LRTdaNHd5em9SeGUrYlJkakhVRUxFbEp3UjJkeExWWmc5SHdrNFcyUWQ5?=
 =?utf-8?B?MEtZSEVmUEIwVmdaSFZ4UC9Xa3hXN1hUVkNEWUtvYjdnVTJhbEVmYkVrbWVs?=
 =?utf-8?B?U3VNWGR1L3FQcnNUOGVJQTRRbzN4UGFYdTJGZEMvN0djM0VzLzdSSm9EVmMx?=
 =?utf-8?B?R1RQWUIvMERDR2RxancvNk1CTld3Q0J3MTEvejlkQUNORkRibi9Fd2lkWVoy?=
 =?utf-8?B?TlJrT0JiK0NiaUFWYnN6YUpYMkQ0cTRucGl5bTVvZExhTnAvd3EyZ1haTjdT?=
 =?utf-8?B?cnR0aTB0VzFwRzNNR1Qray9ady9tR3o2NjNPWnAxSG5RSFdzM0JmWUNzcThK?=
 =?utf-8?B?SEl1bHJrMkJmN0VFTXlVMUdyaFd0dXFoWlZTYURGbFpQTUFpV3lhVnI2ZVFv?=
 =?utf-8?B?ZG85MlFKTzhQZkVDalM4d1dOMWlsSU95OUtiNUU0bWVZZklBSlhPSFFHRGFI?=
 =?utf-8?B?THpZbjlGRk0rODdXV3Z6OFdkOGovSEhEUmdGQUU1UWZxVktncnN2MC9wYnQ0?=
 =?utf-8?B?WndXQXJWalF5cGFSUGRKS2pBT2xHb0RHYjNBaG5ZUGFGOStQRHNPRzNlY2x6?=
 =?utf-8?B?SlhKbTFVVlRrWXVpTWdOck9tczFKQmE3VlRuZUxMbXkzMnhFeFRoVnBLaG9N?=
 =?utf-8?B?Sk5zSFEyYThHSThMcWpKUERGYjBDRm5Nb3d1b09yMVIyRGNqWXk3aTMzVzZU?=
 =?utf-8?B?MEd4eGYvQ2xYK25vdmgxUkZuUGlqelJlME9OK0liakt3M00wREw1ai90Ky9J?=
 =?utf-8?B?b1lQZkRETmZ6T0tIYXNJalNJRG5obTNoSW12QU5uVnlwYWR1MlFqZnRaMUFv?=
 =?utf-8?Q?7jDukrUz+z0RS4rnme?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5498576-9983-4356-e654-08df4bb705b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:15:55.8933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnNUfNXBC1d5nU5DboKycZBEl7nS91gWEVlmLsQzcBvv/6InJrmr4+3Q60Dcr7DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:11, Tvrtko Ursulin wrote:
> Use scoped cleanup for drm_syncobj_timeline_signal_ioctl points array
> allocation.
> 
> This is a split out step towards converting the whole function with the
> goal of simpler error handling and easier extending with a fast path in
> the future.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 7d5c4e4e29b2..e05051c3895f 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1571,9 +1571,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  				  struct drm_file *file_private)
>  {
>  	struct drm_syncobj_timeline_array *args = data;
> +	u64 *points __free(kvfree) = NULL;
>  	struct drm_syncobj **syncobjs;
>  	struct dma_fence_chain **chains;
> -	uint64_t *points;
>  	uint32_t i, j;
>  	int ret;
>  
> @@ -1599,17 +1599,17 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		goto out;
>  	}
>  	if (!u64_to_user_ptr(args->points)) {
> -		memset(points, 0, args->count_handles * sizeof(uint64_t));
> +		memset(points, 0, args->count_handles * sizeof(u64));
>  	} else if (copy_from_user(points, u64_to_user_ptr(args->points),
> -				  sizeof(uint64_t) * args->count_handles)) {
> +				  sizeof(u64) * args->count_handles)) {

Yeah same comment as for the last patch, the approach of allocating points even when it isn't used is rather questionable.

Regards,
Christian.

>  		ret = -EFAULT;
> -		goto err_points;
> +		goto out;
>  	}
>  
>  	chains = kvmalloc_objs(*chains, args->count_handles);
>  	if (!chains) {
>  		ret = -ENOMEM;
> -		goto err_points;
> +		goto out;
>  	}
>  	for (i = 0; i < args->count_handles; i++) {
>  		chains[i] = dma_fence_chain_alloc();
> @@ -1630,8 +1630,6 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  err_chains:
>  	kvfree(chains);
> -err_points:
> -	kvfree(points);
>  out:
>  	drm_syncobj_array_free(syncobjs, args->count_handles);
>  

