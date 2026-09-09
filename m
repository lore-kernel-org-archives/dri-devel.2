Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0C2C79F9E
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 00:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526A410EDA3;
	Wed,  9 Sep 2026 00:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4RjKXQ0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35B210E183
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 00:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvrJ3a5GqnpcQ2skDDDnfJAhp+bUZgxuQsQNSNyyKsUtA9RpxPRnGPpLGBNvQCbl4OVLwSitkjw1gqelt5+E889srqY56s7eU7LiPHN8zAFEjUEGsWO07f+X7kPcLBtIfpB9scEa2lBHFB+q0+bkDQZv1Mf2jwVru/iMXlL1eT+WqDGbV8LzQHOUqmm8DcJBsfkS11fanJ1UFxNE1Avoy4dDJ1oly4M9qgRG9/LZvCfghvGMqAW2F5iJ20prVITPCWylk8aQTj05NWZUQucCimwQ2dJB4VOEPeyLkOrajRrG48klRdFtsrz0P0ZEhdIArij9tiZ9NP4dTsQZb9lEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoP8OQoxXY5Vbaqk6mqToteXG4dzFz5ovU2TcAjWbaQ=;
 b=e0Y7CKLVsuE2/CGjxKg9PHsz+1tbVF6VodFMAVzlJmHsyRD2FDJNBH2RicssLR2B2yQjOOExhByMYPnRFjLd7Gpfw0YKVcEdMkcPeiLVZThOiT3q0sbKHem/Gfc7EbCmCdZTOtaCq3vNrSiQYeCSRpy1Wo2sCeZXKf6/noXK1qPb+4q0wJYv7lN33YZK6b8/5qRxdgy4j9IvPr3aUvY/zUjn4i/dEEkTU11roV+B/IeDzWm9ZqqkbW1d7eLRWmhPzXVnUCqMRWrDmVvAnqnVdetOlofg2Zh8w5rDn82yCIIBTwf99P18ygWcPOQmWxOtUWGagCJW7XRtZghxuj+iQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoP8OQoxXY5Vbaqk6mqToteXG4dzFz5ovU2TcAjWbaQ=;
 b=f4RjKXQ03zkvuTl0Y84es6iOZHsQgFOkvnXOOitggzzSohDbmz9cSG7AyhxwdJsEKjGe7nDMmnaK2IlD2EzLDz+44l2XNlR6aQaxN2iah9AQvXJFI/6sYYTKn/HgiQGEee6/X1dDDc1crYFb2FTnezR8MGmBE9qI/cWS7PzUl8E1hZJoOBAxmSNblp4zDov7lWaX6B4ii4bLnVxhWPbCTbv89MGw2YANjb83loDzvfeGtBCtjkQDJBvPnJ81wSaSNenvTSENLih2E47JjGAB2bAf0p7O9SRBL9/8k2zguI/OC7AE5MANtBNDOIn9f7Av3Jz8iQ9/jjXspD33VQ5Cgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB7443.namprd12.prod.outlook.com (2603:10b6:806:2b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 9 Sep
 2026 00:51:39 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 00:51:39 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 09:51:35 +0900
Message-Id: <DLADH5QVXWSD.2FO9OVBIGYNQG@nvidia.com>
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
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
Content-Transfer-Encoding: quoted-printable
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: TYCP286CA0239.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c3057d-9f27-443f-6fe2-08df0e0c8183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|10070799003|366016|6133799003|10067099003|3023799007|56012099006|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l4rtVDuGGxJy5NTn+wul+5dT837IgxiM53KUWX4kT/eHRzBYy5SL0LgmZtkbQ64asJzniuIYXSf0e6Y0Njm52+grYDts1fmWqKrSi/688azQifw1BG4C1OvXv24nLk53804JUwPeA00ylHM0aiauuJlYo0K+4FEWioNRbMgw0d6kTKhRkdy2C3XmuDj0PAwthTfvW44lcMwx77dNswVn10ZRJ6ow6d78DoUEpYER0u5ua3/yGI8scAIxPHgKqx+VHrdTupProqyq+961ZeVhpmnckZZ2zLjc2lumqbNOrbP3i8kZ4ZRv3lTRGqz21L+8puAkLvVRBcTmTNOLjvJvLSrm7f07q9RTBhcEoHK9DmITMUQCjz8pwb/3Vu/i4HJOmWyGxc+d1ufsgAZ2yJZZXWPb8wcVN9Utn6FeiWPpUXFJu8ZwxKRDCK791LshN5yv2K0R8gqKb8b7NE2OVxEBOhbhF20cxmIoQDjY6xZlUwst3W1hoBsmqAW6ObB3xRFZRYDCBrvy7YuhRiCk1cefFZSJrc6OHxAG6usPCRyZRL7wEyG15S4rhcvOQhZUlEZVHVbFHxkw5GWaB+cykM8HlwxypBTFREUuvmdxIRbhGw9w73tM5J35sL93HddxLzihq3uPv03D0G9GWlY9e7CfAnaMS5tlBKC/V++hy3BlQy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(3023799007)(56012099006)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3lKRWdXWlgwcWg2czhwMUZzczdZb2VmbUdVV0owWEswZS9SV2VKZUFKOUsy?=
 =?utf-8?B?NnhORUdnVG1DeUtOQjRONUJ4MTUya2l4MnYvcVV3UWlLK1Vqc29FNUNXQlVv?=
 =?utf-8?B?ZDFXOFlreU5OZGc2WFJqSnJrb2pKV0tpMGk1enVoRzhENjQyKzFiWWQ4cTRn?=
 =?utf-8?B?UUpVNjVBTlhEKytzbVoyQ2UrWUV2K2Y3cHE0NDBSYVlDQVFnY1hSK3dzanUz?=
 =?utf-8?B?WDllbzh2UEJ1RWpBRHZGRDdxR1dPNXZ1WGNpQmQ4OWswMlNyUFJyaWFlUlRR?=
 =?utf-8?B?UExUUXdMRGZabzlIRCtxVW5qTUd6bEhkWDM0YVVYdWtGQUZvNVVubGU4MEE3?=
 =?utf-8?B?eGFSLzZzVFMwTTBodDhxMzVRM2oxRUpkbVg2dUhtUU5Yby9FZEF2NjY5Q05B?=
 =?utf-8?B?UzNLOWNxM0txWmxJQW1IcFZVVGdtNU5oYXR2RTRmWkRPZzFGbzd1SVZ1ekQr?=
 =?utf-8?B?VFg4STBiN2loSGN1a1Jzc2xONWIzSFVSTFlVMHYwaUR4N1YveEN5eFJiU1hP?=
 =?utf-8?B?aVZvbVNhV1V3UHVkOHYzTEMwUGpQOXFFVWRVbnlNeTJrQmVJVHFjbWVwaGcy?=
 =?utf-8?B?Ti95SDRNUjFhQ0VwaWJZNkJmQm1GVmRSYkFGRWRiaTJiZzRLUTlYT056d3A4?=
 =?utf-8?B?YVo0VzI2SitHTkY3Z2NNNlBVeENpZEwxOHd3VkQzZWtpUGloRndqaFE1cUhX?=
 =?utf-8?B?WmxaOGRrQmZ5a2IvV2V0Vng3ZWhCSkdwR1lQL0JuVWJvTnh6Ly9wSGpnbDNK?=
 =?utf-8?B?MDJwM09sRHkycDJ0OVRreWFkalhXTFcrVTN2ME9zaDZaT3drbWpGMVViNUpB?=
 =?utf-8?B?N2FMbDgyOTdndW92Z1hOMUhrblNOc0kyMiswUDArbHVKZU1tQWNtWUtxcW82?=
 =?utf-8?B?VE1lR2hOTGNHOGk0ZXhJbnBlRk1OM0xCQlRtVVpQaXZEVEFLeFhtdFNFVkFJ?=
 =?utf-8?B?aEpoT290dit5YURTaUcvdlVPNkZ3RzEyc0Y5VXJsR3NYTU0vY3ZaWnpueXFx?=
 =?utf-8?B?VFNBMzRCdkZ6NXp2bzBaRHdjUXA3Z0gwV2ZFZjlnZ0pMQkFFZm1qL1VCWlJZ?=
 =?utf-8?B?RkV1TVdDUERqbS9WTjg5RE1FQVhVQnVQTmNLY1gyUjF0NnI3MklUT2hVN0dk?=
 =?utf-8?B?amJiOXVIWnl6QXo4eFJjVVRDdUFTWnRPNzZQUHNBM0YwQ25XdmtIQ0JoMitC?=
 =?utf-8?B?eVpIdnd3QkVoNDdYZnpNb3hBVnYzSWYyWUlPaGhSQk9jZlZTS3N6THkyYnBx?=
 =?utf-8?B?L0gxd0RKZldzYUNlenhZZmROdHFLT0VpbFdZVU8vWmN0OXNEZm1pd3ZWdkZz?=
 =?utf-8?B?dEtzOXNyVzBLTWVSUGpwTFo3Z3p0aXc4RHVmMlhvUk5PUXlmb1FtVStGUGpy?=
 =?utf-8?B?RlpyT245bkZkRTBPN1huOEtxZzJHa0tyUlNSdFlIcnlaRitKT2ZRTW5QMGdj?=
 =?utf-8?B?SkprbE42WG9CTmt0WWpGTmJJb0FReGRHRXZhU25sR3R4V3VDTm5sT1lxRVk5?=
 =?utf-8?B?QkVsbUp5U3FwWHBTMnZ4OXdSM09LcTc5STFYWFdObFBnWGFCWThKaSs3UDd5?=
 =?utf-8?B?a2hEaWFsZGZYbHF4c0Z3c0s1R3lSdTNXWktSc0REQnkwaUcrVkg4YVdhWWJF?=
 =?utf-8?B?TVo5Y3BSS1FRSDZPTFEzYVk4ZHQzRTNyMjg2TTgwdjErWUo5dVo2YytKYzFz?=
 =?utf-8?B?MW9WaldTRlFxaS96UkYzTzl2N1dPWEQyWFFXM3RhQ2R1Z1RTajZIdnV3aXlu?=
 =?utf-8?B?amFmM04rckdZMGdjSUcvejlNOXpCdmRYa2JrdXZzcTZVeUtTTXVscklmOXFI?=
 =?utf-8?B?RXFTSDF1cGpYVWc5dFQ4SVFYMzZ1cmkvWE1zOUhpbHhUYytqU3IraXNOODZs?=
 =?utf-8?B?RStFUzRoTkhDdFpJcTZXVVF6MllhSUkrcXQ0TjZIRTFqU0U1YTB6WElxOUow?=
 =?utf-8?B?N20rUmhiZmxFdkxhWWNtRitXWk1TRHhteGtKb3RZTUZHZTN5YXM0SVdob0J6?=
 =?utf-8?B?cE1ieUhOand0VHdoaWtoczlJNlJ5a2g1SzVyWnBHWmNMUVdqLytqV2R1NWJG?=
 =?utf-8?B?ekVpSWxDWlVRNktIbWd5dzhhazI1dFZZYVRjTzhaeUpldGRDSG1GS0dJUjhy?=
 =?utf-8?B?RnhGU01tRnZETEd5am1EMGV5SHBGWmR5UGhpSUU5ZU5IWjR5akJxVmgycSs3?=
 =?utf-8?B?UWN1MzcwbFU1Zk13bW90WlhRYnFPM2I0c1JmVUhwb2FkOGVKamFvSVhjci81?=
 =?utf-8?B?cEVKQXVkZ3JIdG5FQ21kZUNTUlQ4Q3pLUzRLV3NyVDJPS1VGL1FWNWtrSGxO?=
 =?utf-8?B?c1V5U3ZLMFBSYnV5ek5SRUMyUjBobVhHeThVWGM4ZVNaZ0s5QW9CamE0dTEz?=
 =?utf-8?Q?FPKHgEC+9UhGktRuHGY2uWt7dzuHGKfVzJUNR+69fUkW+?=
X-MS-Exchange-AntiSpam-MessageData-1: NOlVIugtBULumg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c3057d-9f27-443f-6fe2-08df0e0c8183
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 00:51:38.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeUVsQ46mW/tB5vvd+oDRTETK6I1Sm/M/+WxwxFd6seNEkH8Z38oRsdyS2mxigPFSp0rQywA9S+2LBnzkSHoZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7443
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> Add a decoder for NVKV. This is for receiving messages from GSP for
> GMCAPI calls. The NVKV format essentially encodes a sequence of function
> calls f(key, index, value). This decoder reads an encoded stream and
> invokes a type implementing the new `Schema` visitor trait. The
> `Schema` trait can either consume the value or not, which is useful for
> composing Schemas. If a (key, index, value) is not consumed, error out
> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok or
> not is per each GMCAPI call.
>
> Add kunit tests for the decoder.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 265 +++++++++++++++++++++++++=
++++++
>  2 files changed, 268 insertions(+)
>
> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> index a8e16687a134..cbeee7f376b6 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
> @@ -27,6 +27,9 @@
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
> index 000000000000..ceb97e73e100
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.
> +
> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
> +
> +use kernel::prelude::*;
> +
> +use crate::gsp::nvkv::{
> +    Index,
> +    KeyId,
> +    Op,
> +    Opcode, //
> +};
> +use crate::num;
> +
> +/// A decoded NVKV value.
> +#[derive(Copy, Clone)]
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
> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema consum=
ed it.
> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderValu=
e<'a>) -> Result<bool>;
> +
> +    /// Returns an initializer that makes the decoded `Target`.
> +    ///
> +    /// After the returned initializer runs, the schema should be empty =
again.
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;

Would it make sense to make `finish` consume `self`? Because "the schema
should be empty again" sounds like an implicit contract not everybody
will think about enforcing, which could be a source of subtle bugs.

> +}
> +
> +/// A read position in an NVKV stream.
> +struct Cursor<'a> {
> +    data: &'a [u64],
> +}
> +
> +impl<'a> Cursor<'a> {
> +    fn new(data: &'a [u64]) -> Self {
> +        Self { data }
> +    }
> +
> +    fn is_empty(&self) -> bool {
> +        self.data.is_empty()
> +    }
> +
> +    fn take_u64(&mut self) -> Result<u64> {
> +        // PANIC: `take_u64s(1)` returns exactly one element on success.
> +        Ok(self.take_u64s(1)?[0])
> +    }
> +
> +    fn take_u8s(&mut self, count: usize) -> Result<&[u8]> {
> +        let values =3D self.take_u64s(count.div_ceil(8))?;
> +        values.as_bytes().get(..count).ok_or(EINVAL)
> +    }
> +
> +    fn take_u32s(&mut self, count: usize) -> Result<&[u32]> {
> +        let values =3D self.take_u64s(count.div_ceil(2))?;
> +        <[u32]>::ref_from_prefix_with_elems(values.as_bytes(), count)
> +            .map(|(elems, _)| elems)
> +            .map_err(|_| EINVAL)
> +    }
> +
> +    fn take_u64s(&mut self, count: usize) -> Result<&[u64]> {
> +        let (prefix, suffix) =3D self.data.split_at_checked(count).ok_or=
(EINVAL)?;
> +        self.data =3D suffix;
> +        Ok(prefix)
> +    }

nit: short one-liner doc for all these methods.

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
> +    fn visit<S: Schema>(
> +        &self,
> +        schema: &mut S,
> +        key: KeyId,
> +        index: Index,
> +        value: DecoderValue<'_>,
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
> +        base.checked_add(KeyId::try_from(offset)?).ok_or(EINVAL)
> +    }
> +
> +    /// Decodes every pair into `schema` and returns the result of [`Sch=
ema::finish`].
> +    pub(crate) fn decode<'s, S: Schema>(
> +        &self,
> +        schema: &'s mut S,
> +    ) -> Result<impl Init<S::Target, Error> + 's> {
> +        let mut cursor =3D Cursor::new(self.data);
> +        while !cursor.is_empty() {
> +            let op: Op =3D cursor.take_u64()?.into();
> +
> +            let key =3D op.key().into();
> +            let index =3D op.index();
> +            let op_value: u32 =3D op.value().into();
> +            match op.opcode()? {
> +                Opcode::Imm32 =3D> {
> +                    self.visit(schema, key, index, DecoderValue::Scalar3=
2(op_value))?;
> +                }
> +                Opcode::Seq32 =3D> {
> +                    let values =3D cursor.take_u32s(num::u32_as_usize(op=
_value))?;
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
> +        // The output type of the hand written Schema. In this case, we =
can have it also implement

nit: `Schema`.

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
> +            fn visit(&mut self, key: KeyId, index: Index, value: Decoder=
Value<'_>) -> Result<bool> {
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
> +
> +            fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ =
{
> +                Ok(core::mem::take(self))
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
> +        let mut schema =3D RawSchema::default();
> +        let decoded =3D KBox::try_init(decoder.decode(&mut schema)?, GFP=
_KERNEL)?;
> +
> +        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
> +        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
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
> +        assert!(decoder.decode(&mut RawSchema::default()).is_err());

This checks invalid keys, but can you also check the error path on
malformed input? And additional tests using raw data, since right now we
are only testing what our own encoder produces, which is not what the
GSP will fire at us. For instance: `Seq64` with more than 1 elements,
a zero-length array, an array which payload is less than its advertized
size, etc.

Also I just noticed the `Seq32` opcode is not tested by either encoder
nor decoder. I understand the encoder never emits it as of now and it's
fine, but the decoder path should probably be tested.
