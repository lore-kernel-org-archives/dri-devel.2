Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B5DC982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC6510E679;
	Thu, 17 Sep 2026 09:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTtKjmAk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306C010E679
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0gH+Zk1+syRkLeWXIxWAul4oD/qhpJYlp+pTEAVTWPwPgxHL2MIbqCZnyx8vKudGlioshY3LNW3YQUTmUi/CqVlI2qqj3lv9pCsEKciTfpv5mOQlfUd2W3/lLpUHBFvDV7DhswUVvT21YffOXaYXeQMcrw75WAfF3qBQ5c2NtRQH7+MzxePsTz+7ZMsUgUIFAqkCjYkMJPuil93J/0QjMy/xWJqMXS1bGuSg09K/RxcTxREm0yPLzCISIOVvKAEunfLFihCq6YsroRkUd5USAK71xCB0kO8qvpSWv7AanLDTn/ZMRK3DgHWZo4f3jYioPzfAuXZVt890wFjPNH9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrW/tQB4Efje/QfUsfqMBckXUpxudzxdDvaANUYR5+o=;
 b=VZMcW8Z7owf9Gol+LH1zg6e1P0kU9eEL5C7FKeGygNM+3AkfvVuroze8vv2zoFUpMVg0LzmPKoowuylInSJ0fW+Kghfv5ByKxAooo1bpWW+dKvxA75HJcDKFbyPre1WwmW5P4d9nvQVYSY9P0oKw/DkfvKO+T3Eq0gy1If4JbQIfQzizcG89oZf9FWO2qoK4Jx64PlLPp/CLAsMVEa3W9RuYn7p/RRMxxBmyDmV0V+GeIZJvx5otKs6gaYr2SmI180kWB5QBsB5k2sd+ayspraCvTap3lLZ65U8bpf6oKDFonfFmKKsKd9MaQZ8wF0CjYz70azP33p2GfXedf5xReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrW/tQB4Efje/QfUsfqMBckXUpxudzxdDvaANUYR5+o=;
 b=MTtKjmAk731QkavxrosOhrcwRr3/0n/OV1jDGIz9SPgauvW+yYuUbnIoeyKZKMemnJXJxDsUYM6F9gdWjpei+pHbutZMxkk6qhw8eLjvh+6+GeWl7EzxUyPc8Km7qhgsHL/yLMQzgw0JfdDZrUqD1KsdejtW3bDXZZpFQpdhTaa27sS3dX9MR6oxR54QuB6PThdRttI909m2pnLmyYixwRLnLLj8F/JwBuJVuO//4qEfa9C/S2QWpdFofZZkNwpNEptvEcH2FuCTaw3MB5537hFNh5s+8DHVaxu4Se6tKq56IvQNKYcZOeFa/ZsfFSUzRu/f42uslcroxHJ3tu+KZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:06:41 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 09:06:41 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 10:06:38 +0100
Message-Id: <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Robin Murphy" <robin.murphy@arm.com>,
 "Matteo Kloiber" <kernel@matt3o12.de>, <aliceryhl@google.com>,
 <ojeda@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
In-Reply-To: <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c73df12-00ab-440b-9dba-08df149afcee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: flubXO2oDj551EyPBDM6O+hz2YyNmDd+kARNznFSZcVjqpdU+QjlmVE+f54sDMTLZLMt1o9P2o9NdxChV027UMdylBiiV9ve9CnTpqC5ZgebN7q6Zjl9jq+PuGN7fxYwwt2ZmrGC0hto6auN7FR36G2WFkCzxIMJ4DAB/nArqw3RrzHKD8FM2yKzHMtgf8pTyWbkjaMjK0frjFVHGxn4czn7W2zs+udxRvPUcqrSU2sPeXCXyaiz9gNK2tg6jY714U4eMeohAeSucz18XuBLFXL899Hw03A41PjOUkI7prYjozMjOxaMjAulrRL4wn/UWYHpM1sd2qwBdQN+Kmhn8B42GpSqe0FRpycEoBNtA3Wr9xFvRWAPof/WpE9kxL8lNfRPYY5nDmTYj5h3obYOp7nISYPaFUN3OVIipc8ZdrbER32UVNZbCY3QoH57qMtqxy8Ki3DfJSqVu+4M0acRUuexrEI+Uob3H8fo2Pg25gG33r2fVcfH8RCYxV02zn27ofyvd4F3Zks3DUYxLq6Ly9Laf1e0pAqwU1S2zZhr5aTw0qLXGWHGkkZ/ugqdOM2Uu7ceoP7Z9QlHtqsljEJmyK0L4x6p+MFlOzNx16g2ZmSLHNtPZLd2jdANyanuBbJPw0n+YakULxhz//HhZ3GXGp2rCrnSTe/0C86VQCX7j2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtEN1hyZDFjTU9WeDJYMVZWSFh3ZU9DTE1Qa0RpaHBLUmFDblhRV0ZuelNW?=
 =?utf-8?B?cVdnRXpKcjZiOUF1RXYxRUhTTklkZTM0ZU5iUDM0QWZwMnk0dUVBOWxZaWE2?=
 =?utf-8?B?bE5vY3lLeVJkWFQvNjNRWXFpSkpCUmJhNXpxUjUzYTBNVC9ZdUdqejNzNGhx?=
 =?utf-8?B?dTIrUk1ReGhUWkx1NTVzU1VLMHN2RFRkWi92aTcrdDBjVzVydXFXMU95SU1t?=
 =?utf-8?B?eXFDMlJKN3N0UXphdUhqS2Q5TTN5SEF5L1dYOUQ3ZWdJNEYzd1l6Z1JVVGgv?=
 =?utf-8?B?bUlEdVdKMzFvd2xGZS9aZkVxdlplYTFnNWo0YVhKb0xuTXBaTWk1SThJQ3Bw?=
 =?utf-8?B?ZnptNzNNMjNwR0YwNWhSQjdOdzJCWHlyVU5MU21Pd0dDdXBvNHdNNGtlY0Vn?=
 =?utf-8?B?aUR4U0w4QXZxUGRzcUNGU0xxSzliOUx4WDh0L2ZDRTNoU1Z5VEVVWHlDYTRx?=
 =?utf-8?B?QXZ2VjE3THpFcHoweDNSVFJaMUM3VjFTeDdsRFB2andWem95SFhoM3M4blYw?=
 =?utf-8?B?b3doRWp6VXMwd20vYnN1U05TNit4N2h3TFU5dDJQaWxmT3ZhM3I1SnMvNDA1?=
 =?utf-8?B?dzNITkpObE5najJoQWpsTjhxUERDZnNnbklud1lLODlDNnRpbDdQdm8xOTVG?=
 =?utf-8?B?USt5ZHVWMFJDTkNZNExDR3dpNWtaeTUrN0duNlFXY0U0OVVqVXg2a1ZCQnlZ?=
 =?utf-8?B?M0ovS0dOaStLcGtKSldpVzFLbnMybXlQNG1uYVM1VnhqZ3F6d2tTSUcwTGR1?=
 =?utf-8?B?RGNvY3F4Vzd6c3RjTlBTcDhVSk9QaForNEZqMG1lQ3Y3ZG5hbEVFQk5VTGtK?=
 =?utf-8?B?YnFpWkloeCtrRk5ucDFWdTRMWXJNN2xlZDFqekRiNFU2aldXZytQU3dvUkZi?=
 =?utf-8?B?eGowalZ1d0pmTmxpdHNkSEc3ZjFlbnpIRVZPb1N6RkN5M2hraDQ4SjBrZngr?=
 =?utf-8?B?NkZaaEhJWlNkb3lTcXl4cWszV2k3SW5XOU1iK1c0QkM5bXZQWWxJY2Q0TmQ4?=
 =?utf-8?B?dGgwVmZuYzB2SWFnbmN4NHpzQ1BKc3BHUGlnd3BoMktIV1JEM3BRb3RUOGFo?=
 =?utf-8?B?VFFnZGtySm1pZThuMy84bjRld053RVlzN1JWVjhaaFNUVWJYY2p0ZmVtTmlV?=
 =?utf-8?B?T3hraGVMczlmYUlaaWRBRkhIcStvR0xmUk13Rk9iblBESUViT3JoTko2K011?=
 =?utf-8?B?VEVTWUFhTFgvbVhGcC8xNDdyS1prSDJrZ1dyWjhNazBjM0g3UEh2a0NXNVRO?=
 =?utf-8?B?dG52VGJTSWFkR2Y4dHhTdkZud0JYaUlIdlduVGlidEJWN0ZlMjU4ZjQvcFND?=
 =?utf-8?B?MHNMZWltZlVuTkEzU3poK3ZXR0Q3TmxlclExNzBPRHI0THFRd1RJK3B0UlhL?=
 =?utf-8?B?UFkyTm9ueVBObjBQWkkvTG1QdTdkS0hYV1FOeER0b0tZRWJ5d2taOTVtOVJI?=
 =?utf-8?B?NUhpOFVIdWNHRFMyNzlqWjBKQ04xL09GK0NpZ3k2cThwM25tUUxNSHpabGJM?=
 =?utf-8?B?ZHFVT2VKdjhtcTRlSU03YnY3RzZLbWM0MVJXaHNLbWkyT1ZtUmU5MlJsU0xV?=
 =?utf-8?B?NVkyRmw1cmJwUzhUT01LcXJuUW9lc3JkQ2ZVOVlzTGhGTGJxMUk0UGxRZEd3?=
 =?utf-8?B?YmdtdXFMb3dzakl3SVJhNUVtd08xYi9NbWpPSjZrVEk0dDEyOGNOVXQ5MjAy?=
 =?utf-8?B?Y25mUEM3QTUwbTU5TFY0NTdMRDA2WnZoYjNBQXMrQ1FlOFB5ZWkwc3BxQ2g2?=
 =?utf-8?B?OFlnUk1STHBLQ3hoTVJNWWlVWFUrMkNLN2wvQldTc3pweXhhTzBwS0ExYVdM?=
 =?utf-8?B?d0VmY1hjNXBBTU45cW5QL2FUREdFS1dJT0NKTE1YbU5mZzdLRHVGM0dsaEEx?=
 =?utf-8?B?Z2RhSE9yUGpFSHNjU2tseFYzWHZqbUI1M0JKMmxUZG5BTDZMY1ViQ01PN3VP?=
 =?utf-8?B?UUVQSzd3TkNGNlN0ZWx3dnA2dEpaZEtCS0gvOUc0YnZnQlgxY29TUTh1aEFn?=
 =?utf-8?B?cVQ4MnZYVWQzRmJpT2w1UU5ZK0lvVTJtSFpIOEc5bVhCV0dXMG5FMTJ4bHVM?=
 =?utf-8?B?TUxiM0ZwbU13bEZ1Y2U0cXVkb0xsT3pGWkFmdHNVeU80OTllMEJobTJySDZL?=
 =?utf-8?B?enNONWNzc25HaVJQL1VISCtLbUoyUHdpanM4amZCRmFDRW5VZUY3b2RmZ0s1?=
 =?utf-8?B?Ui80Z3dvOUZnS1dhWlVHSjlTWnN6aGY4ZStmcWVMK3d0Z1FlN2QzNHRmdUxr?=
 =?utf-8?B?a0ZJM1l4d21Qd1pHVEJ1eTVtaFZIMkVZdmU2S1dFQ2RTWFdxRGliT0wxOEda?=
 =?utf-8?B?VVQrOTdNLzBic0dUMit3SnRFNkhMcmNJa2RvUE1TZFc4YUNxUFVzZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c73df12-00ab-440b-9dba-08df149afcee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:06:41.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfoEx9EUuOkIiyHH0E5Ix3E377hz59OH4grHffOO43f4tVTFNMK/458TuGpmoiA9sWDpE+Ufn37AeorGcSlOLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

On Mon Sep 14, 2026 at 2:57 PM BST, Danilo Krummrich wrote:
> On Mon Sep 14, 2026 at 3:17 PM CEST, Gary Guo wrote:
>> On Mon Sep 14, 2026 at 1:17 PM BST, Robin Murphy wrote:
>>> On 14/09/2026 11:22 am, Gary Guo wrote:
>>>> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>>>>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>>>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>>>>> It also means that without patch 1, nova-core would split the firm=
ware
>>>>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>>>>> something we want to avoid. The correct fix is to make sure that
>>>>>>>> `dma_set_max_seg_size` is called by the driver, and while we are a=
t it
>>>>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Ide=
ally
>>>>>>>> we would use the type system to make sure that both functions are =
called
>>>>>>>> before any DMA operation can take place (using a safe interface), =
but
>>>>>>>> I'm not quite sure yet how we can do this.
>>>>>>>
>>>>>>> This sounds sensible indeed. Should I open a thread regarding that =
on Zulip?
>>>>>>
>>>>>> Probably not necessary, the mailing-list has a larger audience and i=
s
>>>>>> the right place for this. I expect people will jump in here with the=
ir
>>>>>> thoughts.
>>>>>
>>>>> The problem with those is not that they must strictly be called befor=
e
>>>>> allocating DMA memory, but they must not be called concurrently with =
other DMA
>>>>> operations, such as allocating DMA memory, as it would technically be=
 a data
>>>>> race.
>>>>=20
>>>> Do they really have to be called *before* allocating DMA memory, not d=
o they
>>>> just need not be called *concurrent* to DMA memory allocation?
>>>
>>> Similar to DMA masks, the segment parameters should be set appropriatel=
y=20
>>> before any dma_map_sg() operation. Plus since they likely influence=20
>>> scatterlist geometry, that means typically they're also going to need t=
o=20
>>> be set before building the scatterlist to be mapped in the first place.
>>
>> Right, in that case I think we have the following options:
>>
>> 1.  Have setters these being unsafe, with precondition that they must be=
 done
>>     before creation of DMA mappings.
>
> As mentioned, I don't think the safety requirement has to be before using=
 other
> DMA APIs, but just requiring to not do it concurrently. Not doing it woul=
d be a
> semantic bug, but it shouldn't have any safety implications.

Agreed on the safety requirement; but Robin's reply does suggest that we
really have no reason to not go the extra step and require these
parameters to be set before any DMA op takes place. Which is honestly
the answer I was hoping for as it makes things much simpler (see below).

>
>> 2.  Have a `dma_info()` method like Danilo mentioned. However, we cannot=
 expose
>>     `&Device<Core<'_>>` inside such callbacks, because otherwise driver =
would be
>>     able create DMA mappings. This however is too restrictive to be the =
only way
>>     of setting DMA masks, because Nova needs to access the bar before se=
tting the
>>     DMA masks.
>
> Just to clarify, I mentioned this to be something we could do in addition=
 to (1)
> for drivers where those values are statically known.
>
>> 3.  Use wrapper type instead of generics for typestate. Then, we can exp=
ress the
>>     pattern of typestate transformation (generics cannot do this because=
 we
>>     always place it behind a reference).
>>
>>     For example, we can have `Device` to mean `Device<Normal>`, and then=
 have
>>     `Bound<Device>` to mean `Device<Bound>` (both of which are behind a =
shared
>>     reference, like today, and `Bound<D>` can deref to `&D`).
>>
>>     Then, for `Core` typestate, we can instead have
>>
>>         struct Core<'a, D>(&'a Bound<Device>);
>>
>>     where it's passed by value. We can then define the DMA setters metho=
ds to
>>     operate on `Core` like we did today, but safely. Instead of providin=
g a
>>     `Deref` impl that turns `&Core<'_, D>` to `&Bound<D>`, we only imple=
ment
>>     forwarding functions for APIs that can work without DMA configured (=
e.g. PCI
>>     bar).
>>
>>     Then, provide a `into_bound()` method which *consumes* `Core<'a, D>`=
 and
>>     give out `&'a Bound<Device>` (this is why typestate generics cannot =
work,
>>     because `&'a Device<Core<'_>>` is Copy and we cannot represent the o=
wnership
>>     consumption).
>
> Yeah, we had this discussion in the past with similar ideas; it is the ki=
nd of
> complication that we concluded not to be worth it and that I mentioned in=
 my
> initial reply.

How about this:=20

  fn probe<'bound>(
      pdev: &'bound pci::Device<Core<'_>>,
      dma: dma::Setup<'bound>,
      _info: Option<&'bound Self::IdInfo>,
  ) -> ...

`dma::Setup` is a token carrying the DMA capability. You turn it into a
`dma::Handle<'bound>` by acknowledging the DMA masks and segment
parameters using setters and a `finish` method. Then all DMA operations
are performed on that `dma::Handle`. This proves the DMA setup has been
performed before any operation takes place.

It doesn't complicate `Device` any further, and drivers that don't need
DMA can just drop the token and don't need to think about it anymore.

The DMA token is not opened from the `Device` because it needs to be
unique, so this adds one extra argument to probe, but this removes the
need to use `unsafe` while strictly enforcing the ordering (and staying
trivial to use).
