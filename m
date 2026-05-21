Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF6CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFD410E133;
	Thu, 21 May 2026 08:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GsERyUqR";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DAC310E133
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCKqeFLEsPDKeYE4DBcbXgU14gCna+MU8Cl02eyeY8oMen5w2ud7clSO6DmZXsTb6gBMwL5dhT3xepSSKSHSQJ4NiqMoYAzswC1xsjPZxvSZOyf/ejHt1nyFBjZAH+mBhFHZMgaCIaxWwiPaoUfsWWq2yTxQrNTZlup82Ft3DgR8Pn0DndsGWTx/DCYMj3yyCTQpKTSVTeZr7//cPD4nw44m/sH43cIea44bYgAURlWplcuISGTw5GtEvgAj/OjUugh2q7pwYC7MGvnaX31lBtBNjGHUyINDLvbLTIroNSv+pXQe4Dmj7Pw10ZqjmcMtZo1OvAXV1I/3vYPwRiUV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjVqHtxovV/VU0Gx1sCI/KXhH97UD1BPkitrcHMr6sI=;
 b=CDE2K6z5koVlnM7lcMucV8dGrjzVfz1UReHKI7yDUwT0qFCPMk88h53mmUrRUY8SaJK1OdzVydGG2dLXku0jJpU/2VYGTgyYsFKnu7hbjNxIvEh/lmQzcSQl83Wy6Q1plO0DY3sjvpmA9Z9qbjJDYCeW7XxhM7uG2jSFKhAK/ZulOk0Yjb1crdosv7KHryKVjio1cVA4Jk4orvEWUrWlPbl0fyeW3+DAgA2kfaCnjD+U3v5DE/qaRTTLPNO/hT5T0XRr9odwVaQkzvrC2bIWWzFcfzS2lgM61/PjVvoGM0zUH5rnudF+8IYpjY0ExroZyZOF5BxrGeynW2NpsfYoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjVqHtxovV/VU0Gx1sCI/KXhH97UD1BPkitrcHMr6sI=;
 b=GsERyUqR1txJnbftSnSThI+KFrvA1HdsJDKIkCFSyKmI0+tQUtjgosAHa8a0Kd7wBPhVwR0XzEiTjhQXxOcjFku40qwdXhIxA2xn/w/ICLJxqgMPBcl7GUpCCaN3KvgMSa9l9yU964UEOcrtE+uql1wg7JUYKKskNhPrha3UsZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 08:36:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Thu, 21 May 2026
 08:36:52 +0000
Message-ID: <d793568d-9611-4174-b9e9-c71ffec5ae93@amd.com>
Date: Thu, 21 May 2026 10:36:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dma-resv: Define guards for context-less dma_resv
 locks
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-2-f2d8c15a97ce@collabora.com>
 <03a57011-e734-4a74-aef2-e3a6016e15fc@amd.com>
 <20260518111456.30ba9bba@fedora>
 <a9ee80aa-0c9b-4bd7-87bb-d3e228357b18@amd.com>
 <20260518161531.331cab2d@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260518161531.331cab2d@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: f60446dd-4e45-421c-ec74-08deb7141bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|5023799004|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: b4kraUOn2o2byKWCmaWK/vo3Hl5wmabtkuY2cuVg0vTH2MHzyASrwJ3a+Q23sjxYQD9K3hIG2fs6XSDSrpUjhxc3lV8Kd5LIYy/4uZbaG4w2rOWxP01INvSOdEwNYK/4PTWG0zKjntyAECwb7Kk5QmhFCKENEPjXHgKzcfUzM9+/s33U98omeI5+g6vsinUfCnsmYCXfuZDyr7JF/Bj7UiYRbyZcV/J1/iuRT9LqQhOXvEewAtUpxMfTZOcxrcxdywa2Gy4UZLbPBj0UK+kE0N64VSjSPlHlM6/jBnw/wSW5wmhptFSRSPdgp17HrroqG9NdPCAUIhFWIQRUyPB7+RdBYlLtbFpBINxPeWEltxW2NoqI7jyYXAtDSB1Hd4E0PMxA9prGB1nM9LaXD5nAi7wM3ltQ8UVeWeh1dksYNWvB+n3w3rIw/x08y4XMBO0pxfVsVvr8kRK0ZRlCg4Gxy6c6sS5PQi2MiYMze1rWb8scnvQTokD1hy3s2Xj5mGLnX5cvyvkPz1QcEccQEO5aZdoF/ibPs0Bpe+Ta9OOrpRmpKRysNWYGTehVkb2GqsgrjoAOvC1YLoWoQsTNkZQ8TGLnXPxhv1picB84OSpfwXQi0rW7SA1s6QhuLify0AZxdegZulAH67DpVaWzu1HTXO1NQhJ+PlrmsjuP2my7CpNycMBs5wm83Xw2m+MWoThN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(5023799004)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9BM0tjc0RCdlJDSTBzeU0vVXlhL0RzU2lWOEFzRWkzQ3dGRDQyMFAvM3FL?=
 =?utf-8?B?bUY1a0FyODFGV3BaamhQKzlxYXd6R0ZMbkNpR0RuT0k1MlE1dDRRZ2hEand4?=
 =?utf-8?B?dHFUdFFuVjNCQ083Q040Q1ROZjVEaGJTbjJIeEo4ZVJEcjZkT2Z4VEVkYTJj?=
 =?utf-8?B?YWN0MVVsbFZNQnBlb3IwZkFvVXdpNTRaakdFQ21abHdyeTRpZnI5cmgvY1hD?=
 =?utf-8?B?UlFxbzFDV21pdDJTYW84TlBINjdsWHJ4Ri9zODluaHY5Ym9EUk5GVVJSMnNn?=
 =?utf-8?B?ZHBuR2V5cWhHd0VWdXRRMmNpMGtqSjl5WDArREJlRmErOUh4UnZQR0ZyYm5T?=
 =?utf-8?B?MjdnZ09CQUhXZ2RBaUlYQ0JuVlJCQmZRb3E5a3dXdHk1a1E5bjkxQkxCM0lS?=
 =?utf-8?B?V3JIbnhpSjlQaDhPSzZBdHk3RFQ4bnl2Q09HUitldkIycnJibVZ0TC9wYVZT?=
 =?utf-8?B?emxYWHNBMDFWclBRdVh5WnhFeFRzWnhKVUVTSGUwM1Y0LytzK1F2WWRDTkY4?=
 =?utf-8?B?TVRRdXJXc0dObkE2MXZRSE53cG4yV09lVDU2QnMxanVrUGw0Y0JGclN4RnZh?=
 =?utf-8?B?QmtnUzBjZ0V0eFh5M0FsTlorS3dkT0JrTkp0dndqaGoreFcyeUFqSHdla0Vi?=
 =?utf-8?B?ekNsblcyMlllMUVBa1pPRUwyUEhPOFYzY0owelVyNjVLMFNQc1lGRjQ5RUNH?=
 =?utf-8?B?NGdQQ1BIV0drNjdiRWw1VVFIelgyQ3p4ejZYWG95Sm1BSnhqeExpQkpSNlFa?=
 =?utf-8?B?WWN3VEV4UFlvYS9mOVZNY2pjOTJQTlo3YWdyZStrKytBS0IrVGxqaTBFdHgr?=
 =?utf-8?B?RlBlQksvOVRWR1EzQjNwaTlLTmZZeTBlZFJpdE1HbW0wd3ZJZmp0SWl5eEFN?=
 =?utf-8?B?OHVCQURiUlovaFZEdDc2bkdFNEprZzRhTXVRZFRPR1hUVEpjclJWT3BmWHg2?=
 =?utf-8?B?UUxnWUw4Z0tueEc4RllzVmMyUFFDMEJhT1ZNWnREYXgvais1aFR2bGpia2pp?=
 =?utf-8?B?elBjbHZCM0xSQzFXdWp5YnkzTEZBN0d5anluK29KWmlYQ3hadFd5Rko1cmph?=
 =?utf-8?B?aFM0T2wzakhhaFJVU0IvR3BrNFJockFKTzNSb1ExWjQvL1lKZ2lnN0Zjb0Zn?=
 =?utf-8?B?Y2kyVVNUbzJScmZsUFRqL2c3UzhxRml5ZDlLK1RpYmE5WjlueVVYYUVRbXVU?=
 =?utf-8?B?QTZzUk9qWjFtVDRwZWlIZnBWR0lRKzFZcjZYZ2U5c1NNbGlzL00ydEdYSnhq?=
 =?utf-8?B?dFJWYmdxOCtpd09hL0QxRFVHQUpCckZXeWlVRENyV0hRQ3UzYVZVeFM4TUlt?=
 =?utf-8?B?NEVaRmVoUVJkaElZa0tYUUNsM3NvZFpyNCs0a21JRXlZSG5YZjFpenR6eWZU?=
 =?utf-8?B?TlFVTllDMW1UdDlHaERXTmVxVkQzTXk5eEhaWElyOTBzakpRY0VwOGlRa0kv?=
 =?utf-8?B?aEpWcWZzNEYrQUc1eXpGbzRFOUtVK1NTU0t0a2ZoZUF4eDR2QUlxM1lEWCtD?=
 =?utf-8?B?aWsrUHY2Mkpjb29yU1dnSHorZExHZjhFODdNMlQxbGVVV2hONTNxaGJXWjI3?=
 =?utf-8?B?YnlWa1p1ZnQrU3JiWDh0dGtjdk1VU3FMVHIwcGlYamlvNm5EZGNRQWdDNDdl?=
 =?utf-8?B?R0QxeUhhYk16bk4vWFVCeVh4OFZxTTkrY0UrY0ZObVlhL0hGaTBUVUtFTHJT?=
 =?utf-8?B?RFZMc3ZTNFZkdzJteXBhbm15VnRJM21vZENvMVhqUmRNK0ovWjdZaVRpSHBk?=
 =?utf-8?B?cnRCYUViK2FmckM3U2YranRWemNHOVN0UUc3Z0NVVUZ1VCszY0tkVUQzV3Ni?=
 =?utf-8?B?Sk1OZDZLWmJpcEdJZTB1WTFtZk8wQWdxc1NEeEJWLzIzalduMHlhZU5qcm1w?=
 =?utf-8?B?MlhEMnprdzgxRVZ5eE9ySGpSRWNZclRERWFGUTlab2RFSjBQSk5lZ3JvSzdF?=
 =?utf-8?B?ODl5Z0s4VXBUcExTdXZrWmRBT0dxNDFqNHJDTWNYV2RjK2RRT2grTTZ1dWwz?=
 =?utf-8?B?UEx3NXg2cE1xQURvZXpId1NHaFVJWUttSDFKd2t4c1B1dVhxbitpS1JqdVRR?=
 =?utf-8?B?SDRib3R1YlpGK2VjWktEdDduQXJwM1h5NVBvandsVlYyMjJVZ1IzNFZiVHIw?=
 =?utf-8?B?N3lpeVhRWUZURXUwNHBhRlhaQktwK2k3NjlLakc4WU02QWVIQTJJTm1vSUJU?=
 =?utf-8?B?VVVOQ3ZVcHY2VVd1L3k5Mmo2V3Q0N0JWUkM3aURSb3E2a3NHNjk4WnRQTXhx?=
 =?utf-8?B?UlFHWUZjdDNFcUNPci9hYXVBaWRXSkgzMnZnUnlwQzAzdTlqaVNoVFpqRlVw?=
 =?utf-8?Q?GTYYdar3W1V/QmFVGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60446dd-4e45-421c-ec74-08deb7141bbe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:36:52.6916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0tWQQ9lRlwQ+zlAh+xJCSInalvosqNM/in0mHVNDTey24Hm6nagDvUPhQp469js
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868
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

On 5/18/26 16:15, Boris Brezillon wrote:
> On Mon, 18 May 2026 14:18:41 +0200
> Christian König <christian.koenig@amd.com> wrote:
> 
>> On 5/18/26 11:14, Boris Brezillon wrote:
>>> Hi Christian,
>>>
>>> On Mon, 18 May 2026 09:10:23 +0200
>>> Christian König <christian.koenig@amd.com> wrote:
>>>   
>>>> On 5/13/26 18:58, Boris Brezillon wrote:  
>>>>> When used without a context, dma_resv are no different from regular
>>>>> locks. Define guards so we can use the guard-syntactic sugars for
>>>>> explicit/implicit scoped locks.
>>>>>
>>>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>    
>>>>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>
>>>> How do you want to upstream it? My preference would be drm-misc-next, but I think I can live with a panthor specific branch as well.  
>>>
>>> Everything Panthor related goes through drm-misc-next, so drm-misc-next
>>> also has my preference ;-). But I'd like to wait for more feedback on
>>> the other drm patches, and there are a few things I need to address in
>>> the panthor patches anyway, so it's likely to take a couple more weeks
>>> for this series to hit the drm-misc tree, unless you have a good reason
>>> to fast-track this specific patch.  
>>
>> Well the DMA-buf code itself uses dma_resv_lock/unlock
> 
> There's no use in dma-resv.c that can be converted to guards. I gave
> dma-buf.c a try, but just like for panthor, I don't really like the fact
> it's halfway through (other locks still use manual locking), so I'd be
> tempted to convert everything at once for consistency. If you're fine
> with that, I can give this a try.

Well depends on what everything means. I would only convert dma-buf.c in one patch and nothing else.

>> and obviously has test cases for all the different variants.
> 
> Looks like the test cases all validate that dma_resv_lock(x, NULL)
> returns 0. If I were to convert those to guard(dma_resv)(), these checks
> would be gone. Is that okay with you?

Ah, good point. No we need to check the return value here.

So keep the test cases as they are, they basically make sure that we can actually use the guards when there is no ticket.

Thanks,
Christian.
