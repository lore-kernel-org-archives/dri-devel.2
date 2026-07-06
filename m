Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D55C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0A010E379;
	Mon,  6 Jul 2026 16:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="btjNjpev";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8468310E379
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 16:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FABpqWQRl8i9zHnwMGkghP9RSN1fDDCd8w1/1CdmvAPlRUJHVlV3kQAn3jYpZVtarAzAk28uIPV2TfOLDXQ57qrm19iftcfPCFMT8URsweu6YtDYfDeJkNbzyYl6CRB2ttr60e0Fmakr9LeQ3ckOTIVxJLtM83pO9X8w1hXL2X4ZIGUN1QoQj7Doo3r5Pi+gRT5/82LJa0Yyk4KXfoWP/+a3d8hcHrCnUhch4buusLWnZnDdPqiPjllLB4zInM5neCCkDbaWe+a8oJjGL0l+CE0vivW+IhPVHtd49e0hvn2y68YHkG/phnmEyub5ezRsjUwPTl4f7C3LwnXW/hILGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDhPcqLnX1dh2aMo3890azdTJwHA1ITPPSlriFqznEg=;
 b=y6kCC1VjBt7MHz2Z1Xeq4clj8wmTdPSou10HrcEWLQKoji/t01QIzPwRNyE2/OfQvTLZZISn/3DEamc2nC350pkdREbCxD9+abB0NuRF2d2k2zS17ikjnESHYEA/S7IZUWDnlARG040q5SB9zCjsVAeO7wAjQOmZxQBIGAAbbyt8GiF8a6TBvEzsKblcqdLaxVP7/7NE3/+Sq5mpDX48AX3t+1XMNFrkym3IvXqxWOfGhq2gUU+oZW2ZmOjtMXQFkfVbV/q7BCIigwVfI813yA6864YoX/QGEVT5tF++elz5km/KFafqDbR6RbJw62C0/CqK+PGsYIN2s6lG04yEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDhPcqLnX1dh2aMo3890azdTJwHA1ITPPSlriFqznEg=;
 b=btjNjpevbV2S2/wgnhu+WxbGrq2WI/8Wvv4Mdeu5bhLAOiTs4KJKjoQTaTNCNPNVPEzIhuFXTc80QlgDbB93O1lqME+eCkWgTonkulCV9uRZD+T4KOlo/pDC0IYdEEEvfl/8mgeobcTk2JjLNwtsbE/EqgIobPvPf8la8SbsAF0qdcKVD0/oU8FkBT5zyqkuC77rDh02Ykkt6rVT6arKQy3S8WLXTsT+Iv7a4WfXJCuBWX5NECPW8Y4mOJy4MAn8SVNs1zdcGW43as667xIiHOmblTgCSpOlSMEGbP86GlP07vcZgAK6CkN1dovcdKINywB+NibEVtJGhZ9ANg6H7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 16:29:02 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 16:29:02 +0000
Date: Mon, 6 Jul 2026 12:29:00 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
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
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] rust: bitmap: add contiguous area operations
Message-ID: <akvXzPd169ahMuCi@yury>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0535.namprd03.prod.outlook.com
 (2603:10b6:408:131::30) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 506ef12c-5255-4c2c-973a-08dedb7bb04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|5023799004|11063799006|3023799007|4143699003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: j6ojp7h1gGIanvuHcdduVojIvmkWjilTcagKMnifIz+IA38fQh1S54lJmBv0RaFPmKPJ+e1+V5X2fdw8hMxmkpdT9n8VBGO5SdN6qc7zVU5w+/fxnoRZC+pemsU+gGJ5rslX/cw9+WGTXz5FU8PQAs0OdexFCDvGWKGi1PW9iwNNKxBTITUMh3YeKE//VpLq+nKennjlUXiLoYrFLXSzNOMdteLk6a/iZiWq1vh7fW61zEzRF7KzBaQb4AbYXltQDoXz2wgtP14wXWPAUuiXFEYs/XSqC7Qew+YqTob28cdVh/p9QjHekQM9GDPkE0Ayr16kNvFs7HMb0AHh7sSXXqx7oyJw+Ec3Zy/oScKmnw6B76wZBfOPaX7TsVZrQvinT2gm3lujqie7cLRP6Ud1cIwQJIj9jVravEoGp7hO0t/M1bo88COMfXBxdxaGxv3TWNqxhMZp5R3qYlAeeXPzJYpHz/I8zOH08fDw/eimkpxntv1uK0hm9wkdMLYaGXtHyEZbgDaa9ZQ3CH3bsnKv9Ba0zMSRiv99RCeLynI5YX8OKGY8QUfEl99p07IdyylNyP6oiz+5Dkn4VWZl7wCIvx/fjYPdmvbp6sB5dLZ00RaoCrsF5r3181FNkLs95Du3DHE/KNJciWHCA4Gs288pQCzwaYnBoXx6Y0MBdh7Zaug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xp5TUm+TrLPYnkJos3XVYf9fEPKckP5pQMA0E4sCNAdE0yCq23LUYZV0IYYi?=
 =?us-ascii?Q?VWBIICzJAtwbyhJxbgSuBzTQLtvz3nfrkXTq/ejHWnVGY959F0aN25oukaX5?=
 =?us-ascii?Q?eYWuKaSL1GdiqxMUz82EGpMY/B/oWpzO0XP0mniHCzLufOT8Ll9UZHf3G8Tc?=
 =?us-ascii?Q?b7/OZNQan+t7B9XdfBhYBSi6hDGfUR8pFSDybqBXJ/xcb5/5VkErScLFzAPY?=
 =?us-ascii?Q?R1ui5BIEj6DlqrHuSOgqzjaPF7BFg/n7lFDyMXAkuBZ22e1F0+YQVqcST82h?=
 =?us-ascii?Q?Je2FRrZZPKIO/iSr+ybGmY1o0IHBMNAU49K9yzV/W/rvhbI2PDOxj3ZgM8En?=
 =?us-ascii?Q?WR47m/wrgsbjv3mOPIgJle5AibrxLztvljH4vE0MRZ5Ge+qXvJf9nppCEgSa?=
 =?us-ascii?Q?kqpOACe0aZxJfKmZ04uIe4ta3T1vhPf5o8PAAxT/J7wkA6W8mulAV0LMcP81?=
 =?us-ascii?Q?d2oJomP272rt5Jz5KzfKZ1GMHqz232/8FJMPJhuMylpK22BDiA7OISYQqmdB?=
 =?us-ascii?Q?+1Js5Whz+jZ+2/JBH6FfaJ+OHbad3vTvMIOSNTdXVH1yZV6WFr/8EOCusNgb?=
 =?us-ascii?Q?3G5uroWbFhHJShgVKOxSa0WJHXczs9On0nSAUVAp2d55qkEp6iWnivWQ73pf?=
 =?us-ascii?Q?q7gTfkSqlUysJkMrTnj75kEOCr389Gvb4TusFOqt2ew7VyDMjEROlvdpeyG0?=
 =?us-ascii?Q?ZD5BPVNX/QVdXI4DLNociquS4hGzYW0Qd8om7QW3JsJYYtXqivi3ofHseGy6?=
 =?us-ascii?Q?npd25nTI8GnRNCqt9JMs9EWKYkWWe290NxuJdzR+BSKExshVYpqVtLVujqRU?=
 =?us-ascii?Q?0vGpab21TLHf/p9/4VoXFFScKeGSq7J4r+iMxHM2RjdyB28PBBvMIDdmjc4M?=
 =?us-ascii?Q?gWNFEiC/cxk6kCgFpqlJmM30XOCaolhYE16lsuKKxDVKH/2TIy5stdZi5llg?=
 =?us-ascii?Q?wFOX5SyZ6QUGh9RYrYAreN/qfKUeuYo7q4L2ZkYFy2Co9070pSGfc67aR+Mb?=
 =?us-ascii?Q?P8iBos2SkuLk+Ahhi64e4NTMBMwTeQFlw4mB++hRVEhiZHiNaDfd4A6tSuLM?=
 =?us-ascii?Q?C+1KJl2KaM8p7If4T7cAo7Y0coOpukVh381OLR1ntTrqwa8B16miMA83Xc3P?=
 =?us-ascii?Q?LlYRagij1CKo7/bHvLAx18e+TzUxPPrLw4Y5hOUWr1yVIouRz+Vp4hfcJi+d?=
 =?us-ascii?Q?euHgMjrys9oY3gxEqn80Y/ezak8LH6jMfXM6PHT0MEaiYcmVyRatrNa0MSSR?=
 =?us-ascii?Q?Oo3l1vjZiy7XYcHHxFcq33+MA9HidGqLA78JYUhxw3Ma7emQTGx1azGzOurj?=
 =?us-ascii?Q?gmVqYQ7Wq8/+iLqHDrsfD7NCJ4V6pqzuQrEzuE3cKAfczKsAHxOHrZFmLrns?=
 =?us-ascii?Q?fuGqtr+ZapMa7koEsM0eGWCzIL6dtqyR/4Twf0wWX7uwU65IH5d+s7QDMb2Y?=
 =?us-ascii?Q?I0knkZ57qSnVgH5pkDevaid2JteOecl6cPbjCFT0lo4eXCA8i9TwFN3aDM12?=
 =?us-ascii?Q?YqpfCkfbVKF6MHMtiUQy/xA7c/JEG5zK7+mTFsxwpwOhp6jy6OQ1/hi0UxWQ?=
 =?us-ascii?Q?g3rIAfW0Dv7pdquXENvGjbFtHksjLk78FVJVT6J/ji68imvnx8NkQThAyhjo?=
 =?us-ascii?Q?pS5Znlp8pioelDm+hMIj12LH5CiHDmqq9wMTeqZZ3kNvyYqzmF+WixLc6Rlv?=
 =?us-ascii?Q?hNForcJ9yqzVX5N7nQsD1ASN5HGIT+TA9182iEppTJ0gEVWw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506ef12c-5255-4c2c-973a-08dedb7bb04d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 16:29:02.1999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8ySHOP5GeVsV87CqR+VRYJzDtIS48/0GgRr5cN+sMdIToGKqlKT1N3zoRC8n1OYRacQkr/zGE8+8gEkrEcxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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

On Fri, Jul 03, 2026 at 07:16:05PM +0900, Eliot Courtney wrote:
> Add bindings and helpers for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> The C code uses signed integers for some parameters, for example the
> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
> backed by `BitmapVec`. There's also a few cases where a non power of two
> minus one `align_mask` can cause an infinite loop in the C code (can
> happen on overflow), so check for that.
> 
> Add tests demonstrating the edge cases.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/helpers/bitmap.c |  22 +++++
>  rust/kernel/bitmap.rs | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 241 insertions(+)
> 
> diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> index e4e9f4361270..dac5c03f2448 100644
> --- a/rust/helpers/bitmap.c
> +++ b/rust/helpers/bitmap.c
> @@ -8,3 +8,25 @@ void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *
>  {
>  	bitmap_copy_and_extend(to, from, count, size);
>  }
> +
> +__rust_helper
> +unsigned long rust_helper_bitmap_find_next_zero_area(unsigned long *map,
> +						     unsigned long size,
> +						     unsigned long start,
> +						     unsigned int nr,
> +						     unsigned long align_mask)
> +{
> +	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
> +}
> +
> +__rust_helper
> +void rust_helper_bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
> +{
> +	bitmap_set(map, start, nbits);
> +}
> +
> +__rust_helper
> +void rust_helper_bitmap_clear(unsigned long *map, unsigned int start, unsigned int nbits)
> +{
> +	bitmap_clear(map, start, nbits);
> +}

All three are the wrappers around the regular outline functions:
bitmap_find_next_zero_area_off(), __bitmap_set() and __bitmap_clear().

The inlined version in headers is optimized for small bitmaps. But the
optimization is all based on inlining in the C code. It doesn't work
if you wrap it with a rust helper.

There was a discussion about the similar find_next_bit(). The function
itself is an inliner, but it's a wrapper around the true outlined
_find_next_bit(). So we decided to minimize the binder size for that
type of functions.

Please, keep the binder minimal unless necessary.

> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc..f7290fa439d6 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -497,6 +497,129 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned per `align_mask`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
> +    /// the bitmap exists or the `align_mask` is invalid.
> +    ///
> +    /// `align_mask` should be `0` (no alignment) or one less than a power of two, in which case the
> +    /// returned index is a multiple of that power of two.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds or
> +    /// `align_mask` is not `0` or `2^k - 1`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::BitmapVec;
> +    ///
> +    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +    ///
> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, 0));
> +    /// b.set_area(0, 5);
> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, 0));
> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, 7));
> +    /// assert_eq!(None, b.next_zero_area(0, 65, 0));
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align_mask: usize) -> Option<usize> {
> +        bitmap_assert!(
> +            start < self.len(),
> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );
> +
> +        let valid_align_mask = align_mask
> +            .checked_add(1)
> +            .is_some_and(|p| p.is_power_of_two());
> +
> +        bitmap_assert!(
> +            valid_align_mask,
> +            "`align_mask` must be 0 or `2^k - 1`, was {}",
> +            align_mask
> +        );
> +
> +        if !valid_align_mask {
> +            return None;
> +        }

This quite a trivial check takes about a half of the function in terms
of LOCs. Is there any way to compact it?

> +        let nr = u32::try_from(nbits).ok()?;
> +
> +        // SAFETY: `bitmap_find_next_zero_area` is safe to use with an out of bounds `start` value,
> +        // never reads beyond `self.len()` bits, and returns a value `>= self.len()` when no area is
> +        // found.
> +        let index = unsafe {
> +            bindings::bitmap_find_next_zero_area(
> +                self.as_ptr().cast_mut(),
> +                self.len(),
> +                start,
> +                nr,
> +                align_mask,
> +            )
> +        };
> +
> +        // In case of overflow, we may get back a range outside of what we requested.
> +        let end = index.checked_add(nbits)?;
> +        if index < start || index >= self.len() || end > self.len() {
> +            None
> +        } else {
> +            Some(index)
> +        }
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
> +    pub fn set_area(&mut self, start: usize, nbits: usize) {

Please don't invent new names. If this particular function in C is
named "bitmap_set()", it means that in rust world it should be
reflected with a method ".set()".

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
> +        unsafe { bindings::bitmap_set(self.as_mut_ptr(), start as u32, nbits as u32) };
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
> +    pub fn clear_area(&mut self, start: usize, nbits: usize) {

Same here: .clear(), please

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
> +        unsafe { bindings::bitmap_clear(self.as_mut_ptr(), start as u32, nbits as u32) };
> +    }
>  }
>  
>  #[cfg(CONFIG_RUST_BITMAP_KUNIT_TEST)]
> @@ -614,4 +737,100 @@ fn bitmap_copy_and_extend() -> Result<(), AllocError> {
>          assert_eq!(Some(17), long_bitmap.last_bit());
>          Ok(())
>      }
> +
> +    #[test]
> +    fn bitmap_area_set_clear_find() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(128, GFP_KERNEL)?;
> +
> +        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
> +        b.set_area(0, 5); // Now contains {[0, 5)}.
> +
> +        assert_eq!(Some(0), b.next_bit(0));
> +        assert_eq!(Some(4), b.next_bit(4));
> +        assert_eq!(Some(5), b.next_zero_bit(0));
> +        assert_eq!(Some(5), b.next_zero_area(0, 5, 0));
> +        assert_eq!(Some(8), b.next_zero_area(0, 5, 7));
> +
> +        b.set_area(8, 8); // Now contains {[0, 5), [8, 16)}.
> +        assert_eq!(Some(16), b.next_zero_area(0, 4, 15));
> +        assert_eq!(Some(16), b.next_zero_area(0, 4, 0));
> +
> +        b.clear_area(0, 5); // Now contains {[8, 16)}.
> +        assert_eq!(Some(0), b.next_zero_area(0, 5, 0));
> +        assert_eq!(Some(8), b.next_bit(0));
> +        assert_eq!(Some(15), b.last_bit());
> +
> +        b.clear_area(16, 0); // Zero-length in-bounds clears are no-ops.
> +        assert_eq!(Some(8), b.next_bit(0));
> +        assert_eq!(Some(15), b.last_bit());
> +
> +        // A zero-length request returns the first aligned position at or
> +        // after the next zero bit, even if that position's own bit is set.
> +        assert_eq!(Some(1), b.next_zero_area(1, 0, 0));
> +        assert_eq!(Some(8), b.next_zero_area(1, 0, 7));
> +
> +        b.set_area(60, 10); // Now contains {[8, 16), [60, 70)}.
> +        assert_eq!(Some(60), b.next_bit(16));
> +        assert_eq!(Some(69), b.last_bit());
> +        assert_eq!(Some(16), b.next_zero_area(9, 40, 0));
> +        assert_eq!(Some(70), b.next_zero_area(0, 45, 0));
> +
> +        b.clear_area(62, 6); // Now contains {[8, 16), [60, 62), [68, 70)}.
> +        assert_eq!(Some(62), b.next_zero_area(60, 6, 0));
> +        assert_eq!(Some(61), b.next_bit(61));
> +        assert_eq!(Some(69), b.last_bit());
> +
> +        b.set_area(64, 0); // Zero-length in-bounds sets are no-ops.
> +        assert_eq!(Some(62), b.next_zero_bit(62));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    fn bitmap_area_exhaustion() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        assert_eq!(None, b.next_zero_area(0, 65, 0));
> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
> +        assert_eq!(None, b.next_zero_area(1, usize::MAX, 0));
> +
> +        b.set_bit(0); // Now contains {[0, 1)}.
> +        assert_eq!(None, b.next_zero_area(0, usize::MAX, 0));
> +
> +        b.set_area(0, 61); // Now contains {[0, 61)}.
> +        assert_eq!(None, b.next_zero_area(0, 4, 0));
> +        assert_eq!(Some(61), b.next_zero_area(0, 3, 0));
> +        assert_eq!(None, b.next_zero_area(0, 1, 63));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +    fn bitmap_area_invalid_align() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +        b.set_bit(0);
> +
> +        assert_eq!(Some(1), b.next_zero_bit(1));
> +        // If this isn't rejected, it would cause a hang in the C code.
> +        assert_eq!(None, b.next_zero_area(1, 1, usize::MAX));
> +        // Reject non `2^k - 1` alignment masks.
> +        assert_eq!(None, b.next_zero_area(1, 1, 2));
> +        assert_eq!(None, b.next_zero_area(1, 1, 5));
> +        Ok(())
> +    }
> +
> +    #[test]
> +    #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +    fn owned_bitmap_area_out_of_bounds() -> Result<(), AllocError> {
> +        let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +
> +        // Should be ignored since out of bounds.
> +        b.set_area(64, 4);
> +        b.set_area(62, 8);
> +        b.set_area(usize::MAX, 0);
> +        b.clear_area(usize::MAX, 0);
> +        b.clear_area(2048, 8);
> +        assert_eq!(None, b.next_bit(0));
> +        assert_eq!(None, b.next_zero_area(64, 1, 0));
> +        Ok(())
> +    }
>  }
> 
> -- 
> 2.54.0
