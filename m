Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56BCC44506
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D026710E326;
	Sat, 11 Jul 2026 10:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DOZtr9YX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FD5892F2;
 Sat, 11 Jul 2026 10:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UURlf+Zp0hGhyGQrUezRsmXavib+g9NRqJ/cFY65phZVnvT5aBCf1Oqj2zVEHlD6Ba3q5sSHk7ZU//F4x+UfAN/OIfx+N6d6ikSu1klmq04XSGLxe8EwT74wKp1Rw+nXWJ70paxC80P89ZLbQnVSgbbjRxdPAIgMVAr4SMGJkXCUNOh4djllR6VjvLy9YIzOwzNsWWp8NzseiQFl4TnKWx8cpBfLH0FJ2gd5P21a5hBMExvr+Eiro1MmjAkusHg0akIXfXB3ulxWwbRdQ2UntLj+XWONDRxjtc+SGHhLh93nj2WIIQXYRUZHDZEZ7BAQheGnQTFFOFBeNn1acCX3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOdmSV0jLg4djF4K1FzqtFxOU06v2ryRZM/w+MXadQo=;
 b=fu9lwkpzq3hN5QdRTXoftU5KoyxyOyWgLKpEi3Lne+dcsAc6uwj7IiLvGzW+QnPYK1skOf3lh6I6RnQJEfc7i3Kf5iyPlgyNn9NjYi+0UNSSJ+Y6PcO0lo8ZN78n5/LsvpfBPG18SzuBdtw1WOs/mCGpwWprJdaEG6Rm/ojPVlj+S0/ItqUKA3u8LKA5w79A7KELJPevxZhoYGWUXGylc6W8bAPM+JS4jvICVHyiyIjK3TUueHrN2fTBmOEJ1iWNM+xR5F6vxCj2cf1Ni+mTRqVnA8yQ1q1pZ6SrTVZmW+TymGU0c/Qppq5crmEeOrM7y3/26aBxR1/jm1t7TNhbPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xOdmSV0jLg4djF4K1FzqtFxOU06v2ryRZM/w+MXadQo=;
 b=DOZtr9YXIH7ZoW2WFVqxjEzZvs4GrQvi1dUBiITRZXVepYO9Kpj+0+7zzjHrX6K6lpPxhHoq0om8aUJj8TAJSGk3qqh2ZkVMocB9Q/hdKW7iJ7ynDezLYPjrBtayn8hE3s/uXBeMbY1Ri/tczMWXbj0QmiRkucxYYO5elxjI2/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Sat, 11 Jul
 2026 10:38:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 10:38:15 +0000
Message-ID: <731fc65a-ab8a-43f6-be6e-03b7fc08698c@amd.com>
Date: Sat, 11 Jul 2026 12:38:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] drm/ttm/pool: Allow backing off reclaim at the
 beneficial order
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-2-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260710215442.2444235-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce42ba7-b04c-49bc-7c2a-08dedf388373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: jutyY6rxU7hwkDfFAFT4dUwSGH5m2ZxAfU3MN1p1iPL6M9EieJ9GhiJi7kDu2gSTaobijN3jAElDn3s8PNbrPP3vZa8/g+7OLVi0VrvO7rFE0eYxMvHRcRqiv3VrSUHcbq4awF3jrgOcrSTrPE+I2zw3tXGJdmZdRFfIlIlq8zSxYJE7gD2mpaWj3zOXTN0sgLXbdlItO5hW+7wG2jd7dP0/UYS1kjiwq8n/SAqynbnP+LD+JWvAEaRMSopuyJtggKesAxT8NdvvAtbqcY7f95qljk2TEAh39RhghDJi3wTfG+o8vWEJdnqk9EQdl+DycyRI6hUjJQS5c7uFEts5KP6cZWuf3jhqzuGMJx8romJZXn67tVLJ811M6tQzF4hxDTVoOW7UbXH5kq6V7zUE1hZ1EB+OteyXHnTA2xBuynFLD5B1tZy6zDmjP4jYFxsX2uUpuTc/bu/ecyQ/vyD8UMNK+aOid7sPgwPHv060wiK/lusJkJaF1Loz+vdpeO6fXXak2EYme4QVb42FYl/XkbYqUVCoz6zwXCteV3R+Mq7ABsv/TG7qu1i/OV1Ld7GEuCDvyb9VB82Gp3gpeJH2kIkS0VEKQvKnXW/S+RNjaroqMq3nb8rdHFDmMXGxfNJxs8UAMI3N0drrx2X4tdy8B/UUBLaNLUi9QqriXMhHJ8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGFzT1FCRkluZlJDSE41Rm4yV29EV2pJWVVkcFRIOEhWZFl4Z1pyRWZ1NUxs?=
 =?utf-8?B?NjZBRTlSaWROdjdha3ExTnhsa3AvZ2RjTnBERzFWUFJHak8wa294dFpZS2Fm?=
 =?utf-8?B?YURrYkY2NHhHSXUrMncxbkZGcDF4YVJSWFhHczNyRTdNSFZUUEc3SzJYZ0RL?=
 =?utf-8?B?N2p0aDJSQUU3WkErb0dXc3FyUFRHcFlHSEVlS0k1S0RVTnAzbjJNcWxoenQ5?=
 =?utf-8?B?ZTE4bVVveGxRYkhFVlpnTW5wK0RMN2g5UDdyc1JjOHJRQnE0bnFlU1E3UmlH?=
 =?utf-8?B?NlArK0JWeU5CaVhuZ0tmdW5raE05WHNNcnpML0k4SHR5MFVmOUdpNm5uY042?=
 =?utf-8?B?NXRSSzRVTUxveVNwTUFZTlRXZ1RqOFhOcTdwR3lrUjlya014MGpvUk5wYkFY?=
 =?utf-8?B?RVJxcUEzYW1pVkFEY2lvdDVucUpRMXh6cWJWdkF3TXVvUzhXWVkzTmNZNjJG?=
 =?utf-8?B?WE9XcmErdlcwQmNhMUJnWUM4ckRRVStCOTVGRTMwM1JoWTlDeXhMUHFuMVY1?=
 =?utf-8?B?RzZPUzc3OUs1S0V1NkhFSDRPaVBja1M3NFJRRU14Y1hMWnFhK0tkYXYrdHFC?=
 =?utf-8?B?T25hYjRIVkxHdm1STVY5TTFWZmhQZnRNMWdGN0dCblEvQlRSM0NxTG94TUx6?=
 =?utf-8?B?VWVucDRmM3prWHcrMUlPNzFld2k5TzQ5M1lLTXptVFE3bnBndmRKekVhQVhw?=
 =?utf-8?B?RDQ3T1pnRmltMXhYUjMyR1A0K2QvRU9kYzlyTnBweFY1ZmJFNFcvLzRTc25s?=
 =?utf-8?B?cDFwVUhJVkJuRVgwbDZHRHZFKy8zRWZ3cXhQZVh4SEVVcjc3Z2xEY20yWVgz?=
 =?utf-8?B?anM1SFRIS0Z1Y0I0bnIvbm44MnVSUTZrQzBvYm9qNmo1Q3FSdFNnMXlpWExQ?=
 =?utf-8?B?YW9zME03Z3hVZllPYXBHd3l0VUd5UWo0NWE2MVJVMklLblRIYjV2TUpHd0c5?=
 =?utf-8?B?c1lUblQzRVNUTTlVZ21EVnVQYjhXVUVuQ3lvQ1l6YWducnR6U2hhdkV3WEYw?=
 =?utf-8?B?R0tOR3JxN1ZjSE5lNURJa1VYRmZ4MEhHbStNaTB3T1ljc1daSzhSVU5lT2Q3?=
 =?utf-8?B?Y3hxSng4Qk1aUEt6MlZIYVNoTTF5YTlOWTZlMXRLazNaR0FocWxBelFrbXhi?=
 =?utf-8?B?RDdSV1lrUzVuTUxmMkJBcjhBb243TjRXWjkvK29PSkRkSmtBS1dSUlpwVTNl?=
 =?utf-8?B?MjlqQjl5bWNTOWNneW9JaEZCbVJHb0dhRWFxSXg3TmhHRURNUmNvTVNXSE5I?=
 =?utf-8?B?RHlPRDNUVGswTDBGcXQzMGN0empZa0tGNTJuMDMvK2k5UVJGL1hneVphNVRH?=
 =?utf-8?B?cksyTTBVRmkwYzhXcElhU2YxS3duR3VNN2lJNXVCOU5FWTZHK3o4WmgzWXBD?=
 =?utf-8?B?ZDVRSTVBSVhIZWZoZ0ozY252ZXhIZC83eUhEVThsOFgrSWhjejIyREQrQ2gv?=
 =?utf-8?B?ZGpqam52aEdFMW5RcFRuTzQySlBNSk9kalcxb3k2Um9URjB0ZDhwOFR6emt1?=
 =?utf-8?B?Y1I5TVdqMERWdUhoNjM4c2hGRmllV1daVXJtNjAxTm1sZjcrb0w1TzBMM1Bq?=
 =?utf-8?B?NnhETGNmdzArcmFWTEkzWWVFL0hzQXppRGFyNXZjTkY3dis5ZzBwbmFwR2xz?=
 =?utf-8?B?R3dGNC9LMVFQb24rd2NRNlk3WmEvUzhrK3RBRDludVJjQzBRRG9ua2ROaGhR?=
 =?utf-8?B?NWdDV1R5bVZ1bTgwaEVxMjBDNHZjeUlzY0lERFkzaWRCaFo2ZFE2SDltT0Rs?=
 =?utf-8?B?KzhnUnJiTUpCaVVKME5TTFlGcVdmL21QV2VuTHhYU016KzBjdHU3NjZ3K2xk?=
 =?utf-8?B?aHBjajFZZDJGMlpVcmJ0Y3FiRUJwNzVlZ28xY0ZmcmpqWms0WmNuVTVISkRr?=
 =?utf-8?B?RWxNTGhIZWlhamtZWENHYllaZnNxWDNHajVLVm5PeERxSzNZTWlZV29vcSsy?=
 =?utf-8?B?bFR1U3d6aXBkeThEbHFyZytLOTZJV1dRdzhWS2lGQ1FGOE9KejdHWFEyWnlk?=
 =?utf-8?B?a0hqeUx6NG0wN0hlUG1heHRNTkRsS3VBTWlvS3BiV1ErdnVwQzc1TFJrN2Fw?=
 =?utf-8?B?T2k4TmFBTU1HR2tOejR3OElWcU5wWnR3d3lqdzFnSVZCbXpiV25ROEQzdnRH?=
 =?utf-8?B?dVU4Z2pta2J3SUgrd2k4YlBPWVNRQmxJSTNIOENJUFI5U3NrdGVBTXk4Z25o?=
 =?utf-8?B?cldCMnZnejA5ejdxTDlENUZtdGJIOVV2eGdKazNhb005RkVLNktTcEU2SkpX?=
 =?utf-8?B?NjlWeDJMMkhRdmhXZVR2VHlOOWE0TWFHdFFWVG51R0xQQXBRMzZBNkJtSjgx?=
 =?utf-8?Q?w9apqBRmFJdLLJDD/y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce42ba7-b04c-49bc-7c2a-08dedf388373
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 10:38:15.1691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv40vscsL+q2uL51jX18nHyhUsySTIMKU54E7jVlzGvphTB9ahgN7oPmGcrDLqjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307
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

On 7/10/26 23:54, Matthew Brost wrote:
> Allocating at the pool's beneficial order normally uses
> __GFP_RETRY_MAYFAIL to push hard for a contiguous high-order page. When
> beneficial-order allocations have recently been failing, this retry just
> burns CPU cycles in reclaim/compaction before falling back to a smaller
> order anyway.
> 
> Add a beneficial_reclaim_backoff flag to struct ttm_operation_ctx and
> plumb it through to ttm_pool_alloc_page(). When set, the beneficial
> order is treated like the orders we already consider not worth stalling
> for: __GFP_RECLAIM is cleared so the allocation skips reclaim/compaction
> entirely, and the __GFP_NORETRY clearing / __GFP_RETRY_MAYFAIL promotion
> is skipped. Together this makes the allocator back off quickly to a
> smaller order instead of stalling.

That makes no sense at all.

You first give a beneficial order from the driver and then later overwrite it.

What could be done is to make the beneficial order part of the context in the first place, but I don't get what the use case for this should be.

It looks like you propose that TTM should accept smaller chunks of memory initially and then comes back later on and re-allocates things in huge pages.

If that is really the case then I would clearly reject the whole idea. De-fragmentation of smaller pages into larger ones is the job of the core memory management and *not* TTM.

Regards,
Christian.

> 
> This is a no-op until a caller opts in.
> 
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Ryan Neph <ryanneph@google.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: GitHub_Copilot:claude-opus-4.8
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 12 ++++++++----
>  include/drm/ttm/ttm_bo.h       |  7 +++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 3d5f2ae0a456..dbe977412a81 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -145,7 +145,8 @@ static int ttm_pool_nid(struct ttm_pool *pool)
>  
>  /* Allocate pages of size 1 << order with the given gfp_flags */
>  static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
> -					unsigned int order)
> +					unsigned int order,
> +					bool beneficial_reclaim_backoff)
>  {
>  	const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>  	unsigned long attr = DMA_ATTR_FORCE_CONTIGUOUS;
> @@ -165,10 +166,12 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  	 * Do not add latency to the allocation path for allocations orders
>  	 * device tolds us do not bring them additional performance gains.
>  	 */
> -	if (order && beneficial_order && order != beneficial_order)
> +	if (order && (beneficial_reclaim_backoff ||
> +		      (beneficial_order && order != beneficial_order)))
>  		gfp_flags &= ~__GFP_RECLAIM;
>  
> -	if (beneficial_order && order == beneficial_order) {
> +	if (!beneficial_reclaim_backoff &&
> +	    beneficial_order && order == beneficial_order) {
>  		gfp_flags &= ~__GFP_NORETRY;
>  		gfp_flags |= __GFP_RETRY_MAYFAIL;
>  	}
> @@ -814,7 +817,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>  		if (!p) {
>  			page_caching = ttm_cached;
>  			allow_pools = false;
> -			p = ttm_pool_alloc_page(pool, gfp_flags, order);
> +			p = ttm_pool_alloc_page(pool, gfp_flags, order,
> +						ctx->beneficial_reclaim_backoff);
>  		}
>  		/* If that fails, lower the order if possible and retry. */
>  		if (!p) {
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 8310bc3d55f9..fd814b5cf535 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -187,6 +187,13 @@ struct ttm_operation_ctx {
>  	 * when multiple BOs share the same reservation object @resv.
>  	 */
>  	bool allow_res_evict;
> +	/**
> +	 * @beneficial_reclaim_backoff: Back off from direct reclaim at the
> +	 * pool's beneficial order. Useful when beneficial-order allocation has
> +	 * recently been failing, to avoid burning CPU cycles in
> +	 * reclaim/compaction before falling back to a smaller order anyway.
> +	 */
> +	bool beneficial_reclaim_backoff;
>  	/**
>  	 * @resv: Reservation object to be used together with
>  	 * @allow_res_evict.

