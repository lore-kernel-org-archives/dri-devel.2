Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193B606A325
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hd6NLDMi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF8510F529;
	Tue, 27 Oct 2026 13:41:10 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75EC10F529;
 Tue, 27 Oct 2026 13:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZNszL7pT9nQ18wquLryzSgRd4NHmn88kD5P847OMTudiqM7rRf57F799XkxQew7uL2dlerPSR1aOblOsvO5FsIeWMKtAvmM6HJy2mP/2ZZJHa9t1bqfznP/BtaNUVKtrQoR0s05zdN4Cd8vwmmXv8LVXBvMfp6I3oZDo3VgBxE0bgJFhQze40ORmmHD1AIXvMR0w+upVvOjvpYNcK1E3D6x7+o4ety4Iw4+NjC8/vah4/D7sgxobWxrMnhWu8On1ipLNrGtJxOFfZoljIB64gsywSLSYovhuS0g5YOrHNg8yBxx36HU2t7r+wh3cniaQhGLJfwzmS2GK4j73Y/d5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4ABcYleVZ28FUVIT2S2CoaW9f5LYg5R5g8UmHS0U84=;
 b=hqkxUYHZD1URS8tjw2rvnMwotCuEYgO09zZFJb1z3MZ0H5O6jYNwl5uL9xJUDj53SnBfEMj22JUmdQnejWqGSAzovKHWyT8uv/DP0O2TTnELeIel9X3e21Z+X/zBpUhrp0zBW79A4onRaOMWUf2giKGGT8TwafaMSIy9qbMzvOdhq/odasQET76DM+V3giZc5NtV5Y3Jj7IhNBXL9jjnrGSRagGiwJS8rd1wcEp7BbGOUX0AgO1GEP7zc7lmcH8RdqiLkBLy6JGxvWnIUNUXWNVRXDj8hfLkqnYolLyRVmFKYK4yDG1e0VO35qkBjwRQLP2bzWwcUmocX/Gja+4NOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4ABcYleVZ28FUVIT2S2CoaW9f5LYg5R5g8UmHS0U84=;
 b=Hd6NLDMiCzxZ26PHUPqfAa6knYxmSfJjnY3Nlin1SnW+hEKIik6XhBwTsFakbMLWhje3xvvC032olqpA71bezVKP/SAReJXk3LL3pA3b1qy++vdp8Nhxf0HEn0nuY1KmY6IgKZWwccydHKclPPr/Bn8sgM4buHCL8an9El1zAHo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:41:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:41:01 +0000
Message-ID: <54e6cd9f-57ca-402f-93b6-27fe2b15b29c@amd.com>
Date: Tue, 27 Oct 2026 14:40:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: amdgpu_fence: remove ops->release()
To: Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Jesse Zhang <jesse.zhang@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Kexin Sun <kexinsun@smail.nju.edu.cn>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20261027133727.748652-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261027133727.748652-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: e92440ec-1431-4dcc-a660-08df342ff09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|261009223027099003|10067099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|5023799004|921020|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info: unpNOvasnT7j8sh+J+3n+0AtCm3ZmyfluYlnuyxGgR0VzLCWmysCct59q2oigwUOTWjQNW+KilbVkOLYiQS93g1Jmxei+Ojg1FKVChFLnxyQcxWAupZgy2E+ah5yiwnbelPPDai6mJnzj+WAiA1CnZkf19m0Fg1dave/Y/tEepCSNdMIfUNSnOwrzNUjaTq+6e57KY/H2JY28syQQQs1vEU29Q0p0SXRYRVXMtYpOs3AyYwcjzAE3TP0n5goyDtQxSUGHz06+Tb/PNrtDqyTajxiOPWGG+HxzkDqBib+z+e0QErn7Jzzb8BneLqO7hy8AhWdQAxDcf+p/kLX4LAz26/PZVqE784V40F1rP5ILiF+2p/uj5YPgbF5q9MKm88IMn9f8WvuHdnNSniUBwtOD270r3GaAOZ2L0KjLJPNDwzV7g1fHmo+JbCmQdlV6QAyyBf9ORkQPGvPlaNHsLPjycH2HkVAApmEAo1/eXXjB4wP05fWrQO+xauAyED0WYXfpuHsCq6q5hQ7WJPK+X5uVdmpzJ+zd+7YQp7DQbFUgTwH2qEM7Acfe5kdHID2AgYx1/YwT6qW5DWBCyw6BedLu/y5MOjhjfLrPiNCLUh0Wo6vmH+nEPd0TKo6/n4wMDfDuyLoPQbBP1mc3gUEGMGKsZzawm3uxplh4SGL1YRcBNJecQ/tek+OF69PxtoHQ/HeJFUZpliSPcj6cnPJX861xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261009223027099003)(10067099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(5023799004)(921020)(261026140227099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0x3TmRQc3pBQ2VnM0ltdEgzVHVmWkNmRVVkL1F1alhXRmJOM05sZUd3S0My?=
 =?utf-8?B?UjVYQS85SFVqTmhFa0tpbjhEdmpmT1U2RG03VUJhUStGbWZ6VlMzcnlwWFNo?=
 =?utf-8?B?dHpEcWFVOXhyekJlUnFxVWZEekxYZXVBZmJvdDFJZzdjaGN1bitmWmdpSlZa?=
 =?utf-8?B?R0JScEVpUE45c2RxUFRVREpwU0tKN1RDRmZ2NHg2YTE5WXNxcmE4bUF5bzh1?=
 =?utf-8?B?aWdwdnRTMjBDWE9aWThjVGFablFJbS92WlZWTUVLL0hYazFJd1N2d1lyNDAr?=
 =?utf-8?B?U3RCVExUUTFyWDdhNG0xbEdUeXI5OHRFQmg2amNkM2phNzRRMnlHQjB3NXV0?=
 =?utf-8?B?R1JZaXFHSE8yVjdNWXJFTDBuOFVra2E3cEtFcTlEd3FoVnJLclp5ckZzMEto?=
 =?utf-8?B?cnBKZDJSTy8zcU83TmtPYkl0Rjc1Z242aTJBWWFwck5TZjFKelhVdUpMekJn?=
 =?utf-8?B?T3hEMTZwZjIrZjhjYXRkSnZCazN3L3ViNUhGMGYvcDBQRjN6VWxTWFA1b1JS?=
 =?utf-8?B?b1c3TnhNeENGTGJEejZPazQ5MjdIbHp2SzRhdVVzRVBvMHY5UU1WVXhKUjRx?=
 =?utf-8?B?cWZ0b0ovSDNMQzJrbEd0NGtRd2MrNjNaS0RsbUxBSkg3NElMMkZPNU1yRGVv?=
 =?utf-8?B?WGpXMDNiV3RjclVpTlFFaHp4NEc4am1KcEpIMW1yak5oQzNKMlFHT2VGTm44?=
 =?utf-8?B?WExTcng5ZE1PNjBFcFNNQWFBb01mSGo1dmNpVWtnbTB0R2xqaTI4OCtJSlkw?=
 =?utf-8?B?aDFTUVFwRFArS2VqRzhCa2N6SUxMUmQwNkVWSVFPQUdKSk1zSjdKZzNWajRQ?=
 =?utf-8?B?R2JHMmRjd0t6bDZZcEJ5Y3RhaVkybU5PMisvSkd0Rm10ZUd0QWMvKzlUREtt?=
 =?utf-8?B?NVRjL2NScjFHRERLSEVzODJuZEpwMjFPazJ1VFA2MkpZeWJSV2x6WGI2UE1N?=
 =?utf-8?B?RllTVGd2NUZwZE9yUktPZEZBQVBwME1hVnNPdWNmUnNFTFJ5R0FLd0VzRDBG?=
 =?utf-8?B?cWgwcHhFSHdpbE5uTFZFbnBYMUdBYmQwTGZLdmVzbUh3YXhMNDhHZVhnMGU0?=
 =?utf-8?B?ZFRyRWkybWl1bndOUENlVmFOdjFWTjVlWHA4cWRzK2RIOFFDTkdoZXkvbVlZ?=
 =?utf-8?B?U1htUk5DMW1FV0J6cDZvSmFrNjFKZ2VoSmRMdzJnWkxFRFVkYzdtYndweXRx?=
 =?utf-8?B?NnZORGxNUkhkdTBNVVREUzczWkxBMGptYUpUNDk5NzZISWpVVjZVTW1acUlt?=
 =?utf-8?B?T0VMMkVURFp4UTY5WFlwUHFybmNnTC9KTFY5SFgzeWtlWWVhV2Z5eWJ4MEZz?=
 =?utf-8?B?VCthZUY0WkZQeGU1alI4VlMzT3FWd29uQm1SckRCaks4L1NpMFB2VGE4eTB1?=
 =?utf-8?B?SmdLVDhlUnlpZy92QVZwMUlUWDNkeit3c2pWNzIxYlBQS2dsRW1xR2k2R2xB?=
 =?utf-8?B?Q1NSWldkbmYzSy9nWjA1QVFoa1hLNFZUWnNwVXhqOXZ6SXBQZHpVUE9HYXB1?=
 =?utf-8?B?QUtaTm1kV2xJSFN3T1hBc1NQbmdreHhEZ2RNblBSZ3lYY0VwR0FoRFg1MjdJ?=
 =?utf-8?B?MDBTL2IwdXF5R0EyUHhhc3JNUkdQMENHa01WOGFXTnJxcER0eVNkWFB5VmdY?=
 =?utf-8?B?MXFrMVRZZk50S2Jma0dhMDhSZUNQYzRLQzNZaGF5Y1l0OHdHdDFneEVkMEdL?=
 =?utf-8?B?UXZLeTZscUVWSGVqSkRxRzdFUlpLaytnc3h2VFkrdXlzcDV6cHdEQXN5YlpF?=
 =?utf-8?B?c3lTY2RHNDIyQjhaS2R4c2tsUHh3VnVzbjBzNWNDbkFnOHN0Q3EzUzVXckRK?=
 =?utf-8?B?NWpwajdscVJsaDJCMUhROWloRFRSdlFOb3gvRFVnTXFDVTJJZWx1RmdPQlFw?=
 =?utf-8?B?dmwxcVp5VUI5T2xKUDBXN2s5YUJmTnpQZUo4RmlrcWJyVXJWeEFrY1dCUW96?=
 =?utf-8?B?aDFyam5VMlRLNUpSTGtiNnZQOW41eFB2KzRoU1orenBwQUVCQ1Y0Z1dOTDdl?=
 =?utf-8?B?UEYvWU1Nc01jd1B3eElBTXJCMjF2M092WXd5aTEwakJTUzNQS01CNUY4OWc4?=
 =?utf-8?B?cG1nWDhCSEFxT3dkdGdldjNaeHVMSXlvTTROa2pzSEhoMENIbjdiVGUzdUpX?=
 =?utf-8?B?SEFTZVE4eXF0M3NrZDNyOFJOanNMZmtvK1NUamlyYWdhTWVWb0NacmtKZzVB?=
 =?utf-8?B?a0dqaCsxOGs0VkVqeUJTMWQ1NGlERk0yWXNvbTRub2pQaHA5UnNkRjZYVlJ2?=
 =?utf-8?B?dTFrcC9aNW1jaUR4V2JNcmIyY0FrWjBvVENSNC90K0dQU09QczdQb3FOSE9H?=
 =?utf-8?Q?1ZhSdygz5wv59bLij8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92440ec-1431-4dcc-a660-08df342ff09d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:41:01.6698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: It3xL5LV+QYvFB9qiFyjgmp7qWYGKQmGoFiIHJpTPo2zPSe6B7JQM/LvkN3BcpT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 14:37, Philipp Stanner wrote:
> amdgpu's fence implements the deprecated fence_ops->release() callback
> which prevents the driver from ever unloading robustly.
> 
> amdgpu's implementation merely uses a call_rcu() that performs a kfree()
> on the fence - this functionality is already centrally implemented by
> the dma_fence backend.
> 
> The dma_fence backend invokes a kfree_rcu() on the dma_fence, which is
> fine since this is always the first member of a struct amdgpu_fence.
> Thus, amdgpu's implementation is redundant.
> 
> Remove fence_ops->release().
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

I have exactly the same patch in my pipeline as well.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Just saw that this should be unnecessary? Don't have a setup for amdgpu
> testing right now, so please take a close look, just compile-tested.
> 
> P.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 29 -----------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 3043ad041bb4..3f8b2571d74a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -892,39 +892,10 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>  	return true;
>  }
>  
> -/**
> - * amdgpu_fence_free - free up the fence memory
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the fence memory after the RCU grace period.
> - */
> -static void amdgpu_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free fence_slab if it's separated fence*/
> -	kfree(to_amdgpu_fence(f));
> -}
> -
> -/**
> - * amdgpu_fence_release - callback that fence can be freed
> - *
> - * @f: fence
> - *
> - * This function is called when the reference count becomes zero.
> - * It just RCU schedules freeing up the fence.
> - */
> -static void amdgpu_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_fence_free);
> -}
> -
>  static const struct dma_fence_ops amdgpu_fence_ops = {
>  	.get_driver_name = amdgpu_fence_get_driver_name,
>  	.get_timeline_name = amdgpu_fence_get_timeline_name,
>  	.enable_signaling = amdgpu_fence_enable_signaling,
> -	.release = amdgpu_fence_release,
>  };
>  
>  /*
> 
> base-commit: 731ba09867520c047c7de53f92e384808e0b638e

