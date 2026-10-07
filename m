Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EEDCA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261F710E45B;
	Wed,  7 Oct 2026 12:05:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DMdTr2MF";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BEC10E45B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:05:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcrqr8r+3i2kMLnHZdO2q0SFnwebBdeyT78gm0KT05Ha6DOruwdaH+GBs3tHG2JjEvfw+dqMq6QJf0T25/1TowMidR/MPL+7zSljL9bh/ydVvSRlg0HVJ6F45EYukF3UBsNG0o38cYKCcQ5y0uJaWD448tNCh/ZsM7wkRBoWcPSHIDt848FL569DfGjkvcNrpMvEoYj2Ik8xiKBbRChvZo7Env80bBRc3rIYPlyhrjj29zLRtNOq/mnUSyQhiRz+8CdRdKdGyXE+1b1gZa2o34sisSwosSRZgot8AzjFIqA3IU1vzUUK1uC+i7Y+Ok+ljl5DnW+k1anKCkU/umE32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E196s1UkZHTTn7POnkAishoEP0BvtZJxKx4aBw4xJrI=;
 b=U4wW5dChNex2IlrNnxOP4PXduZ/tjjTFhkHBp0VmNocBj4D/NZ8xJZ0QPvi9SAakVlG6JGm2VWPg021Jpv8kRExjS4eKe4jU3/pAhLtZIye/SjJUSSzYkmoWfDVpdMnztVCpf2gPgZs7ZeNjwmT6dgiyJ6ZxqBTr15wCYs72Y7y4AGTxcV/J1Pt5TGrecIJPmBubSQqUA5ZSTX68tKq5cOkK7dTf8R3mJnINFJ+lDi7gskl1b24zNxlu0cT7g3rPTV8Mgm4+isaKB+/ZoTS1uSXliTztq+Ps8RuQoFz77tqShrMpWY5ZZUXi+pIwLWstQac4Ajvy5fSxPdYWftGbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E196s1UkZHTTn7POnkAishoEP0BvtZJxKx4aBw4xJrI=;
 b=DMdTr2MFVfvb8VnpJh3BlKR8BDLe2IEaoaiE9+qKth3Qxwn2e9ssetEiklQoCwLRnvpyTeAMoP8ya6i+YNzciyIAxO98e+tk/HRqdKEljcoI1QPdx0CTA4wwboJvIkqcVuKobXAAYYPflw548hymMd1jaYoYQGZrmJqGGyYXcrEWZsqzKA16B9TLODQfXnW3EZKQpD9UCknd2wCkQeFpszrmH+X4n0Y3iuUFwvVWo5I2tCvWIWVs6cMjp4DnO8dYbohEs1aL9tdFIIrRWTgTXC71kNL0GFEh3E35sArgVQ906mw87kvmmY0BDOB0/obZfhmYCi5/GFogPoLC1wIBAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 12:05:31 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 12:05:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 21:05:28 +0900
Message-Id: <DLYLCD5IPKGZ.2DMT37GPHPP74@nvidia.com>
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
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-7-f04504c262c2@nvidia.com>
X-ClientProxiedBy: OS3P286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f474cc4-fa6b-4c49-8d01-08df246b48b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|7416014|23010399003|376014|56012099006|5023799004|4143699003|11063799006|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6/eWntS5paoyfBokQMVLc5C87HobF//bM4ycfS78/iPs5wDNtQG7EsnmB/nIJ/gJDb5dB3prbsbusxwg/6uArAGWz0UsSiNk41c1BawGhTm/+HrGd6VZ1cts5HcATYKCbDIAQwnYni29arGcKHfoqSL+YjYLEUwtVvU0pCeDL2/XZARaW/s8+j+INcMvGJarXLEUSI6lGjaczcUqjs12ExaHdSEWGkp0MbCNMt749unRQUBUonzPYAcnaJMX/i1vJWzcFfgk4mmDN8xh9HmaQsEURD8KudWVYHPfLpK3Pce/psx3dKWWxY4tbVhPZPgQFn9VZGwDc8veO7zmGhkTDaBcDhwbmHXmLwid+vZK2prTZ7ajdFFK5VRN0zd62G6JLGln/pKe6k+Tf97WpOE5eFZ8GgUAl3rLUfgo4QJ96JpkAoc1jaOsDTnF8t1mt9UI1ZjzogNsWM+9dtRnxRPz2oDKPKmPyDF+3v1FUXCO4DeC6NHV2DGwKSkt8s6vD7mDlrHilJG1G/AMoV/VVe5TAiuzj3Flr7pvsvanHeWg/LnvtBno43X1nxr/ZEoenbOJMv4e6kVbwacsZNELSW8YaykpGACL0nTiUFPF3fRcdFxnQZvOSoCDY1V3Q0l3DecavxBcdQyNWLXNNS2M0THwON2SbNAUGmEesOHNg56NuKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(23010399003)(376014)(56012099006)(5023799004)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFR1emN3MjdJYUUxWndRL2VTd0pVeUlVZkZVZyt6UjhoUm9Mb3BJTC9sN3NN?=
 =?utf-8?B?MkZDeVBOdlBQQVNOUWpGV2hQYzNRa3JpQVRWOGY2VmZYTm0zcXdSeDBLMk9X?=
 =?utf-8?B?TjJrSFV3Mk13dm5ielBxeDgyL3ZYUDNZaUJHTU96M1JRWEovbGJJekIxdTRL?=
 =?utf-8?B?VVBMVW5xUHpvRlN1RUUrcVJMOW91aUpCVldIa2xqWkNubjFJNk1IcHEvQm5C?=
 =?utf-8?B?clVod2xESXRUNjJ3dmdsMTNwZk5VeHNndkU2Sis5S0tIOEkyTUE4S2lJYXZN?=
 =?utf-8?B?Q1FuQ1pJclY2WFZmZ0N4Z29Oekx2ZmRGY0FSZDFRdkRJTjNBOWlTYk1vcVNH?=
 =?utf-8?B?VGJJb2FHa0hUYzh4OStpcmtjbUlXS09BOXVueXJ3Z1BQbUVNeTBQT1hoSkpP?=
 =?utf-8?B?ei9LUzRCSmtWT0RuaEFkRnN5OW95a3RTRytCOUFmaE9UNVhFMFZPVmlGcEhh?=
 =?utf-8?B?NThBNm1TSjZ5WVhRazVVa0YxelltcjVnaVZGbkt4SWV0YThVSCswdGJEWWgv?=
 =?utf-8?B?dEZiR2hmOThkMDloS01KdmpjZkM3dzl3U3J4WGN0MGM5bUVxZ3g5SUkyTDBV?=
 =?utf-8?B?VFZMb3ZPL0ZJSGJJUng5V0N5SW0vVlljRkR4MEQ0MGZ6ckhjbWd0WWlpNFMx?=
 =?utf-8?B?d3RwMnhuaDh4NDFtd0t4RFovSit3Q0ZMMTN0Nkw1VEt5SkJGTVlxbUVGMlZq?=
 =?utf-8?B?ZmMwU0N5aHBFZnZLeXZKdkpIbTNXeWhWSUFtS3lNS2FJdStpTjNkNTJOV1ow?=
 =?utf-8?B?VktlVi9id3BBdG9aeWJmL3BUL0tvaCtyNUVwcmp3ZXFKL0FnVXp2anI3dXFW?=
 =?utf-8?B?cXZPamk0QkVwWG0veDhmc2VqWkFTaWV4czhEazU2SVhadVNjQ1QzYkxVNjB4?=
 =?utf-8?B?d1BTM1ZVbitpWjVITzNrSjdLQ09SVUQ2Slp5TkVIU1JnbHpURmlWS2pjNER5?=
 =?utf-8?B?TEpXb3BxVlFzcURNOVRZNUwwbjlQcVEvOUM5TU1hUDBzZlI4N053SGkrS0Jh?=
 =?utf-8?B?bmNQTndJb25QMzFwN3dSWkw3N0IxMmNRUjdlKzU2SXpTVWxhWTlNaG5IMU9J?=
 =?utf-8?B?dHo1RVp6NEN1VEJTTkNNTGxGYTRHSlBRNThNMzFRS0RhT1pMNGNYbTVPQXF0?=
 =?utf-8?B?c1dSRWNlVXBSRDFzc1N2bXNNYmJvYm1DbUJ2dGU1bEVna25acG43a0FiZGNS?=
 =?utf-8?B?WG1VeUllWm1NYW1aRDlENzZ2WFFLbGRBN1VTNjFDMjdEVHZLVzhVdVJmWWlx?=
 =?utf-8?B?dXJlZWdPK09uYUFBeUpxdHZHeWIrSlhabFdnaHI5TGdmMjlnNTJ1UVgzbG53?=
 =?utf-8?B?NTYzSmIxNXk0Wm84bUFrcXhGRjgyWDBtK21UNCtSNXhSaTNuOUVhWEpHQ1hP?=
 =?utf-8?B?d29ObDN6dDVDdWR2V3NvSVVTSS9FMGVFTjJncDBWbFM4WE1YZnNUckVEQVZQ?=
 =?utf-8?B?K0JxTUoyNlRWWHVpcWpvSENFREl2cGRqYzFIVGRleld5SVIxeldqV0NoNlVQ?=
 =?utf-8?B?Zm5raDJWNDdaVU1HeUo2eVUyN3B1UTQwM1ZtNUE0R2Fzc0RqOEliaWVEZUNz?=
 =?utf-8?B?aTFTcDFma09wVldvbFZtb2U5QUdoZFlEY0wxdUtkckFIdVBvTldEdWtUNGdU?=
 =?utf-8?B?a3V0WDY4MmZIU284TnJRWGYzajJvSURtVG1BZnBkRUVVSE9YWmRmdHpHTU5x?=
 =?utf-8?B?SlRwR1ZHbVZaMDhrWTdFbXltaFd3OVYzWUtXV0FpMFRnUUprNlg2NUNkZG5k?=
 =?utf-8?B?UERLSTBXL3JQaFpvdEJNU0Q3RWkyYUJaakpITXVCSGJnVzJyWFZ0SzRHUEt3?=
 =?utf-8?B?dTBhVjFZbGJWZ0RDSDFobXpWQi9uOGdxNDdGYjl3TnpSd3VTcWxnSzdtSkZW?=
 =?utf-8?B?Z1dmcE8rMEE4VHhBNUFoaTlNaXhObWhwNXFuUXdzMC95TG1IUWVyejJlVE1P?=
 =?utf-8?B?cnZ3enA2Zk53M3BBVWRNQk9Pb2JJNG9idXgwK21SVExrZHladkdtMjAva01N?=
 =?utf-8?B?UjBhTTBlSi9TaUwzbUsvV3VadTJHam04VUx1SDM5ZnJtRExQMTU3WVhJaHNX?=
 =?utf-8?B?eG5nZVdTTkk3M0lKUG82S3N1Z0QyeTRhZ1ZhN215djRJcVdIUnhtblpJa3Ba?=
 =?utf-8?B?R2VuZU1IK0JnOVZSWDlNZ2V0ckErNEhDM2daMGllZHRwMlpiSm95VEl2RWNK?=
 =?utf-8?B?ZTY2WFVicVF3OWpjMExMaTNjYUNsckJYMy9ZVVJ4MGRkNWd4dW5MdGQ4aEVV?=
 =?utf-8?B?U3BOd2MwdzVMbDVOVWlSNHFUeDhuZ2grL05iaEdWYzFXT3VBTFJ0OTB2eGJ1?=
 =?utf-8?B?ODVmanVMZ2luMGM5bEhEZHZEZlorVHl4WmltdmxnWjUwdEN1cVJYWWtFMC9B?=
 =?utf-8?Q?Y6xcV0UJ/Y84LUDtXPc4cdsveXHLQVingUnEas61i7LqC?=
X-MS-Exchange-AntiSpam-MessageData-1: aB0xEfqsEhJ92Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f474cc4-fa6b-4c49-8d01-08df246b48b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:05:31.1532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG3CDLURbMHzUI+SEbvAdp/PxA7YCgQLRhJt5RG9uK0/IWdlGyG5HRZEgyms2PTlsO28Ug50MzRY93T20whoeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248
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

Sorry, some follow-up comments after my previous review.

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

I see that `#[repr(transparent)]` is used several times in this series,
but is there a need for it? Same for the many `#[inline]`s, here I feel
like letting the compiler arrange things as it wants might be the better
call. I know I suggested downgrading from always-inline to just inline,
so maybe we should go all the way here. These are very likely to be
inlined anyway, and worst case I don't think a function call would
induce a big cost.

<...>
> +impl<T: Default, const KEY_ID: KeyId> Schema for Key<T, KEY_ID> {
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn init() -> impl Init<Self> {
> +        Self::default()
> +    }
> +
> +    #[inline]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        Ok(core::mem::take(&mut self.0))
> +    }
> +}

Both methods return the built value on the stack, which is fine when we
only deal with scalars but technically we could also store larger
values. How about a `const_assert!` ensuring we don't go beyond, say, 32
bytes for the size of `T` and `Target`?

<...>
> +/// A schema field for a key that must be present.
> +///
> +/// `finish` fails with `EINVAL` if no value arrived for the key.
> +#[repr(transparent)]
> +pub(crate) struct Required<T, const KEY_ID: KeyId>(Key<Option<T>, KEY_ID=
>);
> +
> +impl<T, const KEY_ID: KeyId> Schema for Required<T, KEY_ID> {
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn init() -> impl Init<Self> {
> +        Self(None.into())
> +    }
> +
> +    #[inline]
> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
> +        (self.0).0.take().ok_or(EINVAL)

I've experimented a bit with my earlier suggestion of having a wrapping
`Required` type because I wasn't so sure it would work, but it seems to
be indeed doable! Here is my draft implementation:

pub(crate) struct Required<S: Schema> {
    inner: S,
    parsed: bool,
}

impl<S: Schema> Schema for Required<S> {
    type Target =3D S::Target;

    fn init() -> impl Init<Self> {
        init!(Self { inner <- S::init(), parsed: false })
    }

    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_ {
        // Reset `self.parsed` to make the schema empty again per the metho=
d contract.
        let parsed =3D core::mem::take(&mut self.parsed);
        self.inner
            .finish()
            .chain(move |_| if parsed { Ok(()) } else { Err(EINVAL) })
    }
}

impl<'data, S: Schema + Visit<'data>> Visit<'data> for Required<S> {
    fn visit(&mut self, key: KeyId, index: Index, value: DecoderValue<'data=
>) -> Result<bool> {
        let consumed =3D self.inner.visit(key, index, value)?;
        self.parsed |=3D consumed;
        Ok(consumed)
    }
}

You need to convert all the `Required<T, ...>` into `Required<Key<T,
...>>`, but this reads more logically I think, and now you can combine
`Required` with more types. I believe you could also implement
`Optional` in a similar way.

(you will also need to add a `#[derive(Default)]` to `FbRegionFlags` on
the next patch, but that's not a big deal since it wraps a primitive
type anyway)
