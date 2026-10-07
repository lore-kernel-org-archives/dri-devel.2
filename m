Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF2DCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12CD10E3FB;
	Wed,  7 Oct 2026 06:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2ALLfYx";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBEF510E3FB
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 06:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFV6fFOLEWDGuR9xIZDqglw+5Y7edxxFiEef5oJ0T6gNKTseZhdDPUvpboosDpjKmO+qV8xvJO4HnRlkOFfPzr4bA64ezN+7/sPY2d/1JQJ2TYv5rnnC62llN21abQyY5PZP4w3krlCl5yQCeBIjIeFfCLD9GlGYCGzwpXj0Bxk0CH/49CX2SKHw1CyrEFNDBI3eKvspUQU+tRMMeP2r+jYYAMi51SPc9X8akDzE30VgVfL6pK/aSxKOnGZN/xdDhByfZThSPjKUwvl20IuNzyePow9PiPthwtLLn4GJWWj0OFmbAWk7ISmKPU30PGZ9h/ah3/adjPfWHjosuLgo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ92xTFCDou9bnxwjCEw6NJJW8TSZRh616xx3M695PY=;
 b=XxUhl10eMAAyEvXZ+qMjlKnG6inne/0S5vnyM6+dBjlpW5JlG53Bv/T23m20ccu2QduCv7L6PkCW7eqCHOi9xTQCCjCkRjpapaL6/+tnI2j/B3cyRZQH62wXlXCQZ849z6DOVMjKyxDAzDs9OQXYODsaZF1zMwONA4rcx6fWKainUSIIRIwWfvbs9X2i2XrrrIfdWGzPX1uTplsv/2pwpeb3hPt9MR4xR1uGz2yGCiIjp7gUJIu1hrjTcawHFeXrG24KHaluC3gaLpBiqG1pxhuwI0V09epCYer+L2PmSK8Z0YINEDaS2+ZchHJXnmGqm/dY6gF5cxB6lEn+3w1zDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ92xTFCDou9bnxwjCEw6NJJW8TSZRh616xx3M695PY=;
 b=Y2ALLfYxScw2fqRKtR4qaeRmOD7I68qtyYge2ijt4KcwjBVbIZCfldtZUQ7q7W649derTNLMeuoNhcIWiVKuL+YVLgfp36lVAG0NLDCM4TXo5Eulir8eerda4qNig7c+9rkx+XiFjbWYFT21BjuSjsNGVuePqXMcTIoeYN+BOqNkxMrX1Q8sq/53g6eFELPWpfcLVrreBxKJ46yPh7h9C5PTSgamPIlF08etkfId0p/nUpzd0N7L+BTBIVncOuQ5DtN96wWfUsU5V1LZb560EHnYQbt/5Bzoh8S+E1tyIkpTWqp64lydEuIn3KUCIskQZUIv36PTyfJrHaz1zHukvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPF4C71815F9.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::992) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 06:30:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 06:30:19 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 15:30:17 +0900
Message-Id: <DLYE7QGIIJ66.3SKOCYO9GAMCA@nvidia.com>
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
Subject: Re: [PATCH v3 7/8] gpu: nova-core: add NVKV typed decoding
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TY4P301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPF4C71815F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a28eef5-927f-4bed-2080-08df243c757d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|10063799003|3023799007;
X-Microsoft-Antispam-Message-Info: iQ5g4d8YHZDk7XccA6Ls4FCGZ5yR+4chGmhgZ4U8fO0KYjaqlm9HaHJMbB9g5SY438PI7VprS860tuzBgzvSI+5ybL80KjGgwXfDvsMb3/fK053+oMocXpS+fhgdYaq7FaeP0VsUFYAqgtn0P3TmbaSptx+tCdz/vl/iGsueFu1iAP3UtbK+W0AT3k/j9BwRYewWS9caxKD5lzSFZHTM7smLYtNMRMkCBg+ezd1Rfdud33G+3qIo+gnLMQebzGq+lz24yqaw6T4EIAwwRUP6oNLUYQpuJIJMvNCEiChAJoWz0g6zS9RY3N/+dldOBN4jT9EnOkgWAjcg3BUjdM/40AYUid7CMyAnsvi6XGGhoC+IC+zWTQ4i+U0vrYgHX2A1Q54u3ZNbzRuI7WKDRtxE1Z+KQHFs3+mrTbcHNO0Nf11FjpAbjWK0H9bT+wT7u3kELVGlJWJl6M9mfhBqm2YQZ1jbM3QBEQBmN/NrPJ01ewItJfzSXb0DNT/99rKZ8tepuY86Nf1kpkXG0qH/boDrL1eGFEt1+8vFlTPVK0d3aeKMvXGQnYXv/JkWaYdcywAqkmd2/vgH9YSvwcDifzlzYn6M/TtCVjKsE1oYWBNHnpmZA6Lu3Ci47/SNQoWqnweSWdSPAkkjs3N05DBq7lULKTwrdUJ3uNuefeRg+2l5uo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(10063799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJUMmZFUmx6blpTcXFPQ09ZYVJ4SnMyRGVjeVUrL1hVRzRUUEszUDdDYXFY?=
 =?utf-8?B?ZEJ1K09iellWcUphSCt0cVFuRzJTd3dVNnNyOVN0OU1XQ3FoVXNIWkdHR2hp?=
 =?utf-8?B?eVNxVTlOZm1BN3lxNUtsMlg3MUt3endlTm5kZEVleTZLek5qRTlraUpxQ0k3?=
 =?utf-8?B?SnV1bGVaVGZ0ZE5tNDYrTFNBbm5kY0szcWtQWTNyZVNiQ2VuN3ZleTZGeEhY?=
 =?utf-8?B?cjNVRGZwWWdHRDB2YWI4M2QzVURXaGwzQis4N1FoU2FwK1hiTFp6dE5lS2k3?=
 =?utf-8?B?OGpGZ1NvOVhpc2VnRExZYUovMW1YNmxuUms0VjYwYW8xbkdvYjI2NDhwU3lm?=
 =?utf-8?B?NTRiZHJSZUJBK1BjcUhZdGdZWGg2M002N1BaYXk1M3FLZFRITXhlWnJrTlQ4?=
 =?utf-8?B?UFdaTUFUKy9YYktJQWJTbnZaNjJQR2pSR1ozVzJuVU53aHlIalAvY1Q1ZVA0?=
 =?utf-8?B?U081Q3czNVFOTFZmaGh1RlcveGFyajEzU0RsU2VsMW82MFpEdFBBdno3dzBH?=
 =?utf-8?B?bGxhRVgxdHg2cmtuR1cwYlA1VjhDMVdFWTZaR0Z4Q0V3SC9SVlhEVVluSXZ3?=
 =?utf-8?B?MmJCOEVRYk1qRlg2T2c2ekw2M2U5WEVxYlNva1IwRndOUkY5dER0MVBmcFkz?=
 =?utf-8?B?QVJRNjhrOUoxb3JqK3FpdE9yNDM3eTV2anpiYUxtcmp4S3JlNDJEK3ROMDNT?=
 =?utf-8?B?T2F5dVhoZFp6ZEh6bWdMU2VTKzhOcDJHRDdtclhodjNFTGFTOTVad0VjTStH?=
 =?utf-8?B?WWk0Sk1hNnF1MDRsb2FhaUVxOHdGR1JtSm1vclU3cWh5MnVuZWpBYXk0Mjlw?=
 =?utf-8?B?QXBsakhmZ0thaGdtV0V5YUJ2N2FncEVxK3lJaUp2anhPYTlsU3hKTzJPNW50?=
 =?utf-8?B?azZyUG14NHJ1SG5xcmZYUFNrbmxRa1NSaVlzQmJSTmFoNmFJbGw4VW1pd0pj?=
 =?utf-8?B?aHJzcFJpdGtXMGJhVVJYREw5b2xESFZEbmp6N294cDR6YTBudVB1TWpZckI2?=
 =?utf-8?B?Z1IrZWdKcnN2VXl2ZThQRUhFL0t4Z2FqbXZFVWEvQWFzckRVVFY4WUxISFl2?=
 =?utf-8?B?eVMrU2JlSGZwTldQOC9LZkgyNmdtYzhKNlliUCs0dFB4MS84YzZyalJLdFdZ?=
 =?utf-8?B?ZTgrRFdyd3RNUVUyOVU4bG5YZDRCTlhhd1NKVk8zV2FnelJHM1IvMFE0V3NE?=
 =?utf-8?B?YmJ3WUJNcVo1eG80a0h0Mll5M1dLSUlMeXlvWktOZmhqTEtZSHBEdHlwV1dI?=
 =?utf-8?B?R1RTNy9vTWV1YTJGOXZJSysvWlNMbDVsdU82UE9CR3dQQk1ydmFGUjVXMnB1?=
 =?utf-8?B?aXJFZVdnVkxXTnFUbTZqNEY5UHc3MTVVZTRtWGRIUERqYzdsdzQ5N0dDb3RW?=
 =?utf-8?B?Z29XYlNCbXBCSEZWWTIzcktDTUpvM2RlOUhLcnpITHdUNEk3ZmlubnBZL0h5?=
 =?utf-8?B?M29hODZBVk43VWt3ajJkNjlEckFPajEvWnJuSUNQbjJTOUwxV1NuL1ZYdU4x?=
 =?utf-8?B?MmtYU0JwUG9NckloWEtGbDY1RzBPaHFsMGVwZ2RlTnU0QklsR0FMVEN6VHlZ?=
 =?utf-8?B?eWFsOCtHUGNwWDRKeUluTmxQQzd6dXF4NnFlYzhRR0xPTWtzYWZNZmtvem02?=
 =?utf-8?B?WE9pZTAxcCtRYUtVWXZ0STVtTWJQRERvalVmWG9TL08yWTJnaTVGcUg1ZXZ2?=
 =?utf-8?B?ek4vaGYvMHJBUmNWSjB2UDRjTGo5ejQ4NHFuWnNrT09DVkpMRGNqeS9XTjBm?=
 =?utf-8?B?ZHM0ViswS25YeFhhbmxaZmNrbFN6c0dGSFNmd2ZPVW9zWXdjSHFIUmZzR0Z4?=
 =?utf-8?B?aUpnNDBmVkNRdWVYSWZ4YWxkZlAvVmFaSG9OeDdQWkk3ZVhUK0dRRnpJelVz?=
 =?utf-8?B?UGpLT0lBUTg0cDNLdWFDNmw4emFwdk1YL3ZpLytPMFc0UlVuc2pVbmNmU1Z6?=
 =?utf-8?B?MzhjeW02bng4Y2ZzdVdVdGRwR1VYNEg4UjdJQWZtaFRGM1p0U0ZIeUN6YUN3?=
 =?utf-8?B?eCtCYUdHRVpkRkJURzh3eS9YWXlsR2VVYWw5eWxZODZMbWRreTkzRTN2bUJz?=
 =?utf-8?B?MjlRUDVVaGdBOVNIU2M1UjZxdGtjcHhxajB2NDk1Nm1CbHpQWU5TSFdDWlda?=
 =?utf-8?B?bFpSWVBaRTR2WHp5aXFHMnE3SnV3Qi9pRFhyc3hxMHU4b1orM1AxWU5RNU9E?=
 =?utf-8?B?V0owdkg5dEtkdk9nV0k2NzMxMWxwZXllQytWZnh0OHd0QjJuTXk1SVhGNHdW?=
 =?utf-8?B?RnVWeU5aVlhrRFJhOHVtamRqU2NiUlAvUkRHdW8xMGdKNEZCRG5WSkFFUitj?=
 =?utf-8?B?VU95Q2ZnakpmeWRBMWVBcG9WQ3RCL1FGY21zNWdqc2xNWi92M0VDK2kxY1M5?=
 =?utf-8?Q?qCYj1zXQ/S+0WS20qoc8bwPZU9hoVfB3Q2J9mgRWvwHIM?=
X-MS-Exchange-AntiSpam-MessageData-1: cC86FmhXU2J63Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a28eef5-927f-4bed-2080-08df243c757d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 06:30:19.8786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfJB8CiEC/eMAFijlkfpme1znePfFo0F50oskkwEVLUqBi8vyA0DOltGaRDq6N2WT/Y0UtvFIVXPHT8aIoAGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C71815F9
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
> Similar to the typed encoding layer, add some decoding type machinery.
> Add a simple macro `nvkv_decode!` which implements `Schema` for a struct
> by composing visit calls to each member. Add some common `Schema` kinds,
> such as `Array` which collects an array value into a fixed maximum size
> array, and `Required` which fails a decode if the value is not sent.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/nvkv.rs        |  11 +-
>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 622 +++++++++++++++++++++++++=
+++++-
>  2 files changed, 628 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core/gs=
p/nvkv.rs
> index 7ac3a459a98b..5791df07a7fa 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
> @@ -9,7 +9,7 @@
>  //! function calls will map to some struct - for example, f(GPU_NAME_STR=
ING_KEY, 0, b"some gpu")
>  //! naturally maps to storing a &str with the GPU name.
> =20
> -#![expect(unused_imports)]
> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_imports))]
>  #![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
> =20
>  use core::{
> @@ -23,7 +23,8 @@
>  use kernel::{
>      alloc::{
>          allocator::KVmalloc,
> -        Allocator, //
> +        Allocator,
> +        ArrayVec, //
>      },
>      bitfield,
>      num::Bounded,
> @@ -148,6 +149,12 @@ fn default() -> Self {
>      }
>  }
> =20
> +/// A schema field for an array value under the NVKV key `KEY_ID`.
> +#[repr(transparent)]
> +pub(crate) struct Array<T: Default + Copy, const N: usize, const KEY_ID:=
 KeyId> {
> +    vec: ArrayVec<T, N>,
> +}

I still don't see why this needs to be declared in this module when no
encoder element ever uses it, and the module reexports everything from
`decode` anyway. Can this be moved next to the other schema kinds?

> +
>  bitfield! {
>      /// The op word that starts each NVKV operation.
>      struct Op(u64) {
> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/decode.rs
> index c4c24fe1108e..24dad31296cb 100644
> --- a/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
> @@ -3,11 +3,22 @@
> =20
>  #![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
> =20
> -use kernel::prelude::*;
> +use core::{
> +    convert::Infallible,
> +    marker::PhantomData, //
> +};
> +
> +use kernel::{
> +    alloc::ArrayVec,
> +    prelude::*, //
> +};
> +use pin_init::init_array_from_fn;
> =20
>  use crate::{
>      gsp::nvkv::{
> +        Array,
>          Index,
> +        Key,
>          KeyId,
>          Op,
>          Opcode, //
> @@ -15,6 +26,353 @@
>      num, //
>  };
> =20
> +/// Defines a schema struct together with its [`Schema`] and [`Visit`] i=
mplementations that decode
> +/// into `$target`.
> +///
> +/// Each member of the struct should implement [`Schema`] and [`Visit`].=
 For every (key, index,
> +/// value) triple decoded from the NVKV stream, the generated parent `Vi=
sit` implementation will

nit: let's put backticks around (key, index, value) and link to `Visit`
(and other types mentioned in this doccomment, and possibly elsewhere in
this patch).

<...>
> +/// A schema field for a key that must be present.
> +///
> +/// `finish` fails with `EINVAL` if no value arrived for the key.
> +#[repr(transparent)]
> +pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID=
>);

I just noticed that the schema field types are conflating several
concepts together. On the one hand, you have types associating a key to
some kind of storage (Key, Array, Indexed - let's call these leaf
types), and on the other what looks like modifiers on said leaf types
(Accumulated).

Which leaves `Required` somewhere in between, as it takes a key
parameter and can only be applied to value types, i.e. you currently
cannot have a `Required<Array<...>>`. But `Accumulated<Array<...>>` does
work IIUC.

So I think `Required` should work the same way as `Accumulated`, i.e.
just wrap it around the type you want to make required, instead of
switching the leaf type.

And for symmetry, we should also have an `Optional` wrapper type, so we
can also make fields optional even if they are not `Key`s instead of
having specific behavior for `Key<Option>` (which again is not
composable).

Which would give us 3 leaf types (Key, Array, Indexed) and 3 modifiers
(Required, Optional, Accumulated), with a non-wrapped leaf meaning
"default if unspecified" - which is easier to understand than the
current types where `Required` is a synonym for "a `Key` except it's
required".

This means `Required` would then be used like `Required<Key<...>>`,
which is a bit more verbose, but again nicer to read.

<...>
>  /// A decoded NVKV value.
>  #[derive(Copy, Clone, Debug, PartialEq, Eq)]
>  pub(crate) enum DecoderValue<'a> {
> @@ -51,7 +409,16 @@ fn try_from(value: DecoderValue<'a>) -> Result<Self> =
{
>  impl_try_from_decoder_value!(&'a [u32], Array32);
>  impl_try_from_decoder_value!(&'a [u64], Array64);
> =20
> -/// A visitor that consumes decoded NVKV and produces a `Target`.

Why change this doccomment? Let's introduce its final form in patch 5.

> +/// Lets `Key<Option<T>, KEY_ID>` accept whatever `Key<T, KEY_ID>` accep=
ts.
> +impl<'a, T: TryFrom<DecoderValue<'a>, Error =3D Error>> TryFrom<DecoderV=
alue<'a>> for Option<T> {
> +    type Error =3D Error;
> +
> +    fn try_from(value: DecoderValue<'a>) -> Result<Self> {
> +        T::try_from(value).map(Some)
> +    }
> +}

IIUC this block could go away if we add an `Optional` wrapper suggested
above.

> +
> +/// The state of one NVKV decode operation which produces a target value=
 `Target`.
>  pub(crate) trait Schema {
>      type Target;
> =20
> @@ -65,7 +432,12 @@ fn init() -> impl Init<Self>
> =20
>      /// Returns an initializer that makes the decoded `Target`.
>      ///
> -    /// After the returned initializer runs, the schema should be empty =
again.
> +    /// After the returned initializer runs successfully, the schema mus=
t be empty again. For
> +    /// example, this is required by [`Accumulated`] which finishes one =
object and then decodes the
> +    /// next one with the same schema. Implementations generated by `nvk=
v_decode!` meet this
> +    /// requirement. If the initializer fails, the `Schema` can be in a =
valid but non-fresh state.
> +    /// Taking `self` instead of `&mut self` would avoid this contract, =
but it forces a copy of the
> +    /// schema onto the stack.

Let's not cite specific implementations in the doccomment of a trait. We
want to say that the schema *must* be empty (as opposed to "should")
from patch 5, and that should be clear enough and sufficient. I'd also
move the last sentence to patch 5, and drop the rest.

>      fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
>  }
> =20
> @@ -295,6 +667,133 @@ fn visit(&mut self, key: KeyId, index: Index, value=
: DecoderValue<'d>) -> Result
>          Ok(())
>      }
> =20
> +    // Tests that decoding via the `nvkv_decode!` macro works correctly.
> +    #[test]
> +    fn decode_typed_struct() -> Result {
> +        const SCALAR32_KEY: KeyId =3D 0x1234;
> +        const SCALAR64_KEY: KeyId =3D 0x1235;
> +        const ARRAY8_KEY: KeyId =3D 0x1236;
> +        const ARRAY32_KEY: KeyId =3D 0x1237;
> +        const ARRAY64_KEY: KeyId =3D 0x1238;
> +        const OPT_PRESENT_KEY: KeyId =3D 0x1239;
> +        const OPT_ABSENT_KEY: KeyId =3D 0x123a;
> +        const X_KEY: KeyId =3D 0x0100;
> +        const Y_KEY: KeyId =3D 0x0101;
> +        const SLOT_KEY: KeyId =3D 0x0200;
> +
> +        const SCALAR32_VALUE: u32 =3D 0x89ab_cdef;
> +        const SCALAR64_VALUE: u64 =3D 0x0123_4567_89ab_cdef;
> +        const ARRAY8_VALUE: &[u8] =3D &[0x12, 0x34, 0x56];
> +        const ARRAY32_VALUE: &[u32] =3D &[0x0123_4567, 0x89ab_cdef];
> +        const ARRAY64_VALUE: &[u64] =3D &[0x0123_4567_89ab_cdef, 0xfedc_=
ba98_7654_3210];
> +        const OPT_PRESENT_VALUE: u32 =3D 0x55;
> +
> +        nvkv_decode! {
> +            struct PairSchema =3D> Pair {
> +                x: Required<u32, X_KEY>,
> +                y: Required<u32, Y_KEY>,
> +            }
> +        }
> +
> +        struct Pair {
> +            x: u32,
> +            y: u32,
> +        }
> +
> +        nvkv_decode! {
> +            struct TestSchema =3D> TestDecodeable {
> +                scalar32: Required<u32, SCALAR32_KEY>,
> +                scalar64: Required<u64, SCALAR64_KEY>,
> +                array8: Array<u8, 64, ARRAY8_KEY>,
> +                array32: Array<u32, 64, ARRAY32_KEY>,
> +                array64: Array<u64, 32, ARRAY64_KEY>,
> +                opt_present: Key<Option<u32>, OPT_PRESENT_KEY>,
> +                opt_absent: Key<Option<u32>, OPT_ABSENT_KEY>,
> +                pairs: Accumulated<PairSchema>,
> +                slots: Indexed<u32, 4, SLOT_KEY>,
> +            }
> +        }
> +
> +        struct TestDecodeable {
> +            scalar32: u32,
> +            scalar64: u64,
> +            array8: ArrayVec<u8, 64>,
> +            array32: ArrayVec<u32, 64>,
> +            array64: ArrayVec<u64, 32>,
> +            opt_present: Option<u32>,
> +            opt_absent: Option<u32>,
> +            pairs: KVVec<Pair>,
> +            slots: [u32; 4],
> +        }
> +
> +        let index0 =3D Index::new::<0>();
> +        let index1 =3D Index::new::<1>();
> +        let index2 =3D Index::new::<2>();
> +        let mut encoder =3D Encoder::new();
> +        encoder.encode_u32(SCALAR32_KEY, index0, SCALAR32_VALUE)?;
> +        encoder.encode_u64(SCALAR64_KEY, index0, SCALAR64_VALUE)?;
> +        encoder.encode_array8(ARRAY8_KEY, index0, ARRAY8_VALUE)?;
> +        encoder.encode_array32(ARRAY32_KEY, index0, ARRAY32_VALUE)?;
> +        encoder.encode_array64(ARRAY64_KEY, index0, ARRAY64_VALUE)?;
> +        encoder.encode_u32(OPT_PRESENT_KEY, index0, OPT_PRESENT_VALUE)?;
> +        encoder.encode_u32(X_KEY, index0, 1)?;
> +        encoder.encode_u32(Y_KEY, index0, 2)?;
> +        encoder.encode_u32(SLOT_KEY, index1, 20)?;
> +        encoder.encode_u32(X_KEY, index1, 3)?;
> +        encoder.encode_u32(Y_KEY, index1, 4)?;
> +        encoder.encode_u32(SLOT_KEY, index0, 10)?;
> +        encoder.encode_array32(SLOT_KEY, index2, &[30, 40])?;
> +        let serialized =3D encoder.finish();
> +
> +        let decoder =3D Decoder::new(&serialized, UnknownKeyPolicy::Erro=
r);
> +        let mut schema =3D KBox::init(TestSchema::init(), GFP_KERNEL)?;
> +        let decoded =3D KBox::try_init(decoder.decode(&mut *schema)?, GF=
P_KERNEL)?;
> +
> +        assert_eq!(decoded.scalar32, SCALAR32_VALUE);
> +        assert_eq!(decoded.scalar64, SCALAR64_VALUE);
> +        assert_eq!(*decoded.array8, *ARRAY8_VALUE);
> +        assert_eq!(*decoded.array32, *ARRAY32_VALUE);
> +        assert_eq!(*decoded.array64, *ARRAY64_VALUE);
> +        assert_eq!(decoded.opt_present, Some(OPT_PRESENT_VALUE));
> +        assert_eq!(decoded.opt_absent, None);
> +        assert_eq!(decoded.pairs.len(), 2);
> +        assert_eq!(decoded.pairs[0].x, 1);
> +        assert_eq!(decoded.pairs[0].y, 2);
> +        assert_eq!(decoded.pairs[1].x, 3);
> +        assert_eq!(decoded.pairs[1].y, 4);
> +        assert_eq!(decoded.slots, [10, 20, 30, 40]);
> +
> +        Ok(())
> +    }
> +
> +    // Tests that a schema too large for the stack decodes on the heap.

How are we testing this? Do we expect the stack to explode as a test
failure? That should be guaranteed by the use of `KBox` and `init`, so I
am not sure there is much to test here...

But if you decide to keep it, let's at least size the schema so the
stack *actually* explodes: 2KB is not enough, we want at least 16KB, and
for good measure let's go with at least 128KB to be sure. Otherwise I
think it's fine to drop this test.
