Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0063BC55196
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB8D10E0A2;
	Mon,  3 Aug 2026 21:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jHan3ItB";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626B110E0A2;
 Mon,  3 Aug 2026 21:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHvnM9xkerhoJhyZgq2D/ZmLDljufz+9MpuKUV80bVDEsQ8zzT0IkO0MI9CsV//kzHQVqDISSiDAsixD8aQ8RrrnBVsFaHVXCUUIre5529f7TLxnjkuEyrEpGCv3URrS0Bs/gYhJkJIf8SrsTDy5eFz9XrLK0ibgnlMCR8WeW2gLe6btKIMNi2g7xae5Ec00NuTomgA5FzdvU3TyLEF6aXDdG2ajqBKBtfOozzMZEqOmS+rX0uFla55OzNEjV1Ti/2pG2m6vIwC3ZUAxDR10UvkI4HIpgVSx1FMmLOjt70874mjEp9C4w20sHSNSkYn9Ksd7qR9jUdqmyla8Rnt4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpxBfXVqE3qX7O7/VSNKVq6cHRNLxXipSmSFenYzVGs=;
 b=FBQpGa8jNu6B2CFCArjNlcbWd8vTqpEWnKpVf3ADd75qEiF65EsjfwWSpGfoFhuzlJvdk4Z3i9JtR/hqlgVjU5EHHVSRwsJX683lPfOhvR93Ru+xOmTOVQGXHoBB+7XKxrMo8yTLUWGEZ4GHTjHacFn1QSqSByqmlH/jFpkoz5VJ2LMbjBpmtD8K6HymG4PJ5+0T5PZ+3r2lolueNB1LwFO4yVT5nMlq5vwiTpbw0JpV3JKNIkLURijHS9C7AmBK71UayfnhVTluajiWkfBewcuWFKHBSv/xzq2/BwTpoatnC4rpwJsWJAGpI36RcYSEOL0sMJYpo+Yz9/dPIEP0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpxBfXVqE3qX7O7/VSNKVq6cHRNLxXipSmSFenYzVGs=;
 b=jHan3ItBJbls6T9WSUxC+JU73PtuDE3JlG1Bl5/RjcpAEHj7KEHuITEJV5WY4RntrwT2qBkqphbFIMSNfRZ6spQe66kGahFZWS/fpwqFY8eep8Z4RCgohgc+jpKhnOjcQfS4HP7AMqPcgZIVi65PjtJe7MT+0jRdJxO7Uyh6CqP83JXMs4nzb5Zz/VCfaINZOr/8Y3cFHq0y3ZK9LpqdNG/iFfGL9yvInrs5gxJVsCfcqBJt5aTwJdEN4GzDrkFpEs3wrqSIeYAdk+AZRDGCnOCpFuo/Et8xRRmfrRB77CSvGmBRTQPkbcRC8kA1V1JcNgQO5h/+1fDDKpZ6mjIewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 21:44:51 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 21:44:51 +0000
Date: Mon, 3 Aug 2026 17:44:46 -0400
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
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/4] rust: bitmap: add contiguous area operations
Message-ID: <anELwosZSI5MZR4d@yury>
References: <20260729-chid-v3-0-20cc08032bbc@nvidia.com>
 <20260729-chid-v3-2-20cc08032bbc@nvidia.com>
 <amrZcX33BGJCTDMp@yury> <DKFBEPDNAD1V.1LFARFHMO5WKC@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKFBEPDNAD1V.1LFARFHMO5WKC@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: bed2133e-7367-40bb-b91a-08def1a87261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: D+KJ1nRRP/1SeqBr2hkde6W9A1XYdn+Flk5O9sanGgXCgGmrstnUU+pcufEXlIbA35dskRATvp9k+1pTCE9wYy12lP0rhFM85GUKwo+GVedRR8hrzYhrMlmnBnVVCK/5v4GWY4kwVH7B75r6MpMGfz1uCNg2OjdYn9mWZqKw1DQr0ETfi9OiXvnrGiH9b2SYs+7F0sRpen/KWo02JMsyz5z6asd92UNQNpxc08i7zFyD5WJZB64hDDZbOnTuewtFWEQS7ITYcxaHrOiBnyQzOKHlhYvgS9mjg+K+Z6iZP4u4+xpPiDlhKooq+tttrEgevqla1DjC6HfLGuKnT9XNE7bhN2Gxk22qokkR386TbJbLbfqFbXBe2X2o1ZZuQba7H60KpdzB3RDb5I7OFnEVXAczNfsQle8itIkDGrs/P43qnt3UFkHBpZrJXrt60aw0KypmEE/lKSw2FzdIxi8ipjcYKM8m14fIua9Mnh2H92wE5OYOYGWQYkrq582lfLXeWKE+c1TsSFr1TzU/ltetDMasxWi47jWfVtCqb+9eywDmjprJwVBQoLiwwxAAnCmFrMZd6HX+qrjK5vg732MBffB82EANVpxLXekfz/OVuuFXVwAWMCFjXeALHnB721JCcj1aMBng3vojxj2YUW6dxmZjYlXbkLpUIbPSMDwReg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PrvPkyeC8gQSc+koyCYfcw8OeW4zi+gqE0f3qluQ2N/S0AqIdAXzqXGc88C?=
 =?us-ascii?Q?B+qUfSqi/QOSdlpcRI/EZ3PsJO7wIiJEldPLyC9kSJfDYLp/K9VZEaMqXAr7?=
 =?us-ascii?Q?IJ2uDSoLwYEjgnxXrqikkOXnJ0992BaVFyL0759d6n1SQX5FrOH4h5qjHdkP?=
 =?us-ascii?Q?uASH8z/w8/6TrGuyaWi5wTOcCRV37w6cT222T0MkWxSeqz4NpsgYdQJhXCH8?=
 =?us-ascii?Q?U411pFibM9mkvvJZoIAPYBGiJv60ttdsWzxsVGeL0ATCMbpGVOO+zTrJOn6z?=
 =?us-ascii?Q?BcVUbFa3X5NlN6I7D3f/RLBlnvgH3aYci6mTpAON7QwaLUHjLWPPJhUaTm/g?=
 =?us-ascii?Q?g0S0cgRW+andGsLVS3MpGnFi8hqhGYj8GwidmLRBtrAqt3INfQPooYD5BVLP?=
 =?us-ascii?Q?mjALeAKPiUGP/M6od+eO0FyWOLTMkYJK6gNzwCK8EcKtBqR7IUZFWOZYJzfP?=
 =?us-ascii?Q?3Sh0fQLr6iXkdWF5/31SsnQiMy8CoN33XdmQz9Uiq0Zw6+hO9r4ViR8iUMnL?=
 =?us-ascii?Q?ekrj18SvMnPiGOEIc+tj/P/vtIyCC39Gkh1ZDAMg0QYsUjPOT0ZGk70dhO8r?=
 =?us-ascii?Q?tcvBxzwHq2ENC3cB1DpCV03nYJP8avhOoeP0ojOkxWSpY5hwz6NPGvPXdzHK?=
 =?us-ascii?Q?Om+EcEgxh/CdUfeI+0U8oW4v/YXaQRw9VTRS0NeXoyAfbMa3KawK7nkiKW3j?=
 =?us-ascii?Q?2D+0LeIcVj+c/DJU1MZjL8LKChRNsORegTngwHJQ+3oHB2dnaXIALTwTa0UM?=
 =?us-ascii?Q?CglwCOctl8RER5fj2fjv0KSV0XGag7fG7CQGRlYjQhYxoSKOVpsy6a28r5uU?=
 =?us-ascii?Q?qhcttTRmColuq8dKJ656+o6TTxZUGw3YMnIbcmYgQlPQKnLRlZV8r/P+qMz+?=
 =?us-ascii?Q?sXVr41MIoEikG4FmGUwfDeB4/o+Tb3z7woOl5fAntviCnR/9rv6BSdWXK9nu?=
 =?us-ascii?Q?S0RhXx6P3+TM7euo8dqV4EyEOiZ8aqcdH7PIpWaHAIz/iE07nT+pni184vrP?=
 =?us-ascii?Q?HXVACjPhhv2LaNF5cPULA1BegQgEiGg/zI9+CWnMozZv35/DGyb/MP/z+OLD?=
 =?us-ascii?Q?WoFTPcWd6uvJOEwIqUdenRK5tDmSVsDTsPVEy/43FyYDALs79Jlm7ts7Z8Rs?=
 =?us-ascii?Q?YkFGnkDS0IKRL9dR5jEDfmHNozX4y2kTRHQK2Gw42BL8U6A0JRfNbndh3+sT?=
 =?us-ascii?Q?IXcTjI73AM1S5TroHYnDnFC0wdUEcaMq8S37XDxlhPifSCajaMgiCNcYqnfx?=
 =?us-ascii?Q?AZGEBIFMc1osC67zFS4eXtHOWblvtYQgdkVc1JC3Nw83wH6IFpQqV2gD/mxO?=
 =?us-ascii?Q?D5IXe0rHtO7zUHi8w2Azk2Xvi4uKWL78a1V5x9o62aVudsd2LyJY2ag7mod4?=
 =?us-ascii?Q?dZ2sPIk99q+w6lGE5WHK5uNQJu6K4v29GjoogevC9VK0KHJjdh6ZbV2menwX?=
 =?us-ascii?Q?1OnKXJHM6Ib3v2psiIE4EgD4u+oZYH5q7jfRmW0xZbe+Na6z5/VsV4lFZlzf?=
 =?us-ascii?Q?jb0n/BN4ooCAKZbqxeSqJI1wYa7HR/FMYT1x7/6xLrOY80Nq/m2GELo3n5rI?=
 =?us-ascii?Q?PFy43698SH9s6jnd57fq2QclzIChefMVdIaWRES9yMwTSnr5Sk+kQi0bvF01?=
 =?us-ascii?Q?84V82iZDx95Ohh4BV97D9+NuTnRhkeVqgiyCauCm8UgdXu2QAm4wTQ6GcEIb?=
 =?us-ascii?Q?7LjiaVvpfcmxBBlQdXFK3DPHCJB23584MH9G/b0snFjrnHwQoGO+uXCfDTcn?=
 =?us-ascii?Q?YD/9NZvSog=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed2133e-7367-40bb-b91a-08def1a87261
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:44:51.0981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjCRJZrV1TOuvguS/C0DBUpbvhPgebtE2EmwlWu32E5tUzlAQsCjGM2ygcf9p1Jma0uG9TOufEFTp1UeZsAJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
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

On Mon, Aug 03, 2026 at 09:41:42PM +0900, Eliot Courtney wrote:
> On Thu Jul 30, 2026 at 1:56 PM JST, Yury Norov wrote:
> > On Wed, Jul 29, 2026 at 03:54:13PM +0900, Eliot Courtney wrote:
> >> Add bindings for area operations on bitmaps. Each one is
> >> made safe by adding some extra checks compared to the underlying C code
> >> (for example, checking bounds) and with additional checks to catch
> >> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> >> 
> >> The C code uses signed integers for some parameters, for example the
> >> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
> >> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
> >> backed by `BitmapVec`.
> >> 
> >> Add tests demonstrating the edge cases.
> >> 
> >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >> ---
> >>  rust/kernel/bitmap.rs | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 194 insertions(+)
> >> 
> >> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> >> index a43bfe0ec3dc..f4b0b8ae39d8 100644
> >> --- a/rust/kernel/bitmap.rs
> >> +++ b/rust/kernel/bitmap.rs
> >> @@ -10,6 +10,7 @@
> >>  use crate::bindings;
> >>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> >>  use crate::pr_err;
> >> +use crate::ptr::Alignment;
> >>  use core::ptr::NonNull;
> >>  
> >>  /// Represents a C bitmap. Wraps underlying C bitmap API.
> >
> > Some comments use indicative form in the file, but the imperative
> > 'represent' is a more standard way. Can you please use it instead?
> 
> I think in rust, indicative is the standard even in the kernel - e.g.
> see Documentation/rust/coding-guidelines.rst around line 208-ish, and
> that's also what I see generally in code. But please let me know if
> you'd like me to use it in this file regardless.

The documentation you've mentioned doesn't say: use indicative. This
is just a one example.
 
This is what my AI machine says:

  Among the 1,266 verb-led function comments, that is:

  - 67.1% indicative
  - 32.9% imperative

So, unless there's a strong (and not aligning with the rest of the
kernel) rule, please use imperative form in bitmaps.

...

> >> +        bitmap_assert!(
> >> +            start < self.len(),
> >> +            "`start` must be < {}, was {}",
> >> +            self.len(),
> >> +            start
> >> +        );
> >> +
> >> +        let nr = u32::try_from(nbits).ok()?;
> >> +
> >> +        // SAFETY: `bitmap_find_next_zero_area_off` is safe to use with an out of bounds `start`
> >> +        // value and never reads beyond `self.len()` bits.
> >> +        let index = unsafe {
> >> +            bindings::bitmap_find_next_zero_area_off(
> >> +                self.as_ptr().cast_mut(),
> >> +                self.len(),
> >> +                start,
> >> +                nr,
> >> +                align.as_usize() - 1,
> >> +                0,
> >> +            )
> >> +        };
> >> +
> >> +        // In case of overflow, we may get back a range outside of what we requested.
> >
> > No, we can't. We've got the test_bitmap_find_next_zero_area_off() for
> > it (in next). If you think the test is incomplete, please extend it.
> >
> > If you believe that bitmap_find_next_zero_area_off() may return something
> > like that, it means the function is buggy, and you shouldn't trust it at
> > all.
> 
> TL;DR: Included some tests below that demonstrate overflow/OOB issues on
> 32-bit (with increased vmalloc) in some extreme cases. To keep the rust
> code completely safe we need to check for these, or update the C code,
> but not sure if the perf tradeoff is worth it. Please let me know.
> 
> Ok it seems I was looking at the code previous to df81d444dc74 ("lib:
> bitmap: optimize bitmap_find_next_zero_area_off()"), but overflows can
> still cause wrong behaviour after this commit too:
> 
> [1] On 32-bit, suppose we have an empty bitmap with size==64, start==32,
> nr==2^32-1, and align_mask==0. Then, computing `end` overflows to 31.
> Computing `end - off` then underflows (31 - 32) which can cause OOB
> reads. So actually we need a check before calling
> `bitmap_find_next_zero_area_off` to avoid this case.
> 
> [2] On 32-bit, suppose we have a bitmap with size==2^31+2 and all bits
> set except the 0th and 2^31+1st bit, and start==1, nr==1,
> align_mask==2^31-1. We'll compute start==2^31+1+2^31-1 which overflows
> to 0. Then we'll end up returning 0 which is below start. So we need the
> `index < start` check.

Both examples overflow int32::MAX. It is not supported in rust.
See the BitmapVec code. Your case is just 2048 bits, so it's not
a limitation for you.

On the C side, there's a historical mess - some functions work with
unsigned longs, some with unsigned ints, and so on. I'm aware of it,
and there's a process of unification the API toward the unsigned
longs. That wouldn't help 32-bit architectures because they are all
ILP32, but there's no real use case for them that would overflow the
32 bit.
 
...

> >> +    /// Sets a contiguous area of `nbits` bits starting at `start`.
> >> +    ///
> >> +    /// If CONFIG_RUST_BITMAP_HARDENED is not enabled and the area `start..start + nbits` is out of
> >> +    /// bounds, does nothing.
> >> +    ///
> >> +    /// # Panics
> >> +    ///
> >> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and the area `start..start + nbits` is out
> >> +    /// of bounds.
> >> +    #[inline]
> >> +    pub fn set(&mut self, start: usize, nbits: usize) {
> >> +        bitmap_assert_return!(
> >> +            start
> >> +                .checked_add(nbits)
> >> +                .is_some_and(|end| end <= self.len() && end <= i32::MAX as usize),
> >> +            "Area `start..start + nbits` ({}..{}) must be within bounds {}",
> >> +            start,
> >> +            start.saturating_add(nbits),
> >> +            self.len()
> >> +        );
> >> +        // SAFETY: The area `start..start + nbits` is within bounds.
> >
> > Not sure I understand. In the above assertion block you check for it,
> > now you say it's always true...
> >
> > I think, your language should be similar to the
> > find_next_zero_area_off() case: it's safe to call the function with
> > the out-of-bounds start and nbits.
> 
> The assertion block still checks, even if CONFIG_RUST_BITMAP_HARDENED is
> off (just prints an error returns in this case), so at this point we
> know that the assert predicate is true. In this case, per the file
> convention we take start and nbits in usize, but the C function doesn't,
> so we need to make sure we don't truncate when converting to u32 and
> i32. Also, it's not safe to call __bitmap_set with start and nbits such
> that start+nbits is greater than self.len(), or we can write out of
> bounds, so we can't use the same language + we need the check.

OK, it's bitmap_assert_return, not bitmap_assert. Scratch that.

Thanks,
Yury
