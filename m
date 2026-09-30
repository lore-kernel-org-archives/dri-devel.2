Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5AFC9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E189F10E231;
	Wed, 30 Sep 2026 04:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JUejxxV9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EE0310E231
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntW5l5ZVxhud6PLFCxu8qyw9hyu+kf+/ft2KCk0BJdR2Q0n3FoJgfIAmyl7FxMNbpNof3Wf8xp3xrEOEElZaXPkxZmEVTz1M1O+63gLywd9knyw1piKzaffEHpWkA4QBr/+datB+dZ5rq/wJ5gXpGWuws9HKH0P/17AW8cwZITF8wj6HCRpbr6uqfSiPDQ4K5QMvDqLYi4CmTN54E04N7vlerO7l5VljackHD/1h4dJPCNWh2sVj7gFLczO91f0LqmTVIloX8mfcIWyOB3wBz4O/eh8P3sm9ub1DqXXB4WUlEy8QQrVVuolzxAFYCqnbk/lgoamzRhiL0TFo3x3miQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfOGp9bc/L0IPU6zy6vQ6xHyZ3TXektzkPeqHqUy2r4=;
 b=Ep8NS9qZybRVsYarhVEwBj3yDajpS/0OxK6gEHL+faFjzEyCB6j8KRnGw5gVBKB7FBaEzuHk+MtXFx8J+l+BTJczp6UX0ZFLZk0Leg9qcx6Kg5FKWRUgcaMsxg69/8jN8bxCU7x0o8cr49lRAuEXZweTsoGVVZu+CYH+Z6zD4G7o6tlaQ39EW5qeqg89Y8hRQBS6Gn1AX7BZ8/zNcTvSmi7uKV8P8WH3To1SarqH0A58oUSY2MxlevDyXaqcNTTkAfiCXaStG6paxbqXUB3s44tStpi8VnGM6x39TfB5I8jSKZbMk6h2X8b5C4C7qNu87MJy8zyAZPB2UKoyLjojbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfOGp9bc/L0IPU6zy6vQ6xHyZ3TXektzkPeqHqUy2r4=;
 b=JUejxxV92ixUVK2TUklO0/3hwInffF8qKTTRCAixWQhydFkw/LZiv0eytc0HHFDHX9NXJ56L9k3u4wEaLIkx97rToOIck930rPEnRqCyMUcohMjQM323o3UZC3SL+SFtPXRdmLI4Km0VhCpRv+AMG02QkmRD5uVAdoK/WuctZpub+rzyfdoEBxJfn02vpIQOIOHZzh+9I/YmtCQS6Z0CUOMk2GwZ/p0HaXsc0Khn2BCZ5bzVmd5hz+XbVJvJyEjPnKlPwbMLwpzSAeixyIDM4wK9E0yMm+bR5txrlpwFARc0wsNVuhmhEv/0gCPFHrFuHCrdyHEeYi1K7W29g13KYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 04:41:09 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 04:41:09 +0000
Date: Wed, 30 Sep 2026 00:41:08 -0400
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
Subject: Re: [PATCH v9 6/9] rust: bitmap: add contiguous area operations
Message-ID: <aryS5Jzc9ELvvP8b@yury>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-6-0d6cca376cff@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-chid-v9-6-0d6cca376cff@nvidia.com>
X-ClientProxiedBy: IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::9) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 8102d887-1ebf-4444-6f3c-08df1ead0c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ARoz5FoKhnVVeiJQAAmZN6q+CQ/zHF1Q3koDOtKePVQZItRbECSZ1swc4A+HD9HZDS2IVVmmFg+oaqtFM8uJfDIWm+q6VWmVIDYxJKcMIJioEVojqwqLyUSta4N83ID4yQohGGHfQ53uDbNOT5UQ2K/YVu/VWzGCOOTLI0XwDDmYLm7cQqmjrrw2cXD0a6ikNpWWk5Bt2pDeVnEW8pX5hg2T/BX1/Z9CSSA8mafQvOQE7VUav4jaan3gODWkG5yHLNjLeZhp9Mq+cE7fKkH8N5Ske11y8wTgVo3nLI1Tz/PX6Y/AT7IS0A1V6ebJzYIYyrZB5VVh+g5fLSZuc2kYCtXMlD8AFhPV1N1QdNwdQ3mHdr5fYJ37znaK6885TGnwVZ9a5DUxO6fvm7B3fbxDWN4MW0qC4v9dkhv6HulhcVxsYhRtwBXzXQp1ypRGGYCzGjAXQm4v9mXAjSUxdTgdivgNZZ1bR+O19CKgaLorGqVv+9hAoGqo/KmgiryY92BNjyZnSLiUIE2wr2gTnHtAvRjrXk6Ehw4xMBklJAn9EkLxgYxJQW5+ZlsMHVj33+OfY7PbKDfg2uVxayr4f5pvl6RStz5/RoPQDmVI7z46TO3D737DfXHGxqnmGpYyM8g8Xhr+mALmGbxCEgrj6sFmJl+i20YznUWmeLeTSxwQzqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BUBrPTjAs0jahaQkxuQaZRZlttHYNghmA8zeX6YZPdyqvbx7t/TsVpbfVi6p?=
 =?us-ascii?Q?XQwB/fZ+DQQUuGueF49ii5sx5oiY5iBa/d/LI0yMRwCKuW4gPhd98FBxkBzk?=
 =?us-ascii?Q?okezqNGqGsK8PV3ulBs3k1hGi+v0Rb9qPuf0KVWXspWTYcKz5XXKLTsKh3tm?=
 =?us-ascii?Q?k+uk1A1kABTQUvK/genzSyU5BcQuTcA4tTTiFS/sfOiTVX9vHXnn9Nj4/AXs?=
 =?us-ascii?Q?6s4FTkeWg8kAZJI8SHjgZFdMfbjORqqJWH1qh201mXi8YBrKHOBIVZuNZhFB?=
 =?us-ascii?Q?C7aT1SUTwqpgF8tzCqJgoz9LvgoVXoYHkbyeoxjXyfc3tPNSTgyqYSG/3Lzv?=
 =?us-ascii?Q?NSR/kLXAMeUOtoa8H6NBsnSjdjccM/k0RcEFCxH1Fg2mP3ZZr8F1jBcITVv+?=
 =?us-ascii?Q?UzW8HuRc+oWoklN8uGMwAbdy2fIgjLzXIoDzEqN4LCAzDSeiN6Zo20Me6km0?=
 =?us-ascii?Q?ZP5uanFPgGX65Jpf9lLwm22Vi7iRTDfLS/2/mPOKSaAHc6eeZLZ21iy8261W?=
 =?us-ascii?Q?Q4B1Oq1Xzy8M4jvC0abYQfIUeHZrmX11+4OGjYH7tlrc9XwnvdpP6feBonNU?=
 =?us-ascii?Q?BNymudjCtLK/sHGVz6OaFyUhS2NcOKPje0ZXarettvNnmok1pAyu/wKZ5N/3?=
 =?us-ascii?Q?DY6IjrqPl0C4gk7MXq500BuWFcy8ydWnpR5xYW0OBQZSi1LpDRdvv1sp1MI5?=
 =?us-ascii?Q?h7iiuzY3J3KlG2clwosB/XhLS3sozeCh+EmP3L9pdkZhPY/HW6dzU6t3ZxpC?=
 =?us-ascii?Q?u8i4Eey8D4eeKANDhecEtzDXAOm0mtfWR2EW0NzjDmD8y+zWBHEKnwdtYKjk?=
 =?us-ascii?Q?w8s5n9+tCRRjXyfHDxM6/lYakiqnxjU389QJTRnlI8YjIRYGSUfhDqjZVCkn?=
 =?us-ascii?Q?yEUZGWRhpzWW02esugfnUn8SQVGLr5MH+8rZLHJ6XhuLFBwt/c62LPXydgNc?=
 =?us-ascii?Q?06Oq0HFSuRtK6BcxC2qNbv1np9y2p+Qxma3l3To39IP3VDfk5BI9YyxD1TqI?=
 =?us-ascii?Q?VXgaZGWvFaIF812pMtPB+elD9JUKfHSXcixIK044F09pnPk/NhQglSC40JeO?=
 =?us-ascii?Q?YRnUyZyiMJ4HTeBt6wzLxjQUw4L+q5iihpWkdeS2sxmatyCiazJZuDyoFilw?=
 =?us-ascii?Q?b1QPQSUqfRd7IzhSUOqhtbq+dNFNa0votC98q11eKQO2YSKICdPsT+a0HkjW?=
 =?us-ascii?Q?fKb4c/+nSvx92Zi7StSN8jiHOiakXqw7wXBZmdatGJxhVlxS8JUaNaxaditR?=
 =?us-ascii?Q?yQKMvulW9iCKlHZ3mAZLB6dLDyIA1jJoMZTg7zYNSBNTT5fc5rv4JnnHvZKm?=
 =?us-ascii?Q?sd6RLsnZ+K6LKFRRgSRvy+Up9Rd3hIkQ2NNa3gZAdQnHzZ6C7H/LCv6HRJsJ?=
 =?us-ascii?Q?4B4vu3F1SrGg0DMynA2F8hT09cm1x3w/s1W3ERP8jJgAk8bvsOptuZ5auE4w?=
 =?us-ascii?Q?IiNVRs/idiYcNUMeRKTkVHSLNajfhSuMW3LzVcxdyM5km6oGCw7d7wENmi/r?=
 =?us-ascii?Q?AYCNETpllsp9GhTUC9Uf84nJjE6DlN3QE/4xaPPIB3lHXuJ8NHLIeC5SuKXe?=
 =?us-ascii?Q?XVR7T/jcVmj7DFlrjPMapwR2n3AkwoMmEvryalsJECSR0YkQlqZaBgyzKcBD?=
 =?us-ascii?Q?rx1t1fjAq6SQ2RFEF3WU8t/AdDA7Oikq/t2Ms16w85lhdmrZU1aK0I7yZY/X?=
 =?us-ascii?Q?rtJ58iPwZSBujd4b1mQtrvdNPyUplrV4/4Ah9YVgiRrn9hu0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8102d887-1ebf-4444-6f3c-08df1ead0c3c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 04:41:09.5848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNRgS9foXqpetDB2pPrt0Yq8SS4iDG38ysrXb6rwGv4Oim8Jq0xnWH/oN//4zwLMVm6UmhXLl2wp9GbuWbbt6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

On Wed, Sep 30, 2026 at 11:42:55AM +0900, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> Add tests demonstrating the edge cases.
> 
> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 241 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 239 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index df5505ec7a96..23c2b43a98ac 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -10,7 +10,11 @@
>  use crate::bindings;
>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>  use crate::pr_err;
> -use core::ptr::NonNull;
> +use crate::ptr::Alignment;
> +use core::{
> +    num::NonZero,
> +    ptr::NonNull, //
> +};
>  
>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>  ///
> @@ -525,13 +529,159 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`, where the area plus
> +    /// `align_offset` is aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index plus `align_offset` is a multiple of `align`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
> +    #[inline]
> +    pub fn next_zero_area_off(
> +        &self,
> +        start: usize,
> +        nbits: NonZero<usize>,
> +        align: Alignment,
> +        align_offset: usize,
> +    ) -> Option<usize> {
> +        bitmap_assert!(
> +            start < self.len(),
> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );
> +
> +        let nr = u32::try_from(nbits.get()).ok()?;
> +        let align_mask = align.as_usize() - 1;
> +
> +        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
> +        // Overflow is only possible on 32-bit.
> +        #[cfg(not(CONFIG_64BIT))]
> +        align_mask
> +            .checked_add(self.len())?
> +            .checked_add(nbits.get())?;
> +
> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
> +        // value and, given the overflow check above, never reads beyond `self.len()` bits.
> +        let index = unsafe {
> +            bindings::bitmap_find_next_zero_area_off(
> +                self.as_ptr().cast_mut(),
> +                self.len(),
> +                start,
> +                nr,
> +                align_mask,
> +                align_offset,
> +            )
> +        };
> +
> +        (index < self.len()).then_some(index)
> +    }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index is a multiple of `align`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{
> +    ///     alloc::{AllocError, flags::GFP_KERNEL},
> +    ///     bitmap::BitmapVec,
> +    ///     ptr::Alignment,
> +    ///     sizes::SizeConstants, //
> +    /// };
> +    ///
> +    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +    ///
> +    /// assert_eq!(Some(0), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
> +    /// b.set(0, cv!(5));
> +    /// assert_eq!(Some(5), b.next_zero_area(0, cv!(8), Alignment::SZ_1));
> +    /// assert_eq!(Some(8), b.next_zero_area(0, cv!(8), Alignment::SZ_8));
> +    /// assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn next_zero_area(
> +        &self,
> +        start: usize,
> +        nbits: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Option<usize> {
> +        self.next_zero_area_off(start, nbits, align, 0)
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
> +    pub fn set(&mut self, start: usize, nbits: NonZero<usize>) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits.get())
> +                .is_some_and(|end| end <= self.len()),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits.get()),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
> +        // `i32::MAX` bits, so the casts are lossless.
> +        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
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
> +    pub fn clear(&mut self, start: usize, nbits: NonZero<usize>) {

I'm still not convinced about having this non-standard parameter types
in function declaration, but ... let's give it a try.

The rest looks OK, so

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits.get())
> +                .is_some_and(|end| end <= self.len()),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits.get()),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
> +        // `i32::MAX` bits, so the casts are lossless.
> +        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits.get() as i32) };
> +    }
>  }
>  
>  #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
>  #[macros::kunit_tests(rust_kernel_bitmap)]
>  mod tests {
>      use super::*;
> -    use kernel::alloc::flags::GFP_KERNEL;
> +    use kernel::{
> +        alloc::flags::GFP_KERNEL,
> +        num::cv,
> +        sizes::SizeConstants, //
> +    };
>  
>      #[test]
>      fn bitmap_borrow() {
> @@ -642,4 +792,91 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
>          assert_eq!(Some(17), long_bitmap.last_bit());
>          Ok(())
>      }
> +
> +    #[test]
> +    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +
> +        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
> +        b.set(0, cv!(5)); // Now contains {[0, 5)}.
> +
> +        assert_eq!(Some(0), b.next_bit(0));
> +        assert_eq!(Some(4), b.next_bit(4));
> +        assert_eq!(Some(5), b.next_zero_bit(0));
> +        assert_eq!(Some(5), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
> +        assert_eq!(Some(8), b.next_zero_area(0, cv!(5), Alignment::SZ_8));
> +
> +        b.set(8, cv!(8)); // Now contains {[0, 5), [8, 16)}.
> +        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_16));
> +        assert_eq!(Some(16), b.next_zero_area(0, cv!(4), Alignment::SZ_1));
> +
> +        b.clear(0, cv!(5)); // Now contains {[8, 16)}.
> +        assert_eq!(Some(0), b.next_zero_area(0, cv!(5), Alignment::SZ_1));
> +        assert_eq!(Some(8), b.next_bit(0));
> +        assert_eq!(Some(15), b.last_bit());
> +
> +        b.set(60, cv!(10)); // Now contains {[8, 16), [60, 70)}.
> +        assert_eq!(Some(60), b.next_bit(16));
> +        assert_eq!(Some(69), b.last_bit());
> +        assert_eq!(Some(16), b.next_zero_area(9, cv!(40), Alignment::SZ_1));
> +        assert_eq!(Some(70), b.next_zero_area(0, cv!(45), Alignment::SZ_1));
> +
> +        b.clear(62, cv!(6)); // Now contains {[8, 16), [60, 62), [68, 70)}.
> +        assert_eq!(Some(62), b.next_zero_area(60, cv!(6), Alignment::SZ_1));
> +        assert_eq!(Some(61), b.next_bit(61));
> +        assert_eq!(Some(69), b.last_bit());
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        assert_eq!(None, b.next_zero_area(0, cv!(65), Alignment::SZ_1));
> +        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
> +        assert_eq!(None, b.next_zero_area(1, cv!(usize::MAX), Alignment::SZ_1));
> +
> +        b.set_bit(0); // Now contains {[0, 1)}.
> +        assert_eq!(None, b.next_zero_area(0, cv!(usize::MAX), Alignment::SZ_1));
> +
> +        b.set(0, cv!(61)); // Now contains {[0, 61)}.
> +        assert_eq!(None, b.next_zero_area(0, cv!(4), Alignment::SZ_1));
> +        assert_eq!(Some(61), b.next_zero_area(0, cv!(3), Alignment::SZ_1));
> +        assert_eq!(None, b.next_zero_area(0, cv!(1), Alignment::SZ_64));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn bitmap_area_off() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        b.set(0, cv!(5)); // Now contains {[0, 5)}.
> +
> +        // The area plus align_offset starts at a multiple of the alignment.
> +        assert_eq!(Some(7), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 1));
> +        assert_eq!(Some(5), b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 3));
> +
> +        // A zero offset behaves like next_zero_area().
> +        assert_eq!(
> +            b.next_zero_area(0, cv!(8), Alignment::SZ_8),
> +            b.next_zero_area_off(0, cv!(8), Alignment::SZ_8, 0)
> +        );
> +        Ok(())
> +    }
> +
> +    #[test]
> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        // Should be ignored since out of bounds.
> +        b.set(64, cv!(4));
> +        b.set(62, cv!(8));
> +        b.set(usize::MAX, cv!(1));
> +        b.clear(usize::MAX, cv!(1));
> +        b.clear(2048, cv!(8));
> +        assert_eq!(None, b.next_bit(0));
> +        assert_eq!(None, b.next_zero_area(64, cv!(1), Alignment::SZ_1));
> +        Ok(())
> +    }
>  }
> 
> -- 
> 2.55.0
