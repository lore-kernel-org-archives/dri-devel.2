Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99502CD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A3E10E409;
	Thu, 30 Apr 2026 07:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJutcKno";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2215110E102;
 Thu, 30 Apr 2026 07:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXGUC+j0bufXdKQ95fwJQmDoOE+EmLKdotZCNiMuRLj6w+m2IG8RccQ12LYCNgLZ8QJTyn41cZGOGGsGDtIkqBTAGJKke0we5aGZCiqrjEQr0LqeKRKF/3ePSvSQmbQRYyFYMjC5vS52G2P2e1OpylBEGbDAUnd/eaQQx7MFgEBu2tvV8AZmN/5jVhFfV/eP9GjeSLSqIz9BMtRDLUw3cxxcfWRIuhayTIcOR2vrYBJu1gvl6xRqnO1RB+mWymC5BAWKTIx5cAIGiELH/yF2vbPM0zCDKkKPMQ8owcmrQpXF+G5xYS/HhrhhQgIkY3Pyuu5bw9pWUtRLYwKSLeuJFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDvFLiiMQKBliW1tqNpQ+cgLrGyR1/bwfBngUXkBjyk=;
 b=MBxVp5xFQJKUhpqSfNLxUMNMkMW8/9XMXB0IQNVupgQn4hiHSbzIEJL3F4UqoNl3D7dMUyxmYHuFvujUfDlnKoJuTIzFsMfa7l3yGZa+PIGj4dByLLqUXoCRvLNBmMHqi5QejF6NI7EZNIW/liErlnTmL5ciM7rN/LOoRyeRdYvpMNqQkXQlcITKMOBNQhvTyrOzB3M4mOr7rUEiaES/HBFz2Wf7WODz/ngBKouap+A4tpYaZutW4Cat4ZJtUc6MmlJN/ETJOAIwHfaU/J6KfvAJYen93GL2Wzl3FLHa2sn5A0F5ivMiAhLCAuEQrSzfrU7C5QXOj3E62tz6cue+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDvFLiiMQKBliW1tqNpQ+cgLrGyR1/bwfBngUXkBjyk=;
 b=wJutcKnotUsw1pAyG4uBUckEgbl614lJ1VMoRkjVZ+3snkoM+JjMbGlXJ3QJ1AiME6kaY/hRAr/EsnsxQltrOCWqMrIXwgeoXLAFteXqcjaAlNKf3G/07AKaL0ZCIYCVPlxC4XSuSxFmBAwG6E7qnIIpOmtJ7o31cLo2JTeh5wE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:34:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 07:34:30 +0000
Message-ID: <6e0acd4e-daa9-4490-af27-71730a25d21c@amd.com>
Date: Thu, 30 Apr 2026 09:34:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Daniel Colascione <dancol@dancol.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
 <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
 <d7dda563-280f-4126-a822-a3d43ce5048e@amd.com>
 <aekygVvRz7mu+elE@gsse-cloud1.jf.intel.com>
 <5bd5ed0a-fef2-4bd4-b7a0-d263bcfb1c7f@ursulin.net>
 <87se8didkt.fsf@dancol.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <87se8didkt.fsf@dancol.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 808e739d-857d-41be-4c10-08dea68aea90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: D4s4Dxen3u1uZMi96f22643JjvgsvoTcydAxOY3o2xYm306U4bEeX0KmFQVz0APMDlJu0ahxzzjuiXfTViZgU+taD6K8pRn1UuLqldCyM4fIu1/KFFP7iJkNYXrqTXjHKonYCWvafd424Axnij+jJPDuojfQgLdno2a04oYUgSWm7CckM/RE6E95GsScHp1v+A6HFBCjER2ctVIPgLMIIgNwRqQpWmCwxEsjfPj5SLXIT6jlRItfcI0h1oFOEIxtTS7gPNEyCxBKQFudZs8LrHgn9rCbdNuUpjbztCbqXkt9qp1FPIZw5HhrbduVGg6zvBOUpC0lrmUi73y9cJdPN3K+FKfYPfS7gc7oSWy9aA1UG9Fcx6v/uwQXLs8WIfQWhqS1vDNNesmFZwfODAcygjSbOExSb2E4Y+7ZtNsZgP4rxGUrnHGwFa8dkheDSPgxrqC8anjMcnCnJ8wLV7/a8QrGhQbScFiHIJuuyeWto5lSWkzFvOrIX2i3Ft1uNemvJU+yfNiKFvG1NKL+PrFykvmFo2+dggb6IeWM4yjlnJg0mxE7IQvCYZ0390LLPQ0V43KO4LUFZtt6Df2FQdHZgwGwq1DDIq8fPd7uvVn+4sEVS+wqI7EY8+k+hSsrCXG7hjUF9g25atJTEPEXJcDZBIctDKsMGyuq+UUyWE2D6UFYCqeDlb/AyCXFjaEGPe9Vkh83LgrL2ZPexSfw9+TPaZABEMZg1+dezzvzUiTlB80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpFbHhUSVpka1VzUVFtWDZqNmhQQ1ZSSVJRUWc0MFRYYXZpZTRXck1XT2V5?=
 =?utf-8?B?dzZaZUczL0pCZlczNURNWWN6enR0RURwckVCdUtXYURIcDF4aWZDQ1l2ZmRF?=
 =?utf-8?B?cTRpalJlL0JjY0F4QU12L3ExempEdGtHRXp1WXltc1VTNVVRcy9wWFVjMHZX?=
 =?utf-8?B?dTNhcnhEakxaZDVYVDhsU0FCMGZWTGlsM2MyYjdmaTVJZ0lKTWE2aFpIa0hC?=
 =?utf-8?B?MEFUU2hmNjhvd3VhRFY1MDIxTW9JZUpOSEU1S3BBa3BrS2I2NkpSOHN3VG1N?=
 =?utf-8?B?WkJMWmN0L2tTWmROamJLa2JNLzBWTUFDMVdJd28xc0MvRVFmeDdFNEovSkJu?=
 =?utf-8?B?QlZDRFRiSEd0MXBSZXNVRVhyb1B5NWk4WENMYXZ3dDZWMG5vWW5hYUswTnZI?=
 =?utf-8?B?TURNOE1kNkNMbkp2MFZxZ3VCdUR0UnppaTgrRVl4OTIxb0RORDFqN2dBN0ZX?=
 =?utf-8?B?ME9wQkVwVWNOT1hCN01keSs0TGpSYklGUHd4VUtjRnpUTXpubGJRMnFUM3Vy?=
 =?utf-8?B?SDRya2MrTkhZcmdBQzlyMkFvN3NKZWJCNjhteDR2cnc0eWI2MlZ0Z0tLVngv?=
 =?utf-8?B?V2VWajd1NmpZekhlZDg5YkhZblVjbGZyN3NkUy94aU93YkFUaWtLMmJwMVhE?=
 =?utf-8?B?UTZQeCtBbE1HMWh0Zm9ERGpmdkYzck4xaFJSM2hvbkxSbWlnUHdiSzFENkll?=
 =?utf-8?B?TjlMeUdUN1pnUTFneDFnekRwU1YvU2Y1ZzJDTHdRbTlYNkkwVHA2RENacjBW?=
 =?utf-8?B?TmFZbjVNMmo0UDZnc3dZVXpjWkh2UDZON2FQUHRBOWJjbUNNaGZrMGRnSGt6?=
 =?utf-8?B?dDFHWHRFc09yNnNwbFM0MU9QZFlLbzBEaSsxZHNydWx3RkQrSjlyc3dIMXpq?=
 =?utf-8?B?TkNYazRncFRnZ3E3R2ZqVFFFZWJGUndjcjhJUGZqaE95cEZ4UWdkMEY0QmhM?=
 =?utf-8?B?dDExVS9YbzFMdHNKU0h3MUlSMllmM3ZmclRHVDNKRk10d1VodTQxcDdsTmxz?=
 =?utf-8?B?R0o5dGh2bmtsbHhobjMxWUVWYzZvRSsyc3prS3MvejVUWUlHbWh0Nmx6M3Rr?=
 =?utf-8?B?Um5hM01iRURqN3RDenZIaVByOStVR3RLa0RQNkoxcFVteGgrRm1WSlJ1YWJt?=
 =?utf-8?B?WGgzQ1BLREZpVmRUNmpmaE9YWGowaFI3bGVuNFZMZlNva0FYWkEzNzl2aEZx?=
 =?utf-8?B?SEYwbUVRM0RreGwzUGwrbFh0OEx2d2VaMWcreFl1S014dTNBY3FHdElwb2Iv?=
 =?utf-8?B?a0lRZ3QzRUJBeDJuajJvc25lbERzWCttWkJSRDFDMFVZYXJXTFBuRnI0VnRj?=
 =?utf-8?B?Tis2NS9YeFo4cGYxN1dJSVIyKzRRSmk3RkNuM3BaZ2I1Wk03Q3k3V2NicTR2?=
 =?utf-8?B?VEcxL0dCN2V2d2Vzb1dKWmcwT2pTOENVc0V6MHd4cXdlNXh4Tm1HcEk5Z0x1?=
 =?utf-8?B?Y09Ea2JFOVNGTFpUYUVsVm5VTWRWTlN5TzNUbmdpWlJVZWFYR0w2ZjdJNTVz?=
 =?utf-8?B?bE95Wk04eDlRRG9RMDIvZEZwN0dmR0Z4b3YwYjlFYXpxYXhGdVJNVEo2UjIv?=
 =?utf-8?B?K3pVQU81QnZmcjB2M0Q5MWwxOGEyZWkyVHUvOTduM2I4ZytQRTQwRnoyMXdl?=
 =?utf-8?B?a2EvYk8rZ20zdndDdUYyd3hiZkdoaXJ3UFFhLzc5M1krMVFNdTNIS1V5MUVP?=
 =?utf-8?B?ekN6c2kwaTBlRmhSQ01BTzhXb2JOQXVDb1BPaGFSeGRxZ08zNmhJUkpOdTBh?=
 =?utf-8?B?WEJnelVWTllhY0RLSTQ5NitRWjh4TWR0VC8zK0tXSXhiRSsyUzZiVml2RTd2?=
 =?utf-8?B?RXJFZEtvSWxTbGl5Mzc2dWU1Y2Rrcmd6UmZFUm9xYm1oVk1vOEVqb3l4NTEz?=
 =?utf-8?B?bkZnVDY3TVNzMkgxcXJzOHBWenFtNEF6bTZvSTdYeUxOTmhWVDhwTnI4Z0Y3?=
 =?utf-8?B?cUtTUUZDcmd3dVdkZDM2REpiS2FlK3B3blZXU0pUV214UVBRWmt2S3hBU25w?=
 =?utf-8?B?OVJlYzBGR3piQkhTUzQ0WXdmS2FRYlZXK2g3TXRlWGhrWFRPUTEvL0I0T0po?=
 =?utf-8?B?YldGcnBQZExLWGd3RUMrWGRKYmNES2ttN1dFKzRQQmdhTmc5KzZFeHlZd21E?=
 =?utf-8?B?UDNTemNjdmRESW55ZjlKakNRa2Y4NWNUc0RTMUZuMTZkQ3g5OVhaNjc3bE9n?=
 =?utf-8?B?dzVncThxU0F5ZThrVFBKNzA2UFozTFFKMlg3MWVuOUs0ZDd2eVUzcmhVYUF6?=
 =?utf-8?B?dUp4V2J5VS8xdFFMdVE5R1RNVEFmT1lUUHhYSkkvcVFhRWl2MWNLZW01cXNq?=
 =?utf-8?Q?2yvPC+uawGQBXbn32p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808e739d-857d-41be-4c10-08dea68aea90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:34:30.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWSQQpaouXG3R5XB4r4Htt6Biv+WnHOYgFXnF7RUthK1BpWa3HckHnfi8X5639y9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
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

On 4/30/26 00:52, Daniel Colascione wrote:
> Tvrtko Ursulin <tursulin@ursulin.net> writes:
> 
>> On 22/04/2026 21:41, Matthew Brost wrote:
>>> On Wed, Apr 22, 2026 at 09:41:54AM +0200, Christian König wrote:
>>>> On 4/22/26 09:32, Tvrtko Ursulin wrote:
>>>>>
>>>>> On 21/04/2026 02:26, Matthew Brost wrote:
>>>>>> Triggering kswap at an order higher than beneficial_order makes little
>>>>>> sense, as the driver has already indicated the optimal order at which
>>>>>> reclaim is effective. Similarly, issuing direct reclaim or triggering
>>>>>> kswap at a lower order than beneficial_order is ineffective, since the
>>>>>> driver does not benefit from reclaiming lower-order pages.
>>>>>>
>>>>>> As a result, direct reclaim should only be issued with __GFP_NORETRY at
>>>>>> exactly beneficial_order, or as a fallback, direct reclaim without
>>>>>> __GFP_NORETRY at order 0 when failure is not an option.
>>>>>>
>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>> Cc: Carlos Santa <carlos.santa@intel.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Cc: Huang Rui <ray.huang@amd.com>
>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>>>>> Cc: Maxime Ripard <mripard@kernel.org>
>>>>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>>>>> Cc: David Airlie <airlied@gmail.com>
>>>>>> Cc: Simona Vetter <simona@ffwll.ch>
>>>>>> CC: dri-devel@lists.freedesktop.org
>>>>>> Cc: Daniel Colascione <dancol@dancol.org>
>>>>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>>>>> ---
>>>>>>    drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>>>>>> index 26a3689e5fd9..8425dbcc6c68 100644
>>>>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>>>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>>>>> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>>>>>>         * Do not add latency to the allocation path for allocations orders
>>>>>>         * device tolds us do not bring them additional performance gains.
>>>>>>         */
>>>>>> -    if (beneficial_order && order > beneficial_order)
>>>>>> -        gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>>>>> +    if (order && beneficial_order && order != beneficial_order)
>>>>>> +        gfp_flags &= ~__GFP_RECLAIM;
>>>>>>          if (!ttm_pool_uses_dma_alloc(pool)) {
>>>>>>            p = alloc_pages_node(pool->nid, gfp_flags, order);
>>>>>
>>>>> I missed this conversation so don't know if this was discussed -
>>> I meant to CC you here, but missed including you.
>>>
>>>>> having less of 64k pages is not a concern? I mean slightly higher
>>>>> TLB pressure etc on hardware which supports this PTE size.
>>>>
>>>> At least for AMD GPUs 64k doesn't matter at all.
>>>>
>>> Same on Intel GPUs for system memory mappings - it is either 4k or
>>> 2M
>>> GPU pages. VRAM can we 64k pages but that isn't involved here.
>>>
>>>> There was a large push from the Windows side to use that size, but
>>>> we have more than enough evidence to prove that this size is
>>>> actually completely nonsense for almost all use cases.
>>>>
>>>> I have no idea how we ended up with that in the first place.
>>>>
>>>> It could be that there is still HW out there which can only handle
>>>> that size, but in that case such HW should just set
>>>> beneficial_order to 64k.
>>>>
>>> Or we move to a table config if we find drivers have multiple
>>> beneficial_orders.
>>
>> Or a bitmask of direct reclaim orders?
>>
>> I am not saying it is required to be "smarter" than this patch does
>> it, for AMD and Intel apparently isn't, but for other drivers I don't
>> know so it does need looking into.

Yeah if we ever run into such a GPU just making the single value a bitmask sounds fine to me as well.

>>
>> Regards,
>>
>> Tvrtko
> 
> Probably stupid question: for systems like my Lunar Lake Xe2, which has
> unified memory and (IIUC) no special cache-type or write-mode
> constraints for GPU mappings, would it be possible to use regular
> system-provided pages (e.g. from shmem) instead of going through the TTM
> pool and allow mTHP to provide the aligned and contiguous backing
> storage that the GPU wants? Something like GEM has, but maybe inside the
> TTM API?

We already have that through DMA-buf heaps and udma-buf, additional to that TTM already bypasses the pool for such allocations as optimizations.

The problem is usually that THP is often to lax trying to make bigger pages again. So you sometimes end up with performance problems.

The Linux memory management is generally optimized for CPU use cases and fitting in GPU use cases is rather tricky.

Regards,
Christian.
