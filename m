Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D16CC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A50A10E252;
	Tue, 11 Aug 2026 03:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YWq8PXRi";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDD210E252
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 03:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmdCXODR+d3fDcN2mbLEIGWs5xhx1dMIz+rNBWJUN6bLyuJPTO+EjhQQcGe8/xz3RF29GmrYPtd8KGixJxHfiI3gBM1KjqO6iPVzBvF7cPV3fcwzfdB3rclAfCh2UJW6IffScUh4mq3eOaHilw6vWrd3B5fUgOq9HDpFYQrFXTZFESInpeBdWDj2F0iXd/mIG2jyOYKR0i4tbyRpfyRnBrs3H6FQUZCRXDKPOBxhOIaoK9yzuYYKEVgkVC/wp4SHQtkbeKZMW7GrYX6JXdD0vX37JG4fYB9Ddw05zPaKz0RLQ/Q7siKymRuro0cph1EfRoAytBYyuSkYaeV1paoKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gceyc33LDJfcd8diyTQQm0z6t+gVGjvPzIemtDCfOvU=;
 b=f7s28OQ4KOejW+QhhBq4JSYewDxoyyW3j2iZFTUQkgalFMTuSu8lRHMjXoymrSA+Y2/9aaTp8x4re+L3ZR83QRdvNeMmcuudyJqhkxMtDMPCPQkuvTEAuHY9CnyazUwK9d5gpVvWBd1tS5mnmtg1o9gXBu9JOnI9AmL/V8fbZX+FnjuHsnbt25Q9DWT/dMjFtBuVEixdG+7v082TFSpyfpr/IT/21i/NUKelnERDY0T+SK/j+ZZrvymMgurZ3spe1QV6qR1FfoC1I1go9YFH3dBU9kGbAIhWOzyFwlZ8nlE/ZlGTvWNPzUTAB7edTyBEqp0eDsfarbmiq9TBi+IZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gceyc33LDJfcd8diyTQQm0z6t+gVGjvPzIemtDCfOvU=;
 b=YWq8PXRi4mKfGY/huVWy+zFBtm7RGXqsd2Tlu9UMD9yOwy6iCv665ttItVVzaxyJb+s6gZhVSDGXbEnl9Itsx6Iof4wOK2NLX3tCt03lKDvMhSDkAPL1QJss62bFHt4cy06fry5KA62Q4yQWIbr7kTFtg6iAozC+sXIbMsvBeMDUMRs9V2dLP1lW4wALk5Hb0UrrYk/+FUeDqYut9EE1OYFLlkzP+Sg2WMExYdqWds0wFSTeCClMdLJ5cD61fEv8IODs2P00MODSZkQ+FDU+jmYN4+UNP9Wz97JhCkjCT8uqgt2frcrL9ISVHw2ixX77aPQk1H4ihhLWcHkGLn0GhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:16:56 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:16:56 +0000
Date: Mon, 10 Aug 2026 23:16:55 -0400
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
Subject: Re: [PATCH v4 3/5] rust: bitmap: add contiguous area operations
Message-ID: <anqUJ9VMapPmhAHr@yury>
References: <20260810-chid-v4-0-c9f206fdcb97@nvidia.com>
 <20260810-chid-v4-3-c9f206fdcb97@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-chid-v4-3-c9f206fdcb97@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0713.namprd03.prod.outlook.com
 (2603:10b6:408:ef::28) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: b428033e-6cb3-45df-d60c-08def756ffab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|11063799006|5023799004|10067099003|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j90cTM3cCA9RuCsgvVpqagU/wsSC261RkBXWFJZaTIpaNajQ/A5MG3R6Qmjhjcc5eD0JXd+4tLciNIsJOkBdvHRGygeiK/zuLCTyVQerhUn6iNRM3IXcGJYgPkNWQTIIbFTQGVuf1WCZSSD1NhMq6BS06cBqqgV6ZrgoFj2ptQEgl4bbg+cydCcodaI9XcNIfBxUnYrJTU3/S7J5WXtkuNR2lwmIvnTdOvE+eruDW4pgG4RNBi8M7Xk05mycu/tQOK3p7R2BK2u6shPPVMnQ17ofrShYmenXKwhqBCu2dFEDd5AQxjOWTUfO6wp0HqF05sAUBa1dO3m/QJ9HS4+4JzcppWVh5j+4xeRC+dSmq/OEKLXrD8PrmhioCgTaXkRjZ1La32H9VMDLql7VQ057yrTStxXy7fhpM/khLjIk4EDDWfSt9gZiZJC3mt3bWo7kbvLFFnopxBsS4c6ZWuQPzklkaOVwze6du7kZfgwFjMjeUv8VM5ZW0JAY4y9b2C4OAxBWGjXnc6I5NizTCO7JOM7UyCggLTBvA3JCuiA86tu/jUVRZlZtbZV2ORkmrFQmrb9Bci/s33sokBNKQDOLb+fymkiD6/hqGVP0Ut9qvOcNyv1GrwvVvAw3Jbxezh1Hyh2cD2V+O5YpqMc6sHQS8cn0ABxDWNOdsZQq3EfNv6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1Wh/QHc6AZO8kuXs0iJu+I6/I5wAkjTr//Cqmvf/StUlRj2eWdXrM31LCIu?=
 =?us-ascii?Q?SIeaofSXAoVuGjuFDVae/xs1u5m/TXBKp8fkcTZJ/jjBuRshV/WlcAHGE4FP?=
 =?us-ascii?Q?oC21JOzmvXPpN9g56nDv5e8wCQ606d1PY66bbpWu2kkXuapgnkYb6eVcNhdS?=
 =?us-ascii?Q?QjmLK5JE5XhsvdOZ8+EtcS9kQriU0l3iRodJLKqt9xFKlMPljcNfMloq7C90?=
 =?us-ascii?Q?EKz3tooGcCnX0UvRbmxfM+USRIfB8HLAFcL0QU8IMsDaTvegQj3vxRCbXek1?=
 =?us-ascii?Q?ATUItW/U4U/Z7UG9PB3yS7OubwhJLPA9VWpQ9Ww4te1Dpc405Q/oIxT5yiLc?=
 =?us-ascii?Q?UTZB0RKQZOqnN5SzBD/Z52tMhe8z/fKVsg/yMLpnGr8/wvNmTRPQR4dQC/qi?=
 =?us-ascii?Q?clmtW4Pv+Mq1h3CNBWo5vOmqQdLjJEqStOkvbx/L9jVjPFvvOdYB/lVrklrp?=
 =?us-ascii?Q?4CofbJtZtPdE+SOwVO6LYoNCSxfedgBKab+BkfpGuk0ul36jKQjnXndetAWa?=
 =?us-ascii?Q?kpOOyFQ0KJxUXmtmf6vSMz5Xkm81AvPwJ73FOtFn7oZTbjykfaZdOhvbjYFO?=
 =?us-ascii?Q?DUh3je+gsBsG7ctT7Cm/WSJyujujSd16H5upJ8349sCre51N+r9WDYkjkb9o?=
 =?us-ascii?Q?nDlSc/1RlUFKHmOgDN6Xhvzn+swjq2ROLfPoK+Rfq/Nuy0PUNM56+XeSyfMV?=
 =?us-ascii?Q?HP6yIhHTJUPiUo6P7Rk9rTEOSg34OQfXysijlr3ODcbytb2TyEvTTiXpwTr8?=
 =?us-ascii?Q?sLeLQhCDrxD9MeZ3W3f7mjWp0L34duF1Exgaf29rcuADLSF5ur3/vmSt8vFk?=
 =?us-ascii?Q?MB13aUsVUpuU6ieDM0I/6kSPL2+4WYMPtmDGYnkXMcNF6ZHRlzwJ1uMvJV0W?=
 =?us-ascii?Q?lvHKw5GTNCXb8YBM82A1ZXgrcdePgbdR986NSd8KJ6xdk9RtQ777E/YHup1d?=
 =?us-ascii?Q?r840GtaZ2wuxvIC1kL65WIU+KY6UuIePejPyE2pOjhygDuev68LRrm5Jli8a?=
 =?us-ascii?Q?V1Td6+VnuA70BkH4o2h1LxPUFId6KdVtyHAUryFENufuYZISfmGieox83hdb?=
 =?us-ascii?Q?8PgeQnOgQuwDASNB3K0kRk9/GzdK1BWkIeDbxe3WpQ9j2RuGvwKwCZg6QtwH?=
 =?us-ascii?Q?WKoKg8KHwC4QekXnRbMXTpS/onvTqHh2zhA04LTT/jWBgwwwx7hCdhNpwW9G?=
 =?us-ascii?Q?acBJbknmrWxIMo0Tpp+DYwIZQYQlZcgOMeJe5pFf7zK9cm8i1OFQvfo0clg+?=
 =?us-ascii?Q?CcWpQu3J5IW/l/Bo94TO6IOYmjFRj+AtIi82ij9KdfGTiFeEZSV4O/y7VfEI?=
 =?us-ascii?Q?X2PestTxRyXa0dk8HnXHu1DBabgztQh/GU7dJimxfGnZzIiig26Ojpe9TCaG?=
 =?us-ascii?Q?OJWho8ZhY4TwLiKuXhQFM0AKtOaNihVz4pFHsdPD0YI/lmmXEaP4cIer+rDs?=
 =?us-ascii?Q?am7sL7EnKwPWwg8grzPNU8ndE7Afsb0oSHhQpKiyA2H4qNbc15FiXkGRBG83?=
 =?us-ascii?Q?QO+mKR65WuF4gm3KxO1fbUp7S9jMXQkTXqVsTKTeJIX2rSo0f6nHCIoRxJzw?=
 =?us-ascii?Q?jLk6jItiknbKNUf4O75txDLJjhqQdGCdrP1949nuPydWhU+gbv/QhXBede9A?=
 =?us-ascii?Q?EVSbhEwVcG7VMLtVrZSDPi+GUT+CFiqo38os4w2KjdxAUBM4Z54l9WPXrGf9?=
 =?us-ascii?Q?c06ereK7aDphXGFe/UKWq9MHE/KQf71k73fZwGvvOZZPzCl6LM6eEEuJABem?=
 =?us-ascii?Q?ppVAx+4Ekg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b428033e-6cb3-45df-d60c-08def756ffab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 03:16:56.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vm8hqk1o2RscnTaCcgvMbvHjGSFST+RDqpRHs0cDkwdbcpLCoZpWxEJKjYC/X7wPuyoaMZQ3PQzz9APM7TA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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

On Mon, Aug 10, 2026 at 05:34:11PM +0900, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> Add tests demonstrating the edge cases.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 235 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index 0d481d761f2a..a2557e9c5cfe 100644
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
> @@ -503,6 +504,138 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
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
> +
> +        // The C alignment and end arithmetic must not overflow, or it can read out of bounds.
> +        // Overflow is only possible on 32-bit.

That doesn't sound optimistic. Can you add a check for 32-bit case?

The rest looks good.

Thanks,
Yury

> +        let align_mask = align.as_usize() - 1;
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
>  
>  #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
> @@ -620,4 +753,106 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
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
> +    fn bitmap_area_off() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +        let align8 = Alignment::new::<8>();
> +
> +        b.set(0, 5); // Now contains {[0, 5)}.
> +
> +        // The area plus align_offset starts at a multiple of the alignment.
> +        assert_eq!(Some(7), b.next_zero_area_off(0, 8, align8, 1));
> +        assert_eq!(Some(5), b.next_zero_area_off(0, 8, align8, 3));
> +
> +        // A zero offset behaves like next_zero_area().
> +        assert_eq!(
> +            b.next_zero_area(0, 8, align8),
> +            b.next_zero_area_off(0, 8, align8, 0)
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
