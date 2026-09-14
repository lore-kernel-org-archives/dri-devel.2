Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A54C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E548A10E07C;
	Mon, 14 Sep 2026 06:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VY9IMFWk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036FD10E07C;
 Mon, 14 Sep 2026 06:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlIcC5HC02vjwIMcSiQSLbn89EFcK4eAj7ZFhZNnjwD/ydtN6/Nf/YR95VwoJAmy18KV+S9cxHULQGzC/8W2rQx/0ttVrOnodDti1QrmjAKiJFSw9S2GiUU6faTEt1DwUEfvr4G8T3GoS39fKqXob3+Yua52DLUznzheKSSSI3bUuV7ZAFLQZDE8NT0vVfZTSyiMkqplRoFp8iCJP2q6ENYXaAIyoLQjQLpq+CTTziWbxq+us/IXvnttL9vuQQf7jOcXIpn4BpPL6oTn+eYI6fjuftd/uuHXxk3/+HvBb/VRF0OhqooWRB2xiQ3/jcGfbW2rYCJK3O/7lo4bhJ0baA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+HXZFOYNmwFgpoQ+BB9TfuGYi+0WHTpit+wd6mTh9M=;
 b=xuvj956afmv7shUHXlXHq39BixDseRgmCSzZv6x7xnzpQyTfkAolWDKh0QWRNwWZK6WIkR/wCgSwrt0aZbXH0Pv40BYtA8Z1czxle1Nyai9plAFhiyNGDGXLv39ZGT3siks2L9bzUF9qyzofjplNfxmLySy88aMYfRVXd/klj8L/zWpX1VXpSnfUByUM5ISv5qpUwUgFu7HsxgGgnhKqrvZcXPa1rkpQZZzF79VnEtOztlMmyeZTyKN0wucBm8RXokxyCe3dVLq0H/tXjW/7rT/UmJWoqyZbKOwiPfiJd4mx2Z9TJqKgQCsYh/ETIzgHleg6gLPvsXQgUz9LZyyqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+HXZFOYNmwFgpoQ+BB9TfuGYi+0WHTpit+wd6mTh9M=;
 b=VY9IMFWkNGmWycJSvJSUYkbXylZTCkwfJ79sjtsN44eCMd1QAnmeJYLEAq4viCCxElFMXm8S6L394PmluJu7bthzIBiuKBJRtE12MyU/HIxQw/TzbHO+kx8KvK2qqwpNVWPo/iHfASvAwqTfdo4eouo9AgZZtfcIZwNnP8XZqeIP1Uoy83vWANYarUT7l7zVglYUlZrnVLEoYtHkSJ6jJ2Ck3kKcw5oypPMXuKdhTShdaPdYsnC/dzBpv6AQ8eIXxpht+xpRb5TJ2PmylaEjbLz3ZCYnD77X1ClS7OYDv/b55GZmB4hQRyO50xAhwZLHcdSZBWlothpas6VO5py9iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 06:55:21 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:55:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 15:55:14 +0900
Message-Id: <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
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
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
In-Reply-To: <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
X-ClientProxiedBy: PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b345b4-d374-4d49-81cd-08df122d24b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|1800799024|7416014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|10063799003|3023799007;
X-Microsoft-Antispam-Message-Info: BrOQs4+5ghXXacYW9g6nKZe4IB+5a8bAUIIjCZIlwmFYbS/Z2A9b33qBepLQwLeQJUAV8BgRA9Dq48KRis9cOmn6mIQCXQgXtkHCok6tTpnhlwEvj2XclHGMAnFBSvTSfSmumv3WVNeGJYcIdZ588uSeA6Bl64fojb9IpiY4TqmTbPVFfkdLUFRpFjWt+6vtAXL2f1U1lHFqfPUZDWWjVTFM6QA9XC63a3zz6FgBM0yaqkxn5FfCDJOzmD6WM0CwnMhWpEKIjuwLCuKKEg8nzn4xXg5UBmf/rt//Vcp4RMWN9WnvriTHGalCB7KzcUM5naSvxRU3M35kReW/b5mx7x1+C6weZ0l3QzF7llUb/L8Gt4rdm5lJE3IqiFNCaxpW+sMbkvtX3Ms8GtVSAPH4ar4mFJD3bTdMYnZQFBEhCuBh5BSTkQ0Pw6Os5siQ3joRnDeEiwOOLtAb62n1mBGnrJb+FQVZ4rQief775gLa+uc8uWRO6mbYxb99vMGb0muLJA+Y6pSF0Or3ZyPF9Dl58ccG0yElYxetKtyivQS5YrBIyHSZir4TI4Vr8Nwd3znlJTvRWRfbO/llvAoN+XO91GX5GnjKI2oa9qHgqcsPYVHHHR8OZY7IVQNS7maATRdhHUWt/OqPfsN9VO8y6UaeHlnTc7sFvpRKsrVoNGVGJMc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(10063799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdxN2V1RkUrUTZ3ZGM0UlY4T1V6ekNlSTkxR2VUTTFkS0Zoek1xdGVlcHZx?=
 =?utf-8?B?dEh6TmVOcTI5aWhiZE5jcEdKV2dKMEx3MkpCSWM3UVJaam9CTVZldmovM0tN?=
 =?utf-8?B?Qk9HcWtmemo3bGQxeEVhY2NrMmRDTDV0QmV5RkRQZUxaU1BVam1iNVVBb21R?=
 =?utf-8?B?OGZRSFZuQy9RbVUwWWhJdThTZFByWTY1YXZsTXBvbm5vTGRFV2ZPMGt5b0Ez?=
 =?utf-8?B?OGN1SXc3UzVOQXdBM1ZCT1dLVDNkblI4TTVabmRRaVlxbG90RmJzSWt3RlJI?=
 =?utf-8?B?MTFPVUxQU2MyTzhUMDR5K2U4TkNqT2xjYmJOUkNjNmRVOFpBWlc1WVdQT05F?=
 =?utf-8?B?RERLalo3MWNJZ3JVUmJDNjAvNUVZZDlYd1d6REZ4dEQ3c2xTVDk2d2IvRUJj?=
 =?utf-8?B?eFdrazBVV3lFZHk2Q1daeERYMFF3SXVkaWxybGw2dUQvUGJXcG9tZHlFR3hq?=
 =?utf-8?B?ZTJCQWtnbTdXZUpCLzRXcjRRRk1YS3VtTm5rN1JTeE5rV2QybWZXYVdpei9q?=
 =?utf-8?B?Y0ErY2VWcHJlN3RHdXYxb3IzTDBvQ2FtdXUzZEZocDR0cXNSSkMydnFlcWtU?=
 =?utf-8?B?dWNZMi9rcWpXSG4yc0Y1aXIzN2hHNjRVMUhtanhDZ3FIN3VFV2c5RUcyZERJ?=
 =?utf-8?B?TkhRQVFiRXBPK1pmaTF2cDdWM01kNmg0emRtZW9rQ01pSDJaeVloQkt5U0xZ?=
 =?utf-8?B?WC9rZThZK1QyVjU1WmJ5L1VwNThFUVYyL0lhWkRBT1FSMy9SaGFxOEFIU3Ni?=
 =?utf-8?B?aHdHZE0xT01PTlZObUpTbk83L2FQYTYwZ1ZpU2pmWE9Ka1JMd2Vzc3JWTEpH?=
 =?utf-8?B?S1ZGTWo3QXk0bVF1RkJCbUU5RlduZlFoSmlHRFZNbitabGN3UkV6RTVPNVll?=
 =?utf-8?B?TkVCSVc4eGxTTHVCZ1oyQzR0QjduQmY2d09xaUZvL0NxcURneG03YlIyLzdW?=
 =?utf-8?B?UnYxUFVLa1FmSmh4QXEwZGtHcmI5SGdDNTJ6b1k2UTViRW9MVDRNOTZ1NUVk?=
 =?utf-8?B?MXp3RDY3RHR1bDdieDNQTnBOcWRzVlBEaVdIN0ozNHk0QUpzZkhUR2JhVTlt?=
 =?utf-8?B?anZ5cHdvQk05c245ZktPOEwvOU40TzB2cm5ha1YxUWRQdTBZN3gwa0c1dzR1?=
 =?utf-8?B?N2RDK2tBK2lYVUJXU0N3SWNBWGREdG11VUtLR2tCSEZ3Z01nWURqVi9uWXd0?=
 =?utf-8?B?TWdKaHMxUUpsYWp4ZjcvbDdkeklYSG5vN3ltamJnUWZLZHE1S0NMbnVzeEU1?=
 =?utf-8?B?cUczekJISEQzS0xJcTJDT0lnMXEwcVZXZHNOeDdITGlSUDhVQStJN0hLSUsy?=
 =?utf-8?B?NnFST0ZwQlhFVkQzQVV1YWViS3JHemFBM3U0bnBKQjlyVVpKUmFCQS9vVFdR?=
 =?utf-8?B?R000OERZNEFmaVVLRC9zbDVCUVFONXFreExnaTFXT0JNVGo1OVVvSVhJMTNO?=
 =?utf-8?B?K3BjeDRpbWhPWmZaY3JiQzZqQjRoRGxyL05qQzYzbTZPWVZOcGxheVJualB0?=
 =?utf-8?B?VHpRd3JUeE5yUFZGbHRPYU5UNWFCSTJRb25rN2dZaDRqZFZYNG01TGFMNWZD?=
 =?utf-8?B?bk9XZExZRU8rbS9RSDE5M1VzS0pENjZsQjJrdjVJaTU1ZytOdTRQVHRqWFVK?=
 =?utf-8?B?dTJTdlNXYVFuajZHbHV1VWNIN2JrYjJ4WTFkM21aS2cyV3ViS1NoL0xVRHRR?=
 =?utf-8?B?VmxMdGF3aXZ5WkxaV29ieTJrc3RSWFVxU0k5YU9URjRYYjhhdFY2YzhEUFFM?=
 =?utf-8?B?SFNteGJPem92ODdCS3VNMTNYRk9JTW9OanRJLzh4Y1pTYnVYL1QyRnJSczBW?=
 =?utf-8?B?VHhzanB3dFFNeUc5ci9IVjhFenRpb3drU0pSOWxWUFhITXNyZ29xL1ZwNXp2?=
 =?utf-8?B?bzVJK3Y1alNuaGZFV3R5aUZvdUlXTytqYVhkblRSNEVGUVNKYk5pZEtxUzAw?=
 =?utf-8?B?eG1EWUFFRHVKQ2NPS3pkbXBGL3VmUHFya2w4MnB2M1VWVG8zVnpKaThwRXB6?=
 =?utf-8?B?ZGdKWGdOeDMrdmZEQkx5TC9kNjMyNUxZY0d3N0d5dDJpbFR1UVBGdXpaeUNX?=
 =?utf-8?B?bWZYYXBLZnVmbGJ5R2tNOGMvWVFFbWNWcFJkWWlpUER4amIvVVFhV295bjBR?=
 =?utf-8?B?VEZsd0hETEh0K3FhejQ4WnVEMWllNWMxZFI3ZG1BekIwVTRZd3ZvdGVIeTl4?=
 =?utf-8?B?ZzI5elFUMCt2V0NRR3k0NDhNNU05YU8rMHB3bFZlSytNM3pqc3k1ZkpFYzJo?=
 =?utf-8?B?QytzbFV6MHpGOWF3My9STXB1Ky91a3JHeVVPZXBhYWx4WEpCUGhIZVZ0eUxP?=
 =?utf-8?B?MUt5WGNseVVKZjd0N1dxR25vald6TW5BT3lKaUwza2dSZzFHMy8rWmNkOW02?=
 =?utf-8?Q?sg9dEpo0WCwIYx/ix7wcjxNsW4EaCfsuOwziBOA+mogz3?=
X-MS-Exchange-AntiSpam-MessageData-1: c/NQrY28buyGpA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b345b4-d374-4d49-81cd-08df122d24b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:55:21.0062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgRMF0NS9lGfNQk1/C+aFWmmK/2TuUVnbpX+MtuRfNmQbZm0/+uMecBiYRvbs8dIKOuknOn88H4BQD3cH5mPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
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

On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>> Similar to the typed encoding layer, add some decoding type machinery.
>> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
>> by composing visit calls to each member. Add some common `Schema` kinds,
>> such as `Array` which collects an array value into a fixed maximum size
>> array, and `Required` which fails a decode if the value is not sent.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  12 +-
>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 480 ++++++++++++++++++++++++=
++++++-
>>  2 files changed, 488 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/g=
sp/nvkv.rs
>> index 10dcbb9e602c..7d58ca91cbc3 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>> @@ -9,7 +9,7 @@
>>  //! function calls will map to some struct - for example, f(GPU_NAME_ST=
RING_KEY, 0, b"some gpu")
>>  //! naturally maps to storing a &str with the GPU name.
>> =20
>> -#![expect(unused_imports)]
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
>
> I am getting a build error on this patch:
>
> error: unused import: `nvkv_encode`
>   --> ../drivers/gpu/nova-core/gsp/nvkv/encode.rs:65:16
>    |
> 65 | pub(crate) use nvkv_encode;
>    |                ^^^^^^^^^^^
>    |
>    =3D note: `-D unused-imports` implied by `-D warnings`
>    =3D help: to override `-D warnings` add `#[allow(unused_imports)]`
>
> error: unused import: `nvkv_decode`
>    --> ../drivers/gpu/nova-core/gsp/nvkv/decode.rs:104:16
>     |
> 104 | pub(crate) use nvkv_decode;
>     |                ^^^^^^^^^^^
>
> error: aborting due to 2 previous errors

Thanks for catching this. This builds on 1.85.0 without issue, but I
checked on 1.98.1 and it fails to build. I'll add building with stable
to my checklist.

>
>>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>> =20
>>  use core::marker::PhantomData;
>> @@ -21,7 +21,8 @@
>>  use kernel::{
>>      alloc::{
>>          allocator::KVmalloc,
>> -        Allocator, //
>> +        Allocator,
>> +        ArrayVec, //
>>      },
>>      bitfield,
>>      num::Bounded,
>> @@ -139,6 +140,13 @@ fn default() -> Self {
>>      }
>>  }
>> =20
>> +/// A schema field for an array value under the NVKV key `KEY_ID`.
>> +#[derive(Default)]
>> +#[repr(transparent)]
>> +pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID=
: KeyId> {
>> +    vec: ArrayVec<T, N>,
>> +}
>
> Why is this not defined under `decoder` if it is only used there?

This will be used soon. For example [1] uses it.

[1]: https://lore.kernel.org/all/20260905081116.106613-8-zhiw@nvidia.com/

>
>> +
>>  bitfield! {
>>      /// The op word that starts each NVKV operation.
>>      struct Op(u64) {
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova=
-core/gsp/nvkv/decode.rs
>> index ceb97e73e100..7f5310857764 100644
>> --- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>> @@ -3,16 +3,356 @@
>> =20
>>  #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>> =20
>> -use kernel::prelude::*;
>> +use core::convert::Infallible;
>> +use core::marker::PhantomData;
>> +
>> +use kernel::{
>> +    alloc::ArrayVec,
>> +    prelude::*, //
>> +};
>> +use pin_init::init_array_from_fn;
>> =20
>>  use crate::gsp::nvkv::{
>> +    Array,
>>      Index,
>> +    Key,
>>      KeyId,
>>      Op,
>>      Opcode, //
>>  };
>>  use crate::num;
>> =20
>> +/// Defines a schema struct together with its [`Schema`] implementation=
 that decodes into `$target`.
>> +///
>> +/// Each member of the struct should implement `Schema`. For every (key=
, index, value) triple
>> +/// decoded from the NVKV stream, the generated parent `Schema` impleme=
ntation will call each member
>> +/// in declaration order with that triple. If a member consumes that tr=
iple, it will stop there.
>> +/// Otherwise it will keep going until all members are tried.
>> +///
>> +/// The schema struct holds the state required by the schema implementa=
tion to do the decode. It's
>> +/// recommended to use one of the existing Schema kinds (`Required`, `A=
ccumulated`, `Key`, `Array`,
>> +/// `Indexed`) for each member.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// nvkv_decode! {
>> +///     struct RequestSchema =3D> Request {
>> +///         id: Required<u32, 0x0001>,
>> +///         name: Array<u8, 64, 0x0002>,
>> +///     }
>> +/// }
>> +/// ```
>> +macro_rules! nvkv_decode {
>> +    (
>> +        $(#[$attr:meta])*
>> +        $vis:vis struct $name:ident =3D> $target:ident {
>> +            $(
>> +                $(#[$field_attr:meta])*
>> +                $field_vis:vis $field:ident : $ty:ty
>> +            ),* $(,)?
>> +        }
>> +    ) =3D> {
>> +        $(#[$attr])*
>> +        $vis struct $name {
>> +            $(
>> +                $(#[$field_attr])*
>> +                $field_vis $field: $ty,
>> +            )*
>> +        }
>> +
>> +        impl $crate::gsp::nvkv::Schema for $name {
>> +            type Target =3D $target;
>> +
>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>> +                ::pin_init::init!(Self {
>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>::in=
it(), )*
>> +                })
>> +            }
>> +
>> +            fn visit(
>> +                &mut self,
>> +                key: $crate::gsp::nvkv::KeyId,
>> +                index: $crate::gsp::nvkv::Index,
>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>> +            ) -> ::kernel::error::Result<bool> {
>> +                Ok(false
>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut self.$f=
ield, key, index, value)? )*)
>
> Mmm looks like this is going to be `O(n)` with `n` being the number of
> fields?
>
> This is ok for a first implementation but eventually I hope we can
> switch to a more efficient dispatch.

I thought quite a bit about this while writing this code, since we need
the escape hatch to imperative decode (custom Schema impl basically). To
be able to get it down to a match on the key, we need to know ahead of
time which keys a Schema will consume. That duplicates the info from the
visit() implementation.

I thought up a few methods but it's unclear to me which one is best, so
I just left it for now. Please LMK if you think this is urgent, I can
try in a follow up to improve this. Here are my ideas (when I say O(1)
lookup I mean modulo how the compiler decides to do it with the set of
key IDs it gets):

1. current code - just visit()
pros: key source of truth not duplicates
cons: O(field) visit as you say

2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts multip=
le keys.
You can match on each associated const in the macro.
pros: O(1) if the current key goes to a field with KEY_ID =3D Some(...)
cons: O(#fields accepting multiple keys) if current key is one of them

3. fn accepts() -> bool
You can match on `if F::accepts(key)` for each field. We could potentially =
make
this const with Gary's const traits polyfill.
pros: O(1) if you write an inline-able+optimizable implementation.

4. Associated const KEYS table; use tricks to concat tables
pros: O(1) lookup=20
cons: actually MSRV can't get this to optimize down to O(1)=20
  if you use slice::contains(), but stable can.

I don't like #2. With the current #1 we can decide later how to optimize.
#3 and #4 feel mostly equal to me, maybe #3 is slightly better.

>
>> +            }
>> +
>> +            #[inline(always)]
>
> In this patch as well these should probably be just `#[inline]`.

Done.

[...]
>> +/// Expects objects specified sequentially with index starting from zer=
o.
>> +pub(crate) struct Accumulated<S: Schema> {
>> +    current_index: Index,
>> +    current: S,
>> +    current_started: bool,
>> +    next: S,
>> +    accumulated: KVVec<S::Target>,
>> +}
>> +
>> +impl<S: Schema + Default> Accumulated<S> {
>> +    /// Creates an empty accumulator.
>> +    pub(crate) fn new() -> Self {
>> +        Self {
>> +            current_index: Index::new::<0>(),
>> +            current: S::default(),
>> +            current_started: false,
>> +            next: S::default(),
>> +            accumulated: KVVec::new(),
>
> Do we want to call `assert_schema_size_reasonable` somewhere here as
> well? Also, should this be a `Default` implementation?

Think we can just remove the ability to construct this without using
init(). Then callers can use stack_pin_init! if they really want it on
the stack.

>
>> +        }
>> +    }
>> +
>> +    fn take_vec(&mut self) -> Result<KVVec<S::Target>> {
>> +        if self.current_started {
>> +            self.accumulated
>> +                .try_push_init(self.current.finish(), GFP_KERNEL)?;
>> +            self.current_started =3D false;
>> +        }
>> +        self.current_index =3D Index::new::<0>();
>> +        Ok(core::mem::take(&mut self.accumulated))
>> +    }
>
> This seems to be only called by `finish`, let's inline it there?

Done.

>
>> +}
>> +
>> +impl<S: Schema + Default> Schema for Accumulated<S> {
>
> If this ok that this doesn't provide an `init` implementation? Because
> the default one returns a value on the stack, which IIUC can grow rather
> consequently for an `Accumulated`?

Yeah. So it happens that the stack copies are elided in this particular
case. But I think it's better anyway to do it as you suggest.

>
>> +    type Target =3D KVVec<S::Target>;
>> +
>> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderVal=
ue<'a>) -> Result<bool> {
>> +        if index !=3D self.current_index {
>> +            if !self.next.visit(key, Index::new::<0>(), value)? {
>> +                // Unrelated key to us.
>> +                return Ok(false);
>> +            }
>> +
>> +            // Require that objects at index k have all their keys sent=
 before the k + 1 th object
>> +            // can be completed. Require that objects are sent contiguo=
usly in order from index 0.
>> +            if !self.current_started || index !=3D self.current_index +=
 1 {
>> +                return Err(EINVAL);
>> +            }
>> +
>> +            // The current value must be finished. Push it and swap in =
`next`.
>> +            self.accumulated
>> +                .try_push_init(self.current.finish(), GFP_KERNEL)?;
>> +            core::mem::swap(&mut self.current, &mut self.next);
>> +            self.current_started =3D true;
>> +            self.current_index =3D index;
>> +            Ok(true)
>
> I don't quite understand how this method works, notably how
> `current_index` evolves. This might require more documentation on
> `Accumulated` itself.

I added some documentation about how it works. But this is just an
implementation of a finite state machine which tracks the completion of
each child Schema based on the index advancing. It needs some
bookkeeping to handle edge cases like you didn't receive anything / you
got to the end (`current_started`).

>
>> +        } else {
>> +            let consumed =3D self.current.visit(key, Index::new::<0>(),=
 value)?;
>> +            self.current_started |=3D consumed;
>> +            Ok(consumed)
>> +        }
>> +    }
>> +
>> +    #[inline(always)]
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>> +        self.take_vec()
>> +    }
>> +}
>> +
>> +impl<S: Schema + Default> Default for Accumulated<S> {
>> +    fn default() -> Self {
>> +        Self::new()
>> +    }
>> +}
>> +
>> +/// A schema field that scatters indexed values into an array of `N` sl=
ots.
>> +#[repr(transparent)]
>> +pub(crate) struct Indexed<T, const N: usize, const KEY_ID: KeyId, As =
=3D T>([T; N], PhantomData<As>);
>
> Can we elaborate a bit on what `As` is supposed to be? Not only on this
> site, but generally speaking. I have a hard time coming with a
> consistent definition, so a comment would help the reader forge their
> understanding.

It's documented on `Key` but not here, let me add a link to it.

>
>> +
>> +/// Copies `elems`, converted to `T`, into `slots` at `start`.
>> +///
>> +/// Fails with `EINVAL` if the window does not fit in `slots`.
>> +fn scatter_window<T: From<As>, As: Copy>(slots: &mut [T], start: usize,=
 elems: &[As]) -> Result {
>> +    let end =3D start.checked_add(elems.len()).ok_or(EINVAL)?;
>> +    // Reject indices outside of the declared array size.
>> +    let dst =3D slots.get_mut(start..end).ok_or(EINVAL)?;
>> +    for (d, &e) in dst.iter_mut().zip(elems) {
>> +        *d =3D T::from(e);
>> +    }
>> +    Ok(())
>> +}
>> +
>> +impl<T, const N: usize, const KEY_ID: KeyId, As> Schema for Indexed<T, =
N, KEY_ID, As>
>
> Same question as `Accumulated` about the lack of an `init` method -
> maybe we can use `init_array_from_fn` to avoid a stack copy.
>
> Actually that makes me think that maybe the default `Schema::init`
> implementation is not such good an idea, because it makes us overlook
> types where we should override it.

Yeah agreed on all points.

>
>> +where
>> +    T: From<As> + Default,
>> +    As: Copy + for<'a> TryFrom<DecoderValue<'a>, Error =3D Error>,
>> +    for<'a> &'a [As]: TryFrom<DecoderValue<'a>, Error =3D Error>,
>> +{
>> +    type Target =3D [T; N];
>> +
>> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderVal=
ue<'a>) -> Result<bool> {
>> +        if key !=3D KEY_ID {
>> +            return Ok(false);
>> +        }
>> +        let start =3D index.cast::<usize>().get();
>> +        // Accept both scalar vs scattered array setting for flexibilit=
y.
>> +        match <&[As]>::try_from(value) {
>> +            Ok(elems) =3D> scatter_window(&mut self.0, start, elems)?,
>> +            Err(_) =3D> scatter_window(&mut self.0, start, &[As::try_fr=
om(value)?])?,
>> +        }
>> +        Ok(true)
>> +    }
>> +
>> +    #[inline(always)]
>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
>> +        init_array_from_fn(|i| Ok::<_, Error>(core::mem::take(&mut self=
.0[i])))
>> +    }
>> +}
>> +
>> +impl<T: Default + Copy, const N: usize, const KEY_ID: KeyId, As> Defaul=
t
>> +    for Indexed<T, N, KEY_ID, As>
>> +{
>> +    fn default() -> Self {
>> +        assert_schema_size_reasonable::<Self>();
>> +        Self([T::default(); N], PhantomData)
>> +    }
>
> Mmm that could be a pretty large object. Where are these `default`
> methods called? Do we want to leverage `init` instead?

Yerp

>
> <...>
>> +    // Tests that a schema too large for the stack decodes on the heap.
>> +    #[test]
>> +    fn decode_large_schema_on_heap() -> Result {
>> +        const BLOB_KEY: KeyId =3D 0x1400;
>> +        const BLOB_VALUE: &[u8] =3D &[0xab; 100];
>> +
>> +        nvkv_decode! {
>> +            struct BigSchema =3D> BigDecodeable {
>> +                blob: Array<u8, 2048, { BLOB_KEY }>,
>> +            }
>> +        }
>> +
>> +        struct BigDecodeable {
>> +            blob: ArrayVec<u8, 2048>,
>> +        }
>> +
>> +        let mut encoder =3D Encoder::new();
>> +        encoder.encode_array8(BLOB_KEY, Index::new::<0>(), BLOB_VALUE)?=
;
>> +        let serialized =3D encoder.finish();
>> +
>> +        let mut schema =3D KBox::init(BigSchema::init(), GFP_KERNEL)?;
>> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Err=
or);
>> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, G=
FP_KERNEL)?;
>> +
>> +        assert_eq!(*decoded.blob, *BLOB_VALUE);
>> +        Ok(())
>> +    }
>
> Same as the encoder, it would be nice to exercise the error paths a bit
> more in the tests.

Will do.

