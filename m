Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E625FCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA2E10E267;
	Thu, 15 Oct 2026 14:01:07 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E7910E267
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMlAC4d3t7b/xPpJYk6yvUz8YA5TH0W3217I0CGc0+TyGqS+J7Tpgm1X1kGTplGCcyMVfLMU+y3Z5BBRp86HXjKKhjgTlcEGm5VajeZ0F9MIZdrnhw7q5z5W10ol9pz6g6+vwxNXhwiAZ2N3nEE7LGQ95X0CNsU8EFFkmoVLrAU/Bjrl2Tcr0jQaaC7mW3h+g8JCL8I/4mR/Ws0copWd/B+NYef/zzlZeCBgEeYv0csHLzaYCL7aRTndRQl7AUs14UFzS+KiSbijYIQ2qVHnYaU9BODhAPhflh4gC4e/DL9mQBqNohMvw1i/g1U6T4aRU20UduPfoMBtp+S5RSwj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aMnWIXVFDYBz1u3BxRds3jCAGhwtv0BAJgMhwlGfso=;
 b=NbkJoErdkcYtSGtpq34ESGTG1q69wiMFMt9KYsJq9vGgVTMEIsWVYOXL/PnFc/lJVmfYYSbbzhEdUFnJxmn/EyjwBW0pmqcjVK+rBjeOIwGaTN3wkhWchiTWGL2IFbVdRLelAFico0G+gUhwOxXEjpTbksT77hAVA68CFOMA8uZrbfiOym9v7a0MVlvjM63I2VNzuX30Z8bLH9byqhvLDK94ZD4oR7gMyxrnGQYFpRjuiG5LAXsrsGl3CnzcjMvfIuHrZ3dlii9eYVeeXsnO39hHza2bxltBoeYaciWsWEzfzFvTQIrNsWacJQkLiXIkoUHxoRk3A5HKwbYdexQROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aMnWIXVFDYBz1u3BxRds3jCAGhwtv0BAJgMhwlGfso=;
 b=Sz3yAe9hyg9SY4rTV+WPMsZWehczHG1G1BuqkNwV/YT6gAn2IrXufR/t8+ujyJq8auJY5ewhfIIB+p8is+dCxww37kKP96BaZvcKghQp//bmtWgFOr1/kV9zYdgvZKy1v9yLwG/86qnQpxFBsvjcnVvDQ122Hk1x+jqchjKrOsTKv4dvTulIbyodOhOlhKFkUweN7lZoE9Bh7XPAaRTJFg/9mAmEJnCQxHibQ6/cKrXEvyrPV9fNwidArbVmpTLakgPW9eoC0P0DAPjHpU4vAeAdohuhHq5PKY2WOgHCPPMEnydx6JNvhmacZpeqfjeJ4hh0hFJZ2l3DnKCaGvBFJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 14:00:56 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0496.015; Thu, 15 Oct 2026
 14:00:55 +0000
Date: Thu, 15 Oct 2026 10:00:53 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Message-ID: <atDclcwHGykChUim@yury>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
 <aryYkkB9j14xnWo3@yury> <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com>
 <ase7IBtZjQsPVWSN@yury> <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a6dd0f-aff3-4523-f848-08df2ac4bb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|7416014|366016|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8qfUURNJd5Dq8BRtCWBRqf/kl7v+lKs0kSFdECMUu15whFtjuq4G2ET5/hsl81e22iSrqr/kaU+8JUdF69WUiMUj2pz4SBGZ9sfgB/+3OmTKzJfB4mHsUYdTTRoz5vuo3pQhsesTPjFbUyZCYTXT9fgtKvJ3L3lozq2PeQa8oQiudyBySoOq5jVf4YQRdMSww4MTPDjQkFwt0MrJDXWkpL4atI2yAl8+1qNiZCjPnlI/KQI24m36Z9/BRvURu2JyX4yvG27nUfV/tyfV2+ttCcYvuGKpMKeQtYJgakAGKeeSdUQFLtaSm/OHczIxllBhKfvj09GtMr16jlvBa9dCxNgEu1jI9K1O2Mc5hVMR4nI7f6UmGD7OypTKTTHTgzMU2WRjYjmZqorp30a2dcJsAlyWgRNDeLhS3qprQ4AJff+KI8epkeGKLI2c2fH/9U9z01fIBrYvwVJex+MhBNK5tl4N/Iy1Z+a1Eqc95EJeCQM5grPxt5l8iCH0hHCNu/7T7TmLPJ3OIIm0MlU8Kgsp6xfzWBaikzVNnjPVxyQVNixtl2Nfl0sehGMavP4OtEmpMRy3E2Rg55ft9P3/RxvcoBur1SgblsuESpsdVfE0uZw/kjBPFbxJkytl9V6jtxztDODMsi/AATn6VWhHyQMfXFmeNA7gbboI6mfB4WefXg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhcroKCIf0y79Rfa8WKd8Hnb5HMoNkErNtmZSOtC3Mc8aBEP4CJ6ApzMyCfh?=
 =?us-ascii?Q?jhayvJ8tYyDREA5O1zXROS+8cfMCrr/WAeVZihZ3L6B0GsH/vVJ5lxSoNbhX?=
 =?us-ascii?Q?xu1FZab0IF7FBazut1s1FUvYWyem0KdCxN5ZcYxJ/AY9Dm3MFIgJHduUm7GU?=
 =?us-ascii?Q?jn/tPqdoehAFPIBUHdYVcl0vIUogrXwZHaGefibFTnmDhHGQvVvP5uKH/U9i?=
 =?us-ascii?Q?TgD1gspcUis/hd39jdcjF1ZZ4fJOlDaE9ARhzpHgXkpAoWTLlMc2L4Z6zYDO?=
 =?us-ascii?Q?ld9nGJ+9tmWBeOuQQitBCN9NEypZluZn9XuiRtbs4pnoa9ZQweR5QzR0MDlj?=
 =?us-ascii?Q?PLhoMCdbIt2uTl/VusxKYZ6Da8TmlLNB/KYzgsT8iyx8tx33ph1sX+3atPaq?=
 =?us-ascii?Q?xHVq79zFVKRsAH14VnN4GhXyiYpwj0tQ5hpdqzoCi9XiYvdj0kYB4+e5fXf9?=
 =?us-ascii?Q?3imLRYtSDroNFZ8FG9uqdevPjWu9VCIK7jDIHk8AXc7yXijtksHTuJWFZZfk?=
 =?us-ascii?Q?e//COQUToImjswofIZoBYiLbs871AMb2JOBVveJImY4RXNbDnKwPa5wpbECe?=
 =?us-ascii?Q?XF4HyLEVhH7JqHPoXL1JYTiS9DbFXrF4xek9XL3JJkAZvG6a901ZS/YOxY7G?=
 =?us-ascii?Q?ZMjPMyFnIBmbEQOL3qQRweweYjeDuXEDG6LqgZPrk2s8WidMpjOCKvbRmBUd?=
 =?us-ascii?Q?t8eLRRpYjw/OayGdA0p/OgTlhYg9qo3i1CRs1yntQlhyxNiyhunRzFszDitG?=
 =?us-ascii?Q?eP4QJ/uYC+DprWdvY25//1AbjfNcRV6iEFUOlrquhy+w+UwDRXkcYST+KQe3?=
 =?us-ascii?Q?qUFhCSFER1VBw90NrOzwIYmEcQJN5aNsPb3Qq5p6DL/WtMk25I/H5cjItly5?=
 =?us-ascii?Q?boUbromFLwj/N0XgqIsDJj1g+rDzFHMTImgvLJgKcbbm0zFYJcbopHvBsG1U?=
 =?us-ascii?Q?7j2E9SrQLxhBhBceSxKq3YUQ7sLJaOiaF7DnF1sJDem7pI0kpkGcm+p96FG+?=
 =?us-ascii?Q?DXZl09muvr80OHdM2pD7nSgxSky+VpO59Poc0JYwE61CfBbkf5ji/YFc6xhL?=
 =?us-ascii?Q?ey51CxILNO1R/BGbAtL9hwE0V9PcJ7jJMrS3/CygyqnyKqSr2CWSGgK0HU/f?=
 =?us-ascii?Q?zrTqYxytRxG5Oc9yxMM//ddbwz3J4zcU9aE+VSj2iQ8k2jkGUMdWE4vnyD6Z?=
 =?us-ascii?Q?VP04GWjoFv4QFHnHZBPJ3qa0Rs6KG+7hA1shV6jdy2kw4Jy6W8YxFYxbpOy0?=
 =?us-ascii?Q?rBiVSt+SttkHIN7sgzH97U1MytVGO/bdpoacfKdPRqGL88X9+zyEloMI0Gu8?=
 =?us-ascii?Q?SXUH6ylTHoz/KArXauWo4/8jV8KfiiwSqWhrMaYXbaYb/r/Rnmp76hJJvFfV?=
 =?us-ascii?Q?82K1Ej9NKnbRodx+XqbqNUv9U1D9pC5DfKgooB0TfSLCFMEuj0NT2q5GdhQd?=
 =?us-ascii?Q?B9TqS3NQgMADc5GTVYNsqHwpg6I24iG2te6lgyyiPaI93gAHWNGD6kJvmCzc?=
 =?us-ascii?Q?iUrMqSUkVZDLtkTvkNBZZBS31v6M+Mzn8dc3mJo8huS4buIx02KMqlNELguw?=
 =?us-ascii?Q?iFEHJz+o0BX550alaRMzTEMUcrXoILjtAGdIoDRoWfmYvTpIGbBDg1uPSPvT?=
 =?us-ascii?Q?2qXFOJq11OVght2KXJS6QinDf5kFLruVVUPInP3Jr/pZxU/aymWViddMxCmm?=
 =?us-ascii?Q?TEKy9Qd/rmCk2+/DdTh2k71/dY+W6esCrQLjtGmkHVlkNSQrEsjQmUFEQEuO?=
 =?us-ascii?Q?wNsCvIxLauiNYGvnT80TttkuzVFPUjsvf+4itEIKcKNH+KCXwbSe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a6dd0f-aff3-4523-f848-08df2ac4bb5f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:00:55.7538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hr5bJ0JEKTNXcV/GcR0lXAFGQaciq+isH2cTOK/olaOW1nqu2Nw9dRfQHtomj4fJdIK57LFgVFXlTDEISp2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

On Fri, Oct 09, 2026 at 11:07:51PM +0900, Alexandre Courbot wrote:
> On Fri Oct 9, 2026 at 12:47 AM JST, Yury Norov wrote:
> > On Thu, Oct 01, 2026 at 03:20:40PM +0900, Alexandre Courbot wrote:
> >> On Wed Sep 30, 2026 at 2:05 PM JST, Yury Norov wrote:
> >
> > ...
> >
> >> > Allocating a pool with 0-bit capacity is wrong. Please don't put it
> >> > in the examples. I recall I pointed that this object would panic the
> >> > kernel if, for example, you call pool.next_zero_bit(0) immediately
> >> > after this. Sorry, but NAK.
> >> >
> >> > This .with_capacity() should take num_ids: NonZero, after all...
> >> 
> >> This panic is not specific to the size zero, any size triggers the same
> >> behavior when accessed out of bounds.
> >
> > In C, malloc(0) is implementation defined behavior, i.e. it can return
> > a pointer valid for free(), or NULL (which is also valid for free).
> >
> > This is a very old legacy coming from K&R implementation, then rejected
> > in C89, and later this all became an impl-def, mostly for compatibility
> > reasons. See 7.20.3 in
> >
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n937.pdf
> >
> > Rust adopted C bitmaps, thus creating 0-bit bitmap may go through, and
> > hit that questionable behavior. You add this example without any
> > discussion about all that possible complications, and with no
> > protection for users.
> >
> > Interestingly, you're doing it for the reason that has been considered
> > a bad practice for over 30 years ago - malloc(0) with the immediate
> > realloc(). See the above link for details.
> >
> > To me it looks like pulling legacy with a potential of undefined behavior
> > into Rust.
> >
> > Bitmaps is a way more simple case than the generic malloc(). There's the
> > only user of bitmaps - the Linux kernel, so we know exactly all users and
> > their user patterns. I'm not aware of any in-tree user allocating 0-length
> > bitmap for whatever reason, and such a coding style is highly unwelcome
> > nowadays (30+ years).
> >
> > When it comes to rust, things are even simpler. Rust has much stricter
> > memory policy - no undefined behavior, no implementation-defined behavior
> > is allowed, no 50-years old legacy has to be considered.
> >
> > Rust community decided to take the existing in-kernel implementation of
> > bitmaps written in C, for a reason. But with that it pulls all undefined
> > and poorly defined behavior associate to C language. We did quite well
> > spotting such places and fencing them with safety checks.
> >
> > The 0-length bitmaps is just another case that should be resolved.
> 
> As it turns out we would never perform a zero-sized malloc, even for a
> zero-sized bitmap. `IdPool` is backed by a `BitmapVec`, which up to
> `usize::BITS` uses an inline member as backing storage. So we would
> never call `bitmap_zalloc` with a value of 0, making the safety concern
> moot.
 
OK. Then please remove the 0-length alloc with the following re-alloc
example from the patch. use 1-bit allocation, as an extreme value, if
needed.

> > If you still think that you need 0-length bitmaps in Rust, can you please
> > give the clear and thorough explanation why rust needs those 0-length
> > bitmaps. Are there any in-kernel examples? Any language concepts requiring
> > it? If not, it's still a NAK.
> 
> I don't know of an in-kernel example, but please look at the
> `bitmap_vec_new` test which has been here since the API was initially
> merged last year: the first thing it does is create a zero-sized bitmap.
> 
> It is also easy to imagine a user starting with an empty pool and
> growing it on-demand. Having the ability to create a zero-sized pool is
> convenient to avoid special-casing user code, and in this case I'd say
> expected, just like you can create a zero-sized vector. Again a size of
> zero does not trigger anything that a larger capacity cannot trigger, so
> I don't see a reason to forbid it.
 
That's a weak argument. We can imagine pretty much everything, it
doesn't mean we should support every idea in the code.

Supporting 0-sized bitmaps would simply move maintenance burden from
end user of likely a poorly written logic to the core kernel
subsystem.

> >> A size of zero has nothing special
> >> in that respect, so why make an exception and forbid it? We had this
> >> discussion some time ago [1][2], and I'd recommend instead making e.g.
> >> `next_zero_bit` return `None` on out-of-bounds accesses, which is
> >> semantically correct.
> >
> > No. out-of-bound access should panic because every caller of bitmap
> > API knows the length of that bitmap.
> 
> Right now out-of-bound accesses are allowed if
> `CONFIG_RUST_BITMAP_HARDENED` is not set. The Kconfig documentation for
> that option even says "if unsure, say N", which suggests that not
> panicking (and thus the behavior I described above for `next_zero_bit`)
> is the default. If out-of-bound accesses should panic, then the Kconfig
> does not reflect that.

Whoa? The panic is under config because it has non-zero performance
impact. If it was completely free, it would be unconditional, like
some compile-time checks out there. The "N" suggestion is for admins
and users who build their own kernels. If you're a developer, and
actively use bitmaps in your rust driver, you'd say "YES PLEASE".

> > But if you make that 0-length bitmap a valid case, we need to revisit
> > every function and make sure it returns ENOENT or something instead of
> > panicking. That, again, must be very well explained and justified, and
> > all this has to be done before adding 0-length bitmap support in code
> > and examples.
> 
> With hardening off, every function already behaves in that way, and
> existing user code is already written to not trigger that condition
> anyway (because of the possibility of a panic), so that would be a
> pretty innocuous change.

The rule of thumb is to enable all the hardening you can during
development phase to ensure integrity, then disable it in production
build to maximize performance. For the matter of this discussion, we'd
consider the hardening enabled, of course.

Thanks,
Yury
