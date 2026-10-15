Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACE4CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E960410EBB3;
	Thu, 15 Oct 2026 13:13:04 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA62810EBB0;
 Thu, 15 Oct 2026 13:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgoE0z3VjRCeb5bLugttJNWVKOwZwJSbHLORzTMe4tCTXSbf2CNRGTXlFH9p5XRlqRyocePRV2G8kEUhXzLjKNQJmT++yUKMWs74gGajoAlPA9EzuBt7LQmFkSwnQw7M7p3G8DMcR/FNCfVzKqn0yEmZESSugTzEmhiX18dshyBoXfpVbDEj8D4zHlmnH/Z8pee1Q/dvIzosHR51SlSxtAQX6sSdpbkoyZ5gsoNEL37/i8h0DEebyDau9Y/xwMpTgIDDqOsG/NlDp0quUi/g7r7azQpDZpF72P0qdfKyss1HP1UbFlWcOpgO1PPpyV4Bvv1SalH0dNiwmnejWrLK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKzsa35wDQdjaDhPYB9e0+cReloKInLbVsPuv3Qf8k4=;
 b=t3uhl6AikB2yHm31aiDKy+9Vqj+lx26mozyEZQfdtCSPY9FNOMsHGCYbeTNGo60lPsjpExcxVueRCsnC55TqNh/nkKtQ+WRK5mS4aAuLRaFBFxJ8hhAIyzgfKRq7dSCUpq7+bFTU1rrSIwiXgYNfU+TYbtaflzJ36IU6apvMYHZSIH+bQteJiVTPKCL7DeW3dnaqOJ+L+2v4rUuhSMs6u7xKmdwziMNg6nkJ+kvCXGilllpJS94qpSqL0MxiSJ0lTqJHZhLsuEfSo/aHT6Azy7G0XyhcYLj1riq/QJDdKtZl2chitxSjwILg+RhQL7RAMmzlEEgeEiLX1k8vX3SykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKzsa35wDQdjaDhPYB9e0+cReloKInLbVsPuv3Qf8k4=;
 b=UebwsmDBINwFyCMRgytj2bQmEFHR1r2JoVt7laD42XYsOMYkjwkedsd4iXfu4DWEZs0DAC2Q9L/WOPBkZJTOAyp3X5ajMS7+IR6s2nsJVdiuvgv/WrAR8qdJDXifuF5NMcaVIXXkLpsqg/T7vJsHQP8V6GiQOZhL0e8g4CrgfMJDJRrpgKV08UzMMiQfXhjGYWXvTi8L6ih2UAXkOcMnft4E28VqOUS2zjCwGzmjaUX3mfyyZJu8wHKZQth1WbiqMe3AaZnVABpgG4nckeEhZlzZ3jGo3R+N1zS46y1bUc8y67eyvmAjcvmLA2DlCx5c5Ta+PewtOKu9uS0lJjV8xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:12:52 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 13:12:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 22:12:48 +0900
Message-Id: <DM5FSADEZ25P.35QGZD4HBK81J@nvidia.com>
Subject: Re: [PATCH v3 7/8] gpu: nova-core: add NVKV typed decoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
 <DLYE7QGIIJ66.3SKOCYO9GAMCA@nvidia.com>
 <DM5FAT7JWWZP.24VCIV1SXFQM2@nvidia.com>
In-Reply-To: <DM5FAT7JWWZP.24VCIV1SXFQM2@nvidia.com>
X-ClientProxiedBy: TY4P301CA0124.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: e11545ed-282b-439f-a778-08df2abe0475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|7416014|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: AvXIhbC9ZbUp7TbnD/cA+QNjEQVTSZKf8ojmFam8xOZaDcDhyAbCgb1krTKm4yWK7FasPZv1uO920L5CcF7KvrcgQoKrxvC3eschd9ulB+JxwyBFPhA+qCDDaDy5064t0tSB7wshZt6Eb53Ef05vapBXzqit/gMxn8G6or2p3MQiQtEZhNtTITZT79VLvnLxLLJZMi1ERFYbREy8Z+366RiWAos8Hv/RV/Eh+Mfw9h3I2RYX1EPQR8dnEsmTU8/VQYsPTZeNfeXOn0CcPPFIQ0Bq0CDzSsljo9LFyJvseI0l4oxhpXiN9BpFjgJZe92wWtsuD9dIvrgW3HrzQe2+4+NgGt4+xxevNVF9550EKEK2OhRyWgEElMcfgZh/Y7DLesbv7Fnkm7eWzzBVP30lkIQntZHdjoWpWqEFzw85JWEeg+Jj2t6lLuUxvZ2uzCPnv5kxaJKOhMuH+hE+1A28fWTkozfeOTM1pWFBC9QpqhHVWmioub/s8mD+MUyBU7hLTHsi9DySs93fp6+LiuiYImkaQStPKYrh1B+gJreJL8WpXrgGpZBA1TScwlvqf3M1YUNscIFWRN7c2sfMVmvHWavy+raqmryTMDVLLU2dgjFC1+RDrCi1dS5zWiF2VjDSu7H53kgWMxyNypCquvb/gPEfDFFJkXXP7M8RWjfegCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(7416014)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1dwdk9oYStYUW12QnlxaGk3OW9ZdUhjUXZRdXMwcGtOVDVRMGFhOGg5dDBI?=
 =?utf-8?B?U0JaOUhMSUQvRi9PdEFFUEZoelE2ZGtRYi9iUy9UOVZLNE83MS9CM0pYSFc0?=
 =?utf-8?B?R0tWbGFpbDNLdFdhOXBZNGxhSXRDc1FLT3JHNktFYUdzT0F4WS9UTDhlbkI3?=
 =?utf-8?B?enVHOXh3UEFrbEhvUm1JeUdVZmpTaUFJd01LUFpXRVhMazhuN0hCcjc1bUV6?=
 =?utf-8?B?VUpFTWh4NmhsUVBIQm5TNjlVV3ZrcXJtS0lSQktRNWZiTUZhZXgrdUZ2RjRX?=
 =?utf-8?B?ZUorUktkNnZVd1VmQldQcFk4N3pLU0JPLytFVTVJV1RjTHZndTlMMVdpcUQ5?=
 =?utf-8?B?U3ZDMk12TVFOQTFySEVDcTV2MFlzUGZ5MGlEWEcvU01HS0xENTVsREo4Z3dT?=
 =?utf-8?B?a2hJZjhXUTRXY0ZDT0FnUjRGOHNCVWcvRHZyRnNpSG0reTJ4MzVRZ2FuZVYy?=
 =?utf-8?B?b050Tjl4aUY1RzFYLzYzaWFqTThhZ0dCRVFDMVBwWHFoWGh6UW96UmJ3UWJu?=
 =?utf-8?B?L2tzTU4rc1NBcVJOU2lWMXVtdndXR0F5cmRrM1RHdDRQS2c3eXFIdGIxSTFq?=
 =?utf-8?B?N21jY0R4TkZROTFzYmR6eEhMTFBtbCtDQkg0TjR5cGhYakcrektzaElqS3dV?=
 =?utf-8?B?QlRBalpWZyttTE5UQUhvclVTZEx5RkFBYjVQcnlSZkN4K011OVE4OVdvNytP?=
 =?utf-8?B?Q3YvT1FQZ2EzcG9sZlhjaHNjbStjMmNKMDkzTWZKTk1xWVRiNWtoT25Fa05l?=
 =?utf-8?B?enp6K212c2lueUJmSURmYURCK0N0SERqRkNzc0xUMlFNQjhRUXMyNVkwVXU4?=
 =?utf-8?B?R0MxN1pyREFJdWFPWW5QS2NxREFESHl2eTZSVzFUbGRsNFBVaFIwb053aTI1?=
 =?utf-8?B?Yi9JeXZSR1BMdWhCWkE5ODFGYXpZL2hDRkcxejAwT1RxQ01qSHRHNjg5SS83?=
 =?utf-8?B?UXBGemlrSjdMYkhLM0VmWEhzWG9FMko2WWhQZWpUb1NtMDZGRUw3YUF2SkxW?=
 =?utf-8?B?dVcvcDNUUURVUTJ6YS9PeWw2LzVBYUFxeEYveGJ1ZjFtbXd2YnRtdUNlTHJl?=
 =?utf-8?B?VzFSWlhubld6UUVYN3RjUDVidUpVS1VrZW02bUxQZEh2ZXZrNkVQclA1ajdr?=
 =?utf-8?B?amdYODR2NUNtTU0wUmNEbUVoTm9OdTk4YUY5RmI0RElHYmpuTjg4cnBlLzZ0?=
 =?utf-8?B?TnkxQUorZ3VIV09FODlTN2lIbVo5amVOY0JpeXd6aWJIYkJBNzdldzkyMGYz?=
 =?utf-8?B?bHlHM3ltbHYxcCtLTi9Ccmo3VXZEQzJIcmh6V2dJcXpyYk9LZGtCT2RMb2Ex?=
 =?utf-8?B?TStaMHh0ajIraTBJWlFsbm9oNHEvSmloaWUwOUw5NkpXdkg2OUUvaDlQUE1o?=
 =?utf-8?B?ODMyTllvVGZRN2RVRGVGU0RqUW94NEo5cmp4T3RVekh0MW9IQzUrNEdsamlr?=
 =?utf-8?B?TWhCU1hCWE5KaGNualRZMGQ5dU50OHNtTTdoTXVnRFdhSlJpcXVhcTQvUDFW?=
 =?utf-8?B?TjBPWE9RVkNnMmd3dllmbUxsMW5QZkk2NU5xOG1ZMmZQYUwvVHZtdTlEMUZw?=
 =?utf-8?B?V0NrOFFKN2ZEcGdBeFhESlcvSXNjUEk3ZVkxbXFHRUJsVkJOU0c1RC9HSXRE?=
 =?utf-8?B?cGxiSmVZUEpkTXpGS0x6a3FVRXEwOGkzd29UclJndkc5aHZMay8zMUxaL0w0?=
 =?utf-8?B?OEM4RlRHNEkzSlpnUHJrK0RvRk9XdkE2WjJHREU1aVpMTjhseVZBVmJQVXJF?=
 =?utf-8?B?MEo0Mlg3c0ZabEV0UHJWbnlvaGU0S0pKSnpzelMwdGo0NldzTmhKZDg0c0hx?=
 =?utf-8?B?amNwQVRoTEhxSVMybUxySzNqODdpdXhYaEpENHBCcTNwTGQ0S0dkK3AyZ2R5?=
 =?utf-8?B?dHJ0SmU2SC8xa1ljTXc0RW4wbFdGNTlna2o2RzV5OGhicG1MRGtzUzFRUWNl?=
 =?utf-8?B?dkJ6eXNKeWJ3R3d3S1RaNjk3Z2JDQzFzWFF5Vk45TGY2eVVFSzN2eko3Z04r?=
 =?utf-8?B?SDcvejlvMWNGMEtiYU9LQXFhbkJpOXErQ0FWMHBkQWhRVlhObHZHcDJqYzRK?=
 =?utf-8?B?Uldwb05TOC9UQ0xZNDBGV2h0cnE2eUVzSEo5QXdBYXNLQjViR2dBMVluZkgr?=
 =?utf-8?B?ekNRVS9hcWJpTkgxMXRaWEFXNkJlVzd0MHVydmhJMkpIUVEyYm0rbTNrMDQw?=
 =?utf-8?B?L3ZVNUZ0bUNYNDZad3NvbFIzSmF0Yk05VTh5NGxzc1hxSHlZRTBPbzNTZ29Y?=
 =?utf-8?B?MElQaVd0OVVtRSs0NTk1U0lhd3F0S25kQXo4Ni9XeFFwYXZOYS9VRVhuSm5Y?=
 =?utf-8?B?OG01djVzcUVnRld1UjR2Q052c0JjWDFoc0dOb3N2VUNmQnA4MHNHcHp0NnVY?=
 =?utf-8?Q?H4/Qh5DJ1EGeT/AUsrHMvBg2TZRHWJlgbacWUmDWsjbW6?=
X-MS-Exchange-AntiSpam-MessageData-1: K/rid7gR7W2y2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11545ed-282b-439f-a778-08df2abe0475
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:12:52.0833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPXIZsWpI+mYRsA3fKkNLLKVcriah1S0edZw7i6DCri2B3hbP8D2ZEg5TTdR2shqS5gBgJCy2pyqi21+q8VTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
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

On Thu Oct 15, 2026 at 9:49 PM JST, Eliot Courtney wrote:
> On Wed Oct 7, 2026 at 3:30 PM JST, Alexandre Courbot wrote:
>> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>>> Similar to the typed encoding layer, add some decoding type machinery.
>>> Add a simple macro `nvkv_decode!` which implements `Schema` for a struc=
t
>>> by composing visit calls to each member. Add some common `Schema` kinds=
,
>>> such as `Array` which collects an array value into a fixed maximum size
>>> array, and `Required` which fails a decode if the value is not sent.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  11 +-
>>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 622 +++++++++++++++++++++++=
+++++++-
>>>  2 files changed, 628 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/=
gsp/nvkv.rs
>>> index 7ac3a459a98b..5791df07a7fa 100644
>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>> @@ -9,7 +9,7 @@
>>>  //! function calls will map to some struct - for example, f(GPU_NAME_S=
TRING_KEY, 0, b"some gpu")
>>>  //! naturally maps to storing a &str with the GPU name.
>>> =20
>>> -#![expect(unused_imports)]
>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
>>>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>>> =20
>>>  use core::{
>>> @@ -23,7 +23,8 @@
>>>  use kernel::{
>>>      alloc::{
>>>          allocator::KVmalloc,
>>> -        Allocator, //
>>> +        Allocator,
>>> +        ArrayVec, //
>>>      },
>>>      bitfield,
>>>      num::Bounded,
>>> @@ -148,6 +149,12 @@ fn default() -> Self {
>>>      }
>>>  }
>>> =20
>>> +/// A schema field for an array value under the NVKV key `KEY_ID`.
>>> +#[repr(transparent)]
>>> +pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_I=
D: KeyId> {
>>> +    vec: ArrayVec<T, N>,
>>> +}
>>
>> I still don't see why this needs to be declared in this module when no
>> encoder element ever uses it, and the module reexports everything from
>> `decode` anyway. Can this be moved next to the other schema kinds?
>
> This will be used soon [1] for encoding. The convention I have been
> using is if a type is used for both encoding and decoding, I put it in
> nvkv.rs (since it doesn't fit obviously in either - the
> encoding/decoding related impls can go in there though). If we put
> IndexedKey in nvkv.rs as pub crate since we'll use it soon, it's
> consistent to keep Array here as well. WDYT?

Sure, if encoding is to use it then let's put it in its eventual
destination from the start.
