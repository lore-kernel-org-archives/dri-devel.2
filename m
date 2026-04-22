Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515EEF94CDC
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B527310E918;
	Wed, 22 Apr 2026 07:42:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mc9f+L/w";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE55510E8BD;
 Wed, 22 Apr 2026 07:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro6zjoQ8eFDDIx1903y5yBwNmCzuWUvjPAfSzSm4VicPzOSwoGgnTxH+p9EsgiPtTWc7hv0B3YLC5HbjA38bZaQnAgv92o0DHse3t/T9JpPYBQIoe8q9KPLBsIHrG4CDWKlKCNELTvf+XSf4pS7z0VUlBQv0XKD4QHb8h7h0EfSrRv+n9oE8hLaDLZlS3ktNBjoOHom87HJs5s0P+HdwpiQrIpkoHMV4m93vI4CYMqRkaFdPmFnbjQbhYvwrqNZCzfwjn1N3vjjalzwv0eanAgTjM4UmoK8Egd2k79LKQ0yGN8gDAi+VBPTJvAGQnSUibw9zQtXGqC8kdwZVMulq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxuwSIeFnLTPoktOd8r8b8tdLHuiL8JSMVscYkIWkz8=;
 b=iq7jFtojiybPHEELNfYiALMDcYLoXrXmM71IWaHvWAXDoHSHqRgEicZfM0YjqJhx3o8ggEZKEdAvU6R8IY159X3n8N/ZHOTEUbOu+HpRNRNiHmjlGj5fPAL1HDt4AVuP8e1HloOjohke8YVEYGL9xpXmFAGnq5BVWgrn94X7+0IqCfl+w2+tkG/D27BfnKl2Fj3ut9JNZFtBgcwMZw1tyXY6SGY3SAA+aK6Vy2z5S+1e6z2ymwtjhxDL2jt9z9O+HbQv/pTNIIsYAqHWFBtlYdb3YlhiSNHSyb6rMR/FOJFcH8xhqB4dmk539mBMDClMjB890Tb7fRuvipybXqPawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxuwSIeFnLTPoktOd8r8b8tdLHuiL8JSMVscYkIWkz8=;
 b=mc9f+L/wfiBpwNck1oS2MqE6xx43bLg3FEyuF/mVOJwOjjAmZwvEjz/BGpjBG1M9fn+1jdJf47C73Z2Kz/6O6Q6ooX5AnMAxbPK9fRcLGYOTsSZCPOHscfLml2FTERCnOajN00TQwPwJZg+kBv8nUIGvrUO015BjdDqCREqNU0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 07:42:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:42:01 +0000
Message-ID: <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
Date: Wed, 22 Apr 2026 09:41:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
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
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c33e7e5-ea05-4ba7-77e1-08dea042a3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dPEIcVPP1qGUw1fETumE+V+qebO1KRgcZMGWcdG5AjSqRjNEBVFgCDxk27miwKfnztUFMHXqTvYCx31xpq4Z2SnMElKWCeNGDm5IkBU6NrkNF17jQKjePue3yZ4wpslREZINZCiRX5MFdx53COI7Hgz8Lt6NkgthNfbWHAezmoShSH8RHjBkDsD1bNBc5J0QP7ITLfBLkmcYxGlPdWl0tXomyKqc/Cge/kjWOcc4qMsyi3Rsn72+GhzXYQAps3VPJJ5lVlpF/VCsYZJkD9TsSNgRz6QeqAX10Ky+W84GvMgHTa3Rg6RqbOMY3JADEk4qIAFawJhVOTq6yDJeBvr2WMYgquwwSNHN5oJDUm1VQ1+pdKSPDru4LsJpTQXpy073SK4q+CEYbzAM00WXd8Ej91qTC2VbReO5euLEDxd/rWjOTTAqMs7MSmlBsCo1gXi8dpSbDPzfRnVGUx9VwSwFHKHTXQfrAD0y9UI+qmyseo1PFK5Rfw8c9lViG5guTQlsJ5Ohdm5DeozNzWw1Udjl21GUjaqV0eAEuhTiVqWVwoCG35+NRfHFK863K93sNi8kYTQe4SHfsxtrvay/WHR6ZFM88U1ex3mk6uW3hFjWSEON9NiQmmNhwBEHkxcx/J7ROj7uiiRq3z/Co6PVQC3Yg60zmrRrnOidYTiTzbU0L1lDUvhIVG4vCyCHAnMKNz/4jkDY0c1NL4rotvuK50LrP5iftwO8+os+H9I2Dp4dUrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlJkcDNRR2xOTXIybnpyQWpaNUJsOFUzaVBqWjFjaXhjdnhScCtnSk9ibDlC?=
 =?utf-8?B?QTIraENqSHZPSU1DN0hIa08xd1VJaU1aVTBYTlBsL0xBUTJwQ09vYnNzdTZv?=
 =?utf-8?B?UURPcGJUU3k0NW8zWDhvTUZLUFFUWWErbW11dURzVUFJU2NUU01BZTk3djdq?=
 =?utf-8?B?bnJsNS9oMnk3TmYrc1hyeDl6UEUwS0RsckE5VTZsWGptL1BrSnZxeExrUXIr?=
 =?utf-8?B?L3VIc3p2RmlLdURDWXU3TUlRN2VnaDhST2RubE4vdGF3SFg4TXZaQnZKNms4?=
 =?utf-8?B?NnpHNUluN0IwZVNXeUQydXN2U0pZSzNWajJNM2gxSFdBcEZVdVZicmJuUSsy?=
 =?utf-8?B?NTN0bnMya3p2SXU0dWJoWlZ5MUNMOFlRc3ZyTTJvby9XeVZrM3JBTHFTSGNx?=
 =?utf-8?B?WFFEcm9zZG5tVGJEdUdRZGhQSnBHM2tFaXdYT0NMWTJ3YWU1M2dNaFpNYTYz?=
 =?utf-8?B?OUhWRkgzREk1R2hSQ3JUamRxOHd1VzRMS0lwc2I1cE9QZFZXWjRaU3VTdjhn?=
 =?utf-8?B?MUxwV3A3c29YdDNQVk1MUEJWNkoxSjE1eEk5aUNOTWEzWDQ3aWJYNEN2a055?=
 =?utf-8?B?eEo3VnhYbVNVY3h3TFFLalg5ZEtnWmFveVIwcm5hNGs4RUJGYWpjWVJVRzV6?=
 =?utf-8?B?bDBHU1RLbkdkMVF2dFc5bVpMaEhRRXkwaVc5TU5ZYm5LbUgvL0ZoQ1hGYjBo?=
 =?utf-8?B?U0JDOExDQ3gzbWtyY2tkb3JDcE9SV1ZpeW53VHpWM0ErVUpHU1ppbjN1TzMz?=
 =?utf-8?B?RVZUZTJWNzVUcHNHWVJiWnh5RUFMTE4wWjJXYys1dC9wMlpqeUh0UFNiakpK?=
 =?utf-8?B?RUVDdzVhV3FrUSt4T0hJaENkU3pLQmZMRURRbWZsQXh6bWV5V1hsL05iZm8z?=
 =?utf-8?B?QzZmcEpydE4zL2NDODN1QkZYdWl3bktSSkVpeFZadWZya1Y4eHBnNi96ekpO?=
 =?utf-8?B?SFk2cUUrY3NTZUtMcUNldXhMc2lPbmRrbEVRYUplQ3RoRnhOMkg1NGFOOFV0?=
 =?utf-8?B?cFdmbXVPOFFabkFQdE5PUXdMZXJvZkp0cXdTN21PTkJHRzU3a3FnaHVNU2o2?=
 =?utf-8?B?WGlkMUVXL0dZUzJPWmhrak4rSVlOWW92MExRd0VHc01GTXpxSHdFdUdlVnRq?=
 =?utf-8?B?bUNOZU10TFNjbDU5eEVPRVAvekVOSmR3d2ZJb1ZFYzZlUWFJeE5sUnFvZWJX?=
 =?utf-8?B?WUduYlpVSUhIajcrOUZGZHFPUGNsbUlMbDM4NmxUK1h0Ri9TR29zYkU1bE5r?=
 =?utf-8?B?cjM1UmtaVGZQMEtWV3hoRDRRbnlwSmphUm9zSk8zbklGenB6aG40cjZ1NzZT?=
 =?utf-8?B?RWw4by9DNWFBbElwRWQ3V2JCVy9tcFBwb3lOWE04MVJpYU9sWm9UR28zYko1?=
 =?utf-8?B?SVQxTi9ZdEZJZUgwSklMcVYzYndaMSttNisxeFVhSGR2dG45SUFyNkQ0SVha?=
 =?utf-8?B?NTRpUCt6VGFGV2d5V1hXVnl3NzM3bnZCbmp4T3JodVZXOG9GNS9kbWVVS1Bu?=
 =?utf-8?B?UStVbWRuK2FrVTQwNDdmOWViS2k2VkF1cE85di96L1ZVcWhZVVVBQktuWEQz?=
 =?utf-8?B?cHU4bTluZzBsaEI2Z0JxMzVZODVLUGs1RmxEUVRhVW10L3R4SUZaaEpqQjlQ?=
 =?utf-8?B?NWRCVk9uQTNRSUVoRlBsUjFMQjdsVDY5VkpJSHZtUWw5V1JGNUZiZURaRVNy?=
 =?utf-8?B?UFNtNVAzQ2NkQ09uaVNONXNnQlZHNEJTUDc1cXZNdXEwTkc3V04zOWZmRXVM?=
 =?utf-8?B?MlVweWpnTFlKMUczL1hsUjRyVE43WEFDU2VwaG4xNnpWWDFVNU5DY3dNSWYz?=
 =?utf-8?B?b1F1RmpWTGptRHpTTnhFRll4VUhWcXRmOXZNNnIvV2FRa2JOdHBvbUlaTlpM?=
 =?utf-8?B?MjRIdXNCbGFFV3FzQWxOTkdZUjVJallxR2RTNmpnRmY4OE8zVmw4UUxsTFUr?=
 =?utf-8?B?dGhSZkNOMDZlelNOZlAxb0JkYitrV1RiRVdjMFppUnZ0cnlJNkVhWjI0dTlv?=
 =?utf-8?B?NnhjWThRSnkvT3dnT1VJKzQ5M3h4YXU3bG1qdlJTZEZkcFpocXJsSEJCRnlL?=
 =?utf-8?B?UENtcHcrZmdSYWVvWVJxSmYvd2RyK21veHRNZTNwSmIzSVMzbmpjY04zRnNn?=
 =?utf-8?B?TzRzbThkMUxSMDdBTGgvYjBPLzJqdzkyNTBZQ0JKUTMvUGZLaWliR0ZGMGd4?=
 =?utf-8?B?YkRVQ0psd2FqMVU0bUkveFFudHUxMy9zbDhIaldaKyt0R0twclp0QS9MU2xs?=
 =?utf-8?B?cVhqRmFYb1NKci9RanpDYkhnRHdxNXF3bU9oNzNKRDI4UWZnUXFnRGhLYWFS?=
 =?utf-8?Q?82B7zpd34okSsBRJ5n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c33e7e5-ea05-4ba7-77e1-08dea042a3f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:42:01.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6UZnKiGJzY5g3XN0ZOf7DUmhkOAyJBaPQ0jgPCcFwtkaEd+Y3aVVzav2w9y4zSt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

On 4/22/26 09:32, Tvrtko Ursulin wrote:
> 
> On 21/04/2026 02:26, Matthew Brost wrote:
>> Triggering kswap at an order higher than beneficial_order makes little
>> sense, as the driver has already indicated the optimal order at which
>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>> kswap at a lower order than beneficial_order is ineffective, since the
>> driver does not benefit from reclaiming lower-order pages.
>>
>> As a result, direct reclaim should only be issued with __GFP_NORETRY at
>> exactly beneficial_order, or as a fallback, direct reclaim without
>> __GFP_NORETRY at order 0 when failure is not an option.
>>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Carlos Santa <carlos.santa@intel.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Huang Rui <ray.huang@amd.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> CC: dri-devel@lists.freedesktop.org
>> Cc: Daniel Colascione <dancol@dancol.org>
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>> index 26a3689e5fd9..8425dbcc6c68 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>>        * Do not add latency to the allocation path for allocations orders
>>        * device tolds us do not bring them additional performance gains.
>>        */
>> -    if (beneficial_order && order > beneficial_order)
>> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>> +    if (order && beneficial_order && order != beneficial_order)
>> +        gfp_flags &= ~__GFP_RECLAIM;
>>         if (!ttm_pool_uses_dma_alloc(pool)) {
>>           p = alloc_pages_node(pool->nid, gfp_flags, order);
> 
> I missed this conversation so don't know if this was discussed -
> having less of 64k pages is not a concern? I mean slightly higher TLB pressure etc on hardware which supports this PTE size.

At least for AMD GPUs 64k doesn't matter at all.

There was a large push from the Windows side to use that size, but we have more than enough evidence to prove that this size is actually completely nonsense for almost all use cases.

I have no idea how we ended up with that in the first place.

It could be that there is still HW out there which can only handle that size, but in that case such HW should just set beneficial_order to 64k.

> Also, does clearing __GFP_RECLAIM disable compaction completely and is that wanted?

Oh good point, most likely not.

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 

