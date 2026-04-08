Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F199FD5F95
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD05710E550;
	Wed,  8 Apr 2026 08:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r2oEB0MS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4115010E550;
 Wed,  8 Apr 2026 08:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsj/diQ/rokLUnF0F80hcUqXNQl66hz9qddrW3YxqlLRnt2MarsJ97HZ6K+wbGUDpZz27TpMhlRQwknZ3rWZEEbmA7FGEk/mcxiKTWGNPEXch+o7rniePAEzu9xZS3+KzIInqG5cdkVRM88nyElz25+LYJ9qBz1IYEzYXJCsfAtOyIvV9/lbZKb/d17kqSKlssxNp1PU100WEsHDySZpfAvY4CSr42qf1KU3wIaYmoIrm72WvPYTZikqsOTi/kVvKfxJnOOR8Fl3/S1jAK4y0nSTeR6tLpxomdAQXeVO8Uf2LSQsoJHk1nrInM0lj/CXf2eUY2zIMMSh5f4TQE2BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52B5euVCpYCn2sC9mOLkXLvz+oHSe79irilnIZ/2yF4=;
 b=UEEQ4xzOmfk18HvfrzjCN280s04/oGffoQ6LBnkAKS+TTY/XO/IfKWmXZz5UI896fgd9DQr2uoy4oeAMImKXEIB23LM52lxi3DL7mzHpFBgS3JeJgdGUczLpCVitykB04XKQSYmroEZf5qXLCMKiTAZngol2orS8Xg33AJj27mP1Wnr15zDg05giP+0yunoYK3gXfl2A0hUAbJoLYCnMYfOLbjai+Y4eOP65ca15ZhFE9JCHmk8hX+6sGxuh01npVO5/wX+B3a9EumT8J/oFaHyE0KZVCW3SuGPgLBMqYg1skUTkChDy6QRaL7yVzG0ft7/4k72/t1Pk24nKeakmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52B5euVCpYCn2sC9mOLkXLvz+oHSe79irilnIZ/2yF4=;
 b=r2oEB0MSW4DIHqZdRRxbp+4mRV6GIeelW28p/sit4DFs8UctkVL33frBd2IrhJ9emGW08qi/5l/Uz9A2Ku4YLTLkyi9kvJKZX4I/7Lhq4ekmMW5kr0iussJylvIFqeg7j4EHGNjcvFCLb5CH627Ogei/QXcR/7ynObbDAYHWA+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.14; Wed, 8 Apr
 2026 08:00:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 08:00:42 +0000
Message-ID: <6ffebd9a-d873-461b-a407-a84707a45229@amd.com>
Date: Wed, 8 Apr 2026 10:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Colascione <dancol@dancol.org>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <87341fsa85.fsf@dancol.org>
 <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
 <d8e8f290-c2bd-483f-ba0f-735c503e269a@amd.com>
 <adVAHkA4gERWOszt@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <adVAHkA4gERWOszt@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: c960b7fd-b81e-4a57-24d8-08de9544ee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: bjwlth+5LLOnXclD8zvkdR46AhzmIT2FHGSUz3EBNOEWrw0xcfz0zzhHoHRyRdeXTik8/OUlt96HYpXkHizYlecfYkB8oxYydTUZlva76tl4dvcfMPrsKDsm6OD6xCBJXXJGpiZoY0DQkXZBDc3i0K1hK210K8PpnBQqF4bzvWe+5cguuLP5sP04RAHpunoyafTgC6Hmws/pbDCJTRk0BNkmZghUBSaex9u8xUbsYSn3JhW+BAot0ueOUZwEyrj0VGEVBuqPEA1X+Jr/8AoEc0xoYLK5QNsTig7JQih2lDPTRqw93iBjRGAi/TzRL7NzheUCjGqEH0fzKNs2vhEwgiNq5emayeylrfj14bPF+KnL3h1gNemDd1SrCEJcfPxffI5bylQ9RIteMd/gD/f660UgmMxesNdFFZjm05TkFlEDbV6NqPTd7NKjPjzMBClvjaK9CGl6FoWKnfiVTRn8SQqEOmDXM1OB/nKko9jrE+OaEvZHkYma+6Z9bHZ+Llgq5Cv3AmvIg/etDAb7q/7zWuN1PR6ewujuKhirWo7QdBJh60d3o19cFElwhEicqYqQWWTDVUGTkshux4REdXXtHzXtwKR9MejW5XD22IaJNOh+0neNWgfFSErxUrUhoojcT89ZJmYthnzXL79CxVx+bGE/oiOeaox1Dea6F1ozHmWFrXSDFFsuN+BsIwwJZRF+VffBHePfCm00tcOA4lcbFrKKVQD9n1ntCq/qgKNDz24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zml3T2dFNzNPSnl1RkVrUk82NW9jK2tUS1QzU1lJMWNnZE1ENVRNb0RjemNY?=
 =?utf-8?B?UTR2eUx4RTNrSE9KMzZUblgrcE5wWlZ3ZkhsK1VhbUxMb2NNV0ZUUUllSGVs?=
 =?utf-8?B?ZlhJcDY0YjVyZXhGL3d6VFl6OHRHTG53dmNIOW9SUzNBK0U4TGx2d01oRG9l?=
 =?utf-8?B?YlRwOWVzL3VNL3lqQ0NHY29JSXJDNGZuTmxBb2tHdWhTTlgrYnJjQnpINkty?=
 =?utf-8?B?bGt2TUFSWGxscGl2WHdNY2pJOWI4VkRORUVnV2d1Q1BWNVU3R3l1QlVJYjFX?=
 =?utf-8?B?Mm1ib2dENnI1TUtocEUxeStMOUVpREhDWFRya0V6aEJOcVRRVFlsMTBXSzlx?=
 =?utf-8?B?bFluQUNINUZCM3NpdmhNMzRJV1ZTdm96SGNlRFJGbFdvZWRuTmhxSWJlNWc4?=
 =?utf-8?B?VjhhdVpGL1NZZDJEV2ExMCthVnRCUWxIZ3R0bER5MlBTR21LSTVKWkpGQ0dN?=
 =?utf-8?B?NHN6Vk02WEZhZm1JOW9sRCtvK25vYncwTU9rYTRUVGU5WmhlRkJTbXFKNUdl?=
 =?utf-8?B?dnpFU0kva2FNZGtrczQxcW9NcXlvSVFNRUozRnBCVE5wRzlGUGR2VXZUc3Mv?=
 =?utf-8?B?SnRQRW5keFBJL0ZSVWJ3Y0dXRFRnUWo3ZDg5V09WZEJLcVZJT0UxUlZnUHNG?=
 =?utf-8?B?azdiTFNRRjBtRVpGdkF3dmVycjRJU1NlYmc0cStrS2dnK3NlVi95bXBwWEIw?=
 =?utf-8?B?eEpGaXY1ZFZhUlZsSktWdDlGZjlZaGs4RWFYSHNuUWNrSWpneFJJdkI3cWdv?=
 =?utf-8?B?UmVOQjNxYksxUWVRQmlCMmp4N1EzeEY3M3dRRU1GSjJZeHFiRlpTaEpLWUsz?=
 =?utf-8?B?eG5mNTlHMEJlZ3pOdkNSQk5MVngvQ2doZ2RKSjh5bnM3ZjRSaDNrQkZ0Y3k2?=
 =?utf-8?B?aWhOQkp6cDRCaUhJVjdaaHVLNW1ZOFIxMVZZWHhrOUQ3azcvUkZuMjFPdFEy?=
 =?utf-8?B?SW9pNStsZEd4T1Y5NEg1QXIram9yMUlsdDhIQytJNFBhaVVrNGZHbExSckdT?=
 =?utf-8?B?KzJFU3JSQzFtckx3VGpyS1pqVmxYdG04ck91Mzk5ZVRQT1JDVHdXU09YN2dh?=
 =?utf-8?B?OE5Vd283cWlrWXdqRmJvSk16VGNYUVJZQ0x2cVBvSmlydzJhalJoS3diNTdk?=
 =?utf-8?B?NVAxRkxWYVFKbnJ2ZnJNSUNLd2RIRHJQRFRnc2RweC8yNjhOWXVHSE5rZU9T?=
 =?utf-8?B?NjFGQytSUXk2UERMOGNSMkNTUWZkWFB1Yk8yMlM0MmsrMFM5RWJ6aHJ6K1gy?=
 =?utf-8?B?Sk1UMmw1UTlmeWd1TVExKytaaURvdHVXLzBRYUw5cXpkL3FqeEhFMjlDa2JF?=
 =?utf-8?B?eTJrcm1tSFdQZ3pMNm9ONnlVY1pnZEVwaXEvRG5ZcTBKVlF1Nm9hb2VkVG1v?=
 =?utf-8?B?ZkIzM0w0Q3lJMnF3dmpVMGp0YytpVWhyU1RVRSt4UkZJaWRqSzlyd3lYaVFF?=
 =?utf-8?B?ZEFZL0ZJM1pTQTQ0SURGMklIY3lpays5bEl0clhkdHU4QjZ3WHZBNERqV1cy?=
 =?utf-8?B?UmtNRGJrZUlBSHVsMnh0QVI3NmFiZUFVYU81U3lTZituTk5DcjdSZWl2VTFn?=
 =?utf-8?B?RWFkSkJUT0lML2ZkSldHTXJMTzhPREc0Z2I3MzdQdm9SdUYvdmEwNnk4dXVl?=
 =?utf-8?B?SS9VZndXUkVrUENVUDZ4MkZRT0FuVXpWTlMrQVYrRE0xbDlQMTlFTElKYU1w?=
 =?utf-8?B?YUpJMnFXNHRWL2daMnlPZnRuTW9HaXd3TDZDZGYycWtMcTVBdFFrMkJuaDRm?=
 =?utf-8?B?S29hMEp1dTVkSHlrN3M3eHU0RE5oOEcvM2dFMW10azRUdmp3THI2M1hqNzND?=
 =?utf-8?B?a2R0MWdiYVVnam5ZMS9qYVpGRkUraXJ1SkFqajRHMStFTWxCa1NSKy9KaHBO?=
 =?utf-8?B?RVQ0Yy96UkZhWEZobjRCN3dtWXZ3SXE4L1VaRDFjcWN6S204dU51TkNZNFVi?=
 =?utf-8?B?NDAyUVl4dWlySllVRWlsMmIzekg1RGF3V0lDZUo2YUI3RzBzc3dtbVlUT29p?=
 =?utf-8?B?UHJPdDRIdmFWRlh1bC8rU1lEdzl2dWZxRWRVT0VlYkZxYlpyUnZmTEhHNWtB?=
 =?utf-8?B?ZFNvQ1ZmUHM4SnZXbTFPU3E2OC9xNXNmSk4relJTdXRNYlNQQUNMM3R6WTZH?=
 =?utf-8?B?R3lTMjZlMUxpaHFnRHB0UTV0eFhIeUU3QXNuS0F0ZGxxNUc0b0VNd3RZR0pl?=
 =?utf-8?B?bzlqcUJ1VnNTYlBRQlFyZmowcEJzVUp6VG5sQXFFakthU2hFVGFTRGJCRFdt?=
 =?utf-8?B?b1JEMjNOZHA1ZEZQMG54V2Y4MUtwZEppUWdpZmNjbVpKbllYbXZhczlqZGpC?=
 =?utf-8?Q?dRsAsmT8xe3OnVh0yI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c960b7fd-b81e-4a57-24d8-08de9544ee68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:00:42.6362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl9B0ohQLzh0PMQ13Lio8AIAVGB4WQd19YVGieGy41yvI6hyvBpSCjbYNsWAfWTT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

On 4/7/26 19:34, Matthew Brost wrote:
> On Tue, Apr 07, 2026 at 09:43:30AM +0200, Christian König wrote:
>> On 4/6/26 23:02, Matthew Brost wrote:
>>> On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
>> ...
>>>> -
>>>> -       /*
>>>> -        * Do not add latency to the allocation path for allocations orders
>>>> -        * device tolds us do not bring them additional performance gains.
>>>> -        */
>>>> -       if (beneficial_order && order > beneficial_order)
>>>> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>>> +               if (beneficial_order && order > beneficial_order)
>>>> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
>>>> +               if (order > max_reclaim_order)
>>>> +                       gfp_flags &= ~__GFP_RECLAIM;
>>>
>>> I’m not very familiar with this code, but at first glance it doesn’t
>>> seem quite right.
>>>
>>> Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
>>> diff, help?
>>
>> No, not really. The problem is that giving 9 as beneficial order only saves us avoiding direct reclaim for 10 (>=11 is usually not used in a x86 linux kernel anyway).
>>
> 
> Yes, the first snippet was a bit incomplete. I adjusted it in a
> self-reply, but that likely still isn’t exactly right either. I’ll also
> take a look at how reclaim works at higher orders and how kswapd behaves
> there—I’m shooting from the hip a bit at the moment.
> 
>>>
>>> If I’m understanding this correctly, we would try a single allocation
>>> attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
>>> still attempt allocations from the pools, and then finally fall back to
>>> allocating single pages one at a time.
>>
>> Well the code is a bit broken, but the general idea is not so bad.
>>
>> What we could do is to use beneficial_order as sweet spot and set __GFP_DIRECT_RECLAIM only for the allocations with that order.
>>
> 
> That’s roughly what my follow-up snippet did, but with
> __GFP_DIRECT_RECLAIM replaced by __GFP_KSWAPD_RECLAIM. I’m really not
> sure what the correct policy should be here. But in general I agree
> beneficial_order should be the sweet spot where we trigger some sort of
> reclaim.
> 
>> This would skip setting it for order 1..8, which are nice to have as well but not so necessary that we always need to trigger reclaim for them.
>>
> 
> This has made me think a bit further. I’m not really sure the current
> approach of TTM setting policy is actually the right choice—it might be
> better to give drivers more control so they can tune this themselves.
> 
> Rough idea...
> 
> struct ttm_pool_order_policy {
> 	bool enable;		/* Should I call ttm_pool_alloc_page for an order */
> 	gfp_t reclaim_mask;	/* Used in ttm_pool_alloc_page &= ~reclaim_mask; */
> };
> 
> Then, in ttm_pool_init, we could optionally pass in a table (0 →
> MAX_PAGE_ORDER) that controls the allocation pipeline in
> __ttm_pool_alloc.
> 
> This may be overkill, and it still wouldn’t provide per-BO control,
> which might be desirable for cases like compositors versus compute
> workloads, etc.
> 
> What do you think?

That you need to completely disable allocation of a specific order is rather unlikely from my experience.

Different HW has different sweat spots they want for allocation, e.g. 64k, 256k, 2M etc... but in general it has proven to be always beneficial to try to allocate large pages first just to speed up allocation (calling GFP once for a 2M page compared to 512 times for 4k pages makes a huge difference).

I also don't want to overload the driver->TTM interface with to much information, so just giving the sweat spot or maybe a mask for the most desired orders should potentially do it.

Christian.

> 
> Matt
> 
>> Regards,
>> Christian.
>>
>>>
>>> Matt
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
>>> index aa41099c5ecf..f1f430aba0c1 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>> @@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>>>                             struct ttm_pool_alloc_state *alloc,
>>>                             struct ttm_pool_tt_restore *restore)
>>>  {
>>> +       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
>>>         enum ttm_caching page_caching;
>>>         gfp_t gfp_flags = GFP_USER;
>>>         pgoff_t caching_divide;
>>> @@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
>>>                 if (!p) {
>>>                         page_caching = ttm_cached;
>>>                         allow_pools = false;
>>> -                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
>>> +                       if (!order || order >= beneficial_order)
>>> +                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
>>>                 }
>>>                 /* If that fails, lower the order if possible and retry. */
>>>                 if (!p) {
>>>
>>>
>>>> +       }
>>>>  
>>>>         if (!ttm_pool_uses_dma_alloc(pool)) {
>>>>                 p = alloc_pages_node(pool->nid, gfp_flags, order);
>>

