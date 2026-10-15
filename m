Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0076CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F3310E3F8;
	Thu, 15 Oct 2026 12:50:16 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E858D10E3F8;
 Thu, 15 Oct 2026 12:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJAl3Db5AdQ6kc3uZ978X8P8DEzYcmNxUp/+boWqAqixRumpG5jlpaK9Dh53wTOql7EVsQI6oftG+PrrN8ftpP34qIiq5ZNmOmqU+KkIK0a+fxiAY3iydlABkdEIhkFVQWAREqCe/UYhK7ylbVZXa2FwfaZbUVsr3eryvdVJpxDb4eKx6EzNFkT7aj/Ck8dqeEhoSI1e5vYgAEyZwwSEWO17jd/tr+upH5obKx0XYL8nfLdwGrPztDMQCxHCl6cOYyy2aJslnsMZnOlUG357e0poezO94PyKEmvSZeSoOrJ9NCszok2RwrFOPdXsQ6DFZiBAZqvDrgmMkDmG0MUyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyLbfZJaF+b4DEQKf6VxcWquykG3D0VNP4Bj3lRi8oM=;
 b=i2hHRk8fZHC2P7wP0aEa/dLOIxXMjx5RDUaQ/UaYt80LnUkZr5/nqwwMov/6qMwd4URQIaV4HRK/qzUq6iSIE1SwtQQjw4mvTLdvE35feCY74Dca/iJgAuqth27wkHiX2L9XXA/oakcNDSqt4myQtw48Q6Ehzgbrn2Y1LPM2FBGVdJs/mS5zGxgv/Bs27FIaeG34qPanC+uy06kFXVMg6yoEmvUPY3Ik6ln6h1WCdwDh4LVgt4WpFn0rXLOrg9Mzyqhi03m5CP43zW6URc4xtqtMbpo5ID5zZ7vl6Ua6toZz4+JrOFHpzJYp39UmV4Dpll39fvXIjn5HiXztxok0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyLbfZJaF+b4DEQKf6VxcWquykG3D0VNP4Bj3lRi8oM=;
 b=eGoBQfoxD6N21RbnyXVl5XqnyXlbS8NEs8kxoH7uhdPU4QFI0SfcZSWbHI5jclNItdCz2BSwyBMF8rB9vzKUxJs4+IVCWnOlvrmZ9PAYDAFp9ErBdxYzfiKT5orLEkO3oi9N02k1Y7H+ZVKiXMjkJWFE2373qqNuOjS5hGCnDvAFZCd3dhubV84XG+7C5HNlvOLzOxcJiwM20E/VmcKEdt/rRvxi5yLIbFA7U7nO4DBOIdGCv859mABrjOv/V8SCJ25HmGl+hWUejLJAGSUNmYP1icW0ZTWguOBSFuBpOU5l6Vi0ezzhyKRJjeo2dGLwx/bD9Cq/1Bv9MsYG4si0hQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Thu, 15 Oct 2026 12:50:02 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 12:50:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 21:49:59 +0900
Message-Id: <DM5FAT7JWWZP.24VCIV1SXFQM2@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
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
Subject: Re: [PATCH v3 7/8] gpu: nova-core: add NVKV typed decoding
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
 <DLYE7QGIIJ66.3SKOCYO9GAMCA@nvidia.com>
In-Reply-To: <DLYE7QGIIJ66.3SKOCYO9GAMCA@nvidia.com>
X-ClientProxiedBy: TY4P286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2397d0-6ea9-4265-25a3-08df2abad413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|10070799003|1800799024|23010399003|261009223027099003|56012099006|4143699003|11063799006|260925021311599003|260925021911599003|10067099003|18002099003|22082099003|10063799003|260925022911599003|3023799007;
X-Microsoft-Antispam-Message-Info: t/4D/66dEexJNvxdy6S3w5Rs78DYL7Qs+ortEuy+EtqWKz0WogjVV+Z/ssXSgYPNlSRv3uKgEyxtPUkdOO+XFAyVqKhOEfZNwXMiXLX6HanST/J2sym0smTD2wAdAXt1hgkpP5NubnSu9n6z5TJaDI4cJWRI/Yqt0pduv9tv9Bol7g7bzBWJtqnoXzCukkFahd5P9VpG2RPv+fbcqoCozQqciFqHy7IseVtKtrNSdkppEzulKDZsW5kGswWg9h0ocCs7EFTOaADwmUyo+7zHvsEgk1sKLNW0a20noDw8qbX40HeypGmWRl2q6XSOR1feerFZXbTDY9OW56sPYtkH2DtIOw2CDfidMW7oiEFoyB+zbqJ8H5DXSAwDud1djDm/eSLwQtyVstj7Hkr3r8nWSA6ZHtQmUuvxSqxk7W8WyCALIjJwM2pnL7T8nqkN47oUt++ZD3yTiAZaslYEjwheoffcCLjw6wEYjizi5fYm6J27VjpZHQ8SH3UWehJMc00yI3+20E0gso7nsdLvi4/3R6whbzYCr35UyR4ZSR5jd79RbjIfXOTUXQdOt3hAOHyIqyCg9ACAZ8tywiU5C3/gFheSqkdwQHJsx+nfxFj1QLoMygzJyTFo1K5zdGthlFP05VIT+d+azPluScVzZYVT7SFuC1oDA6S8XFuyBvaH5Xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(260925021311599003)(260925021911599003)(10067099003)(18002099003)(22082099003)(10063799003)(260925022911599003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZ2OXBGUTg4VFR3NFpvM0hldnJucXIwWlJRZ28vcFhLalZWNTIvRHpyV3hK?=
 =?utf-8?B?NTZGNzBKK1VTV0Z5dWxPNE1ZdVdxTkJBaUl1VTA1MHJCZ2hoYnYwc2dVcFlI?=
 =?utf-8?B?QnJ3b2g3RnpJZVZIaWUrMmJmZHpBdm9pYVdiNHB0bmNmNUNzVTFoVUlNSEZ4?=
 =?utf-8?B?R3hWQUNxeFdFTzlKTlVXNVJDSWlKV1RodExaVG12RXNuWkRzZUh5UUFIYzZs?=
 =?utf-8?B?dUxYMFNrY2ZzaXJpaEdzQytwbjdVUjdld0dMOFF2L1QyTTlaUUNLMGo3eGI2?=
 =?utf-8?B?eGVyYi96bGNnSFc1ZDVqdXNQQ1VUYTlMMGd6U1RBbkVOR3k0R1lmbTJtbEov?=
 =?utf-8?B?SWdNVDZCNldWSVl3dEJ1VGdPZGh3TmN3RHdETzdGUGtENzF2bU9nVXpsM2hq?=
 =?utf-8?B?TUpJcnpLbTJXTTNvQW5UOTdvRmd0V05qcDdTdTNENGYyZjY3bkRUOXdtUmhR?=
 =?utf-8?B?K3h1NHlreTA0MkNaWnlaNnBTZXgyQ2NJemNLNUtlbG8rYlZmQkVPalE2UFdF?=
 =?utf-8?B?dnY1NlB0QUdDL1BwR21BVmk0SXlVMEtqbzFwdWcxYXVISExXNk9qbVV0ZjFS?=
 =?utf-8?B?WWVqNk5qU1dkRDZKaW95eGE1L3AvK1NrajZ5VEZDTzAyM3kxUnNRa3JEeVdT?=
 =?utf-8?B?UVJMbU1mWHpBSHptVkIyTVJWU3J4K2RQMysyWngveVhEZmw0cjNYZjBZaFBp?=
 =?utf-8?B?a3ZyR3RXOFNzUm9LNGo5REZDeXNrVEVReGlrZi9VK2V4SGVlMU5OY1MwRHY2?=
 =?utf-8?B?THJjM0dmT3RLQ1h2UE4xVmtmNGloTWhRNmI0NmhHUENyaGVWcVlXUnhkcjJt?=
 =?utf-8?B?N3NXQVJoT0RYZ21yV08rTUxYa3NYYlNtc3ZLK3czd1FNK3ZyRmtXc0U3MUtl?=
 =?utf-8?B?ZTVaYkJ6K3VUMzM3UUhXbVB1bnIwdnlyUzNCRUMwUExOZ2pWNVZlYU5BeHMw?=
 =?utf-8?B?NHZqdllISnBiSXhra2hWV3RFYXNhWnc3VGg1MVJuaVBaY2FPcWZPM0pjMjB2?=
 =?utf-8?B?NGVjYm9sSjZ6b2M1enVLWXVzOHVuWjAwaHhCS2gzY0p6YTNyNS9uWHR2V0xh?=
 =?utf-8?B?VWl4d2hPNFlVUlhkekswWWY5SjFEamF6QitTSGRaOVU4aHlRZmdNL3Zudm1a?=
 =?utf-8?B?ZnRWV1hTT216aXphZE9CNDVRazd1dkhDRGxpeWNYcnA4UzdCUU40N2ZzaHQv?=
 =?utf-8?B?ekRNbmVVZzJIbERIT0R0TGp3dWJaVHdadUZvUU9RNzRsSVk5by83djJDSlpX?=
 =?utf-8?B?MGMrK3FZUk5QYTlRb0k0d3oxREd1UmExdVNvZ0tDRUxFQWdCLzhqc29kdGtx?=
 =?utf-8?B?eXF2eUppcE5GaUVYTXUvb01nZVhqRnVicjVvQkpmM0QybnBqSkRyckhBKysv?=
 =?utf-8?B?UjVhRzVkbGFtYnpSQjgyNlVsREUxOU5leWIwT20wdTAzSVdDK0NzSXppRCtY?=
 =?utf-8?B?dThQRWxwcmk0NS9VbE42b2JwQksxREZqdXpRY2gva2FMem9oc0dEWnJaOUEz?=
 =?utf-8?B?NGN0bEFPVHErdkVOMkQxVm5OSVhuaTZWWmZ4WWhpME1WYTNTVXRRckZ2eWhl?=
 =?utf-8?B?UUxxUlJBMzBRVUNQUFVSYlNmcjdvQzVyRTBlbis1RGJzRmVEY3c5dFgrVVV1?=
 =?utf-8?B?bFgyRU1wVENsZkJHWXNTTEorVnlJa0NLNzRiQzhDSU9Sby9RMkU5c2d3MTNo?=
 =?utf-8?B?cVI4QkgrNnNFUzFzK1VhU1FsQkxmdDc1czZLM2prN1hTREhCZjgvTFd6Y3l2?=
 =?utf-8?B?N0VGMjJ1bFRvWDlzaUN0RTN4elpGOVJjWDJ2cTFIbTBFL2ZDN0Ixcm82NzlW?=
 =?utf-8?B?TjJrWDFvaE94eGprOHdtckxNWDB1SmxhZG55d1lrZldYVWlaRjlhTXN5Nmtz?=
 =?utf-8?B?NHpQdGJsKzQ5VU5jaUFkTzVVa0lTSHBxMUVwTVVOa2ZWSFA0QmhMS09nb2VL?=
 =?utf-8?B?elp0VDlrTDhhM1FBd1FCN2NCYTlDbUIyd0k5UWNvWFBUY3VpWU9PbFhvQ1lj?=
 =?utf-8?B?UHlQNXh1VDNhTURkcDVlZGxhaThiWXZ5dUY3MG1CMENxUHowaU0xMWZtNloy?=
 =?utf-8?B?RmV2d2o5aE1JdVZtTnhmd1dSdExDaXNGdDc5aElLRVNIM2UyM2ZQNFdweDdn?=
 =?utf-8?B?M0Vab0NueXRIclBudmFyalM2c1BWajVDZ3Q0OXlnL0tLSS9CYStWSnhpRkd3?=
 =?utf-8?B?emc3SDkvZ2VUNzRocVNFY203TW9mbUlKbG92TGNZd2hzTE94bFNDMmswbGVo?=
 =?utf-8?B?ZjFNanU5bU9XcExOOXFSS2w3T1Z6bm8xTlloN25rM05tZjVoVU1oUzUyMm41?=
 =?utf-8?B?Y3RCTFo4UXI2L0NTVXp5Q0pGeVVFbDc5b3VtbWJVblJrS0pZMGdyTDI1TDZu?=
 =?utf-8?Q?10gnO/58S2URu0WbCTYv6BdhwMi7I2L5jEBbjsRTjfYz8?=
X-MS-Exchange-AntiSpam-MessageData-1: Dyu1I6FkhIyN5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2397d0-6ea9-4265-25a3-08df2abad413
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:50:02.2402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA4LCbigtWCF9fz/dsHK6TXIa+8vfMFiw0wHhvUOTDhShgMfe+l442xed+CjZ0n0NxdH5mlJ7+qbYfi1QlWmkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

On Wed Oct 7, 2026 at 3:30 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>> Similar to the typed encoding layer, add some decoding type machinery.
>> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
>> by composing visit calls to each member. Add some common `Schema` kinds,
>> such as `Array` which collects an array value into a fixed maximum size
>> array, and `Required` which fails a decode if the value is not sent.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  11 +-
>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 622 ++++++++++++++++++++++++=
++++++-
>>  2 files changed, 628 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/g=
sp/nvkv.rs
>> index 7ac3a459a98b..5791df07a7fa 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>> @@ -9,7 +9,7 @@
>>  //! function calls will map to some struct - for example, f(GPU_NAME_ST=
RING_KEY, 0, b"some gpu")
>>  //! naturally maps to storing a &str with the GPU name.
>> =20
>> -#![expect(unused_imports)]
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
>>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>> =20
>>  use core::{
>> @@ -23,7 +23,8 @@
>>  use kernel::{
>>      alloc::{
>>          allocator::KVmalloc,
>> -        Allocator, //
>> +        Allocator,
>> +        ArrayVec, //
>>      },
>>      bitfield,
>>      num::Bounded,
>> @@ -148,6 +149,12 @@ fn default() -> Self {
>>      }
>>  }
>> =20
>> +/// A schema field for an array value under the NVKV key `KEY_ID`.
>> +#[repr(transparent)]
>> +pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID=
: KeyId> {
>> +    vec: ArrayVec<T, N>,
>> +}
>
> I still don't see why this needs to be declared in this module when no
> encoder element ever uses it, and the module reexports everything from
> `decode` anyway. Can this be moved next to the other schema kinds?

This will be used soon [1] for encoding. The convention I have been
using is if a type is used for both encoding and decoding, I put it in
nvkv.rs (since it doesn't fit obviously in either - the
encoding/decoding related impls can go in there though). If we put
IndexedKey in nvkv.rs as pub crate since we'll use it soon, it's
consistent to keep Array here as well. WDYT?

[1]: https://lore.kernel.org/all/473ff4cbabf401357934a611c0310499130d9efe.1=
790580105.git.zhiw@nvidia.com/

>
>> +
>>  bitfield! {
>>      /// The op word that starts each NVKV operation.
>>      struct Op(u64) {
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova=
-core/gsp/nvkv/decode.rs
>> index c4c24fe1108e..24dad31296cb 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>> @@ -3,11 +3,22 @@
>> =20
>>  #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>> =20
>> -use kernel::prelude::*;
>> +use core::{
>> +    convert::Infallible,
>> +    marker::PhantomData, //
>> +};
>> +
>> +use kernel::{
>> +    alloc::ArrayVec,
>> +    prelude::*, //
>> +};
>> +use pin_init::init_array_from_fn;
>> =20
>>  use crate::{
>>      gsp::nvkv::{
>> +        Array,
>>          Index,
>> +        Key,
>>          KeyId,
>>          Op,
>>          Opcode, //
>> @@ -15,6 +26,353 @@
>>      num, //
>>  };
>> =20
>> +/// Defines a schema struct together with its [`Schema`] and [`Visit`] =
implementations that decode
>> +/// into `$target`.
>> +///
>> +/// Each member of the struct should implement [`Schema`] and [`Visit`]=
. For every (key, index,
>> +/// value) triple decoded from the NVKV stream, the generated parent `V=
isit` implementation will
>
> nit: let's put backticks around (key, index, value) and link to `Visit`
> (and other types mentioned in this doccomment, and possibly elsewhere in
> this patch).

Done (here and other locations).

>
> <...>
>> +/// A schema field for a key that must be present.
>> +///
>> +/// `finish` fails with `EINVAL` if no value arrived for the key.
>> +#[repr(transparent)]
>> +pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_I=
D>);
>
> I just noticed that the schema field types are conflating several
> concepts together. On the one hand, you have types associating a key to
> some kind of storage (Key, Array, Indexed - let's call these leaf
> types), and on the other what looks like modifiers on said leaf types
> (Accumulated).
>
> Which leaves `Required` somewhere in between, as it takes a key
> parameter and can only be applied to value types, i.e. you currently
> cannot have a `Required<Array<...>>`. But `Accumulated<Array<...>>` does
> work IIUC.
>
> So I think `Required` should work the same way as `Accumulated`, i.e.
> just wrap it around the type you want to make required, instead of
> switching the leaf type.
>
> And for symmetry, we should also have an `Optional` wrapper type, so we
> can also make fields optional even if they are not `Key`s instead of
> having specific behavior for `Key<Option>` (which again is not
> composable).
>
> Which would give us 3 leaf types (Key, Array, Indexed) and 3 modifiers
> (Required, Optional, Accumulated), with a non-wrapped leaf meaning
> "default if unspecified" - which is easier to understand than the
> current types where `Required` is a synonym for "a `Key` except it's
> required".
>
> This means `Required` would then be used like `Required<Key<...>>`,
> which is a bit more verbose, but again nicer to read.

Yerp I think that is fine. I originally did it this way to avoid the
verbosity you mention ("Required<Key...>") and to avoid needing Default
implementations, but I'm fine with that version too. Let me update it.

>
> <...>
>>  /// A decoded NVKV value.
>>  #[derive(Copy, Clone, Debug, PartialEq, Eq)]
>>  pub(crate) enum DecoderValue<'a> {
>> @@ -51,7 +409,16 @@ fn try_from(value: DecoderValue<'a>) -> Result<Self>=
 {
>>  impl_try_from_decoder_value!(&'a [u32], Array32);
>>  impl_try_from_decoder_value!(&'a [u64], Array64);
>> =20
>> -/// A visitor that consumes decoded NVKV and produces a `Target`.
>
> Why change this doccomment? Let's introduce its final form in patch 5.

Thanks for spotting, think I did not absorb the change into the correct
commit.

>
>> +/// Lets `Key<Option<T>, KEY_ID>` accept whatever `Key<T, KEY_ID>` acce=
pts.
>> +impl<'a, T: TryFrom<DecoderValue<'a>, Error =3D Error>> TryFrom<Decoder=
Value<'a>> for Option<T> {
>> +    type Error =3D Error;
>> +
>> +    fn try_from(value: DecoderValue<'a>) -> Result<Self> {
>> +        T::try_from(value).map(Some)
>> +    }
>> +}
>
> IIUC this block could go away if we add an `Optional` wrapper suggested
> above.

Think this is ok, one issue with `Optional` is that it's currently not
possible to pin_init (or init) an Option without materializing the value
that goes in there on the stack. It's an issue either way though but the
`TryFrom<DecoderValue>` limits it to small values (refs or small integer
types). Anyway, I think we can just add another assert on the size for
now, so SGTM.

>
>> +
>> +/// The state of one NVKV decode operation which produces a target valu=
e `Target`.
>>  pub(crate) trait Schema {
>>      type Target;
>> =20
>> @@ -65,7 +432,12 @@ fn init() -> impl Init<Self>
>> =20
>>      /// Returns an initializer that makes the decoded `Target`.
>>      ///
>> -    /// After the returned initializer runs, the schema should be empty=
 again.
>> +    /// After the returned initializer runs successfully, the schema mu=
st be empty again. For
>> +    /// example, this is required by [`Accumulated`] which finishes one=
 object and then decodes the
>> +    /// next one with the same schema. Implementations generated by `nv=
kv_decode!` meet this
>> +    /// requirement. If the initializer fails, the `Schema` can be in a=
 valid but non-fresh state.
>> +    /// Taking `self` instead of `&mut self` would avoid this contract,=
 but it forces a copy of the
>> +    /// schema onto the stack.
>
> Let's not cite specific implementations in the doccomment of a trait. We
> want to say that the schema *must* be empty (as opposed to "should")
> from patch 5, and that should be clear enough and sufficient. I'd also
> move the last sentence to patch 5, and drop the rest.

Done

[...]
>> +        assert_eq!(decoded.slots, [10, 20, 30, 40]);
>> +
>> +        Ok(())
>> +    }
>> +
>> +    // Tests that a schema too large for the stack decodes on the heap.
>
> How are we testing this? Do we expect the stack to explode as a test
> failure? That should be guaranteed by the use of `KBox` and `init`, so I
> am not sure there is much to test here...
>
> But if you decide to keep it, let's at least size the schema so the
> stack *actually* explodes: 2KB is not enough, we want at least 16KB, and
> for good measure let's go with at least 128KB to be sure. Otherwise I
> think it's fine to drop this test.

Happy to drop this test.
