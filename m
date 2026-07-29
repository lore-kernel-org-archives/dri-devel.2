Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B4CC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1DDF10E6D4;
	Wed, 29 Jul 2026 05:35:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uhkb5yBw";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A56810E6D4;
 Wed, 29 Jul 2026 05:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVJggZA0DYChF+04NSDOreO+uPvfd+ukGC8PNUQLrBQEbiRaDuUNQkjqqhmIT2kBXx8BKjNCibQ/ZvpXPPZpYKVInrllVWL2XGJlUOugK7BYabw4fJSMBjtK1myXreqGQmeMjhiYBlKQRHdN+/TEiqoy9LFVpk56gyjRbJqwobWuTWZp27lNP8H/ZSek0lLzuBKJXIuB2wtQX8/wnvOQXf6h7PVtJN9DP/0LPdbEJr101e+8i+dCpJxx7LLTn1zvNXttVpX/wFR5oYoQqCV/15qlaJsyITVLiqSeB0+w0dg8HF5lp/zmsnCwG+vdHWaT8Bna4RdgeppD/pJFQHDZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRacOUnScHtxMPY+XjLZOGnK15NabZ9xUXKJTGvJPAo=;
 b=kv1ydoWNBgwmQ/XTP11odByHXduVZ6CbGiETTrpaOuv5sdGUTSeJ5y3nwhX0bFcABxJ7fM92OrPczU4oLtH+626wvoh7hEq6Yd659lh5OQVjnggB7yVkgiIzxha4CNItB5Wc5uT1+SSQi+7isHuimIgCUXvQ11BHYh5NSOVXq5kKEqU84q0cfCCAgq0TIr2yGxNEJx8W52sfxqZxecmerB7V2ajxXhlewF7bfJcka5lvsH4VFh82WTEn5GB5+BZo8pJA6SdGIoTqyUkEJTPq/+BdZ/A1u5DjYSajV1wFoJiustv+qi517CebUxt+KIvAbctoyjmxfIjNaw5jl+2iEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRacOUnScHtxMPY+XjLZOGnK15NabZ9xUXKJTGvJPAo=;
 b=Uhkb5yBwbLN1WDeEng9gSVmooeAgSXQHniAuyQM/+7njjfkj9cwOxe9R6lBnlycfPIcHidnOGuymZ1z36YYnqR7maq93Stb04yMwgQatskPhfPFjepwk5MfOPCRJ/kgwZpAT0Jtlx6FJmh+lT8SStxW92mulr9uRfLjNSqGXUukyVAbWwrk5Bvx7wqaa37ToLjM+321DIGExEY0xuMlSnWfaBB7c/AVovK9uf0jgvKKxqXdZb7aAlzNIWKCSqjVQWxcX5XQQ5pNp7WkWmGjMizt/kGMU5540IAUDU0g6riyjIHmpxeziCDDB0/PugK0L+7y81v0aBJMUdK/jbfMlwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 05:35:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 05:35:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 14:35:04 +0900
Message-Id: <DKAT7BH9QAUM.8T1WAO0K0OIB@nvidia.com>
Cc: "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/4] rust: bitmap: add contiguous area operations
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
 <20260723-chid-v2-2-c35e5e9fb3d9@nvidia.com> <amHtZeAl3VFsibE1@google.com>
In-Reply-To: <amHtZeAl3VFsibE1@google.com>
X-ClientProxiedBy: TY6P286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB9174:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f6917d-305e-474c-eb91-08deed332656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|7416014|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: s1wZur1L3d7cb/dTzn9EgyJrP8CDvJhYz65qDEa3FLcSWlXkU7mtr5KDNOnSft3VmOYkLoAUANAkqkQ7dUhPTTOBjjp5Pi6+HQrGcByuMntkqKXtg2bZCuuO3AHD0PibU3b6JE+inU8WllkocwNFY+Ma3fHGpBtYzgPOND2a5NIwzli3voJVtsXC4tL0ke/nuIYz5rlR/xxvZ/DxpiBTTVPRGRC1mPG3YTBrDJmfQ7YwsAZ5yMW5bm89NDuCBYOGpd9dmG+WHPSxXODF2H3MRiijz2wh6tr2ECe8AXsGJJH+47oDrqOY40T+68C3fUtgf8WP9TxR3t2R1ZFQ4TZSfJ+4EvvgTOJK9220sBHDBELgR5/vj0bcO+nDUhek+keOhiH+v86mi9hrEG6ISZERffAc94f2ZqjshYkfLFHgwHwC2D+IJnmna+7oy3CyClveM01etZ/I9Sd6Qsgt7WSPQSP+8nwB88FI8UJwga32YYxokiuer08p2Tc5JEIF58PAwQCyXniIxN7K81JzRXt7oDhnUV7vFnmoNzQp2gu23RLoGW4dDgjO1VWZpNUojiFAhS4jcG8HKTyaxQ+78vxRU2QvDYynJKfm0slrG3nm9wBJAYztTPE89mkdJ2xaxlwRbU17w+E+cZ+N7dCkeYWKaMbV2WdR5yVZzDc+9tUG2Hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVYRkpQdHRJaVcxYzZobWtqdFlxNE81aklGaXJjWVdsVUN2L2UxWlEwdCta?=
 =?utf-8?B?RVU2U29uS3pkdjVOV1Y0Vm9sQnBmc3JIZ3RBNTdlQ2VwaE9OWmY1Ull1TUxu?=
 =?utf-8?B?dTRCWEs1ajlHT3dkSEM0ZUNKSFptNjJkNXFZR0dGSzRISDNKeEpPVnZ0Zm5J?=
 =?utf-8?B?VXVqNVhUVi8xKzBWZ0FUTEtXbWNkWTFnUGEvUXcvQU1Uckd6L1psRUJ0eCsw?=
 =?utf-8?B?MG5XemJxT2tZbWt0bEhlWmthYjRjc3YyOHM4VEZrb3drSUx0c2xQeFMxSCtN?=
 =?utf-8?B?U2VLTU1RZzdKQ1FwR0EwQ2c2M2xHWlY3Q2I5UDE5Z0VJY2h2aXNnTlZnTmtj?=
 =?utf-8?B?Qk1CMFdNSjhxNVJ2clRXa2Z0YXNuNWtjZmYxcjRXUVZaTGlucVA3OHUrMUlp?=
 =?utf-8?B?MWpNUlBsVm1mVkpvNFR2c01qZVgzKzM1VzV5cDdHQW1wT3RKRGpvdGNYRjZy?=
 =?utf-8?B?NHI4UnNRTlVKTXNMd3lGZmJzU0V0aXRKTzhJdVlMcUYrNW1WMHRYZHZpTEZw?=
 =?utf-8?B?aWxsenpmZ3h3dXRtQTZqNFplWlc0K2pDRjdOejA3NHJNdGlNRHNxL0lpZmZK?=
 =?utf-8?B?RWtMVHlsM0NjMTZlYTFHd1I3WHVxSzMwaWY4WWR1OWc0b3ZvalNyYm1JdVJu?=
 =?utf-8?B?aldjc05kUDlrSU1MU2FjcnY0WkhZbE1FL0xWcXJkbllhTWZvUkhYUHByRjNx?=
 =?utf-8?B?czVIK1RWUXRlRFdiZ1Z1L2NSQjUrQXdmT2ZodnZkNEJuaDh1cXY1WmtRUTRl?=
 =?utf-8?B?cEpGNmR0akRaQU5adFRENDFqd2xEbi8wT01DYmd2a0hDN0JqL21yN1NTNk5J?=
 =?utf-8?B?dTgzenRsd3VYS2h6cXNncVBzcFVJMkNrSVZBKzlmS3lCUlRVcnZheDZIYlhU?=
 =?utf-8?B?UlR4dDJwSnVQNmlwL2poNEZzMmRrbzZPd05LN0l2YVE0WkQ0aVZZV3ZlNlpn?=
 =?utf-8?B?dDNHSjhsTXVMUktIRkw3UzlpVS8zVlcxVWxkMUZiRmYva2lSTGozUDV5blVk?=
 =?utf-8?B?a3VhQlJ1R1Vpd2RvdHRpeVpQZGdCK2NGTVBCc1dIZUxGZTByM1JDVm5nRUFm?=
 =?utf-8?B?RGxKLzZ6SnFpUy9pNXREVXo0UUtVSDlQbDVPUVFjVG9YQWxmbU50bVJlYWly?=
 =?utf-8?B?dlRBNFRubzV3dWpUcmlwZ3V0NUc3bFRWbjVYS251akpHYTJuTzFUWnJMcE1l?=
 =?utf-8?B?S1RVYklnYVhtRTdKdW9IeGJLTUhPTU1wQThSM0dxTldhaDhlUy9NOXJpakdw?=
 =?utf-8?B?NDFUWXYwUThTTVZoSkhieU9lQWhFWjdzbld4amdyYmRadUhVNlAzN3NLY2JL?=
 =?utf-8?B?czZySHVxc0NNZ05IZlppeVV3YnhwaS9INExieTJsc3RsNWhLVHhad0krMjYr?=
 =?utf-8?B?U2lxR2poc1JVazQ0ajJYZkpMamFTT1J6NW15U2NqTlgyc09ud09IZkZON3B4?=
 =?utf-8?B?eUM3V0lqL1NqWjErTWx0aE5SQXdCM3J1RWh6cUREb0RBMFpUR1E2VTlqOXlG?=
 =?utf-8?B?Tm5rdC8vdkRVbkdmYkFDbWZaMGhISU5XMWVLNkxReXJWME41QzA3Yk0wV25I?=
 =?utf-8?B?TTFtdTkxMTVsei82aWdvSE9kQ0p6cWdYZXpxcko5YW5QYWNWVXM2cm9xL3U5?=
 =?utf-8?B?QjB1Qk9UMC9MSXNqeEVMSW5DU2hZR3FPR3liWDRuamYxb2J1dEVYbUxKVnp3?=
 =?utf-8?B?eGZSQTJlTTE2WDljeVorcEdWS2JoWEIweEgrRHdYc1RiRkFKUWlMUHJQWHBu?=
 =?utf-8?B?VlptMFlCaERJd3BvRmlPRW55WmhZK1Q3V3hGbWhVN1VoZG44WFlDMlFnbXZZ?=
 =?utf-8?B?QlZGOVVZRjRKc3dVRTBKR0dkQkMrQXJ5OXd0eHpUSDBlLzhLdDFQbGtxRG5u?=
 =?utf-8?B?U1UyRWVxREpYVVNXQjJubW84cU9IWlRzckFtZnR4ODhEa29hYldZWlk0bmMz?=
 =?utf-8?B?RmRrdCszTG1HcGY0NlFqQ2ZDcjBhOGRCTksxMDJjMWlWUGNjM2ZRZXNyYm1K?=
 =?utf-8?B?dGJCWHVNaTlJM1FKZFVqWUZqSVdBT2JuaVdDQS96dzZ6OUg5ZlR1R3oyKzRW?=
 =?utf-8?B?SUNITHY0R0RnTmlZUG5Va0xJUExOMHFNREZUVm9zb1VndDlHREZ4N1dXTGow?=
 =?utf-8?B?cFM3Uk9YMytHNWNmTStRT2F6SFpHaGt0SXVhK2dGcE1ZTFU4cnNOdVMva29u?=
 =?utf-8?B?dTdsVk1Nakg2WEs1bm5ZMkljaWFXVFNVdW1OTFRBRGVmMFYyV3RkNXJPUGs4?=
 =?utf-8?B?SGNkTXhtVWZGUTRMWmtNWU8vTmZiekRxM1ZPWENwMzNWOHYrNlFFWWh6L04y?=
 =?utf-8?B?MlBrYkZPd285ZW5MNXBLMGpMSW1IazVSQ0RTZVVWUU1UbDU1dGFoUEJlS2h6?=
 =?utf-8?Q?/z3+6n+poiTzpzq/Yj4fjeVoFjZcvWmO4eCXm4UYaxGBE?=
X-MS-Exchange-AntiSpam-MessageData-1: fXw/oU/kyNHiDA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f6917d-305e-474c-eb91-08deed332656
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:35:07.7272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQuuoH3FtkfEE+FoxMfJMNxLOXaZKE7RESN3QbfZ3eayT/9Ts6QEbBTrBrRvny/qhqRIqguYXQIFCiW/x4vzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9174
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

On Thu Jul 23, 2026 at 7:31 PM JST, Alice Ryhl wrote:
> On Thu, Jul 23, 2026 at 05:59:11PM +0900, Eliot Courtney wrote:
>> Add bindings for area operations on bitmaps. Each one is
>> made safe by adding some extra checks compared to the underlying C code
>> (for example, checking bounds) and with additional checks to catch
>> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>>=20
>> The C code uses signed integers for some parameters, for example the
>> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
>> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
>> backed by `BitmapVec`. There's also a few cases where an `align_mask`
>> can cause an infinite loop in the C code: masks that are not a power
>> of two minus one, and masks where `self.len() + align_mask` overflows
>> the alignment step, so check for those.
>>=20
>> Add tests demonstrating the edge cases.
>>=20
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/bitmap.rs | 217 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 217 insertions(+)
>>=20
>> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
>> index a43bfe0ec3dc..1395bbe99cbb 100644
>> --- a/rust/kernel/bitmap.rs
>> +++ b/rust/kernel/bitmap.rs
>> @@ -497,6 +497,127 @@ pub fn next_zero_bit(&self, start: usize) -> Optio=
n<usize> {
>>              Some(index)
>>          }
>>      }
>> +
>> +    /// Finds a contiguous area of `nbits` zero bits at or after `start=
`, aligned per `align_mask`.
>> +    ///
>> +    /// Returns the bit index of the start of the area, or [`None`] if =
no such area fitting in
>> +    /// the bitmap exists or the `align_mask` is invalid.
>> +    ///
>> +    /// `align_mask` should be `0` (no alignment) or one less than a po=
wer of two, in which case the
>> +    /// returned index is a multiple of that power of two. Masks such t=
hat `self.len() + align_mask`
>> +    /// overflows are checked and considered invalid, as they can hang =
the underlying C code.
>> +    ///
>> +    /// # Panics
>> +    ///
>> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is=
 out of bounds or
>> +    /// `align_mask` is invalid.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
>> +    /// use kernel::bitmap::BitmapVec;
>> +    ///
>> +    /// let mut b =3D BitmapVec::new(64, GFP_KERNEL)?;
>> +    ///
>> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, 0));
>> +    /// b.set(0, 5);
>> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, 0));
>> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, 7));
>> +    /// assert_eq!(None, b.next_zero_area(0, 65, 0));
>> +    /// # Ok::<(), AllocError>(())
>> +    /// ```
>> +    #[inline]
>> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align_mask=
: usize) -> Option<usize> {
>
> Instead of using a `usize` argument, it'd be ideal to use the Alignment
> type defined in rust/kernel/ptr.rs, since it is guaranteed that the
> contained value is a power of two, so you can omit all those checks.
>
> (Since you need a mask, you'll need to subtract one from the provided
> Alignment, but that should be fine.)
>
> Alice

Yerp good idea thanks. I removed the checks, but there is a hang where
using Alignment doesn't help. If the length of the bitmap plus the align
mask overflows a usize, then the underlying C code can hang (depending
on the content of the bitmap). This can only happen on 32 bit systems
with a 2 GiB align and a >=3D 256 MiB size bitmap, so it's very rare. And
I guess it's not exactly unsafe. Happy to put the check back if people
want tho.
