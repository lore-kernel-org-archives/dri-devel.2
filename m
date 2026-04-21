Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0D9F327AA
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26B810E146;
	Tue, 21 Apr 2026 06:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/FDwHTc";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8067D10E146;
 Tue, 21 Apr 2026 06:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tiWiPkUUUgUPZ/KJ1JJWQCEAKjlxsrY2nq7H88rFgj6oPYtzWaUVsyhMFUFyHhzLz3MP2UsPfi2VnYKIZ7X6FU7YxYoQBRi/Hggv/PzbpAMjkBlbZCFUedIKeeDIzt1Pm4fMrZzKM07S+xvFTEutHb9dBsLuyMLOJcZjcY51F+h7j4xxNK/2FcXqzl4GCnZuGgWBX4LIDbicRiJlII34GPNbR/MMZcBegl+51TxUWOkeoXgPZaI/JNJQrO/pT1EIjqHnYlwCwARUQZFxfUuxGYefPyQV3dnTr7tXW6YnG4qEwS7SNO0a4SKLuGV6BJ/C0/OWEwqBDuqmydQ1cum1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1CBCM67kOxD2FDIMZUzqXt3tq8SDhrL/fUEXRHabNM=;
 b=K2cgFYsmKZwap8IlAyfozpUZaBU7UsxmsnzmYNlODEt4OENC4zvEgR/DgOeJDjB9s/bk8qgKKxSxSzNKpPpKACHE1PBm/j/dq/Pcr/RJys661NIDYu4sle8vpYtSBEw9F56bvkQMKaEEr2BdQvr2/Ay2yfKIQAC6EopVV+cHsSVCsPkM7xGel42k827p8cqaWNMkel5RDxJKUhtVUq9uIYxi63bAqTC1b1g67fEwDpujPvxmWscMqq2M4KJ5tD5qwfez16z3xJz0IE60ZcoKfHQ/1n94ldZWJd7JhD1HmtFpK4CXvsxhZNkfn3SGh13WuPtFGFSHZAvsfI+tC6MCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1CBCM67kOxD2FDIMZUzqXt3tq8SDhrL/fUEXRHabNM=;
 b=T/FDwHTcs9TjOAgACC7rpaUhZrviPYKNexa60TxInrAcg/fWalFUOGG3e9GUJK+7d79QkEICMMpI/i1jY3XcTvYPhdfGv/YztgQMGaxtXhs8KVyj2c9QJNJOkDiF0SLYfh6Nrk7O2OSi0MySR44sUtgZemk0nvhYWJugo3+nQQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 06:11:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:11:24 +0000
Message-ID: <aecef1f3-5625-48b2-9117-b14cb1b61e50@amd.com>
Date: Tue, 21 Apr 2026 08:11:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260421012608.1474950-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e272ea9-417c-49c3-0fcc-08de9f6cd08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uP966aSRfWGpm8EIccIN7uoCmzOYGvTn/t8u2UK0IujWFXnmgKPTvO4geYKgm2xOLUDMmWwy5I8vOQkZ++RgUeo78vxJhU6BgN63TuZwmNsui4pij2dnGRwDjJQnWJzfOSlyybIoe8yOYASoXhHXKk6ZSGO1jjBKbDzFLXCOrIBE22psQDmh4gx07Dt3s85Zu5kaNx9MCzZqKNURjl5BVBNLcyuNAMpFnrZtEnUHT74Xr2NTBKVuQytVxJaG5ndsLBzK5v4Xa4YTK4i72R7MkrLOxKa66qPsUvxvNwDm22fhInm+T2Ey/4r4CegYVnYnX9k/RxmGD/aBjJoZQQsiDkIRYvIPkHi70ULW00lXRnRSdLsYqwO12d3E/SqlrwyjqRwP6QvMv1kN+u8YgxAUtVC4/SvW0t9/Km18Rwm1pNOrV0UTI8efa44wBwgnb0jWVO+gPUM7Dj7hwPdhPHDVCQ/khSZO8qOLdQtN7HLFrpI6Ntu+G3gI2UGO3FddcPo9aSEew13vb0Y1k7YFyEkBy9mZTXZWCaPr4TRGQtdPQGbnUaWtuda7CwiJEt6UE7ic1j1TOvmnElRgejoQ1EWyrzAlwmTQxiaC+k9hYixargJrgBDrGqWGkljJ9Q7Dl9SLWZd5ufco2+R1dn9G7dCbYjpHcjnFaWafh37jlEOg6Ks4vzRufOn774W8kmG80VE8+oFHEfedU7pdk/XNVqfDi6rv2SiyZQ8oSyAlH8BFjb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk02SEZHckFRbDZiZmZid1c5R0hReENJc3BUT3UxcmZMU1NJK0N3SkN4clFh?=
 =?utf-8?B?MmU2dktEaEoxcHlBdzBTT05HdG5IZk1Fb3FhNTBobUp5NEkxd2VaZlZqMzIx?=
 =?utf-8?B?b05vd0J4dzR6T2RBUmxUUm44V0RNS1ZzWEVmcVpTaDNVUGN0VXFWMmhwY0Fl?=
 =?utf-8?B?MGZYdzlEUHRWa2xQMlhJandnYk1OL2htRElRaDlCajcxbTk0TytOWFZPSURy?=
 =?utf-8?B?anBwUHMzayt2blJxWjFmNEN3V0gyY2d1N3RYTS9lVnZQUnordysvYUtyNXpH?=
 =?utf-8?B?eEoxc1NhbzFWSkIyazUxWm1xTldjUTlzd1FldmRjaU5ORWptN2xxKzZWWVpJ?=
 =?utf-8?B?SW5IUEVyNHhtMXg3K201dGtPVE5GalNiNGsxTUhVUmlELzhJSDlmRGE3QnhL?=
 =?utf-8?B?WnRGMDJvWFRVU0dNZUF3VGprSmp0VE9QTC9OVFZWZ2xLbU5mZFVFMDA1cVJX?=
 =?utf-8?B?UlVJT2hRTkNURjBxUFhyaFlJVC9zU09neVlQN0N3a3kxcXZoaW5TM3M1RFVw?=
 =?utf-8?B?c1Rud2NxcHlNc2pLdTIvemJreFhzNlBBNytXOGpmVUxJNWg3L1FGUDZHNElT?=
 =?utf-8?B?RkttRVRyczFVZUdLelFqZHRQYUszQkUyNVZONko2UVdWYzhVNTR6SnZVdmtm?=
 =?utf-8?B?Y0V0Y2VIcGtZSG9TUmVpOXhYRWhmaUZPRzFNRWt4V0U2ZG8yRU0zOHNnMGNv?=
 =?utf-8?B?R3MrMkZaMHF3ZW5HSXpjTHRhQ3RxdUcvb1dBN0ZYTlRhcVJtbVNrenJTd0xP?=
 =?utf-8?B?Z1FodWhhcXJueTJ3bnBLQk94Wm5ObXdnR1ovQWd3bXZCYi84ZmFSNnRvTWhu?=
 =?utf-8?B?MGV4SmVud25MRnl3N3ZUM0lTNzRRTVZvUld6Q2ZLN3lxMlhqNDlKeDFYM0Iw?=
 =?utf-8?B?R0F0dFdWSHFCQklGYWhITWMzU1Y1RlppeWhGNWRmYnhCRjRoc2dyd0Mxd3Jm?=
 =?utf-8?B?cURvTHNCcnZ3Z0lVL2RyaGZnZmRCQUpyU2VMY2ZlSG1VNVpiQ0dCbDY3ZlFI?=
 =?utf-8?B?ZWRTaTA0T1hsWDVsS1hMUFRWeWVzL2VZTHpVM0JJMW53WHEvaG92d29CVUND?=
 =?utf-8?B?Rjd3Y0pFbkRrRE1Qa2ZWaVdXZlp4M0NkbjFsU2gycHgxQ0N6RUJqZnpxQno1?=
 =?utf-8?B?bGhFR3pITWFGLzhYRWVlMHRTYXhJRE9YRG8zM2lQWHNUTmg3eGZTV05XYjU2?=
 =?utf-8?B?NE1hQWgra3RieVhVbFdSV25mODR0elNLMmlZUjB2Mk0xdjl6UXJFMHU4bkkr?=
 =?utf-8?B?ZGJHNGJMTVFWVWlxVUdONnVEdGpTMldkVk0wallzS2V1UE5jUHBsVG9hVG5F?=
 =?utf-8?B?a2NhTGJHcmtBcDArQTBPRmthZEYrRXBqdS9FazRnb1psVWpHNEZmTmZvR3l5?=
 =?utf-8?B?enBsUTRya3U2K3FDbmJucHAwYzJROXFrSGRsUTIzNExQOWMzd1VCMGtJb2pQ?=
 =?utf-8?B?TmJPcWlSSzVxMWlPbDByMlZ0VHoyc0g5aEcrcUxwZUVVcVJjbTd5RnZFNzYr?=
 =?utf-8?B?NGt6d2VXanhiR0tBMzhnNWFsa1FMbjRrcXVkVVRyMU43RThpZG5GdW5GYzRF?=
 =?utf-8?B?SS81cmZYdXU0dythSVZQRGJxdXlLZXE5QnpEOVdaQ2xpaDVITG1sWXNsVEt3?=
 =?utf-8?B?RklkSlBFWSt6WDkwSElBYWVHejVqSUJ4UFVEeFI1eDh3OTdlVDNXeUlqMDdw?=
 =?utf-8?B?QURJc2dHRzRsOHJXWUNPZEZXVmdwTWdvalYvUnNVQytIZFlJRHNuTmNkcmdI?=
 =?utf-8?B?dXlyVlhoaW5UU0hYcVRpL2FQcTZOa0Z5OUdiWHFLZllXSVRsTUxJUDhlMjRy?=
 =?utf-8?B?NzB1T3Zqcmh1bXcyaldGdFRNZFNkSE13YmJPY0ZiS043VEx1NVM2alBCZnl4?=
 =?utf-8?B?eFlnNzlScGwybkpMZmJqbmg0cU4wbTZ1Z0RmaStFNklLa3FtSXlYbGxMQ3By?=
 =?utf-8?B?aWdKbk9EU3BEM2RTRGJmMCsrYXN1TjQ1VmJkU0ptWGVoQ3oxaXFaLzdEOG1a?=
 =?utf-8?B?ZWdIaUdhbEdOTjBmUXZZZ0xCeS9IbE5uZGhFY2xyZGNERzgzZWxzU1NDb1lT?=
 =?utf-8?B?YXhHOHdQUEpHbTJESFMrVitGUzhwU3JUTkh0ZVplZEFJdXpuWTRXOWlHNG1v?=
 =?utf-8?B?TTN2UEhzejZJanYzMGdMWWJvYXcvL0lMZ2k0ZDJuOUNGMnJvMXlqbG92OEx0?=
 =?utf-8?B?OWJSdFdNQWR0UkcvTnRuUGVEaTFJRUZjOU5RcEJiYlhMMjlyeHN0b3QyNGc4?=
 =?utf-8?B?ZHlhTVorU1ZoNmthb1IxVW05bXRuYWN4dUg5RzliZUpQNVlydm1LYnM2UGpP?=
 =?utf-8?Q?LMhqbM57uk9CeQ49HA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e272ea9-417c-49c3-0fcc-08de9f6cd08c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:11:23.9923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFva2kjPn+Q/L+Vpk3M0r7CDiI3vweqRUTEuMwDIGsj+EZoLZCLkDj1tXTQTB2IZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647
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

On 4/21/26 03:26, Matthew Brost wrote:
> Triggering kswap at an order higher than beneficial_order makes little
> sense, as the driver has already indicated the optimal order at which
> reclaim is effective. Similarly, issuing direct reclaim or triggering
> kswap at a lower order than beneficial_order is ineffective, since the
> driver does not benefit from reclaiming lower-order pages.
> 
> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> exactly beneficial_order, or as a fallback, direct reclaim without
> __GFP_NORETRY at order 0 when failure is not an option.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> CC: dri-devel@lists.freedesktop.org
> Cc: Daniel Colascione <dancol@dancol.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd9..8425dbcc6c68 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>  	 * Do not add latency to the allocation path for allocations orders
>  	 * device tolds us do not bring them additional performance gains.
>  	 */
> -	if (beneficial_order && order > beneficial_order)
> -		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +	if (order && beneficial_order && order != beneficial_order)
> +		gfp_flags &= ~__GFP_RECLAIM;
>  
>  	if (!ttm_pool_uses_dma_alloc(pool)) {
>  		p = alloc_pages_node(pool->nid, gfp_flags, order);

