Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4F0F99355
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D8F10EFCF;
	Thu, 23 Apr 2026 08:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZL9BsRfH";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011032.outbound.protection.outlook.com [40.107.208.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2426710EFCE;
 Thu, 23 Apr 2026 08:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezPYpOGy+K3vDXaZkvvxJFN6nxm7aj9ldbtwTq7Kpdru4gOp0LTmlOLgSaqWkNfvA/kEnJT2hFVnIlcv7wV+l99/CvM5sILgk5IlQkNHhtKDXPKgEHNmh5aWyKNfoQA+fHLh48Jjtg+lrZUHXjoJoTEVgN+B1h9Lls02E9Fh2Yost0IBH0z2MJyr/i0L3ABdcznVgUaBqvaka57TtwqDHb4thDfv5CaLF+69EN2gRdGEqmXrYKudtLqVFWuUGjMAFRL7DVfmPOY6ik4VbSL/ArLjEJckeSGtMYD5gh9nxhLUQ/WZO574f1xMHAIYOlO1DPSQGPmQHBcDU/qClqbTag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra7Cj6boqoS5GcbE5KBfmii7SZuFtNRBEMgcBtoDWLE=;
 b=NCl6c4cGMdUHRvwCexV7FoyGIt98GkG0LidPLoICk0zQYF47IO8X5RbQziHHe6T4YSAOKKJH24rSvUTjDHQA6tDN9oMDONojmtQ4hHJxPni4eiLXfM7e5P4ZJdl+atLsSIfqM2ZSpuJvB+5dweCalQTFq1J9J6HNefWbfoe6YgoybIotFR61wtChada2MZN97sftuzF0ZXlxYPcDQKv/zKQla2/dLBw3z9J+XtR407fBOlZSwm59IUoGe0wMSJAwri3Zgh01sdC31Y9l4X6q1pnWByeSzN/KNbO33m4Cz1XS4VbRMZwhkcv63yuauan5+mFZlFqZpjJxeMGZ7vlsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra7Cj6boqoS5GcbE5KBfmii7SZuFtNRBEMgcBtoDWLE=;
 b=ZL9BsRfHDnUz2D/iB8SVsdFNEkcmEcYfbF/MJ78sokbTsr89z/oVXuVnLGDpcjkL77Ag/x7KeUmKQeIJ6TKhESWvwbetM1gBnqTZ3mzp+v1vl/n886ZEmmcECuIVmrMKne6PLgdafxaObW1ef69Lli2T96shOE6Jup6K0m4JDeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 08:44:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 08:44:44 +0000
Message-ID: <697436d1-5720-4b12-9cd7-2d76759d63f5@amd.com>
Date: Thu, 23 Apr 2026 10:44:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 1529c8a8-0155-4cdc-6024-08dea114917b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1YxDhdY6AwAkHZc/QbxkWuDW9He0OfQIGXIuBtgCFSN+TXPuuri1gzpkoGR3mqE5yTJW4WpLFDwNtmid9OuaC00pQp7gXh7U08G0DHMie44axi1YAe0tWpNkDdNx0ZnyormGAtG/ZOOqmYXsGnFNkl3PYflsaM1zJG8KyAdH7DeyHrQxIhv3iC8L5u83IM4O++Qx79GRN9giL//j1FP2hOy18OButCudbGxA38fAqvfBWKWHiHXVJ/U646HmWj5H0VYWo7aO/UuIrsQjrK23IzdXWCh0njInzbec5zs4RdteHHRV/dQ0UDf4+cMJSFjpyZ5R1JQe29E6X0cCQRcSFJ62H5SSdAAzxhhUVRfrEvwW35XMd4fX8AnQQxA80k7TVW7HmwMEA8Od+A/tbJkP/5KeK+GmW608zAlMkaVszckS/6lWv4hCEYmGVc+VTmA0J9VaxdxFFUzONyyL4UwlKmF0/2CaLhv5DoXgbKzgWZJ7GfOnhkZQDGHtZsBlaNB0wEGs6yoIXxy7z+sJR8EGMH0M5A+RhTOWRLE7nlJNI4FT+5yAIQJe7GDfpFGnwk+bUIauYHVs2h3dBeYGv77iHZSeE/JMDglC8NjhUmo2P/c/e4AM5KPHWUpxL5Pk0gMbQpVDqhbkOFEP2ZQVmkVdMB1m0QxaI22+c9r4aqnPqxq4DN2a4hSqO5fQrfiobwVj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29jSHpRQ1h2TlhrL3lKbE83WDFTVmdURjBLeVMwMDl3SCs0cDZxZTJZOWpE?=
 =?utf-8?B?dTZGSjg2eGpwRnVSSXU4RTNtMGRraE52YThSZEt3M2QxOVhtNTVIbk04LzV4?=
 =?utf-8?B?RWxMMVQrTDJuYWtiQk1PenFwazE5QkRQelJTbGNVdHpLL3FNa2dXMmpBeGtv?=
 =?utf-8?B?MUtNNlZoWEdhVytYQ2VkcnBGYXdlRDkxK1BqakxEOWpzNExLSGc0RDNob290?=
 =?utf-8?B?OEVyb0tWT0tUZVdXV2ZqZHNXNExWUWZVT21hTURrMnpmQmg1Q2xobXBqdVIy?=
 =?utf-8?B?SkRQTnVRN3RRNGY1ZDVLMXB4ZWZkSWdzdFY0YVQ5MWpWRVA1SXZwbWovMFd2?=
 =?utf-8?B?WGswekFRMWxDOXZJb1B4bEhwOENLc09ZbDZQNUlSYVpsam1DMTVSN003RDV1?=
 =?utf-8?B?YWg2dlJqSm1jMkVnUGxQZVhKbDg1U3loVE0rRWV0cUhIZ25Hd1V5MzhGT2tX?=
 =?utf-8?B?elhQcXJOM2JGaFhpeFdRWVpIY3FxQXU2V3Y1NzlxaDIyVDM4aFRqbW9SSjdW?=
 =?utf-8?B?NElGempna0hwSmowYXIrUUdNSEEwOTgwVDRaajVwTWhWV0RmYVNHMFlJTkhS?=
 =?utf-8?B?OWIxMll6enhOeFppSFRnbmFra2prTGxKSWd0RzNQajhNenhheDQvYU1MNVJr?=
 =?utf-8?B?TGt1SnAyK0Z3d0R5MG1wK0E3YklxcHpVT2NJaGtiMEpxVGcyd24rcmRaWUgv?=
 =?utf-8?B?b1IxWk5TNlhLRVpUY08wSXJuNHBVdHhUVnNvVmtQNnNoOEdwM2h0V2hMR3dF?=
 =?utf-8?B?a3BoN1RYaUh2c3lhaXlpOFYyaHdsR0tvbllRV2xHOXZRcTI3WkNUMmNQc2Zi?=
 =?utf-8?B?YlIxanlKUW11NW1aZFE1cUFzampqb3hOdS9ZRVBlTzVXcm1ZUklBc29pamJy?=
 =?utf-8?B?d1pUSWFERzNDTHdxSFRBdDZLVTRuOEVCRWxna0ZNTW1kS24zRTE4VnR3Vnli?=
 =?utf-8?B?NktQVmZKQU9BTkVLNEI5MkozWHBjamdrZ0g2K05PS3JGUGpmRnFlcURZclly?=
 =?utf-8?B?MUM0QW4vbXo5T0I0ZFlUdXQ2RDZVWUpTa3A5NjJrclRMTjhOQlBsL1BKVWtP?=
 =?utf-8?B?SUJKL0hTdnNXUXlETlB2WVNzU0NwbEQ0Ny9jMks1dUNmaVd4US80QTRZcUZ5?=
 =?utf-8?B?THhlajhodjNSUVpWQ0tGa2QvVUMzU2k2VDJYTWFNRTNtVlZFQTZ0dWsydXcr?=
 =?utf-8?B?R2pLbHRmQzRhSDNMaUgwRzNtNmVXM3ZhQmVoUTNFMHR4VDQ1RjVxaWc3MU1D?=
 =?utf-8?B?ODhndWgzS081eGJuS3pNcjQ0STRoOWx0V1YvU21HZk84R0djWnVLcEROQkNR?=
 =?utf-8?B?VXRFbktmNUdvWndTU1pieDNHU0hLbTNrU0g3K1B4akQ5eTY1Qlh3SVNYcXBD?=
 =?utf-8?B?STIvRVVjNzJqWlVCYy96bHhqTUsyMmdDZ2syRGwxYUx3ZjNMWmV4WmVJUnBt?=
 =?utf-8?B?c2diT1lqYTk1QnR2NDVFV2EwU1U2NGl3YjNJYjBYY3E1MWVwVVpqYTdpV091?=
 =?utf-8?B?b0orWW5IandmQzhDMm9lT0hnRTYrTmcra0tZMjNid1dYZ3c2QlhqdHhFV3dE?=
 =?utf-8?B?OXFWZVhkRTMzUEt1OFpFQTl3a2xFbzdtakhudzg5WFR2NDZGTmxtWUNSc0dh?=
 =?utf-8?B?SDgvem4zVDRXeEUzQ2c0d2N3cndoOTJPOTZqbnFtMEVlMVFnQys3YkZVTy9Q?=
 =?utf-8?B?d0pYakJmL0srUm9iVEtOdVNzSVk3d0c0eWxUaVUyTjVVRWNmRDB3b1RKcENa?=
 =?utf-8?B?K0wzVEIzSWR6bVgvbUpGYXNIeW1qaFRjNDVrcXNKNUNCZHdJdDdlSzRPbUtV?=
 =?utf-8?B?TzQ1bVBiQ3BDNnBnMW5zbUJoMlFpZ2FyMXo4NHFsbjhVVWlrOVVqejZod0ZL?=
 =?utf-8?B?OE5hZkZ2bmdURG5rK3cwY0d0Rnd3NjErdGQweGdnME5NN01sTGV6ZGZwZFJC?=
 =?utf-8?B?Y2hPaGF1MStJTEVmVThXbUZtQ295aU04dkZZZWkzVkZJaHhWUDB4bEtYcFdD?=
 =?utf-8?B?eSt3eFNqaEVLQ0RKckl2TEtmR3pyUDI5eHhTbmQ2enBxSkdLZjZjaWQrNTY5?=
 =?utf-8?B?VldHbmdkV0RxZDg3TXl3cDdFRTNsekF4bFlBWWpQQ1dwMEc1L2ZqQnVCTHRC?=
 =?utf-8?B?YTZINGk0Tlg0TXdmTFhBS08zdlFJT0lzbzlyQncwSktwamZBTkdER2UzNDN6?=
 =?utf-8?B?V2RWSHJON0dxL3dIQWltZ2R1K0NzT1VtZFhzR0xFZWFhSzZkaW5rUHFwVnE2?=
 =?utf-8?B?bitYWXRJcW1UMi82L0EvbVRVV3llQTREN0dwc3I5UUh5WllKT2NhSmVXdmNZ?=
 =?utf-8?Q?tkag155qZ5wdgsoL2u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1529c8a8-0155-4cdc-6024-08dea114917b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 08:44:44.8094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfh83GPBk2qL37vWqM7tLzYL9+iUjcBPA+iS09Nqn0NRVYZ9CBiTl6pYsXJ5lS1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

On 4/22/26 22:41, Matthew Brost wrote:
> On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
>> On 4/22/26 09:32, Tvrtko Ursulin wrote:
>>>
>>> On 21/04/2026 02:26, Matthew Brost wrote:
>>>> Triggering kswap at an order higher than beneficial_order makes little
>>>> sense, as the driver has already indicated the optimal order at which
>>>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>>>> kswap at a lower order than beneficial_order is ineffective, since the
>>>> driver does not benefit from reclaiming lower-order pages.
>>>>
>>>> As a result, direct reclaim should only be issued with __GFP_NORETRY at
>>>> exactly beneficial_order, or as a fallback, direct reclaim without
>>>> __GFP_NORETRY at order 0 when failure is not an option.
>>>>
>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>> Cc: Maxime Ripard <mripard@kernel.org>
>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Cc: David Airlie <airlied@gmail.com>
>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>> CC: dri-devel@lists.freedesktop.org
>>>> Cc: Daniel Colascione <dancol@dancol.org>
>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>> ---
>>>>   drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>>>> index 26a3689e5fd9..8425dbcc6c68 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>>>>        * Do not add latency to the allocation path for allocations orders
>>>>        * device tolds us do not bring them additional performance gains.
>>>>        */
>>>> -    if (beneficial_order && order > beneficial_order)
>>>> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>>> +    if (order && beneficial_order && order != beneficial_order)
>>>> +        gfp_flags &= ~__GFP_RECLAIM;
>>>>         if (!ttm_pool_uses_dma_alloc(pool)) {
>>>>           p = alloc_pages_node(pool->nid, gfp_flags, order);
>>>
>>> I missed this conversation so don't know if this was discussed -
> 
> I meant to CC you here, but missed including you.
> 
>>> having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.
>>
>> At least for AMD GPUs 64k doesn't matter at all.
>>
> 
> Same on Intel GPUs for system memory mappings - it is either 4k or 2M
> GPU pages. VRAM can we 64k pages but that isn't involved here.
> 
>> There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.
>>
>> I have no idea how we ended up with that in the first place.
>>
>> It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.
>>
> 
> Or we move to a table config if we find drivers have multiple
> beneficial_orders.
> 
>>> Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?
>>
>> Oh good point, most likely not.
>>
> 
> Without completely reverse engineering the core MM, I'm not sure here.

IIRC (and I'm seriously not an expert for all the details here):

__GFP_DIRECT_RECLAIM is throwing things out which we can trivially reload from file system, e.g. memory backing mapped files.

__GFP_KSWAPD_RECLAIM unmaps anonymous pages and eventually queues them up to be written into the swap. And the hope is that when those are faulted in again they eat up only single 4k pages instead of blocking a larger order.

If I'm not completely mistaken pages actually don't need to reach the swap for this to work, it's mostly just defragmentation of the pages into larger orders.

__GFP_RECLAIM is both of the above together.

> I just read the kernel doc for __GFP_KSWAPD_RECLAIM [1] and this to
> indicate if this is clear compaction won't be entered.

I think we want to avoid only direct reclaim, because __GFP_KSWAPD_RECLAIM just eats up idle CPU cycles (you need to be OOM before it starts to actually use swap) but I'm not 100% sure either.

Regards,
Christian.

> 
> Matt
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/include/linux/gfp_types.h#L198
>  
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>

