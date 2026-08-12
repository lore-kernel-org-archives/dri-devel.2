Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AACC5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:44:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7DD10E455;
	Wed, 12 Aug 2026 19:44:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="B7AVhuOl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DAEB10E455
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VArRY8kSofjs1dK09i/O/JVq3KwuP419XOgOgkM9Ayd1TnB0ENU63aVMay9zSQjs/7VwLDVXbhAJ6PR9ubjYOubFIk3BgZ9Um4njC6u0kByDiZ4bn9YO10tzuwJqUJKwrpgkj7sqlumwxPR6q31W4FffxntrCW6k1xZ/zqM6mCR7xg+BIpsZ5vIwH7n3dOB+lO7EyWHFdZAfXMVkWDk1inC0hUgxBIqQv9XOTUXJeXR3jy7TvWbSF6OlJhLyRvSOWjHD7TqjsLuoKLL7Sf+afxOVGAqmGQW9YUtBFSz0ISihwXAaBi+UOvvkE05iVl0U4JI9y8sWe05abzD31HogpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2FFP77lhns6+RRs/lQrYyf3J9ljZ9geBob7A/Cdf2E=;
 b=v/UPGDfvAmqrg3KmKPbX5lS2HVuZ9eTSaXXx2NJ3snj5xjGse5+lqrS+h+akL7l7Ef4AMCFog6A1p9HboNNVDOW00zZ0s8yafZU/CfbFb2DGUbKMb1DbWJs3+DRnFPeMDSO8aOcGg2gaGR0FGhPoJMA4dU2c6ti4phSpYFJtj7Aj1gaNlZkOXcb2YSunT58JPWw4c5kea2uP9njGB8TEFT4Cx3UGkY7094Qn+Qj/s1CpxSFB4qLbkHPw3W9OAwHgqB71yfY5lFwB+KBl95sOXBdGkjsaYohnySMAH1vcFiCnYvyU7tab3i2q/PIp6sMlsv/8Nv9BLFH6a/7/d7+WkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2FFP77lhns6+RRs/lQrYyf3J9ljZ9geBob7A/Cdf2E=;
 b=B7AVhuOlhR7HdZHPcpzgoC+/OascoOXBVUW6iKIhOnrsnqnGmzggzqaq6b7GA2tEQgSqQ6H5+on8ln39yDQHsiYibyfbGVCtm7JqVqUgC9JCQDxZF5v+Me3pN9G7M5O44JWCJvKlQtvLzaHgfBJ7arMNaibrlSOpcDK+4/sIDzZy8sZL5houwbXCKCAEvoOgcXVjlOqL5l5KShG4Hkl7iI3D220IUMACG8ZjbzXtvCleAYQRWzCE27uCXF4sWThDoCiNVQePYeBevZ+dCBmoCSTW0neAT+R/5+KZqggKtP1qpUOEvlkVlrQw6SMG0mec4k80pRtMxkGelE+uZBZ8XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 19:44:43 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 19:44:43 +0000
Date: Wed, 12 Aug 2026 15:44:40 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/5] rust: bitmap: restrict bitmap length to at most
 i32::MAX
Message-ID: <anzNKIX3V_zf2O8C@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-2-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-chid-v5-2-6c767770b3f4@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: d90de05d-dbd2-40f2-c6ca-08def8aa2830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qc/RALFJzJdfA64GzRd5F1sBfwn1D2m1520MqgbKbTrzk0iYGFj0JWYQNKroFjJsY7l4IrMLn3kIWzhT3hl93BoUOs2fgl0DjcxkWXfvZz+NaRagw/B5COyTRXUjD1ED1KIOCGB0slo+zkLVBg2PBFJnJ7O7sRgzhMYXZEmjkz5Scd3h37klOZCcTDGAzO7t2rg1cf8YewgB6zjof24vpsbZ4IxhjOicYoapIB71ySg/20P4jWvkmHpHprgVmvzhlA7VZ+eLv1q+IyVCy3feepXpSDkk2UMiPqD8FMar6oY6NOoC+KMisL/CBB+Hpn+VZO+ClhZ5t4Mhmh96/01eD/yda5fIdylo8lOmNmz1qSjU4fWT11D/6zt6VaVGtoW74Zq7E5U6yUpwi0AUBFp1a9gYLZ6l65kixzyHbLMJ1g3v+H7nXVnh4Daw4ApfW6+5DxBRWX+kVY3oCyM1kHbYwpKqckgWZejRgAqw3Yf2VLHEgC8darEZs5Kj6NIn8D6wyTIejtBAwnCWyyQerIWK1IAFDeB0UC/fZd2JV1k8h4cKDnpuLMpFwRRISfGkrGMhiLhevTENiuHVvhZRXRb5HBvsJVAehb8Gcx+l3RgjV9EMq1U2brTMVg94pYN7p6gQqIZo3OUv430tUm5mLE5I/hlM8684xYV3k2FPvQVK1Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmYGS2kUdkxmQeFFRAh1QNKchGwXagUzvdhdE8y+twBxp6uR3PM8wgBg2h7w?=
 =?us-ascii?Q?LuvItfK0VK18hOVfsF6nIPpqMqYSFmKJfSgsJEs4+0edzLAJ+e4znPtIwz4+?=
 =?us-ascii?Q?LLvzC2rGTVWXLCI0WT2djkULhI8pCD4ZrYI145eiNDnai9huTXN+ssCaCVYy?=
 =?us-ascii?Q?PJlLaiCzBqDOk2ijUhuE3fI2oW9vHuPj8fqYDMbGX1hFOZOlYc3wR/CIFtq0?=
 =?us-ascii?Q?v9vVHN3R7j15qKx+8YN1grwUuFcKVUpCbMdKRf1OoAJt7/OZacI0kjZoGlHV?=
 =?us-ascii?Q?KUfggg0t2GxbyZgTw3vRtzzmGsVzsMCQ+onM4LmeRHP+Hbdu8gT3FtIwCJ1R?=
 =?us-ascii?Q?NprxOTn2afVE+qGNCrqIwOsu3bQEpKCpcaUhndwsXdrvs9Vv318iJbfbIG4I?=
 =?us-ascii?Q?OnmhLGeJbxF+i2PVnI/Y5HfqNv+o1Zxs3KPcU9fG7p0Rp7DAQo4k3PRpB4BM?=
 =?us-ascii?Q?ORWrCS7e7WHom4EO1ocoQHmVsxMFZ0tf0VGk20gyE5KhmYkl49vIrX/+TMMC?=
 =?us-ascii?Q?8c023RPkve5A0gXTxbcws3xhIDY9TSDnvDB8SW2REdRuR1S8u81+fdJndIpQ?=
 =?us-ascii?Q?XJrkTxFxdAC+XxwgKhzPQX283HKaOpQe1PfzkWk99a6fx9hnwzN4qDmoVIyI?=
 =?us-ascii?Q?grbDYSdRmPjSQcAI3SClrVWT2Yg4UHxfmVZTEc99o5kTKAMaIqI3oix3p+JR?=
 =?us-ascii?Q?33UDNMstHg8XO7eVwTn9MRKavLEAe3KpnxXQXoirUcABjoNo08t66FEpgzeQ?=
 =?us-ascii?Q?bcr089ZvxPh5EjOV7NHzdJ97sn6Wgv46Bakqp+zpMgg4yjkidycLiqlXiHZx?=
 =?us-ascii?Q?PcG/kZknheHAyDrXcjkNNOwGdMrmTUFp8zjSbXQDnZ0LIUEweKRUJT+nzejO?=
 =?us-ascii?Q?CgaZe3mbZ62v+T2chqw1ZGLrvLTe707ck5hPEiYKT7SiCnP1gnLYGG4h4ef6?=
 =?us-ascii?Q?PsF+p0cXA2+p0Lr7Ij3gYa8JD2E754qJTHei71XZf+D9cSddLHb8jRtsLYVd?=
 =?us-ascii?Q?pzOYL4oU2+WhN8jRwld0zUv4P4hvFOfOvTFWU7VydRVsLzlyQA9j+3Tp02/7?=
 =?us-ascii?Q?ggstNZAVpc0N4lgxaCR1PTopjMd1/6+k/LUzUBl/JZ1HgxYuUiFKiiaNRkc9?=
 =?us-ascii?Q?HE35fPbEFK1QvEMdipN0AQ7ibGC23Hu/iFwwi3REwTmup4zFKw9DuQAxW5PQ?=
 =?us-ascii?Q?OSCz3c5SVhQkoo5YQlSXuerEmAW0SMERvUBYoHVhxoYSn8AY26dkYsTrrb6b?=
 =?us-ascii?Q?NCKbqIq69AJdAlHQldL95YUL1Ndzu7wkw8bSVmlspLJR767u52fPBwqdQhOF?=
 =?us-ascii?Q?tzRycbpwNynshpaWKiVQEEwwCzjpaH0MGCvcWSBv1mO7VCVIv3g902ofegnN?=
 =?us-ascii?Q?ABLgvETfE2GnnXyMXcck4+KcNCnAFh9ycJhcqg6zZCPKfv3eZhV889BFBrJB?=
 =?us-ascii?Q?1vmMeYwKnz7klZ2+7ve4eVLh+oz80ytgEJaOxAnz39fTtrDMhEHYNL3hO3+g?=
 =?us-ascii?Q?otQx6Ny8bm/BZ1RG/ZnfVxQ6KbaB2zPC14SN8vLLvtac5RzZEI61MOk+wcyU?=
 =?us-ascii?Q?vgWyfrIrqBdPWu9zPMQdUOrauC35qNu2moxiwv9vgpyGfIrUGINVW7HQfzXF?=
 =?us-ascii?Q?lqEdSxi8YHk+zI8/my6dGL69bD+dIVmjPfZURHkDW5IAEsha2B2WEa6dxHy/?=
 =?us-ascii?Q?1N15/Eo0P6mXpo54u4qTJpHxxrkLQxzD6ppgbV9GBE1Cynifo5MFQFHR7Fy0?=
 =?us-ascii?Q?UnSY64n8ww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90de05d-dbd2-40f2-c6ca-08def8aa2830
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 19:44:43.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENVLRCBcjc+NJXCplIFHUANY+TIN7/Nf/5kEOUzo+lh/BpSGxf9lwZzJNv+RuMws2KtXQ2zJjv0ukZ8rzr9/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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

On Wed, Aug 12, 2026 at 05:51:22PM +0900, Eliot Courtney wrote:
> It is currently possible to construct a non-`BitmapVec` backed
> `Bitmap` using `Bitmap::from_raw` that is larger than `i32::MAX`, and
> it is not part of the unsafe requirements. Restricting all bitmaps
> (even non-`BitmapVec` backed ones) to a maximum size of `i32::MAX`
> simplifies a few things and matches `BitmapVec::MAX_LEN`.
> 
> Add that requirement to the unsafe requirements on `Bitmap::from_raw`
> and `Bitmap::from_raw_mut`, and to the invariants on `Bitmap`.
> 
> This also fixes u32 casts truncating in `copy_and_extend`, which could
> otherwise lead to OOB writes.
> 
> Fixes: 11eca92a2cae ("rust: add bitmap API.")
> Link: https://lore.kernel.org/DKG0U8RLO7LZ.2I1AIH0S38PAP@nvidia.com
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Yury Norov <ynorov@nvidia.com>

> ---
>  rust/kernel/bitmap.rs | 68 +++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 21 deletions(-)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc..fdcfc0409773 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -17,24 +17,57 @@
>  /// # Invariants
>  ///
>  /// Must reference a `[c_ulong]` long enough to fit `data.len()` bits.
> +/// Must not be longer than `i32::MAX` bits.
>  #[cfg_attr(CONFIG_64BIT, repr(align(8)))]
>  #[cfg_attr(not(CONFIG_64BIT), repr(align(4)))]
>  pub struct Bitmap {
>      data: [()],
>  }
>  
> +macro_rules! bitmap_assert {
> +    ($cond:expr, $($arg:tt)+) => {
> +        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> +        assert!($cond, $($arg)*);
> +    }
> +}
> +
> +macro_rules! bitmap_assert_return {
> +    ($cond:expr, $($arg:tt)+) => {
> +        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> +        assert!($cond, $($arg)*);
> +
> +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +        if !($cond) {
> +            pr_err!($($arg)*);
> +            return
> +        }
> +    }
> +}
> +
>  impl Bitmap {
>      /// Borrows a C bitmap.
>      ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
> +    ///
>      /// # Safety
>      ///
>      /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
>      ///   that is large enough to hold `nbits` bits.
> +    /// * `nbits` must not exceed `i32::MAX`.
>      /// * the array must not be freed for the lifetime of this [`Bitmap`]
>      /// * concurrent access only happens through atomic operations
>      pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
> +        bitmap_assert!(
> +            nbits <= i32::MAX as usize,
> +            "`nbits` must be <= {}, was {}",
> +            i32::MAX,
> +            nbits
> +        );
>          let data: *const [()] = core::ptr::slice_from_raw_parts(ptr.cast(), nbits);
>          // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
> +        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
>          // SAFETY:
>          // The caller guarantees that `data` (derived from `ptr` and `nbits`)
>          // points to a valid, initialized, and appropriately sized memory region
> @@ -51,15 +84,27 @@ pub unsafe fn from_raw<'a>(ptr: *const usize, nbits: usize) -> &'a Bitmap {
>  
>      /// Borrows a C bitmap exclusively.
>      ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `nbits` exceeds `i32::MAX`.
> +    ///
>      /// # Safety
>      ///
>      /// * `ptr` holds a non-null address of an initialized array of `unsigned long`
>      ///   that is large enough to hold `nbits` bits.
> +    /// * `nbits` must not exceed `i32::MAX`.
>      /// * the array must not be freed for the lifetime of this [`Bitmap`]
>      /// * no concurrent access may happen.
>      pub unsafe fn from_raw_mut<'a>(ptr: *mut usize, nbits: usize) -> &'a mut Bitmap {
> +        bitmap_assert!(
> +            nbits <= i32::MAX as usize,
> +            "`nbits` must be <= {}, was {}",
> +            i32::MAX,
> +            nbits
> +        );
>          let data: *mut [()] = core::ptr::slice_from_raw_parts_mut(ptr.cast(), nbits);
>          // INVARIANT: `data` references an initialized array that can hold `nbits` bits.
> +        // INVARIANT: the caller guarantees that `nbits` does not exceed `i32::MAX`.
>          // SAFETY:
>          // The caller guarantees that `data` (derived from `ptr` and `nbits`)
>          // points to a valid, initialized, and appropriately sized memory region
> @@ -96,26 +141,6 @@ union BitmapRepr {
>      ptr: NonNull<usize>,
>  }
>  
> -macro_rules! bitmap_assert {
> -    ($cond:expr, $($arg:tt)+) => {
> -        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> -        assert!($cond, $($arg)*);
> -    }
> -}
> -
> -macro_rules! bitmap_assert_return {
> -    ($cond:expr, $($arg:tt)+) => {
> -        #[cfg(CONFIG_RUST_BITMAP_HARDENED)]
> -        assert!($cond, $($arg)*);
> -
> -        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> -        if !($cond) {
> -            pr_err!($($arg)*);
> -            return
> -        }
> -    }
> -}
> -
>  /// Represents an owned bitmap.
>  ///
>  /// Wraps underlying C bitmap API. See [`Bitmap`] for available
> @@ -415,7 +440,8 @@ pub fn clear_bit_atomic(&self, index: usize) {
>      #[inline]
>      pub fn copy_and_extend(&mut self, src: &Bitmap) {
>          let len = core::cmp::min(src.len(), self.len());
> -        // SAFETY: access to `self` and `src` is within bounds.
> +        // SAFETY: access to `self` and `src` is within bounds. Both lengths fit in `u32`
> +        // because a `Bitmap` is at most `i32::MAX` bits, so the casts are lossless.
>          unsafe {
>              bindings::bitmap_copy_and_extend(
>                  self.as_mut_ptr(),
> 
> -- 
> 2.55.0
