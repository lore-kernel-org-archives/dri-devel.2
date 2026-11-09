Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFE606D80B
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OyAFFFTO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C1A10F2D7;
	Mon,  9 Nov 2026 13:56:05 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013056.outbound.protection.outlook.com
 [40.93.196.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0E110F2DA;
 Mon,  9 Nov 2026 13:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0CJji+5aB/zJd1YxkBWDlwDW052Dx48QFdu6Q8Wx4S9RfkFMnMh0VqzHUvimHhH+TEYgdnAjSgNsZhrMHvQmXsmHSm0ug7njCUjEyiYLAhi2Qz3Gd/sBKvKSsJXFO8ufsmNeO3ujPfpMbV5QW8EDIWqGv7MhoJihR0HiGavPuQn6yoAmNefavy5XiC48FrdCEJC5u2R4OCPLyczyLBY9q0YhL6PsVBG1dKquDyGYb9yVx0/4M2gwUz69+VS2Mxi0/iCOrYT2dFwQYjfZZS6Z79Ci+fXKyrdAJrTFcmpgqlTQqxO9XgMZBmSDCQs5ItSnNEYoC8/wgUDMa7SB1PIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN9zRRCqBklE/zWOzf9eSt3dkUUReAxpod8E9LbUsgE=;
 b=BaKc5A7PX8ziAvOfWq1NUPSR37Xy66GtoGl8qFcMD/XhzL5XtNmJJbECcaZcGncgdfdWCAMgJRc1d8o/FqBFvFnz8wI1NiJesmhubrF5wICYCAbLsDyQVDCeh7nEwmwkpubpLTIDgLNd+dPfcy0ciWnIYbdD6iHJ/TwkzgF+5tiBhSGhdSzWbB79Z39M7wmF6A9JePspyc5TaheGXBWVWy/ZCMpNZS4RC6f+AKtWLRNwDe5YDwjJUe3wRJ33Jbwiur0GucTA99YITzL9u3hYIojEjeR43flg5ysxJMDR9+GlYmiApjvB0fP0EAH65m35VnxksN0RQnP6WgL5mdr8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN9zRRCqBklE/zWOzf9eSt3dkUUReAxpod8E9LbUsgE=;
 b=OyAFFFTOYfOU5Jh/JMy7avL2gyBRqx37vN47dyja4QTO9q1q5Z6y3TbQeK8Awv0eKOIbjN9zfhZ8cXIZVIjZnzStlja+q/NsUaA8r2LzZuoHqH2W8NkZpx9N1SE/E8cicFN9hD453ul+rj/FLjaq5GaDSC5Lpk2Lwmp+o31/1xk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 13:55:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 13:55:54 +0000
Message-ID: <9d434db2-fca5-4168-acc7-1f5756e1dee7@amd.com>
Date: Mon, 9 Nov 2026 14:55:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/22] drm/amdgpu: implement SVM range GPU mapping core
To: Huang Rui <ray.huang@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-8-ray.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021025915.2433837-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 42fba94f-abd5-4075-aeba-08df3e692bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|921020|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: eW5GyN009D25D5pKiWpRgGVESTzocEs3slWJkt5RUnS7PbvXlHJiG/oovzTyjVbe8/dUS+pVWxVAcOBVwZ3FYeVyQ+NSPYtOWuWsQr4PrWozQRjHc03fKripo4qwe5MsIlSYk+E+2tLWVI+25IT9UUb/TvGjWvY2KolVMoNkyEoEV7IHs8gK+qoowmr4af4y1y1EdCbKryoTTpUNAbTg8NyChJEJfFsbPgFJyN8TSQmiJNZrIMKO7uiKNGjDPpr8TBAbxtcwiFtcN4uWGHwHp7Mh7YBg7oP5x8FgfZ9RVSG4yW+4w949sgyg/2AGPTdmWC69yvAVePzbD1hyVYFRyvU9bg+dr3x55W3fEZ5FyoEMfBdbctbEj8RG+CgnOsjwM9CCTXtYLbPGwU2gOqQlwvKj4BrShVrWwzDCN+Nu0+hsxlTN366LQGkE2h7Wnn6TYfsp9EFd5U9NzNYU33VZAGvkoZdz2omMeDiXa58gNHYQkJ3on9e6cmeuPckjmys19qkzI2HrnOPtQLumTk3Qy+NNZLhW3qurq64VhhVg92HqOZRVxzlkHifMiAuc1T9s8w0A66pEKE6tK2GZ4sf5fAZEUoOdUn1KYiP5To59kPf7kACPTcFBttdyMzpiYg2iuM4lxMB6mUEYYrqg+uluccnghSH4HZgWe57inAnJlifG8jInidpZiRw0O7RUYf/0LT7mjP6+HcXj0qpCcWUu6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldhbHplcDVTVEp6VXIxMlBOaTMyQnFWTU9BY2hXK0ZVYThnRjFIOVBId2NS?=
 =?utf-8?B?VXpHYmdVeVJvUHllalVQMDNaQjA3UUdSb0pTOC9Ldk5TZFVxN1QyQ1lqeHdj?=
 =?utf-8?B?VlJnemdKSGYvT3p2Sno3ZTAyY2FqSVg1N0lVMWRyQWVMNkN5YlJ6dU9CeXZG?=
 =?utf-8?B?ZXEwQ1VwdnRueHkvdHFBWnlRUzVwYm5YVGJycEI2QmdDd2ptaDFTZ3JsRXNK?=
 =?utf-8?B?V2NZWHRrU0VoSXp1QlNnVnRCQ3lZK3RsaWIvdWVFdUZhY043MXh2T0VNMllK?=
 =?utf-8?B?WjROUVRFTTJCcmFqckxiUW5lZW9QZGhmaStaN0pDVXQ0ZzJlSTMvQ0FXSHJB?=
 =?utf-8?B?UHJ4WmprNkw5QkxTVDkxMVB2ZzdSaGsxTFBma205cE5qbGZNUVJoNWZHWVdU?=
 =?utf-8?B?RUc2ZlNHZVV6eU9tenJLN1VzdjZoODQ3cG9iU09zSGNPYXQxN2JDRy9vTmtp?=
 =?utf-8?B?VWFxTjdjdGpLSzVGLytyVFhVcHlhMFVaNU9SQTRkWG9IRXp6d3BhUU5hSjNv?=
 =?utf-8?B?UWxyL05naDNIN0liek5jQXN3RVlVMTB3R2VaZk85R2VtbnlYanZXRmhPVU9n?=
 =?utf-8?B?eFVmMVBkMlA3ZlFKSHo2L0lxZnIwZWdKQ0wwRkJPdDdvUGFhWUJ0c0paVlc5?=
 =?utf-8?B?UnJGc2xSWk9BZDd6SUFCL2hLY0M2ZHBMUU9XOWpuNndORE9VcTNPbThkS0tt?=
 =?utf-8?B?MHZLU0UxM0dCd29JcXdZY1l6dnQ4Um9OeURvblI5QzFFVUFNc0xBRmZjdkdV?=
 =?utf-8?B?SHFYc3pHKy83am0xaXJsUGp0b2Urdjk4eU0ybGxJVWVheWIycU1NVFptZEsz?=
 =?utf-8?B?UmxMYmpGK2R6SUtnUy9uVDFObFVrQUpzVHVwRUF2NmZVaVVOY2h6S3hMVG9W?=
 =?utf-8?B?V2x3cmd5NFBVMDdQWkVMNCtkMnI0ODUvcjJWVEFpeStUSEhRZC8zTnRVeGxy?=
 =?utf-8?B?YWZoczdOMXdhUUh1V3YvenR2VWt4djdkOWJyOTVxM09wVksxdExFWkowSCtu?=
 =?utf-8?B?WmZrNjJYb3hUOFQvR2hKY3BrbkdzTEVBT1MxUGx6VldySURxUHoyL0JRcWhw?=
 =?utf-8?B?VEpmQXNOaDVIL0gwQnI0OXRUVVUyNUNOcGsvbndaUDFiQ2RuQnczOHpld0Y1?=
 =?utf-8?B?NnBIVG5iNWk0d1dqenBQYjlWQWxuTGl0eC82bHMyS2tZQVNibzlkVzRKMHNW?=
 =?utf-8?B?OWdCcVFIWnZRb3FUeWZYUmQvV2E4bjFOTUx0WklySzRkNERrNWpWa1lsb3J6?=
 =?utf-8?B?RWZ2OXBvWEkwMWhsd1NxdG4zR2dCTWlRdk5FUTI5UHVNb2srckZ1bEdjZnFO?=
 =?utf-8?B?M0JBRk1kOHFPWi93aG5lN2lBZEY2dDc5dGRIQnhTcnVjcGd0NmVTMjYwYkUz?=
 =?utf-8?B?dGNWVit6T0ZRTUhaV1BrVCtHd2VyWmdCb3Q1dXJWa0ZjemlRNkp5K1Z2MzU5?=
 =?utf-8?B?RXN6aHJmSmltVDZ1YVF0WmJSbm9oZGp1T3NxbmxEN01LUVdGQWFzc2VHdHBL?=
 =?utf-8?B?RWppTUc1L2dmUVlaTXN3cm1uRVU5ajJ6emNIdXVycTNaQ3cvdDJjUHRmU25Z?=
 =?utf-8?B?T0RTUWVGbi83dnpLVFlvZnFqUFZFaVo3cW8xSXZpbVRqTnNOdGFTYktjU2RM?=
 =?utf-8?B?cWVIdURxTmdjRWl6ZkJyL1ptVm9DSEI0eWw0ZHI2R3ROV0owV001RFhuYWtu?=
 =?utf-8?B?eFpsb0gzWWlSU3ZKUFUvbFBlcjZXU0Q5amo5UDdJZldWMmVZYW55djBGeGpF?=
 =?utf-8?B?MDQvbzNpZXByVnpyYjJtQUpYaVdJamhuNmZjODRlYVNxRk1pb2oyR3MvNjNO?=
 =?utf-8?B?YTE4RlhqYmpVV2EwVWlYL1poNWJKb0lTYUhVNWsxWXc3b3kvMVd3SWpxYkZl?=
 =?utf-8?B?LzBxZ0dHRlhLSGpjRVQ5b0RzK2krRjc5Uy9ETXpvbnl5ZEhkK2dZUVd2TGFS?=
 =?utf-8?B?VEZCeGQxZG1hZXc1MlJGNGN1czdZZ1VUdXE2Vzdtdnl4TmEyV2x1czYrTkVH?=
 =?utf-8?B?elNnNnBtckxBMVRDRDdlQXF0RUVBU0M3dmFxSGlIOU8xazJobllKTU5ub25U?=
 =?utf-8?B?SjBTVzFMZVVUNitycUlmZWtFUGJETEtzWWdZR3pWVHhVSVRCbDFPSFRCQUZ2?=
 =?utf-8?B?M3R5KzhtdXB4dGF3RDRkRmRXQlpiVFdrRmNGZmRvdzhkM1ovWGVyYlh2WFph?=
 =?utf-8?B?Q3FsdFc4d3NqR1NHbDNJWG5VMXdud3ZPTGVhOGw3ak45WTcwb3hzbHhvR0ZK?=
 =?utf-8?B?cVZXWS80QmwyL0xOeDFkaWdpbFo4MERrLzRGSEtoaUpzdzQraWh3dHF1ekcy?=
 =?utf-8?Q?f9ypx+oKKGs95/SfmG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fba94f-abd5-4075-aeba-08df3e692bb6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 13:55:53.8885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFzG7pdMVPYd9doOLOPFbY+DnNVq7ABFfmj15C8ffbAQKuRaUMvb41n0CtLWbXkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
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

On 10/21/26 04:58, Huang Rui wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> Implement GPU page table mapping in amdgpu_svm_range.c:
> - amdgpu_svm_range_pages_valid: check notifier sequence validity
> - amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
>   against the requested attribute set, under MMU notifier lock.
> - amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
> - amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
> - amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
> - amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
>   PTE flags per segment from entry->proto via attr_pte_flags, then
>   programs PTEs under notifier lock
> - amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
>   API.
> - amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
> - amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
> - amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
>   pages, program PTEs, update PDEs, flush TLB, record attr_flags
>   and mapped state); takes attrs + read_only and forwards them to
>   update_gpu_range
> - amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
>   creating/mapping ranges
> 
> - Add to amdgpu_svm.h driver private interconnect tags used in
> drm_pagemap_addr.proto:
>   AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
>   AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 417 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |  40 ++
>  3 files changed, 461 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> index 72f954d2df39e..cfdc4e6d045b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
> @@ -27,6 +27,7 @@
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_gpusvm.h>
> +#include <drm/drm_pagemap.h>
>  #include <linux/atomic.h>
>  #include <linux/kref.h>
>  #include <linux/list.h>
> @@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
>  struct drm_device;
>  struct drm_file;
>  
> +#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
> +#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
> +
>  enum amdgpu_svm_xnack_mode {
>  	AMDGPU_SVM_XNACK_OFF,
>  	AMDGPU_SVM_XNACK_ON,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> new file mode 100644
> index 0000000000000..d4830e53f3d8e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu_svm.h"
> +#include "amdgpu_svm_attr.h"
> +#include "amdgpu_svm_range.h"
> +#include "amdgpu_svm_fault.h"
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_trace.h"
> +
> +#include <drm/drm_exec.h>
> +#include <drm/drm_pagemap.h>
> +
> +#include <linux/mmu_notifier.h>
> +#include <uapi/linux/kfd_ioctl.h>
> +
> +bool
> +amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
> +		  struct amdgpu_svm_range *range)
> +{
> +	struct drm_gpusvm_range *base = &range->base;
> +
> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
> +
> +	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
> +		return false;
> +
> +	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
> +}
> +
> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
> +			       const struct amdgpu_svm_attrs *attrs)
> +{
> +	return READ_ONCE(range->gpu_mapped) &&
> +	       READ_ONCE(range->attr_flags) == attrs->flags;
> +}
> +
> +
> +int
> +amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
> +			  struct amdgpu_svm_range *range,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	struct dma_fence *fence = NULL;
> +	unsigned int flags;
> +	int ret;
> +
> +	if (last_page < start_page)
> +		return 0;
> +
> +	flags = memalloc_noreclaim_save();

Completely drop that, this needs to be handled by the VM code and not here.

> +	ret = amdgpu_vm_unmap_range(svm->adev, svm->vm, NULL,
> +				    start_page, last_page, 0, &fence);
> +	memalloc_noreclaim_restore(flags);
> +
> +	if (fence) {
> +		dma_fence_wait(fence, false);
> +		dma_fence_put(fence);
> +	}
> +
> +	return ret;
> +}
> +
> +uint64_t
> +amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
> +			    const struct amdgpu_svm_attrs *attrs,
> +			    bool read_only,
> +			    enum drm_interconnect_protocol proto)
> +{
> +	struct amdgpu_device *adev = svm->adev;
> +	uint32_t flags = attrs->flags;
> +	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
> +	struct amdgpu_svm_pte_flags_params params = {
> +		.coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
> +				     AMDGPU_SVM_ATTR_BIT_EXT_COHERENT),
> +		.ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT,
> +		.gpu_ro = flags & AMDGPU_SVM_ATTR_BIT_GPU_RO,
> +		.gpu_exec = flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC,
> +		.is_local = is_local,
> +		.is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P),
> +		/* TODO: add hive check. */
> +		.same_hive = false,
> +	};
> +	uint32_t gc_ip_version;
> +	uint32_t mapping_flags = 0;
> +	uint64_t pte_flags;
> +	bool snoop;
> +
> +	/*
> +	 * The per-IP MTYPE / PTE flag selection lives in the HW IP specific
> +	 * gmc_vX_0.c files mirroring amdgpu_gmc_get_vm_pte for BO mappings.
> +	 */
> +	if (adev->gmc.gmc_funcs->get_svm_pte_flags) {
> +		pte_flags = amdgpu_gmc_get_svm_pte_flags(adevamdgpu_gmc_get_vm_pte, svm->vm, &params);
> +	} else {
> +		gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
> +		snoop = !is_local;
> +		mapping_flags |= params.coherent ?
> +			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
> +
> +		if (params.gpu_exec)
> +			mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
> +
> +		pte_flags = AMDGPU_PTE_VALID;
> +		pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
> +		pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> +		if (gc_ip_version >= IP_VERSION(12, 0, 0))
> +			pte_flags |= AMDGPU_PTE_IS_PTE;
> +
> +		amdgpu_gmc_get_vm_pte(adev, svm->vm, NULL, mapping_flags,
> +				      &pte_flags);
> +		pte_flags |= AMDGPU_PTE_READABLE;
> +		if (!params.gpu_ro)
> +			pte_flags |= AMDGPU_PTE_WRITEABLE;

Don't touch the flags after calling amdgpu_gmc_get_vm_pte().

> +	}
> +
> +	if (read_only)
> +		pte_flags &= ~AMDGPU_PTE_WRITEABLE;

Same here.

> +
> +	return pte_flags;
> +}
> +
> +
> +
> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
> +				bool intr)
> +{
> +	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
> +	int ret;
> +
> +	if (intr)
> +		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
> +
> +	drm_exec_init(exec, exec_flags, 0);
> +	drm_exec_until_all_locked(exec) {
> +		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
> +		drm_exec_retry_on_contention(exec);
> +		if (ret) {
> +			drm_exec_fini(exec);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

Please drop that helper and always use the drm_exec loop directly.

Regards,
Christian.

> +
> +int
> +amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
> +				  struct amdgpu_svm_range *range,
> +				  const struct amdgpu_svm_attrs *attrs,
> +				  bool read_only,
> +				  bool flush_tlb,
> +				  bool wait_fence,
> +				  struct dma_fence **fence)
> +{
> +	struct drm_gpusvm_range *base = &range->base;
> +
> +	lockdep_assert_held(&svm->gpusvm.notifier_lock);
> +
> +	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
> +	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
> +	const unsigned long npages = range_end_page - range_start_page;
> +	unsigned long mapped_pages = 0;
> +	unsigned long dma_idx = 0;
> +	int ret;
> +
> +	if (!base->pages.dma_addr || !npages)
> +		return -EINVAL;
> +
> +	while (mapped_pages < npages) {
> +		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
> +		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
> +						npages - mapped_pages);
> +		uint64_t pte_flags;
> +		unsigned long start_page, last_page;
> +		bool is_last_seg;
> +
> +		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
> +			return -EOPNOTSUPP;
> +
> +		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
> +							    read_only,
> +							    entry->proto);
> +
> +		start_page = range_start_page + mapped_pages;
> +		last_page = start_page + seg_pages - 1;
> +		mapped_pages += seg_pages;
> +		is_last_seg = mapped_pages == npages;
> +
> +		/*
> +		 * The struct hmm_range hmm_range field inside amdgpu_hmm_range
> +		 * is drm_gpusvm internal state. It is not exposed to the
> +		 * implementing driver and is managed entirely by the framework
> +		 * as part of the framework logic. This amdgpu_vm_map_range call
> +		 * always runs inside the drm_gpusvm notifier, so omitting
> +		 * hmm_range here is safe.
> +		 */
> +		ret = amdgpu_vm_map_range(svm->adev, svm->vm,
> +					  flush_tlb && is_last_seg, true, NULL,
> +					  start_page, last_page, pte_flags,
> +					  0, entry->addr, NULL, NULL, NULL,
> +					  wait_fence && is_last_seg ? fence : NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +struct amdgpu_svm_range *
> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
> +				unsigned long gpuva_start, unsigned long gpuva_end,
> +				struct drm_gpusvm_ctx *ctx)
> +{
> +	struct drm_gpusvm_range *r;
> +
> +retry:
> +	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
> +					    gpuva_start, gpuva_end, ctx);
> +	/*
> +	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
> +	 * denies no RO flag range insert for RO VMAs, so treat
> +	 * -EPERM as an indication of RO and retry if not set.
> +	 */
> +	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
> +		ctx->read_only = true;
> +		goto retry;
> +	}
> +
> +	if (IS_ERR(r))
> +		return ERR_CAST(r);
> +
> +	return to_amdgpu_svm_range(r);
> +}
> +
> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
> +			       struct drm_gpusvm_range *range,
> +			       struct drm_gpusvm_ctx *ctx)
> +{
> +	int ret;
> +
> +retry:
> +	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
> +	/*
> +	 * HMM returns -EPERM when write access is requested for a read-only
> +	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
> +	 * VMA permissions.
> +	 */
> +	if (ret == -EPERM && !ctx->read_only) {
> +		ctx->read_only = true;
> +		goto retry;
> +	}
> +
> +	if (ret == -EOPNOTSUPP) {
> +		pr_err_ratelimited("range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
> +				   drm_gpusvm_range_start(range),
> +				   drm_gpusvm_range_end(range), ret);
> +		amdgpu_svm_range_evict(svm, range);
> +	}
> +
> +	return ret;
> +}
> +
> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
> +			    struct drm_gpusvm_range *range)
> +{
> +	if (!range->pages.flags.has_devmem_pages)
> +		return;
> +
> +	drm_gpusvm_range_evict(&svm->gpusvm, range);
> +}
> +
> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
> +				    struct amdgpu_svm_range *range,
> +				    const struct amdgpu_svm_attrs *attrs,
> +				    bool read_only,
> +				    bool intr, bool wait,
> +				    bool flush_tlb)
> +{
> +	struct drm_exec exec;
> +	struct dma_fence *fence = NULL;
> +	unsigned int flags;
> +	int ret;
> +
> +	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
> +	if (ret)
> +		return ret;
> +
> +	flags = memalloc_noreclaim_save();
> +	drm_gpusvm_notifier_lock(&svm->gpusvm);
> +
> +	if (!amdgpu_svm_range_pages_valid(svm, range)) {
> +		amdgpu_svm_range_invalidate_gpu_mapping(range);
> +		ret = -EAGAIN;
> +	} else {
> +		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
> +							read_only, flush_tlb,
> +							wait, wait ? &fence : NULL);
> +	}
> +
> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
> +	memalloc_noreclaim_restore(flags);
> +
> +	if (!ret && fence)
> +		dma_fence_wait(fence, intr);
> +	dma_fence_put(fence);
> +
> +	if (!ret)
> +		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
> +
> +	if (!ret) {
> +		if (flush_tlb)
> +			amdgpu_svm_flush_tlb(svm);
> +		WRITE_ONCE(range->attr_flags, attrs->flags);
> +		WRITE_ONCE(range->gpu_mapped, true);
> +		range->validate_timestamp = ktime_get_boottime();
> +	}
> +
> +	drm_exec_fini(&exec);
> +	return ret;
> +}
> +
> +int
> +amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
> +		       const struct amdgpu_svm_attrs *attrs,
> +		       unsigned long start, unsigned long end)
> +{
> +	unsigned long addr = start;
> +	int ret;
> +	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
> +	bool need_vram_migration = devmem_possible &&
> +				   amdgpu_svm_attr_prefer_vram(attrs);
> +	struct drm_gpusvm_ctx map_ctx = {
> +		.devmem_possible = devmem_possible,
> +		.devmem_only = need_vram_migration,
> +		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
> +	};
> +
> +	while (addr < end) {
> +		struct amdgpu_svm_range *range;
> +		unsigned long next_addr;
> +		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
> +		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
> +
> +		range = amdgpu_svm_range_find_or_insert(svm, addr,
> +							addr, end,
> +							&map_ctx);
> +		if (IS_ERR(range)) {
> +			pr_err_ratelimited("failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
> +					   addr, start, end, PTR_ERR(range));
> +			return PTR_ERR(range);
> +		}
> +
> +		next_addr = drm_gpusvm_range_end(&range->base);
> +		if (next_addr <= addr)
> +			return -EINVAL;
> +
> +		if (amdgpu_svm_range_is_valid(range, attrs)) {
> +			addr = next_addr;
> +			continue;
> +		}
> +
> +		/* TODO: add migration */
> +
> +		AMDGPU_SVM_RANGE_TRACE(range, "GET PAGES");
> +
> +		ret = amdgpu_svm_range_get_pages(svm, &range->base,
> +						 &map_ctx);
> +		if (ret) {
> +			pr_err_ratelimited("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
> +					   drm_gpusvm_range_start(&range->base),
> +					   drm_gpusvm_range_end(&range->base), ret);
> +			return ret;
> +		}
> +
> +		AMDGPU_SVM_RANGE_TRACE(range, "UPDATE MAPPING");
> +
> +		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
> +						      map_ctx.read_only,
> +						      true, true,
> +						      true);
> +		if (ret) {
> +			pr_err_ratelimited("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
> +					   drm_gpusvm_range_start(&range->base),
> +					   drm_gpusvm_range_end(&range->base), ret);
> +			return ret;
> +		}
> +
> +		addr = next_addr;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> index 39db3a18b5f2f..e5a5f52166576 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h
> @@ -126,4 +126,44 @@ struct amdgpu_svm_range_op_ctx {
>  	uint8_t pending_ops;
>  };
>  
> +uint64_t amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
> +					 const struct amdgpu_svm_attrs *attrs,
> +					 bool read_only,
> +					 enum drm_interconnect_protocol proto);
> +int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm,
> +				struct drm_exec *exec,
> +				bool intr);
> +bool amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
> +				  struct amdgpu_svm_range *range);
> +bool amdgpu_svm_range_is_valid(struct amdgpu_svm_range *range,
> +			       const struct amdgpu_svm_attrs *attrs);
> +int amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
> +				      struct amdgpu_svm_range *range,
> +				      const struct amdgpu_svm_attrs *attrs,
> +				      bool read_only,
> +				      bool flush_tlb, bool wait,
> +				      struct dma_fence **fence);
> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
> +				    struct amdgpu_svm_range *range,
> +				    const struct amdgpu_svm_attrs *attrs,
> +				    bool read_only,
> +				    bool intr, bool wait,
> +				    bool flush_tlb);
> +int amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
> +			       const struct amdgpu_svm_attrs *attrs,
> +			       unsigned long start, unsigned long end);
> +int amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
> +			      struct amdgpu_svm_range *range,
> +			      unsigned long start_page,
> +			      unsigned long last_page);
> +void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
> +			    struct drm_gpusvm_range *range);
> +struct amdgpu_svm_range *
> +amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
> +				unsigned long gpuva_start, unsigned long gpuva_end,
> +				struct drm_gpusvm_ctx *ctx);
> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
> +			       struct drm_gpusvm_range *range,
> +			       struct drm_gpusvm_ctx *ctx);
> +
>  #endif /* __AMDGPU_SVM_RANGE_H__ */

