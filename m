Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB22C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D80410EDBA;
	Thu, 30 Jul 2026 04:56:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CqFC47h/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013011.outbound.protection.outlook.com
 [40.93.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A18810EDB3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:56:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHY9iH+CowpHrz1wn08CNM7tJyjVQrj/jQTMTH32Ap3O3YOFWTE8kPUDh+kjAxSfHJqaOCu/b3EOwzkszv1bHsDroEeQ8j6xAazITRBHsQ1y0Qm0uO/DEZhwXh+t2qWvrjZXd0WB7qSRhgQ2nuEF5wNi1DiZoLDE6T46/ov462OmpGv88F+k80Lw2IZidPshIrQhH6GF0cWGhzj5I+Uri3zXcnSZD+ry4dsDC0jSStDMwkcjlGfMhXFTA1ggDBGlSRIv83oY2nDL7BHIEagH0e/2ELARhr7WGoF0KE5uMqeZSNVGLLETW5znKc60DREEvo2NdUq7Xv3+VO+3lorJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0IQo01UpQDIXvvYeVOy5orQWxfHQQuutOScpAVyAuE=;
 b=lq2LTSoR69Qce3zoBv2XDltiuIjcHw29Q5yD8/1arRJGVww4F9WKw7MOV9cjIKmOvZ6gXgnOEM4Oz7HPyODJvFk54BuBfw+cHRYUpmpD+agVj+DGz38ONRj2cfZzOktrI8VpQyk/RS+sI3h5MXqGaLcqYq+0+j35yxW3Z8oJe9mIPx4RVnuapZ0F+OcU61G9PKDqx72PPNrHoZCru0fu3jwXS25hFJEdYCcGQxSvofeXvd4ROGrW4kIrI24OMdUy+5ZD/coEMxTGjmZN1P38Te01B21Q0e3BoZFq3w5KVauNgbAeOayUJmCwDhigbLT1tWpjB+7xpHkVUivp8vLQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0IQo01UpQDIXvvYeVOy5orQWxfHQQuutOScpAVyAuE=;
 b=CqFC47h/maddL2sxWgAaSTndPuQy8A15buHFBSgfPRpYIIDBMqC/xlG3u2Gzbv9NRsSYG3hL8GqX+OQ9Z0VdNOEfgn7Ox9Swien1MR3qknbF2mrn9s2RthXpioxRw4aFttN2wygu8elR6vAKsMga366TFNSfoG+IZX6BiRDWsv50L3QfHTYhheETegEDkcLxMSgk9VqzgDUGuoTwY6FcYIgpijrYpPxUTyZOyElhu8FrFoETAqFKflGYwUAwLanXVAQRrFmy0t/qh0PfEE+YIYlw4O3PxihoJ8CDiLtZ08z4a/Uc9NKt9rF+I005PlqzSEq/wX6KpXeAcPlXDDbHGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 04:56:20 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:56:20 +0000
Date: Thu, 30 Jul 2026 00:56:17 -0400
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
Subject: Re: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
Message-ID: <amrZcX33BGJCTDMp@yury>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
 <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb841a9-0056-4ed0-a93f-08deedf6e599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 5wynsMd3TmCJ8YYzvPU8N45U243NibwOE4cE4WH8uBqoDJGAUNYBij7045Ttm7J5IY8U3yYu6+BWcfojZAtFmPJJXqjITWmSA1RjjO7tXrNu00KArdcaRV/PAGvZcRctHByy7yVZv9CzkzEfglJg7kMsr4NB36TVryLAl8JJjW9+50AszuS7WvkJ4Ng0WRZAuzkZDg51GWUdZYXXII8e4xf2iJQQaFrd0PwqJwjoWHsLduc5LWjEM7oEkputEYp5tGjHt27Go8YRIVmyfjUo7Zobq3OOG+oSFt1xLgFuBd98StCnhQlmPT/u2asw3MYmR/H+Z0AGoP+smWSKcpXZiiqC/qHv53oIZZSGQh5+MMs0fFynGAXA5nAiAffqsi46ISbmx52hoNThrhJfKrRx/8n2NW6TTFyqubk9jHgqyCO+SOev7r9WRIaFIbJrXcB2ShB0zkBTTfd6JnTV/saP3uaBJ4MKnQ1nVszJwNzL1xjISyY1XiwpUWvcTyinlHweK45rg3NOyBwN0YZsqBX0saAknWimN2z7jEXzQrnPemmJZ4T1MLdc34J+fJ2jZLfjlG6TquoSHaySYo4i5mxj29FRkcSHTXD1JcgdmFA/bxLJPsv6pdiyGwPBf5FPXWZAgjJGwHq31kg02ZddXJd8T+OMIm5a82Z0szaha1Jnvl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V4kyJNkJqUKptsvATdL1CdsD2W3IYH/wPCFYgvOH29eVQebLNBiTe0QxQdo7?=
 =?us-ascii?Q?oh0c4Atrp9ckGbE+lpBv8PTwiHSlpoqYNV724RrzRRKDPyw82p6H0YoVzIQj?=
 =?us-ascii?Q?1syXw/CzIyGqSnlyiDj/8hJULW2p3Hs7mrrxKtMxdnBZuIhophxAIdT/IcZW?=
 =?us-ascii?Q?y4hnCMzFSf9TgseiuasvFuYq2NTpMIC+2aHb0Q9WyG1ExAz8SKTJfC9aUySP?=
 =?us-ascii?Q?aboT7pbXvLefOXEx2uHc+0W8ZQNEAP/0Jux3FGRh+PgVXB5SAO3f+enYsLVM?=
 =?us-ascii?Q?pt0Z+x8sSKh44EhxpC8tZdWGKWSpiq8liT4fsomQCualDLVWQ6qnn+Tm9IT8?=
 =?us-ascii?Q?K6RT6gxF7eBsDMdOeQkDXMuc5SWngA49NIyhd4p3vv5+bEdnhnaGCgG8jX+z?=
 =?us-ascii?Q?hywuS5ofS0wvNNwpcvYbNUdo2l0nm/8p7qIcjdd1BlRTUsg7ENIP+oKR6935?=
 =?us-ascii?Q?vB/iMoQJhoUuaEqi71s2+Fe0X/PuKhW76/adDCFcWu/iVsl4vnvk2f9MbJ/C?=
 =?us-ascii?Q?6HJ8wWdpyM/R8lf7/WCc+OoMfmiE907yYFpzB7pOX4fLazROCVHkoIFsWS0W?=
 =?us-ascii?Q?At7q5oRk5PFbpiVJTFvZuATp903gZ69FZfA1hhabsRVN6EODptsRVZ8s/+YF?=
 =?us-ascii?Q?+NEScASAitfzoQjMQsGTMTblBayFoTKp/R3Aj/q5hSM5Os904BUHG0+qG7SG?=
 =?us-ascii?Q?3UUxX6E0y9VRMn/nkLIQ49r9vGx1zz5dRHADEw4MkjTY0rqcsSnMd3+pjT0F?=
 =?us-ascii?Q?0cshHFOzhKRDa3aIKGJHv4HqEOBRZC3VwGhvDw4HTLf15oRd/cNUP7Skufs4?=
 =?us-ascii?Q?HTRmtWR73YCNo19Q6u7Mkqs6n+TYtO1jQFqdHUfp69qOxJpQKpgzKLN0V270?=
 =?us-ascii?Q?jrhxh4Re3Wypin4prNBuHrxUlJ0zmBHRbqvv6Rzd1ZHjWnNMqGfWBWTd42rL?=
 =?us-ascii?Q?lWGU8Aubc8d+c8wU/IOxX5Q8Lf6rSqIk2/38DXPW5aZL2Cj3A6x7v92WwwVj?=
 =?us-ascii?Q?qSfzNhjK5xzrxSz5RXcIdMJG6aNTk+BcWBIf7GzUgqrOAYulHOp0HreS8BD9?=
 =?us-ascii?Q?r5QUKTVRCEWGLS7FVdypCvnr4eKfjeJHf3xy8Th0DX9Rh5ZTzgWWffzq9H/y?=
 =?us-ascii?Q?qYhunXZC95yJ6q4CaJCfA8FZAvytPe1LdgoNTissSgjgFNRYQLIDlcvOZlnF?=
 =?us-ascii?Q?Kkws3QghOvyxuhjapzMKyHJokDETfZ4hfdW3rD52CzMm56u0oJxgwu1sSuf5?=
 =?us-ascii?Q?v6HW+2Fm5a7D4CeXL7XbADTjSRSC/jGNBXvpGZxPs2PipxlujrVTvixIpUqz?=
 =?us-ascii?Q?RU8WCJdP7OHjlGcL19AF8RTde6O2/SWCibQtTha+TsLy7eN9Ux4mgRiNerVU?=
 =?us-ascii?Q?rB/kG7hvIs1dfXo+LUD7d82W4+hEJYtPs+vomKmERzZ696DESnhnSAAfTrcZ?=
 =?us-ascii?Q?eQsRH/p9duAgg9r/9LHY1bChBBvGcfmeV+uEt7+NbZhsxW4h085GlYZ/6VNh?=
 =?us-ascii?Q?IaPPuCsvwVXRD2k8crpd8xVnpHoc3w8aC3GhM12j5qmcMOjXcGFkiWWOhg/j?=
 =?us-ascii?Q?pOM6e0qz0z/8oKhuMhhfq3awsOZa7vjPpIg3OOEvlyeUh6LTkXK0CT9faF7n?=
 =?us-ascii?Q?2BB33mh91rdiZKqSqqx4MDWeR2dxsSGojPJ50VPA6GHEWKYzuCHmMOqqlNEE?=
 =?us-ascii?Q?xb58hJ4AD3Glsnc7w9x2XHYlr9x8kv6hFFB4++QRKP8MlGiN1tjs6zHKr4Rf?=
 =?us-ascii?Q?rtCL0LgLHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb841a9-0056-4ed0-a93f-08deedf6e599
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:56:20.4381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLmlabdYQipWMldA+5zHvLaeJf5ifDt6Lq0rbCClVk+GuByoDXxHhaMQ9nvGEgy8ol+yp69ntu4yTyjMeoxdpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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

On Wed, Jul 29, 2026 at 03:54:13PM +0900, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> The C code uses signed integers for some parameters, for example the
> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
> backed by `BitmapVec`.
> 
> Add tests demonstrating the edge cases.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc..f4b0b8ae39d8 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -10,6 +10,7 @@
>  use crate::bindings;
>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>  use crate::pr_err;
> +use crate::ptr::Alignment;
>  use core::ptr::NonNull;
>  
>  /// Represents a C bitmap. Wraps underlying C bitmap API.

Some comments use indicative form in the file, but the imperative
'represent' is a more standard way. Can you please use it instead?

> @@ -497,6 +498,116 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index is a multiple of `align`. Alignments where `self.len() + align - 1`
> +    /// overflows a `usize` can hang the underlying C code.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::BitmapVec;
> +    /// use kernel::ptr::Alignment;
> +    ///
> +    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +    /// let unaligned = Alignment::new::<1>();
> +    ///
> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, unaligned));
> +    /// b.set(0, 5);
> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, unaligned));
> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, Alignment::new::<8>()));
> +    /// assert_eq!(None, b.next_zero_area(0, 65, unaligned));
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align: Alignment) -> Option<usize> {

Please create the rust wrapper next_zero_area_off() around
bitmap_find_next_zero_area_off(), then in rust create the
next_zero_area(), if you need it.

> +        bitmap_assert!(
> +            start < self.len(),
> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );
> +
> +        let nr = u32::try_from(nbits).ok()?;
> +
> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
> +        // value and never reads beyond `self.len()` bits.
> +        let index = unsafe {
> +            bindings::bitmap_find_next_zero_area_off(
> +                self.as_ptr().cast_mut(),
> +                self.len(),
> +                start,
> +                nr,
> +                align.as_usize() - 1,
> +                0,
> +            )
> +        };
> +
> +        // In case of overflow, we may get back a range outside of what we requested.

No, we can't. We've got the test_bitmap_find_next_zero_area_off() for
it (in next). If you think the test is incomplete, please extend it.

If you believe that bitmap_find_next_zero_area_off() may return something
like that, it means the function is buggy, and you shouldn't trust it at
all.

> +        let end = index.checked_add(nbits)?;
> +        if index < start || index >= self.len() || end > self.len() {
> +            None
> +        } else {
> +            Some(index)
> +        }

So, this should be a simple:

        (i < len).then_some(i)

> +    }
> +
> +    /// Sets a contiguous area of `nbits` bits starting at `start`.
> +    ///
> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
> +    /// bounds, does nothing.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
> +    /// of bounds.
> +    #[inline]
> +    pub fn set(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds.

Not sure I understand. In the above assertion block you check for it,
now you say it's always true...

I think, your language should be similar to the
find_next_zero_area_off() case: it's safe to call the function with
the out-of-bounds start and nbits.

> +        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits as i32) };
> +    }
> +
> +    /// Clears a contiguous area of `nbits` bits starting at `start`.
> +    ///
> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
> +    /// bounds, does nothing.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
> +    /// of bounds.
> +    #[inline]
> +    pub fn clear(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds.
> +        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits as i32) };
> +    }
>  }
>  
>  #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
> @@ -614,4 +725,87 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
>          assert_eq!(Some(17), long_bitmap.last_bit());
>          Ok(())
>      }
> +
> +    #[test]
> +    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +        let unaligned = Alignment::new::<1>();
> +
> +        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
> +        b.set(0, 5); // Now contains {[0, 5)}.
> +
> +        assert_eq!(Some(0), b.next_bit(0));
> +        assert_eq!(Some(4), b.next_bit(4));
> +        assert_eq!(Some(5), b.next_zero_bit(0));
> +        assert_eq!(Some(5), b.next_zero_area(0, 5, unaligned));
> +        assert_eq!(Some(8), b.next_zero_area(0, 5, Alignment::new::<8>()));
> +
> +        b.set(8, 8); // Now contains {[0, 5), [8, 16)}.
> +        assert_eq!(Some(16), b.next_zero_area(0, 4, Alignment::new::<16>()));
> +        assert_eq!(Some(16), b.next_zero_area(0, 4, unaligned));
> +
> +        b.clear(0, 5); // Now contains {[8, 16)}.
> +        assert_eq!(Some(0), b.next_zero_area(0, 5, unaligned));
> +        assert_eq!(Some(8), b.next_bit(0));
> +        assert_eq!(Some(15), b.last_bit());
> +
> +        b.clear(16, 0); // Zero-length in-bounds clears are no-ops.
> +        assert_eq!(Some(8), b.next_bit(0));
> +        assert_eq!(Some(15), b.last_bit());
> +
> +        // A zero-length request returns the first aligned position at or
> +        // after the next zero bit, even if that position's own bit is set.
> +        assert_eq!(Some(1), b.next_zero_area(1, 0, unaligned));
> +        assert_eq!(Some(8), b.next_zero_area(1, 0, Alignment::new::<8>()));
> +
> +        b.set(60, 10); // Now contains {[8, 16), [60, 70)}.
> +        assert_eq!(Some(60), b.next_bit(16));
> +        assert_eq!(Some(69), b.last_bit());
> +        assert_eq!(Some(16), b.next_zero_area(9, 40, unaligned));
> +        assert_eq!(Some(70), b.next_zero_area(0, 45, unaligned));
> +
> +        b.clear(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
> +        assert_eq!(Some(62), b.next_zero_area(60, 6, unaligned));
> +        assert_eq!(Some(61), b.next_bit(61));
> +        assert_eq!(Some(69), b.last_bit());
> +
> +        b.set(64, 0); // Zero-length in-bounds sets are no-ops.
> +        assert_eq!(Some(62), b.next_zero_bit(62));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +        let unaligned = Alignment::new::<1>();
> +
> +        assert_eq!(None, b.next_zero_area(0, 65, unaligned));
> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
> +        assert_eq!(None, b.next_zero_area(1, usize::MAX, unaligned));
> +
> +        b.set_bit(0); // Now contains {[0, 1)}.
> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, unaligned));
> +
> +        b.set(0, 61); // Now contains {[0, 61)}.
> +        assert_eq!(None, b.next_zero_area(0, 4, unaligned));
> +        assert_eq!(Some(61), b.next_zero_area(0, 3, unaligned));
> +        assert_eq!(None, b.next_zero_area(0, 1, Alignment::new::<64>()));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        // Should be ignored since out of bounds.
> +        b.set(64, 4);
> +        b.set(62, 8);
> +        b.set(usize::MAX, 0);
> +        b.clear(usize::MAX, 0);
> +        b.clear(2048, 8);
> +        assert_eq!(None, b.next_bit(0));
> +        assert_eq!(None, b.next_zero_area(64, 1, Alignment::new::<1>()));
> +        Ok(())
> +    }
>  }
> 
> -- 
> 2.55.0
