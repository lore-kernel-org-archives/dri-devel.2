Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB2C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:50:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF24D10E121;
	Tue, 30 Jun 2026 13:50:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="cg8nn9+u";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC72D10EC9E
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXxVQJ3OfDaIFszGVR8vsvI30aI/VE5rWED0VZU4oj9E72/9QDQM0rFe04EGdLZOPXDWYApHv7UVfvqWkF4AyCf9peCXexXI6kZJzifwqyHCatLhD4FGyQZ56Yb/g3EumlPly5B0sNtRZ2EVSljIFb3Rdms257/7wyn/mITmYN/KK3AQztayBFigNuC4umS/o0Hv6qfjw7+tK3hwbO418uexIeXtFYFjlumKugkwruFxiVH99ISJyCtExzCBK/qKutXABP17BxBA1UVXz1/mn8O+2uE4zX17AirU9zaSfe1sg8FPlJCu7BHaIzYusv46M/Vv59p2wJXX8hUm+hTUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G53gXJ0IkuM6ajQP2Dw2xcZrW/Pv3EOgghUAyRU81Aw=;
 b=Xt4ewPwAVrbM5pRtEzoYC7G4yyt9MVb5LFutg0KaTUw2fgV3LKibE5F9oFEzgtz4XohMj1MVN5Y8NRup/10ZW3bvRYoYqowwkUd96SOly1UYE2Gj+kS1e/g2CrM8xPVWFXMMKmBLWYL3TRsJ6h+H6ZZM3T8IxiG60OYRcgb7RCf6/FDlyk7NFB2vWJnNh59Wqb7mH7vcXOm1oqxxmcnayu2NoUID+lDp6R+WKQRqZogPqsUyLzDqiQBxwYX7EvXACITInKDvHuRO9KokQX0j33mMUHXR+9H8DAjfpcwSi4FHBk5i2opwhP6Xpy73a0Mcb7KkG8BExmeqNScsRFo7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G53gXJ0IkuM6ajQP2Dw2xcZrW/Pv3EOgghUAyRU81Aw=;
 b=cg8nn9+u273OUWXp+01Qr1J3e3vlVKRV+P/DRpgzJ+KOhsmYA74uV1v5YapcnySTLI3G0+6RfmxtL27dKagRzPPnvdW4YKa2RYY6OqMvXLtEKUOdBfumyawLvx/aHyclP65lFilDbYKwGSF0Szc0QwqtkwK/BhBLypA6BT+6n08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7437.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:50:44 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:50:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 14:50:43 +0100
Message-Id: <DJMFL0Z8UJJW.1CAZUYCA3WQZX@garyguo.net>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
In-Reply-To: <20260626183630.2585057-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0150.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1c20f8-7342-4b0a-b884-08ded6ae94d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|921020|6133799003|4143699003|56012099006|5023799004|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: fvJXimCaCsdelq8qbIM5OpvZg3KMT3OCb/Hf5CoOZv2kiu2gz0JlQn1qVPrHNWCaPl6t6cqOAiZeIaf0UX+0u8klulX0NbALBETs2Ax7ekjWQUXoUxIOBdhihm2gB9MxrGfrI8snWPm16zopeJ+fo9dVnCqnU+hTyhrkFTPkW61vO/nz/RW+UqyX09AUTlFshxpHPChM8hbredJr8EZGnrdPqyzxg9n498ny9EeEimvLo3YffeW9QdXwEfZTNZKiMgwp8WmIfmzYa/AjzP8rQQQmQ/WvyRgPR08nWDaDnzk7VEXXindwCJJW4Fw8vdlx6l1d3yWook5zNrP5AImldF31gvBEexjM0oHKj1b6SU85L5fUykCoOXba1WHL01hSXeIAtQ6k4DH+8KYuVcL+hasZScHAnyCftmjdXGYrie7z0Efr8cLuVQhtUHeXiM4zzTg3dFD2io2XGr6Oz8Ouh1eeUFgDiO+Ot5U/Bzg08A7gKbSlxYll9bwmIBM9bbPGQXZdAypaa3q3sucLHV5sb0oVhit99bvzmDkBPZMcFhh/2yowl46Yk0lQzZLADakLSWCLD1C5LsAny3rRu+WJ/u+Mkr5m9XxCqIXdo6X4dP+/0ZcqRy4jUvF+DGbRqmLcgpA/w0AY9UqF4YfRiTerih2OUZgkmTcmR9O3+98bYenWc/VqY4c7+2sqJDmyHvGnjAF282oKcfR9bVxOsqMFnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(6133799003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enN4WU52cjF0Y1AxU0JMUDJyWC9MdWRENTJYM0w5VHgrak13VW5rT1RRU3Ru?=
 =?utf-8?B?cDBmN1RnUmZpN1g0eEdYUUFLQW9pTSttenY1QVBzVWpQYjhnUi9JSEdpcTRv?=
 =?utf-8?B?MlREOGhIaFpJWlAxTjM4YmN6MXpELzk0RWVoZzZFWEk2VjlZYzhlOWV5c0tu?=
 =?utf-8?B?R1YySUNQakZuOEVGWEpVdkpMLzRmYm9abjdxR3RLbXBVTDVZREdTYjZVVWJH?=
 =?utf-8?B?M0NCb1lFYmtVTmc3YzI4dituaWpGdXczYUdrY2hqVzdLWElYOEVjUmltVmY0?=
 =?utf-8?B?M3dpUU0xMlJVZmlQS2pRekFYSXB1OTd1NnAvYWtGYUdsUzFnWUZvK21ZbXZW?=
 =?utf-8?B?V2o0N24yQ0l5a2NhcUszckVPNzY5UGRpbXBrbEo0ejJRd0QyZzR4QXVHcDFH?=
 =?utf-8?B?c1hGT3ZEcWxmbUtoWG05UWdTcXFxY21MV0Z0REJVSktZSDdMaGthMlBPR3M0?=
 =?utf-8?B?RTh3OVZFOVh4TUFyOGpFSWNUZC9kcGhLRFJ1SzRYcTY5bHZHZnNDeTV5ZmFU?=
 =?utf-8?B?VXNjUVZtL2NFenAyNGV4Y2JNRTlKZmNWcloxUENJdmhmTmhER3NZN3E2alhi?=
 =?utf-8?B?dU8zNmEvUlRTb0k4Wk4ycTJOUzJFVXpJd3N1SFFBbGhFQ1hrNmNBYmdqblV3?=
 =?utf-8?B?blk0Nm5pNmkvOFg0enJKZythTFY5Y2VBWGpoT3o5QnBmTmMyYjVjbm5UODRj?=
 =?utf-8?B?dU50cXovRzFLTUhvS0lMSUtacjJkY3pBWjFsa3lPbFdIWkcrTXVSRktCR2o0?=
 =?utf-8?B?TFVFcjNlVXdTNTNsNHh4UytiNTNiZkYxYVR1YmI3ekJ5YWxkZDRFYXFtZVQ2?=
 =?utf-8?B?WXRjUXNET0FwS1NlY2NzOEFKRWVidC93RXNjTmcwenZoSUh3VURsckQ4eTha?=
 =?utf-8?B?cVIra1lXbEVVcXBuNlRNS1d0SDBrWjdHcmk5S2F4ajVZTTJBQzFaVjlMd2Jj?=
 =?utf-8?B?aXBlR3p6WElSNzQ1SlZTelBuSVh5TG5FUW5sQlpBTEt0bW5MU09lTVVwbVJH?=
 =?utf-8?B?ZmFDUmFOZHVUWi9yeGY0Uld0MThsMTFWZXlZWUJMa25nRXhDSmJCSG5nd25h?=
 =?utf-8?B?TVNaQnBpN0R4RkdBbzkxRWEzQ3dibGFoQ2p2TmRBUWdGUGMrTGY1ZzVhejVt?=
 =?utf-8?B?TVVaelVEOHBMUkdWU2RRc3NRNlhkYlptc1JvUDFKNGlrL1FWVDc1Tmc1WExQ?=
 =?utf-8?B?UVFKZVFQSW5LNS9GZnRNZFRoNHNDZDgwS2V0NGVHNDV3VXJSMGFRMDB2S1Bn?=
 =?utf-8?B?Vm5LQmV4OVB5VmFkZDUyZ0luaVpPL0tnOCthekhKTXlpRnVwd2J3eUtSNWtJ?=
 =?utf-8?B?Mk9UQzZleGR0MUtXbnpCMnQ3Um5DVitUWVNsRzhPdzcyQStiRkE1M1V0cVU5?=
 =?utf-8?B?NjhNOHVFSU9rMmtUV1Rxd3pvU2U5aWp0ZkpZbXYrMHlNazNBeGlsWjJxZU9J?=
 =?utf-8?B?VGJIOG5QUmRid1pML3dCcWFqci9ZS2N1eTVDeWw5QmRGMXJXWVNENUpNcVdH?=
 =?utf-8?B?ZVloNlBwdkRhMWIyN2pvcXBjOEZLRlV4Vkw0Q3B5TXRiZFFyUGlLb0U5MlhV?=
 =?utf-8?B?TXNXWkg4R28wS2w2YUdsODZSVHg1TUlqZi9HaFFldjUzTXQ0YTBiZHdNRWpa?=
 =?utf-8?B?NXh2SlMwZXRVdnhSSkE2TXdtNXgzUnQ1Tm91dy9tVm1sNlB5SzdUSTE3amg1?=
 =?utf-8?B?N3ltWWFNKytPK0ZRSEcwK0lqSW12VkVJUWZEZUE4dTlQVXlOV1ZyeUE0dGlJ?=
 =?utf-8?B?YXBBMXlnM0RlRlBZVEgvNkZuRXVUNDZPallWL0x0d0VWTFdKcHI2cjIxTWJZ?=
 =?utf-8?B?RVhNNzlHNnMwSG9CVk1pbXhSOWZxQ3NvYWd5UG1OZG53Mnk2bVAxcHdhRjJi?=
 =?utf-8?B?aFpWUWsrWXVuU3lRVk5wRVBoSDZSdGRkWStoOEVldEhObnZ1YWI1MjZVd2c4?=
 =?utf-8?B?NStvaWFzbnp2T1JTRGpaZGtKWkhIcXh1dkl2bEJ5SGlEZXVaMFQvQ0s3UUdh?=
 =?utf-8?B?ejJ4a0VNU0ZCSUNpVkhwQmo1TGwrVEM3NlltemtiT0YyRzZqNkp3S2pzNWlD?=
 =?utf-8?B?ZzJwV1VSUXhwK0gyMWVvRkIrUkduQVU1dWtPelNSMHQxV0R4OHoyWXBvcHhk?=
 =?utf-8?B?c0NNbzhMd0tXZGNmMDBXVzBpVThpdnFyN3NwVUwzRGI2a3pxQmxKRC8zOVI4?=
 =?utf-8?B?NFE2Y2NORDE3T1FZc3hVS25aaVRIWW4yWUN6RjVSRkVETUlWVFZvdVRoUGln?=
 =?utf-8?B?VGhSRDVmanBkT3NrQ05pYkVJVkNyeVVwTFo4VXpYejJuNm8zd1RMMVhDRnIx?=
 =?utf-8?B?T1pLRjdacmF3eDI3N0xQZ21iTmhrdFArRlFtQlRPR1EvbkZzQk9SZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1c20f8-7342-4b0a-b884-08ded6ae94d8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:50:44.3972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JPTsd9Pe3+KDGp9NEqanPWPXOKpU2PogXOYjU7oduulKHJZLrbayHXhHdi+++TAH5eKmgaM/rfZmIOPKlKqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7437
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

On Fri Jun 26, 2026 at 7:36 PM BST, Danilo Krummrich wrote:
> Add a new ForLt trait as a base for CovariantForLt:
>
>   - ForLt (non-unsafe): represents a type generic over a lifetime, with
>     no covariance guarantee.
>
>   - CovariantForLt (unsafe): becomes a subtrait of ForLt that
>     additionally proves the type is covariant over its lifetime
>     parameter, providing a safe cast_ref() method.
>
> This split allows non-covariant types (e.g. types behind a Mutex) to
> implement ForLt and participate in DevresLt / registration data patterns
> that use HRTB closures for sound access, without requiring a covariance
> proof that would fail to compile.
>
> Both macros share the UnsafeForLtImpl helper type, distinguished by
> a const generic N: ForLt! emits N =3D 0 (no covariance proof),
> CovariantForLt! emits N =3D 1 (with compile-time covariance proof).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/types.rs        |  1 +
>  rust/kernel/types/for_lt.rs | 72 +++++++++++++++++++++++++++++--------
>  rust/macros/for_lt.rs       | 68 ++++++++++++++++++++++++-----------
>  rust/macros/lib.rs          | 19 +++++++++-
>  4 files changed, 123 insertions(+), 37 deletions(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index cbe6907042d3..c1ed05d1046c 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -14,6 +14,7 @@
>  #[doc(hidden)]
>  pub mod for_lt;
>  pub use for_lt::CovariantForLt;
> +pub use for_lt::ForLt;

Import style

> =20
>  /// Used to transfer ownership to and from foreign (non-Rust) languages.
>  ///
> diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
> index 9487a9352f1c..9270a069cd3a 100644
> --- a/rust/macros/for_lt.rs
> +++ b/rust/macros/for_lt.rs
> @@ -176,8 +176,10 @@ fn prove(&mut self, ty: &'a Type) {
>      }
>  }
> =20
> -pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
> -    let (ty, lifetime) =3D match input {
> +/// Resolve the higher-ranked type into a concrete `(ty, lifetime)` pair=
, expanding elided
> +/// lifetimes as needed. Shared by both `for_lt` and `covariant_for_lt`.
> +fn resolve_hrt(input: HigherRankedType) -> (Type, Lifetime) {
> +    match input {
>          HigherRankedType::Explicit { lifetime, ty, .. } =3D> (ty, lifeti=
me),
>          HigherRankedType::Implicit { ty } =3D> {
>              // If there's no explicit `for<'a>` binder, inject a synthet=
ic `'__elided` lifetime
> @@ -188,14 +190,33 @@ pub(crate) fn covariant_for_lt(input: HigherRankedT=
ype) -> TokenStream {
>              };
>              (ty.expand_elided_lifetime(&lifetime), lifetime)
>          }
> -    };
> +    }
> +}
> +
> +/// Produce the `'static`-substituted type for the WF check. Shared by b=
oth macros.
> +fn ty_static(ty: &Type, lifetime: &Lifetime) -> Type {
> +    ty.replace_lifetime(
> +        lifetime,
> +        &Lifetime {
> +            apostrophe: Span::mixed_site(),
> +            ident: format_ident!("static"),
> +        },
> +    )
> +}

I suppose this code motion is no longer necessary. If they're just part of
`for_lt_inner` then the diff is going to be much smaller.

Regardless the code looks correct to me:

Reviewed-by: Gary Guo <gary@garyguo.net>

> +
> +/// Shared implementation for both `ForLt!` and `CovariantForLt!`.
> +///
> +/// Both macros run the prover and emit `ProveWf` structs to check well-=
formedness for all lifetime
> +/// instances (workaround for <https://github.com/rust-lang/rust/issues/=
152489>). `CovariantForLt!`
> +/// additionally emits covariance proof functions and sets `N =3D 1`.
> +fn for_lt_inner(input: HigherRankedType, prove_covariance: bool) -> Toke=
nStream {
> +    let (ty, lifetime) =3D resolve_hrt(input);
> =20
>      let mut prover =3D Prover(&lifetime, Vec::new());
>      prover.prove(&ty);
> =20
>      let mut proof =3D Vec::new();
> =20
> -    // Emit proofs for every type that requires additional compiler help=
 in proving covariance.
>      for (idx, required_proof) in prover.1.into_iter().enumerate() {
>          // Insert a proof that the type is well-formed.
>          //
> @@ -210,15 +231,16 @@ struct #wf_proof_name<#lifetime>(
>              );
>          ));
> =20
> -        // Insert a proof that the type is covariant.
> -        let cov_proof_name =3D format_ident!("prove_covariant_{idx}");
> -        proof.push(quote!(
> -            fn #cov_proof_name<'__short, '__long: '__short>(
> -                long: #wf_proof_name<'__long>
> -            ) -> #wf_proof_name<'__short> {
> -                long
> -            }
> -        ));
> +        if prove_covariance {
> +            let cov_proof_name =3D format_ident!("prove_covariant_{idx}"=
);
> +            proof.push(quote!(
> +                fn #cov_proof_name<'__short, '__long: '__short>(
> +                    long: #wf_proof_name<'__long>
> +                ) -> #wf_proof_name<'__short> {
> +                    long
> +                }
> +            ));
> +        }
>      }
> =20
>      // Make sure that the type is wellformed when substituting lifetime =
with `'static`.
> @@ -226,13 +248,9 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>      // Currently the Rust compiler doesn't check this, see the above `Pr=
oveWf` documentation.
>      //
>      // We prefer to use this way of proving WF-ness as it can work when =
generics are involved.
> -    let ty_static =3D ty.replace_lifetime(
> -        &lifetime,
> -        &Lifetime {
> -            apostrophe: Span::mixed_site(),
> -            ident: format_ident!("static"),
> -        },
> -    );
> +    let ty_static =3D ty_static(&ty, &lifetime);
> +
> +    let n: usize =3D prove_covariance.into();
> =20
>      quote!(
>          ::kernel::types::for_lt::UnsafeForLtImpl::<
> @@ -241,8 +259,16 @@ fn #cov_proof_name<'__short, '__long: '__short>(
>              {
>                  #(#proof)*
> =20
> -                0
> +                #n
>              }
>          >
>      )
>  }

