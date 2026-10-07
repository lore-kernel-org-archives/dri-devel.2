Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D35CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 04:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7AA10E32E;
	Wed,  7 Oct 2026 04:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aWEUbpJU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE7C10E32E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 04:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8U8Mb5v7kZTr9UqNuIxpD+dzZx1oebW24+XI1Hce6U3sQtlcYbEmlZa/+PHXjaciQuU3iHmYFlUc1OSXd6TWR/PD8QIREP5Sc8ZvPFp31s1Z2n80iuRXgOhDI3ZgIOXwKxmZ5EWKR7p7LMEw2HdawuXXsW7Mz/xDTDdhoYjfWT3dOJLmrY7itbcRy5pTZQeqsEUlPvXXZQypTHYec8D3nytfyEVHRjN2PJcwx46vmIE8ZForedHRFNIlFpv4gWbBQbC6Z0y90Pg9LZioBOZMug1ghoUWUdK7TO4YvoOvxlc1y14tfkgCLZ4uTFzKU9WyqAoWs7vYC3faZaIgc4EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frym2XaPUgfaeGJdXzXTWM1J5372eBmN4bu7oBmoOQ8=;
 b=UVs2cmtm3IFPMCVCzZDCTd1HRRegzrRazG5YgpY7kF7IpFgnpz4uoIBXwUQhd/M9aTod4n43uIo+6JMi46V8oUj9p25n33nKeDd0pymsSH23T9Ie+O80YwpDzAaQIXfXCELhSryb6lUUeyPCON7NUTZ7enE//vBaAYeKW2T0sL4cKgMJqCWUlDMwqOXYl9pfvt/y6Jd5aL5yGLYG86x0Zo+bLdGfeZFrM2c/45y3nw2URcQVhVHknyHwX/yhkFg6c+As3PXmZcaMvXWenP3NzRWyAQxiwG+YxtilUZNPFde/xQKKyWs1Xf2XSOUNHhMP+dNsCG1EnMqUVmcfjpWFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frym2XaPUgfaeGJdXzXTWM1J5372eBmN4bu7oBmoOQ8=;
 b=aWEUbpJUSKsuefvWMhpurWYnyczbe6SJh8hTdImOWdMor01xA8KdL8Jau6oldBRJHtlNNaUpwiXviO7R/D59zTZeGsBH4vUXWbsTT/Mfaj2enKmOoWaiWL4Blwh4QGbRpK33cvoOutL0S7fExooes/KS2u2Barv3l7CKODanOH/ootVhZqk4ErDz1JUzFHw928uSh/JaOp0Nl18jv9ZhDjp9NeCM0R8Qhho3WrxCRMmmRpF8jAapTciUAXgeW+KLumPPxSmEWkc+jrkY1CiVa3K6jnI34Gs1t6w0MkXi3CY1ONNc5gAceOyVlQYcgqYMlEJEVA9K5isIoqJozvBT9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB880722.namprd12.prod.outlook.com (2603:10b6:8:404::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 04:51:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 04:51:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 13:51:03 +0900
Message-Id: <DLYC3REXSZIE.2LU3UFZP93SJ0@nvidia.com>
Subject: Re: [PATCH v3 5/8] gpu: nova-core: add NVKV decoder
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
 <dri-devel@lists.freedesktop.org>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-5-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB880722:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6c969b-0721-4964-17ff-08df242e9912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|366016|376014|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1W8t9qoqRA3xs3rgYPD4p0kRJbu7JbgJZIbIbCDG2qdaFNm52kh4gBhgMJc5sKHvorrE6HGPZx2fxYIbiDp9gHZNa5GtYiiQ0ontCO8BKxRIEepq0MpW1nY6NSiQGA1jO48GW2dnKXqq65YjT60Sboh8eYdnrJDBHDCwhnfT3ycVlUnvUrab3IIQYqe7Ty5e2fKen2BC59eJmefpn8OhrmwPBB7YzfyY6NsXNmPwagcKvEs6fmkw2pV0WzZ9ghpnDP1nQ/TyQU9di8dertc7XxIcc48V/Fil7424jZXuw0J0fZhdA09TEbFwvJuveEraGhR0VMhRe5gy3D2Pc61DcGlJ+oBwVBqSaGYqMKToyuTeCskNZu2ZByTSnhYjCDJyKkAo1MbYJDCAUhZ0OZWRq+20D964B8FJULvU2rWF00JFVZ7ZBbFCQM/lnXDSlMu06JZBgpRd+s5oYGK/NUmJDqEQKucfNfhhKF3L0AMmkyAPUEvk17lwW4hg9haAkgW8XaqNuk4L+jYVS7vtJ9oRykDpzyyfOHhfHr4rTcNlxxqu5NnSoph24RiJrJmx0v/d8ROKAYcsAOImZIbwxcjESRuBtg3p0HuP0Z8T8eyo7ble3PhfibkgpYLoZQa+xrfFFtaihMwNZZKuLYY0GSAJRfjSlHtaApM/u/2OO9jxNuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNIUVhnSDJERTNpUFZDd2ZhQnhmM3dncGV1aUg5ZEtaRkdCUFdwbmc1VlIx?=
 =?utf-8?B?WW1qbGpFWWhCbkw0U1RZU1B0OVFjSWs0dklGblNIU1NwTWx0WkFmbVhkcXUy?=
 =?utf-8?B?bk56czdKQStxd0dPZlYvQ251NzBpZGxDeW9aVnpTbXdKZU4yNE1UV1BMYXYx?=
 =?utf-8?B?NEdOM3daRUU5akx4NWd2OWQ4RzhxQWt4V3hXcjJlWGlGR04vRm9Nanp1M3dM?=
 =?utf-8?B?ZmhMUzZDYkVoUVluWkR0bU9NbnUwNm9CWmpVMmNPeldLRnJWY2JQNUhBV0Uy?=
 =?utf-8?B?ak5HQ3U5aWUxdGdzRVhvaGVtdnA3L29BUDZ3QXd5bHB4am9MTkp0d3hDUXhZ?=
 =?utf-8?B?dU9qNHdXREZxcXhHOEl6c1AxSTFadFE5aHprZnJRRVR2YlBhUHAwSDdTV2Ur?=
 =?utf-8?B?V0NvUElrOFI2WkNad25NcUlJZnY4Yy9sYkJaUFpDWHhEaXVZc1pZR3Z5REFO?=
 =?utf-8?B?UW9mTUdMSHFOMlQ5RC9lbUNRZWw1TlI5N2RYSE1XeStHNXBzZklmR2lSelZV?=
 =?utf-8?B?U0dEYUlFRjYzWCt0bm1uNWZ2TUVQSGhabUVJM0djK05aVWZuT3BBckJnOHFQ?=
 =?utf-8?B?UFpiTjI1REppcUEvcjRLM3h1Nll1YVowcFRCaks0NVBEYXFabG1MeUg2YitU?=
 =?utf-8?B?RFVBa0hvRk9TUENydVlVYUpQaVYzamI0ZlhUT2ZWTXJOZkp0UHpqd3Z4dkND?=
 =?utf-8?B?T29nZUZzTzY5TGhkTjBEQWtMU21McDI5Vy9McVFiSDBzMUpDbmVZK3g1Q1FW?=
 =?utf-8?B?ZkIzS0lJOFp1cVMyS0YvWWVIalBaTHNMOHYwT3ZxNzQ3VVNvenZwU2pLSkQ5?=
 =?utf-8?B?c3MzTldKQzFGUExCaW1FbzlkQVQzRnFpUWFtNTBXeVJhQlNScCtKWkliU25H?=
 =?utf-8?B?dzFxcUNwZXFVTExlUCsvZ1l0Tnl3TmtwblpnRlR1NUJocHhWMXBTWjN6WE9a?=
 =?utf-8?B?Tk53SUhTVThBenVockdGZWtuOVQwTWtuUTlCZTNGWEVkc2E4dWxiQXdsMG5v?=
 =?utf-8?B?a1JKaUpmTEFSS1FtMDR2eFpLSVM0NGxTYy9iRGdUMlc0aFVBMVRyVm5abHYw?=
 =?utf-8?B?RFBFT08rdjU4T1NjSTd5QytCTDJaL0pRR0gyWlNPdjhkK1cxamd3WFZ0SVpU?=
 =?utf-8?B?VHVubnBCb2FTNWp2VVpqTFR6MVJ2V0VJRXUvNGhTbWtSNWJTMWptY2FBWkFI?=
 =?utf-8?B?MnBNVFM5blorVFdkQWlUMGwwYTFvVUdMWmY2dTJ5MVhMckRIZXRsbnpqalZW?=
 =?utf-8?B?TVRHck1nYTdiSmpiZ0ZkbzdFS0ZieVdhejNGK2VMRXRNNURFWGEzdC8xZW11?=
 =?utf-8?B?M09aR0tvUENmSXVRRWdPN0VHSHhkN1h2NnVzOWtVdmpIQ2hYNTFoMFNjR1c1?=
 =?utf-8?B?ekF5Y1BSeHpGeHhDY0I0dzJ2eDhwU0NwVVczNWZqdk9YNXdEaUlkdGVDY282?=
 =?utf-8?B?bHpaSkhETFFsQ2orVUYzRVRJTVhuZEVXY0M2SjRsRnpLdDJxMXRBNTlJWUhv?=
 =?utf-8?B?RG5Ib1BBbC9Ld0ljd0xpbU5jV1JSSjFHdUpIay9DUmlYVW9wYXMzRXEwVUwz?=
 =?utf-8?B?c0t0aXRkdmlxcm1CK29JWmFUMVloQWxNYjhUcGoreFVNdTVzZjg1cHhrSjk1?=
 =?utf-8?B?QUpOSkNaRGo4MjVvUmxpV3YwWk0vR0hHeWlUK1c5RThyWHNLZksydWxaTkVx?=
 =?utf-8?B?UjFHbHdEaXpQY0JTZzJ0UTJ3QlhnZkhJR2xpWCt5OGZJYUYySnIrUXRsblZ0?=
 =?utf-8?B?c0Vmc0ZaM1UrODVvYjkyRWVrNnFRU09ScG44bmNmU01YS2hMbWVOekdTYzdq?=
 =?utf-8?B?clpGYUMrZ3l5ZUQvbkc3SzFwQ1VFWU8ySFM1TitKYW9pOTJHRGxzTUVCT2Va?=
 =?utf-8?B?cVJWSnNtQzNaOXFkOUovQkdHdzRGQ2xrV3l6amxMeXoxZTNZMGRRNXUzRGox?=
 =?utf-8?B?NnRLaS9QSE05eHJWUy9UWnUxVFA5b3J0ZHBxK2h6djhKNzNLY3dVb1VJR1RH?=
 =?utf-8?B?SCs5N2NqQUtPamUvanoxdzcvVEh1bDFZNkpWbnNQb3RnTE9oWENKWFhJc0lh?=
 =?utf-8?B?U21CNGJBcE40T0srb2dQTll2VGl5aWZGc1ZFQ203ajZJc2dDU2hhcVdLZ1Zw?=
 =?utf-8?B?TTJYb0xGbWp5ZFZYbnZPN1NJbTVEeEtGVmJmQ3ZwNWd6Y1EwVzlDWi9mQkY0?=
 =?utf-8?B?akNHdVRkMWZaL3lrUHlJU3BKOFBXSUNLSWZPK294WmczaUNDMzlENEhtajQ3?=
 =?utf-8?B?cHBaQmVRMjlVTGhLVytMTTdrL2Rtb2JkdXcyTE1VMmV3YStQeDFiQlp2V3lw?=
 =?utf-8?B?S2pKTEZVQWhBNEV3dXUrd3hObGdpSDc3d0I3Uk05dVF4bVdVcWp0U3lOcDBQ?=
 =?utf-8?Q?7Kn8tdQ2NkdxakjkI3j85HKuO0o2vnaumFedlNk6XJIqG?=
X-MS-Exchange-AntiSpam-MessageData-1: 5Zds/VDZ1RasGw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6c969b-0721-4964-17ff-08df242e9912
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 04:51:06.6979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbqB1OEyB4MfBxag+hM3vtxtzl+mASTidnFGcsC1loGlQt1L0F34/RGiDYiOSyZCb+3h/qzr4kBWXrMJsIiDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB880722
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

On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> Add a decoder for NVKV. This is for receiving messages from GSP for
> GMCAPI calls. The NVKV format essentially encodes a sequence of function
> calls f(key, index, value). This decoder reads an encoded stream and
> invokes a type implementing the new `Schema` and `Visit` trait. The
> `Visit` trait can either consume the value or not, which is useful for
> composing schemas. If a (key, index, value) is not consumed, error out
> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
> not is per each GMCAPI call.
>
> Add kunit tests for the decoder.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 487 +++++++++++++++++++++++++=
++++++
>  2 files changed, 490 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> index 0957dce92f96..10f7a16ffc23 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
> @@ -29,6 +29,9 @@
>  mod encode;
>  pub(crate) use encode::*;
> =20
> +mod decode;
> +pub(crate) use decode::*;
> +
>  /// The allocator backing [`EncodedStream`].
>  type StreamAllocator =3D KVmalloc;
> =20
> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> new file mode 100644
> index 000000000000..c4c24fe1108e
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.
> +
> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
> +
> +use kernel::prelude::*;
> +
> +use crate::{
> +    gsp::nvkv::{
> +        Index,
> +        KeyId,
> +        Op,
> +        Opcode, //
> +    },
> +    num, //
> +};
> +
> +/// A decoded NVKV value.
> +#[derive(Copy, Clone, Debug, PartialEq, Eq)]
> +pub(crate) enum DecoderValue<'a> {
> +    Scalar32(u32),
> +    Scalar64(u64),
> +    Array8(&'a [u8]),
> +    Array32(&'a [u32]),
> +    Array64(&'a [u64]),
> +}
> +
> +/// Implements `TryFrom` from the given `DecoderValue` variant to the gi=
ven type.
> +///
> +/// `TryFrom` is used by the `Schema` implementations in this file to co=
nvert from the
> +/// `DecoderValue`s into the types to store. Provide the implementations=
 for basic types here.

nit: proper doclinks for referenced types (recurring problem throughout
the file).

> +macro_rules! impl_try_from_decoder_value {
> +    ($ty:ty, $variant:ident) =3D> {
> +        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
> +            type Error =3D Error;
> +
> +            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
> +                if let DecoderValue::$variant(v) =3D value {
> +                    Ok(v)
> +                } else {
> +                    Err(EINVAL)
> +                }
> +            }
> +        }
> +    };
> +}
> +
> +impl_try_from_decoder_value!(u32, Scalar32);
> +impl_try_from_decoder_value!(u64, Scalar64);
> +impl_try_from_decoder_value!(&'a [u8], Array8);
> +impl_try_from_decoder_value!(&'a [u32], Array32);
> +impl_try_from_decoder_value!(&'a [u64], Array64);
> +
> +/// A visitor that consumes decoded NVKV and produces a `Target`.
> +pub(crate) trait Schema {
> +    type Target;
> +
> +    /// Returns an initializer that creates an empty schema in place.
> +    ///
> +    /// Use [`KBox::init`] for the heap or `stack_pin_init!` for the sta=
ck (if sure that the value
> +    /// is small enough to fit).
> +    fn init() -> impl Init<Self>
> +    where
> +        Self: Sized;
> +
> +    /// Returns an initializer that makes the decoded `Target`.
> +    ///
> +    /// After the returned initializer runs, the schema should be empty =
again.
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
> +}
> +
> +/// A visitor that consumes decoded NVKV from a stream.

Note that `Schema` is also defined as a "visitor that consumes decoded
NVKV", which makes things a bit confusing. I guess that's because both
traits implement different aspects of what a typical visitor does, but
clarifying their relationship (and the reason for splitting) would be
helpful.

> +///
> +/// A schema that doesn't need to borrow data from the stream can implem=
ent this for all `'data`
> +/// lifetimes, avoiding having to carry the lifetime parameter. A schema=
 that borrows from the
> +/// stream directly should implements it for its own lifetime only.
> +pub(crate) trait Visit<'data> {

Should this be named `Visitor` instead of `Visit`? Trait names should be
nouns rather than verbs, and this would make the `Decoder::visit`
method's prototype read more clearly imho. If you intended to use
`Visit` as a noun, I don't think that works either since the `visit`
method is potentially called many times (so it is not a single visit).

> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema consum=
ed it.
> +    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'d=
ata>) -> Result<bool>;
> +}
> +
> +/// A read position in an NVKV stream.
> +struct Cursor<'a> {
> +    data: &'a [u64],
> +}
> +
> +impl<'a> Cursor<'a> {
> +    /// Creates a cursor at the start of `data`.
> +    fn new(data: &'a [u64]) -> Self {
> +        Self { data }
> +    }
> +
> +    /// Returns `true` if no `u64` values remain.
> +    fn is_empty(&self) -> bool {
> +        self.data.is_empty()
> +    }
> +
> +    /// Takes the next `u64`.
> +    fn take_u64(&mut self) -> Result<u64> {
> +        // PANIC: `take_u64s(1)` returns exactly one element on success.
> +        Ok(self.take_u64s(1)?[0])
> +    }
> +
> +    /// Takes `count` bytes. If `count` is not a multiple of 8 (`u64` si=
ze), bytes are discarded up
> +    /// to the next multiple.
> +    fn take_u8s(&mut self, count: usize) -> Result<&'a [u8]> {
> +        let values =3D self.take_u64s(count.div_ceil(8))?;

s/8/size_of::<u64>()

> +        values.as_bytes().get(..count).ok_or(EINVAL)
> +    }
> +
> +    /// Takes `count` 32-bit values. If `count` is not a multiple of 2 (=
`u64` size), bytes are
> +    /// discarded up to the next multiple.
> +    fn take_u32s(&mut self, count: usize) -> Result<&'a [u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(2))?;

... and maybe `size_of::<u64>() / size_of::<u32>()` here?

> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
> +            .map(|(elems, _)| elems)
> +            .map_err(|_| EINVAL)
> +    }
> +
> +    /// Takes `count` `u64` values, or fails with `EINVAL` if fewer rema=
in.
> +    fn take_u64s(&mut self, count: usize) -> Result<&'a [u64]> {
> +        let (prefix, suffix) =3D self.data.split_at_checked(count).ok_or=
(EINVAL)?;
> +        self.data =3D suffix;
> +        Ok(prefix)
> +    }
> +}
> +
> +/// A decoder for an NVKV stream.
> +pub(crate) struct Decoder<'a> {
> +    data: &'a [u64],
> +    policy: UnknownKeyPolicy,
> +}
> +
> +impl<'a> Decoder<'a> {
> +    /// Creates a decoder for `data` that handles unknown keys per `poli=
cy`.
> +    pub(crate) fn new(data: &'a [u64], policy: UnknownKeyPolicy) -> Self=
 {
> +        Self { data, policy }
> +    }
> +
> +    fn visit<S: Visit<'a>>(

Although private this method would benefit from having a short documentatio=
n.

> +        &self,
> +        schema: &mut S,
> +        key: KeyId,
> +        index: Index,
> +        value: DecoderValue<'a>,
> +    ) -> Result {
> +        let consumed =3D schema.visit(key, index, value)?;
> +        if !consumed && self.policy =3D=3D UnknownKeyPolicy::Error {
> +            Err(EINVAL)
> +        } else {
> +            Ok(())
> +        }
> +    }
> +
> +    fn seq_key(base: KeyId, offset: usize) -> Result<KeyId> {

Same here.

> +        base.checked_add(KeyId::try_from(offset)?).ok_or(EINVAL)
> +    }
> +
> +    /// Decodes every pair into `schema` and returns the result of [`Sch=
ema::finish`].
> +    pub(crate) fn decode<'s, S: Schema + Visit<'a>>(
> +        &self,
> +        schema: &'s mut S,
> +    ) -> Result<impl Init<S::Target, Error> + 's> {
> +        let mut cursor =3D Cursor::new(self.data);
> +        while !cursor.is_empty() {
> +            let op: Op =3D cursor.take_u64()?.into();
> +
> +            let key =3D op.key().into();

Tip: you should be able to declare the `key` field as follows

    15:0 key =3D> KeyId

... and obtain a `KeyId` directly, making the call to `into` unnecessary.

> +            let index =3D op.index();
> +            let op_value: u32 =3D op.value().into();

Same here with `u32`.

> +            match op.opcode()? {
> +                Opcode::Imm32 =3D> {
> +                    self.visit(schema, key, index, DecoderValue::Scalar3=
2(op_value))?;
> +                }
> +                Opcode::Seq32 =3D> {
> +                    let values =3D cursor.take_u32s(num::u32_as_usize(op=
_value))?;

nit: let's use the `IntoSafeCast` trait instead since this code does not
run in const context.

> +                    for (i, &value) in values.iter().enumerate() {
> +                        let key =3D Self::seq_key(key, i)?;
> +                        self.visit(schema, key, index, DecoderValue::Sca=
lar32(value))?;
> +                    }
> +                }
> +                Opcode::Seq64 =3D> {
> +                    let values =3D cursor.take_u64s(num::u32_as_usize(op=
_value))?;
> +                    for (i, &value) in values.iter().enumerate() {
> +                        let key =3D Self::seq_key(key, i)?;
> +                        self.visit(schema, key, index, DecoderValue::Sca=
lar64(value))?;
> +                    }
> +                }
> +                Opcode::Array8 =3D> {
> +                    let value =3D cursor.take_u8s(num::u32_as_usize(op_v=
alue))?;
> +                    self.visit(schema, key, index, DecoderValue::Array8(=
value))?;
> +                }
> +                Opcode::Array32 =3D> {
> +                    let value =3D cursor.take_u32s(num::u32_as_usize(op_=
value))?;
> +                    self.visit(schema, key, index, DecoderValue::Array32=
(value))?;
> +                }
> +                Opcode::Array64 =3D> {
> +                    let value =3D cursor.take_u64s(num::u32_as_usize(op_=
value))?;
> +                    self.visit(schema, key, index, DecoderValue::Array64=
(value))?;
> +                }
> +            };
> +        }
> +        Ok(schema.finish())
> +    }
> +}
> +
> +/// This is defined per call.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub(crate) enum UnknownKeyPolicy {
> +    Ignore,
> +    Error,
> +}

Documentation explaining the effect of each variant would be nice.

> +
> +#[kunit_tests(nova_core_nvkv_decode)]
> +mod tests {
> +    use super::*;
> +
> +    use crate::gsp::nvkv::Encoder;
> +
> +    // Tests that basic decoding into a manually implemented `Schema` wo=
rks correctly.
> +    #[test]
> +    fn decode_raw_schema() -> Result {
> +        // Decodes an IMM32 pair and a SEQ64 pair (the encoder emits a u=
64 as a single-element
> +        // SEQ64) with a hand written `Schema`. Keys and value constants=
 chosen to distinguish e.g.
> +        // saving the wrong value to the wrong location.
> +        const SCALAR32_KEY: KeyId =3D 0x1001;
> +        const SCALAR64_KEY: KeyId =3D 0x1002;
> +        const UNKNOWN_KEY: KeyId =3D 0x2001;
> +
> +        const SCALAR32_VALUE: u32 =3D 0x1111_2222;
> +        const SCALAR64_VALUE: u64 =3D 0x3333_4444_5555_6666;
> +
> +        // The output type of the hand written `Schema`. In this case, w=
e can have it also implement
> +        // `Schema` on itself rather than having a separate carrier type=
, since the `Schema`
> +        // implementation is completely stateless.
> +        #[derive(Default)]
> +        struct RawSchema {
> +            scalar32: u32,
> +            scalar64: u64,
> +        }
> +
> +        impl Schema for RawSchema {
> +            type Target =3D Self;
> +
> +            fn init() -> impl Init<Self> {
> +                Self::default()
> +            }
> +
> +            fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ =
{
> +                Ok(core::mem::take(self))
> +            }
> +        }
> +
> +        impl<'d> Visit<'d> for RawSchema {
> +            fn visit(&mut self, key: KeyId, index: Index, value: Decoder=
Value<'d>) -> Result<bool> {
> +                if index !=3D Index::new::<0>() {
> +                    return Err(EINVAL);
> +                }
> +                match key {
> +                    SCALAR32_KEY =3D> self.scalar32 =3D value.try_into()=
?,
> +                    SCALAR64_KEY =3D> self.scalar64 =3D value.try_into()=
?,
> +                    _ =3D> return Ok(false),
> +                }
> +                Ok(true)
> +            }
> +        }
> +
> +        let mut encoder =3D Encoder::new();
> +        encoder.encode_u32(SCALAR32_KEY, Index::new::<0>(), SCALAR32_VAL=
UE)?;
> +        encoder.encode_u64(SCALAR64_KEY, Index::new::<0>(), SCALAR64_VAL=
UE)?;
> +        let serialized =3D encoder.finish();
> +
> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Erro=
r);
> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, GF=
P_KERNEL)?;
> +
> +        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
> +        assert_eq!(decoded.scalar64, SCALAR64_VALUE);

Nice test!

> +
> +        // An unknown key should fail with under `UnknownKeyPolicy::Erro=
r` and be skipped under
> +        // `UnknownKeyPolicy::Ignore`.
> +        let mut encoder =3D Encoder::new();
> +        encoder.encode_u32(UNKNOWN_KEY, Index::new::<0>(), 1)?;
> +
> +        let serialized =3D encoder.finish();
> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Erro=
r);
> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
> +        assert!(decoder.decode(&mut *schema).is_err());
> +
> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Igno=
re);
> +        let mut schema =3D KBox::init(RawSchema::init(), GFP_KERNEL)?;
> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, GF=
P_KERNEL)?;
> +        assert_eq!(decoded.scalar32, 0);

... this part looks like it should be its own test though. That's
trivial to achieve if you declare `RawSchema` at the module-level
instead of inside the method.

(also nit: let's assert `scalar64` as well, or none of the values at all
- I'd lean towards none since that part is already covered by the
  regular decoding test).

> +
> +        Ok(())
> +    }
> +
> +    /// Records each visit as (key, index, value), for tests on hand-bui=
lt streams.

nit: `(key, index, value)`

> +    #[derive(Default)]
> +    struct Recorder<'d> {
> +        visits: KVVec<(KeyId, u64, DecoderValue<'d>)>,
> +    }
> +
> +    impl<'d> Schema for Recorder<'d> {
> +        type Target =3D KVVec<(KeyId, u64, DecoderValue<'d>)>;
> +
> +        fn init() -> impl Init<Self> {
> +            Self::default()
> +        }
> +
> +        fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +            Ok(core::mem::take(&mut self.visits))
> +        }
> +    }
> +
> +    impl<'d> Visit<'d> for Recorder<'d> {
> +        fn visit(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'d>) -> Result<bool> {
> +            self.visits.push((key, index.get(), value), GFP_KERNEL)?;
> +            Ok(true)
> +        }
> +    }
> +
> +    // Tests the decoder on hand-built `u64` values that the encoder doe=
s not produce: SEQ32,
> +    // multi-value SEQ64, zero counts, a non-zero index and padded array=
s.
> +    #[test]
> +    fn decode_raw_u64s() -> Result {
> +        const SEQ32_KEY: KeyId =3D 0x2000;
> +        const SEQ64_KEY: KeyId =3D 0x2010;
> +        const EMPTY_SEQ64_KEY: KeyId =3D 0x2020;
> +        const EMPTY_SEQ32_KEY: KeyId =3D 0x2021;
> +        const EMPTY_ARRAY8_KEY: KeyId =3D 0x2030;
> +        const EMPTY_ARRAY32_KEY: KeyId =3D 0x2031;
> +        const EMPTY_ARRAY64_KEY: KeyId =3D 0x2032;
> +        const ARRAY8_KEY: KeyId =3D 0x2040;
> +        const ARRAY32_KEY: KeyId =3D 0x2041;
> +
> +        let index3 =3D Index::new::<3>();

nit: variable only used once, can be created inline.

I really like how testing coverage has improved in this revision!
