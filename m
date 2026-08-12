Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B04C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFC810E19E;
	Wed, 12 Aug 2026 20:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rIQRwaQZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CEF510E19E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 20:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmKKo5MfmhmehWvy9zZvEpIO6c3qidbm73eJCMxMCeoc8K76Ki1+EPKdfp5w3+clNllt5DtP0WBfQmxSLyXLnhO6ArZRerDky8ESuekxPsGrcMR0ucMQkv8FSHoROAaOniU73vPftulJxGbO9f+5Qb8V+5NSfWj7s0SEO+bol/KDND48qKx8NpwQcljORQM/8F7mYBziNJAMt6hf3CmRpd6G+9ScUS1/2k2PMDQFtEOvUtowhpOMGV8bh4UhcAQAg500CVzRA7LYkywSRVlNNWDwF0bhnW+nfaOOww1qHkliOUHn4ycvhwVuXJUO/1BseEx4S7NYt1DlamGTcWesmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1S5ppFM/ihwZ8v13+WSDYy7B6g876CCJerOayB2quE=;
 b=QUPVmhc2QrYf2IXY3tADw4bBPxmzZsNKEhnrGFjqLMgYpSmGUUoDIVY80rLZoXdhXHKbJ3h3VTNy1MxwIlT3yMOsrObXJ2eZTpYMZ8h/RZa7i4abQlSF+UWv++zAExgdQL4H84nHs2vhcGWD8UFrnn7EPb89bb4ug/GVLnrkyHZBmdYLdDBRK1kIArWmyXGZe/U6tMooWrgdQScw7TRqyEb3PoT1Cv75wsr5A3MiXdUYW40RB7n6r1oYce+n9/kqyJdiC5rUR1h7xLLPNfTH7TNHVZYQuzFEO6NvfYlacuX2KxHRxCTgQBX425uzWi5UDZ/uKBlVgEFsWqjiwF1lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1S5ppFM/ihwZ8v13+WSDYy7B6g876CCJerOayB2quE=;
 b=rIQRwaQZT3j4CVlIOZWxSz10kPpDt3LHiW8Zy61ReWkapwNxjHqXeNHQ1FWo4axvJomkHALvb52qbLef5NLgqTDI3Bke0M3CpfcWKgZHIrlEXOeXPyKhp+6wAq2yveAEhoiw3ry7RLs6F47/RUGALYwXM6skPlsElMs2q1g0zwWiqLzNw063F7uXgW+u+jeuVrIOZ4ZThQHZ03GITZ0Xdbn/1UZnDZLsiWl5mV12WduzU4dz6tMsXgcwJs32I6GfqoQUsPo2Hhor/0EyOCgV85rSIo3hFPV/lZsAjqZ63kyhlrtudGJG950ueEqemBzBFoGeBOfCSnBactDJ6DwbtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:31:37 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 20:31:37 +0000
Date: Wed, 12 Aug 2026 16:31:34 -0400
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
Subject: Re: [PATCH v5 3/5] rust: bitmap: add contiguous area operations
Message-ID: <anzYJhbIr-aix4qX@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-3-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-chid-v5-3-6c767770b3f4@nvidia.com>
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: af2bae3c-f364-4c9c-b79a-08def8b0b564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PMt8K3lxNSMVuBgyGdJErC+hiuqEpNQhtdOd2KjBN0LviJS1slYur3odG9MC7q6Frlm01YkNhWbCnd7q9HsS3p+il0GGFFmPoqjXiPLjiH8akoM08vcn9/gEloEmwd5a8r0b08af6LZZvv98QqvXHChyhvak1EsrXPBWufGF9FDbVtP8wVxgH99Cmi0degDOzD/599YBsFuXN1tdeChuK3p09qsJJTR1i32eaxofWr6SgLMWh3zrjKJdCT2I1buYhhhoK4/TR8Q297RN+lnR3SFXLRf/QegZ5GNKr3wRQDrZnV80xzNoeusYXJpbRE0ZQZYlpaCiJNqWN/IP7yvy8UneucjKwhNnRZgncd57tSA+8zJYtwNEFOar483aJD8UsbfGrPRHbXexAlqvQimF8RrSEasoJNsDEd2d7j5ZElStCMqafs/XLs5cZmGsV/M8bDSYGnCQadQuvL3VG3rSMX/ntJskaZ49wulzyQf7/Bmst948afCSYIcacgbsTi3IXHhtezGamlkDOdNh41GrGa4YI3kNEu2AW3xsgANknD4th/GqD4UpHFECAFpxKTPIM0FxmYYYKpb05DQB7rdQt8np2BUdIsnGHjLCZLZbnbkSAvoLCfipT7LG39kV+pS/z58036t3ml42uu3k7hZ4etP+zXqZQ6ijeHgqPZ1HXA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hISZWmVSWnUWV7x4VjAqp4OvVg3sr+BdUOoAr/7CjaV7jvYs/jUN5JHewZ0d?=
 =?us-ascii?Q?SDUzWR+zM08ieLL1iJQUu4dJwDDf/BBVohm2FZ3ENTRFSkJDceAxMLkYE2j7?=
 =?us-ascii?Q?ISXxpNAI8I/di6q90C2vBHuuepBGS5SqKkKHlL96sEvKJjebQqB3XGVkbc5s?=
 =?us-ascii?Q?XmOFd+iQM1y1ZBxlsOktySxZ4KqhGZLDeL5WJaZF67Ct7BnohYz2EE1YYKre?=
 =?us-ascii?Q?TUfmvkFaWoYUk230WGi89YS3/46GUJMlPNn/zgLeT3GtGyGCLTaz+bdIzO/b?=
 =?us-ascii?Q?29nUoUdSxZ7N7auCJjcsY7p/mhW30052gBe+Myy9CEPFrjgflw+91bAeh/Z+?=
 =?us-ascii?Q?S7k2x8vC0BMghcUEVVMVq5NGZAdSfAeCzBNNSmuiFhYOnnoaXDBKHez59xUd?=
 =?us-ascii?Q?uthGu0/HDkElnaO6U1ov/WN8ehloeLKy9ob3LGfQWc5Sb5WmAkxXzoJ77Po0?=
 =?us-ascii?Q?8nIJlxMUrlasN4FNumlHv+y9MBvVQusMk5tXUVKidkGp/5rjwQMgzO+aBdLZ?=
 =?us-ascii?Q?8Hmg82w7nNFbmehudt5RXJDORn3f5/DNfE1DTVB9R6+PeWvPiIi9dS0eOJvZ?=
 =?us-ascii?Q?1ysmNF2P5oxjh+p+SidjbY9db/kR+dOgR2VyajNRfjsrK6mWPFjSWx0pO7NK?=
 =?us-ascii?Q?ZT4S/A++3B7WP8RGU9ejvhZ8nTqhD7/RPQdemDwRUjxu09ABSkdwe3J3qoI6?=
 =?us-ascii?Q?l2wNQ0ijyInmvY0mNN2+uI8PEj1teWjfFzOO7PmsPLldlX8aPOycjPQsSbfK?=
 =?us-ascii?Q?IMDnTCixYbCj+cKYQRtxsw63pYfdnaLA999MBF+uiinhf69HXMOnUU0h/oat?=
 =?us-ascii?Q?TyJhQ4UnD8ncYvyo7Z8p1sm87ReEHERv+w+lC59Ute5QY5A4vBfmUjcCyFzh?=
 =?us-ascii?Q?jLNpf5eO8dXSDWUmAy94hIuVPeANN+gYxo6PZjdj824thqEliEzC5h8fMxVu?=
 =?us-ascii?Q?PFW7xGaFE60N0NcmxaSccGN2HJCFnR/W85ybj84HglpZ8xQZFg3lfFtFpj5p?=
 =?us-ascii?Q?wL45VWODuzhYE7aEPdkbJotaP+Be/r6rYMJP6uLPNW3YMNbletgMDYRgJx0l?=
 =?us-ascii?Q?9Z98puSU7g7yURZWp8yGA5Q/dNvnE6M0R/lAvIe7dx04i/KCbvveAroBYCIN?=
 =?us-ascii?Q?HbhOltZbIEvRBKgUMQ+ygVTRvvwD4DGJ4ZSzY5vyTMhEsWSZn8VuH1WrcpeE?=
 =?us-ascii?Q?Dt+xUVxx6uogIxgv5ABlqr8IQR9+ZTp/3e2yvQT1zCY7SEAxOo1nGm8J8zaq?=
 =?us-ascii?Q?ZF8dfEjJpbyWplX+qqAymDyj6XmdLqp94tUHjbKgcTiyDQXWL9XlMT6UEYH8?=
 =?us-ascii?Q?suSEm77ewzHOe4Y1B2QZSWyOLP3e+kAiXcMnEYwnS+KYbWn93UxUZbxH8Zd+?=
 =?us-ascii?Q?WwIUE88z/qrP13GEAjBWgMBkK/+WlmWOfq+v7YVpnKyxnfe+jCzy95QLM4Ma?=
 =?us-ascii?Q?sXmWngks8yFHm26tcq2nrLCk8ew1jazBfoF2PS08F74UKlzZikAnYALLLxDl?=
 =?us-ascii?Q?bJzTq6rAFgmzQAcPey4mtmYvDO6Yk0AS/y6QsV4RdqrUVpvqk+V9do4whS2W?=
 =?us-ascii?Q?3t3CXMt6GqtL8fV67vxuUfNW2PI1pINs4ypbvkDbOIrlEklkV5IH75QE+/CF?=
 =?us-ascii?Q?XLCp3zCIR86EPB/BnsFr84pFQID7IHE+nauAU3Ofl3klybEMHXzhcHWbDz5Z?=
 =?us-ascii?Q?EVU7kx5DQYQE9ZfGU5qIPFQuPgx+qbxW6PydTJ31Q3UCEm0JbSG5USkLAdbs?=
 =?us-ascii?Q?ohCMmMWoRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2bae3c-f364-4c9c-b79a-08def8b0b564
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:31:37.6692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GTdRsNvJ69iapTbrnjNSn68WvgJNh1R0AquSz4+sKkosxzaq0Oo8z2BnKMKxU99sEg4kiq9lDoO9NoePc44nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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

On Wed, Aug 12, 2026 at 05:51:23PM +0900, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> Add tests demonstrating the edge cases.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 236 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 236 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index fdcfc0409773..74c92cc452c9 100644
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
> @@ -523,6 +524,139 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
> +        nbits: usize,
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
> +        let nr = u32::try_from(nbits).ok()?;

What about nbits == 0? In C, this is a undef, and thus in the current
rust implementation. Maybe make it NonZero?

The same question about align and align_offset.

> +        let align_mask = align.as_usize() - 1;
> +
> +        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
> +        // Overflow is only possible on 32-bit.
> +        #[cfg(not(CONFIG_64BIT))]
> +        align_mask.checked_add(self.len())?.checked_add(nbits)?;
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
> +    pub fn set(&mut self, start: usize, nbits: usize) {
> +        bitmap_assert_return!(
> +            start
> +                .checked_add(nbits)
> +                .is_some_and(|end| end <= self.len()),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
> +        // `i32::MAX` bits, so the casts are lossless.
> +        unsafe { bindings::__bitmap_set(self.as_mut_ptr(), start as u32, nbits as i32) };
> +    }

In the case of bitmap_set/clear(), nbits == 0 makes it a no-op, and
guarantees that the pointer is not dereferenced. So, no undefined
behavior. But in rust case, I believe, it should be a stronger policy.

I'd add an assertion, at least, or better make it NonZero.

Thanks,
Yury

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
> +                .is_some_and(|end| end <= self.len()),
> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> +            start,
> +            start.saturating_add(nbits),
> +            self.len()
> +        );
> +        // SAFETY: The area `start..start + nbits` is within bounds and a `Bitmap` is at most
> +        // `i32::MAX` bits, so the casts are lossless.
> +        unsafe { bindings::__bitmap_clear(self.as_mut_ptr(), start as u32, nbits as i32) };
> +    }
>  }
