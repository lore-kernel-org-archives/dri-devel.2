Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B9AF94CD1
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 06:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C9710E030;
	Wed, 22 Apr 2026 06:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tKliri37";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BAC8876A;
 Wed, 22 Apr 2026 06:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXkNNoQ6s2BiI0iwAq/9lKQJ/XQxAFIq9DhCvL4musUnGwelqs3RQJ3Gfv4fKQ5YvszyEGOm4NY0oibOxKt8QFpYPXlJOmS0hJ8o45eraMHS3qxNKlwg0dzkHw3A9HYP3luIImzK2bOgWSyGOrzhv6VAowApjgfbwbXbdENE/tG5V2Q8L7cGFB1OM+CG5b6J9FC05lxj7hiXPgMyDrnbk8+aaWq+2SdkEh3Cg18c/8J3R80MDulrKy1YIE6MbQS2vsD8mpyEp0Bp/3qsGLokgSpTCTYk7mmoH7bU5DQsWPmmwFv6Wybk4Bye5GeBFVulNM+FP4626TxBr2hQmkoC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7zZnYk1f+K6mgX+zYwIrpAqyz3ipoVnuNuhnsmM7C8=;
 b=MTC3+cH7kjRsLDkgUmcmL6Vz3Z0a6no/SlispfyfBvcfojYbef1i19LOeaBNMN+WnBkv9Y0rlLUcezynmaMWHZ5YeUNiNN5fxuhuCHQSRwZH/OkHaaXcPlS4yDmviqaBXdhFzj8GkyF8GW2C3/hrzy3VEidrPUzKRilDi0yh2pFwxAlPWyqzGnADpTtCNIEAwdurEYcLC6BUvRxlvLwXio2vXIGD401ZcJIqsPHCT+7EPZkAWfD3c571ccly+cCzlUzfP5etevsIvVujZjqeKH6vk1RoW0n+ofmlvWqlun7/Gma/giBIU7lBDYsElFpppq97PkJEmnSyUgMdLlggsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7zZnYk1f+K6mgX+zYwIrpAqyz3ipoVnuNuhnsmM7C8=;
 b=tKliri37F8FyqXpiQByGIoAaRCzzpOpEUynEQ+BfX5hIKarV1vmJlI0y5tcgGCmbunia6Zv2jzqBZSdyA/G/aIRywlKyOjiuWtt4FaRIvE0x506kQ57egPkK+1RQLtptNBFOVdrQ7E+7ULjxpr4K2QSI5LL1idEFXdM3i4KGx4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 22 Apr
 2026 06:41:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:41:10 +0000
Message-ID: <c340442c-ced0-4f9b-b8b4-8e2ed6518159@amd.com>
Date: Wed, 22 Apr 2026 08:41:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <aecef1f3-5625-48b2-9117-b14cb1b61e50@amd.com>
 <aehKusO6Sc1Qn+Wi@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aehKusO6Sc1Qn+Wi@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4e2b5f-f57f-49fc-774f-08dea03a236f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: dZ1m9aDjcw6QYqiCNjCfGXifAqgKtIJQo2ThGxgsfg6lwZIvlo9qVqb1cxAsWwHesAyGeMtZTs8R1NRD/H6tX9JaKATPgplkAtH3XCv49bakhHrh+D5gNYIm/ai3dFMNAOfCqXh9hmL+jB8+ZWjIUCadbROc5V5WZt8YwTPA6mZ5lBBOeMGnU80eJ9oPE4S9aVanoCIanIQi5qLPAzMwlyYRYfOAuYSAZ6LOp65LI16wPGFF378kqomR7XcDhmArEfvj10IfPw2CrYLlIlhPTkZKT3NrYb1rGo8iyFujGEbefI8LoPBq1YgJy2mBb18U3tOTf6X0hUdM+Nl0pIhG/GLVpIfIexDOxtmKX1pXaQl5kPDus/FjoIndKgrhUZ1F8Q+RzOz6B+HMiKF50EhoE2PAP89tDvz00GBFq0twUN1mX+1bb/6fiwPUUKybA8uBfUn0/9BKWEGdB/j1VhtjwF9U0h4/JexE4wdLxmzlVgvpWEGXccZfTHKwKqKUcfZ82yUVh+Ox/P8IwcbEc2c/yHS8wp1WvhrHbFhXVbxdKBMXJ6UZUN1Vgy8JoDZUPalOZTRqCtsByOchD/Zu2laDdXIOO10PVhZ1qOTMoUz7QehTHmQpUHq++/ITS3ihaG/o7nYoi8ULAWGGB4psVjo3qNAToIq3nMwyI5dwFANWDnn4BmGbwnFHeQOSw3/cOpOkuZSwrPKEOHHUrwtDC5SNGGXocRNWQqo/z3LP8Dv6OZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtlZXpPUzNMeGxYRWlCT2xlUnpxNmNUdTIyS0s2WDV0UWpFdHN5OVNmYlVq?=
 =?utf-8?B?QzRMWnhKNGxEYnZKY3FNOHoraG9MbnV2SUdwUyswdjZ1WVFKYzZIL2hxcm5M?=
 =?utf-8?B?NklveWVLbUpYQTEwMHJ3QjRMQ0FVTWVBQlZmNXV6d0dUTWVBamtNZlJZUDJx?=
 =?utf-8?B?UVZrWXFBTS9EdWdYYmV0R2J5Z1BjV3hBSXUrbGpqK3g0TzJmY004ZFJGaVdr?=
 =?utf-8?B?d1N1KzBNbGF0OGF5UzdOQlFuNGdoY3hsWGU5V0h5R3pveFhXYm1HQlI0c0Ev?=
 =?utf-8?B?WmRydHliUDRMRzVXanczMG5NR3NyTzhlQTMyOUQ2WUh5azFpQU4wcE1LSGty?=
 =?utf-8?B?OWEwMjdYQmlaR0VpMXFUQmlZL1VJWDA1WHpiTVowRGlDYnJWWGZoSUIwZjhZ?=
 =?utf-8?B?OXB1b2Qra1VqMy9QYzJRajRsZjFYQW5lc2pBK1RBV2pLZVJWNVI1djhMRW45?=
 =?utf-8?B?ODF5dENaVk9vN3JxMVBPSWRHb2VyYk00WHBBV1VRTmgwY0Jna0lhTVB2bGxE?=
 =?utf-8?B?alRoemNFVUdoaFE3Tmx4dHdTQ2h2MkZvM2YvT0czSmNMbjd0MUNEZENjMXlW?=
 =?utf-8?B?YXppUVVqbk1xanY1Y1JnYlkwV3Q4ZWg1R1MzUTBJRytNUUwwalZMSm53cDFM?=
 =?utf-8?B?ajAxZ2pWS1JEbUN4VVl4eDRiTUxLZGFiS3JtM1NxeXJHT3J6clA3V1F1ckND?=
 =?utf-8?B?NWpxdTNkcEpQTjFIR3JZdDExSDRObk1wRFdDUHlJUnRWUk5XYTBoOG9idGFm?=
 =?utf-8?B?dkQwdVNra2xZUndtK1U1a05yTlZiL3EzK3FVSlp5N0tTSWg0ZUZTbFZucmJr?=
 =?utf-8?B?RVRSUmtGdTlGY3VFTHc4N09DbUlmUnFyZkorZ3U2MnlRNVRPdGZQTUgxSjVP?=
 =?utf-8?B?a3d3bGI5UHRzYjBJV3dKaTdHd3dNenl3eUxJcjVHL1lBa0FJamlNdm1nUndV?=
 =?utf-8?B?WjQ3NnRaUjdJelhhWUN4MHdiQ205ZnNLY0pBNi80cGNKRjZ5VWdjdDVGNzZO?=
 =?utf-8?B?dDdsMjlVcG5NVXQyWi84OWdxd2lMS1VmNXJ2cG5lOVMrSTBYLzZ3UDRBMTFT?=
 =?utf-8?B?NmtsVmgzMzV4WGtBTU56eDVWUEo3a21CaHNNSTJrak5BTnVFM0VzWjc4M1Ir?=
 =?utf-8?B?WUU4cFRSQ0dqMGlYekgwU1h4Tmw4aUkrcFZ6cEx3L3ViWkRudzdOb2Y1b2ta?=
 =?utf-8?B?U3F4aVZBT0xrWEU4eTJwL0g4VHU5clI3emtsMlpEcmpkOXU2UlBUcUc1YkYx?=
 =?utf-8?B?VTZMdklzVmhDd3JXQkNaUmZ6bjF3VDRnQ2VQZGg0bTBJMW5hbnV6NTJIOW1W?=
 =?utf-8?B?YXVYNytIZFQ1R1ZYRHV5SjYyM2huLzdkSVFaZU8rK3VhaVFtQzNJUFIxeWts?=
 =?utf-8?B?Q1pSWW93SUVDM2NneHdlaFNXVzNvdyt5ZSs2MU0rYnRjRkUrT0ZuSWpuOWZy?=
 =?utf-8?B?TUJURzJ6K3lWbUFxTXB1ZWNybU54cDZkN24zWk5nMXh4RzU1Tmt6M2FMeHdr?=
 =?utf-8?B?RjdHYTZNOWlvdklRQkJoNEw0NzVFTW5ZWHN4TVFza2tZYkQrbXdzb2dZSTlm?=
 =?utf-8?B?VWlUWHVjaEtWd1o0Q0pMcHdGZ3dPZ2thV3VScGs0aktKcHFiZDNXQ2hSdjFZ?=
 =?utf-8?B?Ry9IVDF5OHZhWHZwM0xDN24xUDJwWDV3YitxcXdvemN5V1dWQ1Y5ZjlzMjBR?=
 =?utf-8?B?MmRNQitwQVVidmF4WjJudG9yZXB6RTFENDB1am1OWHZuU08vbU04YW93Z01B?=
 =?utf-8?B?b2grSE5vbHhrbll4d0RBTGN1cmw3djl4YncvWGRub0NnT2l1Ry9vNW51UTlk?=
 =?utf-8?B?dVF5Z2p1THEyc0kyYTBNVzluUy8xK01rb3ZiNmZabUMrYzYySldPMURwbnky?=
 =?utf-8?B?R1ZINEU4UW1NQXJSaFdCZ1htZlVJZzRXV1NBWGRlbThmRGpzU05BaTlxamlL?=
 =?utf-8?B?dEtRRVB6bzI0MDIwRDFjYkthQzN6YWJXN1prbEtsb05EcVBuOGRabC9rVStC?=
 =?utf-8?B?RFVKS3NaeUM3dnlSTXRYTllUSkdxVXBEbmt1Zm00NVFZQkptR1BEZ2Zrc3ZS?=
 =?utf-8?B?RjYwNmt6WURmc3ZKSFA5WGNWc2tZTFAva2JncnhhSEZzUDNlOUVGc3BoV2Rh?=
 =?utf-8?B?dmxndmRHQmtaZ0pVN2lIdmJESUdaSnpmTVVzU1N6SDRCako3N3pXNWk4L3VK?=
 =?utf-8?B?cWwvY1NDZkJ3RmJFcTF0aks5dGExUzRvMVlBRUV6SFFzRXJDdk5FcmFxaG1Q?=
 =?utf-8?B?cVhsQkh5YW5BZk1xcnlDSWxFb1F4NEtYdGV1bzlDWVZabUV2SjMrdHIrek9i?=
 =?utf-8?Q?Ma6Z2+w9tJeA23v6db?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4e2b5f-f57f-49fc-774f-08dea03a236f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:41:10.1084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePOMG9hfM/Txi7iW8VPm60jgY89n2170S0s0HHpQaNjkojkTaZLEeVQiUYLUVrdE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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

On 4/22/26 06:12, Matthew Brost wrote:
> On Tue, Apr 21, 2026 at 08:11:17AM +0200, Christian König wrote:
>> On 4/21/26 03:26, Matthew Brost wrote:
>>> Triggering kswap at an order higher than beneficial_order makes little
>>> sense, as the driver has already indicated the optimal order at which
>>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>>> kswap at a lower order than beneficial_order is ineffective, since the
>>> driver does not benefit from reclaiming lower-order pages.
>>>
>>> As a result, direct reclaim should only be issued with __GFP_NORETRY at
>>> exactly beneficial_order, or as a fallback, direct reclaim without
>>> __GFP_NORETRY at order 0 when failure is not an option.
>>>
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Huang Rui <ray.huang@amd.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> CC: dri-devel@lists.freedesktop.org
>>> Cc: Daniel Colascione <dancol@dancol.org>
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
> 
> Thanks! I'm going to merge this patch to independently to drm-misc-next
> unless you object - the Xe side heuristics of the shrinker will take a
> bit longer to land on an agreed upon design.

Yeah feel free to push it upstream through the XE tree, the two liner is probably small enough that it won't cause conflict.

Christian

> 
> Matt
> 
>>> ---
>>>  drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>>> index 26a3689e5fd9..8425dbcc6c68 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>>>  	 * Do not add latency to the allocation path for allocations orders
>>>  	 * device tolds us do not bring them additional performance gains.
>>>  	 */
>>> -	if (beneficial_order && order > beneficial_order)
>>> -		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>> +	if (order && beneficial_order && order != beneficial_order)
>>> +		gfp_flags &= ~__GFP_RECLAIM;
>>>  
>>>  	if (!ttm_pool_uses_dma_alloc(pool)) {
>>>  		p = alloc_pages_node(pool->nid, gfp_flags, order);
>>

