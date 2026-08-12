Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741A8C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA71910F144;
	Wed, 12 Aug 2026 21:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cjkb3u+P";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DA810F0F4
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 21:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3EiFDTzqEIKksBZsTSuYHj8QUMM9sqqWmet0kENXEw2GNeUdzFhK7x/5yJH/K0LmVXz1pRl/Mr6XPfmJAn0U7Qs7ZmeZWnyztcdIsgHXnxF6HsijrumjUw1YN5X8YJ8OB/B7tr7V5QPEHNyclf/kFHtYRGBacN998DFD8pyvwp95pJ9PmC8NKiahBBFaKL4fFnN8L2sUb2bRCXwW1+d5lpaGtT5SgfxmUMukrUH8py6+Pqfsj8ePcq26n+h5pR8LJpptIQ3jJ1T5TSM98JXANB8EnMEoWUp2EXWaSf7jANxCc2KIR5GSntLeG+m2v4GBwiLGWLTHVwur5+5wPuXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2COJDpD1dWexnUsu9rdOtfUSlaTsktewIZCZVy7PtcM=;
 b=Tu92z6R86HK4oXLV5YLBSLSAASdQAl//8aqhIO6Q2dhQiH9ChwcIOIvpSlqmsMO4Iqh5dKHSliRkY0WPIJR3iPLAHb2nP2XWxKKF3GUmt61o1aIKM19xEE3+zfGCAaaHrkZql+QDj8Hd6muXrKMieVJwmGG3hQd7AijjXND8N0ENCw03aFyny3EXcRuw1yMY5YDTXMZYKFa7m6iWFxKXCrDmbKPH9wQvlJR50UQ9dRrrOtj5k6IdUnnn0hRkNoB8FN5MiK2eYnmL07D/pOGm3yWeQ5yavM00y9T1GAsu64RU5FF+tHAzlOfMsafSIjSlYl4Bwm+2ajEK9Qg5SQwVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2COJDpD1dWexnUsu9rdOtfUSlaTsktewIZCZVy7PtcM=;
 b=Cjkb3u+PDYWPydh/sm70beG0fFl9YTpYyKiCQqF53okZxknm7Tp0rg2G8iEtj3/jGxNPMTeoXrbjj9mKUkkKOzVL58b9fHP4QvtdVtJaV5c2Bcqmq0vrRVaVm5WtgDUL924GocD0mO/lsvD8ozi8UFK+dsdxfNRIAaBvnL0RpQpC5A4aOziOuymhgfYyYD5H+3hgm0+lnCWAf3rpRsKNt2Qs9hUd40/Ug6Rckd4/QuZxnw7SE26kEUkYvID81EkJOWgnY2QPKwLVXasiLMugw8N7Dz8ddexOvfb7uBgBtz4iLkhK7+C+Q7B/nPSmfYZ6esCOZb8Eb+5n8hJ42PwgYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 21:16:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 21:16:39 +0000
Date: Wed, 12 Aug 2026 17:16:36 -0400
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
Subject: Re: [PATCH v5 4/5] rust: id_pool: add contiguous area allocation
Message-ID: <anzitCSFv28wKWeX@yury>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-4-6c767770b3f4@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-chid-v5-4-6c767770b3f4@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b529abe-54e3-4ffd-be0f-08def8b6ffa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YmfUdUmrU7kDa9unKqIBV/7pd0hEdaRkSiPk+irFt3g+BshZuQYDQ41KLFttfpqW3U85btBI4Oa2v8hn252gXb4bZNpYKcHK3Yks2n8AtsYSfct9/tBiG7BmDcMXGXJYs+iEzlHh/aSTidtKp9CAnGrFLQslOFZv46+d2AP0jpqVzPTvwCK8IWIM1y0soa1AP4UewLdcGed4UeL+9i28jQ2aS/q0o1Z2QwANAmYdtoG6LnJW7/7/Ksd3nFMPE9qKvv5+c0xsl1dRX0KNwO57yMb6w5TSPpa7Kewok94XvRIzld/VvON84d3eUamUmssobZkl68fiqSbjxTjvaQ0lfEpKXGAA5jHJJiPYcDhfihgoHHUsMGSVq9Mqky/JY5aL4v4OHB2WpSNiyJPJUUSRtk7Co2B/TO6bdhPZhTzOSk5Sm4Uk5cqi6Le/VHVJib6QUy6x4S/Q0KHc/iY2cdqvKJBONbMk4KulTnib47m+hH5vvdv/T1IpMoqWAmcxXuW8hk3YWIcWQH/L1BcDUsPArV+PyXaSdbWRmg5b/QuaYT0HLgk3pB88FVAtk2p6fkjXITIOkS7FkXk+7KfFoRvw5Hr5UmuzIHMDb59kXbXGTqFAEvVFkT6CxsGtzZKwX/vo9cuQYgm5S9nOnucAnb0QdZR8C5jh5evjayI062/fEC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mKNFitCWSaUWU20Z1PSPCXP0kYmJu1EYlREIiEK2X58r7JP6rtirjzBbdtM?=
 =?us-ascii?Q?RdNJQC4fku/npYp+T3i6YPrtEkpqfCX1suw1OYIXPfa7/djsCpr7HJqknacs?=
 =?us-ascii?Q?lp4YlLC3YaoNRwov8wJyuaN1y5aPjCwY0dCfeSa7DwtsrsziI+B/yS2WtG2V?=
 =?us-ascii?Q?vWNKMa0XHojuxysjS6EUTQrHpLwABLHJkx759pb2/sZ4nGJe6mHL9NALctwz?=
 =?us-ascii?Q?M3x27uk8K1LjQ/dXUazwczJ4GKy6lzT0ixdBs06Hafk6dZLjkY5IvbtKf97Q?=
 =?us-ascii?Q?dgw9Qs0sbH/BM4cI3Hjqk1WelX/d3eKKTSkHF54EEZvfFAs+HxeHItK4IgCe?=
 =?us-ascii?Q?0c/kgzqWYIgV3Ms7Q5AfT45z0BVhPG8E0W/HYA/kK5r1qz7Ym8KTe6kq0lLZ?=
 =?us-ascii?Q?nFtsgp8hP4bol6OF0kpiEpKoEvAgppoudrqXPmFpIDtCOs2ncDZuPuwXhMrZ?=
 =?us-ascii?Q?TShwcb+0Hmqaay2KuvEHrQgoAJxE13GMJzutYXmR5bQ16LIj/SpHAJJYoR0a?=
 =?us-ascii?Q?waFI2jAGv//lkNcaw43Nkwaz5CYLHk7WTTyBOld4u9j4FUJWkbGd8th79sdH?=
 =?us-ascii?Q?K0HcdKaM+QI5ezbPj+R3K+7lyP28Amh/6IrotBTtDQGZJbDO41hEUzcysSc4?=
 =?us-ascii?Q?yDM6Bx8M9ED/Go5Vt83N72deZjhgR0MrJAM8wGUb7e+XzpvxZIYI7R8P4hw6?=
 =?us-ascii?Q?0PUo7Zi7M+dVcu/cFxjYv4eVskbdMtj9+8u7L0BxQ8nGRyvE2w2B/WLiM1Nt?=
 =?us-ascii?Q?u9DmGEaMHBDUrJAYNglqae7dknDnmTkiVuA6Pvh4SZMcYUd6py3VvOWwp5CM?=
 =?us-ascii?Q?gCTbS3prxSsCB+FpWkOAX91Y20Phpw3QDyGgKL8cNW7CgvjPd2P4nKD0z0Hz?=
 =?us-ascii?Q?8yYLuJ4C/juj8P1E7mJWLoaj000bsPMhnjefdiyq6W84/XupTIYF/R4OtV9a?=
 =?us-ascii?Q?84UKFh0NyrXgIQciXuxQVS8pYsoGz8+6UbIMOVxzPlB4JBZNaC6+V8S0I+DX?=
 =?us-ascii?Q?NH0RSxmfDfBjH3OUwDHH4/g9Ps06Josi1SE8NaCUIl/2Ga08LJ7XVb30uoWZ?=
 =?us-ascii?Q?rxzkdVkR80uxNHSE9TJ/po/WnZo4pZJEh/Fbc6i6hf5kS/L21f7b/t4SXd4I?=
 =?us-ascii?Q?VDByamD3bsuLfktEAHSPL3lTrHZOhMK211CmYqTiAycs0YLdie92sBrk+W17?=
 =?us-ascii?Q?SIRCDhqDTOtuPolLd1Jp05yv3kV8ROqt6fpMOqoXxdHgUu3z/XRO0T3p7fED?=
 =?us-ascii?Q?dYK3otOMDGjwJDGMz5SNPmbyydj5E3SsKOgtLm95N0Sjfwg6MK32InSyX5lU?=
 =?us-ascii?Q?WzSrKksPFlC5C6rFE2QMtl1SCuA34xZt61+Z72GS6QsuQMs+84fixu4ghuqs?=
 =?us-ascii?Q?pPpP2i3ruInkxHdt9FA/6Ur1jxEZlthQzNho2RgqQeFg2R9FvWtWur0ncRG5?=
 =?us-ascii?Q?dyPWJ+sYFx68YBup4BrwnDhEJ5ft0ErkAGl6MqCDTA+oFuCt9KBvvg7xdI7M?=
 =?us-ascii?Q?3MU5UvH4YtaFz5VS/Nk0zD3oNMc9n6gv4slarWp/Dlrt96jQU6un8kdoDDZy?=
 =?us-ascii?Q?tx8OwKpNU0QJWvR9Xq7nIYJJICwNesAS2k9xg1UNB6+hmEMS4sY6unQ+Zs66?=
 =?us-ascii?Q?ySZPVtgN8jddDFe97w1gBDWQg8KQVogeYMG5Ey4gYhRu13izdtMuw+6DgeYs?=
 =?us-ascii?Q?vj51XFIloKJlTHuPLvLeYfB6SLBmVNg09OxXo67jTNyfSXgwAWBSbe3YCnU/?=
 =?us-ascii?Q?pN+NHoTVwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b529abe-54e3-4ffd-be0f-08def8b6ffa1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:16:39.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: is9VGgWJ1uxr2d3VM8IGOdJJ6zlyho4obsvdACTwFshaXQKCzI8k8U0VfJKmU/yUot5TOnGwX6howfSfMEPf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
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

On Wed, Aug 12, 2026 at 05:51:24PM +0900, Eliot Courtney wrote:
> Add support for contiguous area allocation. Add a new type,
> `UnusedArea`, following the same pattern as `UnusedId`.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 384753fe0e44..eb911a0e3217 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -4,8 +4,14 @@
>  
>  //! Rust API for an ID pool backed by a [`BitmapVec`].
>  
> +use core::{
> +    num::NonZero,
> +    ops::Range, //
> +};
> +
>  use crate::alloc::{AllocError, Flags};
>  use crate::bitmap::BitmapVec;
> +use crate::ptr::Alignment;
>  
>  /// Represents a dynamic ID pool backed by a [`BitmapVec`].
>  ///
> @@ -240,6 +246,33 @@ pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
>      pub fn release_id(&mut self, id: usize) {
>          self.map.clear_bit(id);
>      }
> +
> +    /// Finds a contiguous area of `count` unused IDs at or after `offset`.
> +    ///
> +    /// The start of the returned area is a multiple of `align`.
> +    ///
> +    /// Returns an [`UnusedArea`] upon success, or [`None`] if no such area could be found.
> +    #[inline]
> +    #[must_use]
> +    pub fn find_unused_area(
> +        &mut self,
> +        offset: usize,
> +        count: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Option<UnusedArea<'_>> {
> +        let start = self.map.next_zero_area(offset, count.get(), align)?;
> +        // INVARIANT: `next_zero_area()` returns None or a start with `start + count <= map.len()`.
> +        Some(UnusedArea {
> +            range: start..start + count.get(),
> +            pool: self,
> +        })
> +    }
> +
> +    /// Releases a contiguous area of IDs.
> +    #[inline]
> +    pub fn release_area(&mut self, range: &Range<usize>) {
> +        self.map.clear(range.start, range.len());
> +    }
>  }
>  
>  /// Represents an unused id in an [`IdPool`].
> @@ -287,6 +320,42 @@ pub fn acquire(self) -> usize {
>      }
>  }
>  
> +/// Represents an unused, contiguous area of IDs in an [`IdPool`].
> +///
> +/// # Invariants
> +///
> +/// `range.start <= range.end <= pool.map.len()`.
> +#[must_use = "the ID range is not reserved unless acquired"]
> +pub struct UnusedArea<'pool> {
> +    range: Range<usize>,
> +    pool: &'pool mut IdPool,
> +}

So, the compilation message refers the "ID range", not the UnusedArea.
To me, this 'unused' language is confusing. What should I do with the
area that I just allocated? Drop the 'unused' one and create the 'used'?

Can you rename it to id_range please? Then the API would look more
consistent, at least to me.

> +
> +impl<'pool> UnusedArea<'pool> {
> +    /// Returns the unused ID range.
> +    ///
> +    /// Be aware that the area has not yet been acquired in the pool. The
> +    /// [`acquire`] method must be called to prevent others from taking it.
> +    ///
> +    /// [`acquire`]: UnusedArea::acquire()

So maybe implement the find_acquire() method? In the caller you
serialize it with:

        let mut ids = self.inner.lock();

Is it possible to pass this down to the suggested find_acquire()? In
my experience, having non-atomic sequence of find + acquire that
requires the external locking is the recipe for troubles.

> +    #[inline]
> +    #[must_use]
> +    pub fn range(&self) -> Range<usize> {
> +        self.range.clone()
> +    }
> +
> +    /// Acquires the area.
> +    ///
> +    /// Returns the now-reserved ID range.
> +    #[inline]
> +    pub fn acquire(self) -> Range<usize> {
> +        let Self { range, pool } = self;
> +        // By the type invariants, the range is within bounds.
> +        pool.map.set(range.start, range.end - range.start);
> +        range

From hierarchy perspective, the UnusedArea wraps the Range, and
passing the Range to the higher layer breaks the hierarchy. If you
follow my suggestion, the hierarchy will be enforced stricter:

        ChannelIdRange -> IdRange-> Range

instead of  

        ChannelIdArea -> UnusedArea-> Range
                      |
                      -> Range

Or I misunderstand the concept of the UnusedArea?

> +    }
> +}
> +
>  impl Default for IdPool {
>      #[inline]
>      fn default() -> Self {
> 
> -- 
> 2.55.0
