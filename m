Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C65C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FA610E72A;
	Mon, 29 Jun 2026 07:57:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI3TAtNV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DA210E72A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmbpljTb899UKdpv3S/68+NSWgI+/b4I+CBCKMnk/HqVlMydBrZuNm3465cunu6nSZjrJFyZ5q/y0cD0JLviLkA5O0hcbo55qsi6nbsS1A8Qw1BuOMgoXkflzBCPVYwBDTWOoGPLUl0q0pemDfX4eQUXuUFRSqOPeYM5tPu4toeNp8F/uzNxpO20KgVtSyStZD2pHJkbxpZohEFSXar8YDeV82x5BaigKc+R+d1GIsoEH6v3/4cIkpdM1KOtKbvUJfFtSezSSheuqPuNpKlYuGHibuLrhVU3e6VpSipOURQ6Y3l2mb7gARqqwIkCY4OK8svcw29TblY3wyInyxqnNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rbhlbMh3tqk8MI2bE5YdCKDbB+7Xazo18hOJLWrWyY=;
 b=O/f7axGZVC4uu2CKJ0cenv1/+N45jEzPo3Q6DKxd0RIPP5ts0WiYBQ2ujCWyVhjn5eVVhoAFAgOvlpmLR9l6QevC+Q6mPdoHkWzO7EfZTlbFXO3gEVfQLZfFLRl3EIhtIxGzp8Kx5wUeMVZmLpTdUHYVwAsMuukCVT00bK4VgM0hZBNBCs4EBEIo9pp8mFTbKXnbzb3rT0/wIjIM+no5o5FloXQ2JefT3Aay/WgW/hX4j+Ln1hvw+6okQxdxiHCT0gwt9mnzGR/0kZi9J3k2N1ywjuFjrwP0LTsBnYGo21HkBpF6BCpNd0I354TW6WLNY9EddQNyN6uSGF6AUe3AEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rbhlbMh3tqk8MI2bE5YdCKDbB+7Xazo18hOJLWrWyY=;
 b=hI3TAtNVhc640IYi7ZRMeMdJTZWZqV/wE8APeH9FS0dlSuQT0VqRCLUz6udI8ORq3+WFy/2qhIMTydcQJQoO8Q5r9pHs4GC1hazc/3BZw0B6TgANnGZUyq9IDF8PTJHqk0kT8xViIdeRPDNhziamZrYXIqbKKpuSE7S3dyip4CqPsLZidGcorOgsaT8df5LAB0oG4ux7jPEHViXDLfXHHkyMQhNT6zq7K8RoYmFohaarTcuA8OjnPf+Ntqd1LOBBzNXdGv+R8QZNvo9zzVyd1mVydQG3grSt2JUFLJcfEe9pktBWObuwOc0EtTWGKUWrjwsGQta7ekf64pKvr8oqSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Mon, 29 Jun 2026 07:56:57 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:56:56 +0000
Date: Mon, 29 Jun 2026 17:56:50 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>,
 =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>, 
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>, 
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Pedro Yudi Honda <niyudi.honda@usp.br>, 
 SeungJong Ha <engineer.jjhama@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.de
Subject: Re: [PATCH 1/1] nova-core: Update firmware bindings to use zerocopy
 traits
Message-ID: <akIiunspnSSbGWoZ@nvdebian.thelocal>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <20260629025220.1935622-2-apopple@nvidia.com>
 <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
X-ClientProxiedBy: SY5P282CA0143.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ce2ca1c-bd2f-46bb-9473-08ded5b3fd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: H/T+mYOhSKb1WZS5NrTaEP+QltlzzNA/pgMIcvFPzVy5QgItenThcA7m39FDLkplyHAJS3ZFVHVqtTCh16jSABwiMn6PWarFv/K5KOkIgs0fy+EvDB++uGDn3wJYie8DEw6D14dCHv0HbsydXSUUO9EtNmnfvfH/ecgacywsgtUw9+PlntJZJJILlvsdhuPLcEtDnwhePQQIFZqDB/5256MlyE8MLvYyeJDfXTIzl8qMtFKDJ+cecfaZBe3OmTQRrzcGwSEZBMjPodWUWGemyQcAzhzHS4ROa+bCOUr5J3DelEuL15RedmgNTNUL2kVDNGyeWZ+sNq9UH8/nJ4xTmwFqlDD2coeOtpoq4aeQ1v4jpxvXH3KZX7W2kSd5qAdOzWY+jf7M72UUcydGUAyG0Gk2gtBNsE/SxSbeclKBhRdArXMbCg139ROQrOSw+IpUmtyEiA8dlAe2F4GKx14F+XznE9ekE+qDzrjcpd/q8/yfakJLuWNU5h3IGPnsxhwxE7npgqhdDoj/LZbusJJNrQTkowPpbpyNv77zfo0wyT91Dusa5Q5zr/sDqlA6IJLZNzAH2W4MxE74O4UFLyBnNl5go57w8Z42LGYXDdV6L7h9bLIh5VHDUyxzVxkpSG69eNRt2utdpLqKeKicienoh6Y7TeX/Kp+7juLF1u9TjS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S4FQByalwUvWtHAcW+Rg0MkIGb1OJE+rEZa/Xf6VcvTEo3c9uy9o8F69f6c7?=
 =?us-ascii?Q?2sXfpEzyypJOqsulQK/ufrQKJRsfyUjT5IZmJsKJzeNmX1serUVzEIuocpHN?=
 =?us-ascii?Q?TT1iYZGpsWMQ3VX3hqtM33+nEEULXhD0j5gMMl9qYMYyNxmGd6lqqEc7gqT0?=
 =?us-ascii?Q?fj5FgTsbktFDIqnrWFCZHl0ok1HYvTWxWNip0TmowTgzAwT6G/BkBJ79DIVT?=
 =?us-ascii?Q?GJC9j0L5gPKRSsLudAzdVexlwjFXEmUQMWflcTH/KMOieQTHvgXcIqNEfq2l?=
 =?us-ascii?Q?ZIS9rdHuvjGgUkDh9ehvlSFiAvWSzVrzWVBGhk027gcyKYvIEAcsw9Zr8PfX?=
 =?us-ascii?Q?Z8G+N1e6nEUwzErK3x1I7GdpqsTH9bStlFLb6wc6+zCNfFrrc5COozNhu1xe?=
 =?us-ascii?Q?BeTD7MjAxGf+IGb+1i1V4XFmdigKOSYjPoyzo5UU/9kAYojhezCQrycQGtwq?=
 =?us-ascii?Q?toUxvslZ9BjhObUKKkpQrZkwTPt+rf0QNi10goXD7N2fj4Ardt/wuR/P+5X5?=
 =?us-ascii?Q?S1IdYYABWrJuiAdSfwZYjLI7izTBmy186s1JXWJs8XKdfzHZW8incvPwA+06?=
 =?us-ascii?Q?sQoOshGOEwiNoZr5RZVkWo/89pFrY6WKv/ytJwaMUpxPBvJkJSSQ2r+6Q1Sp?=
 =?us-ascii?Q?QWCEEp+xBHMCYzMCSpCpdKATHoA9HSi4XMISAxxlFNdXxbqzHCdXiG4FdUVy?=
 =?us-ascii?Q?cXDnJaADCDnTekntV2Raej+EDXm0Zf8VY2sJOKpXn5ljBkdSQmHfXDStBWfS?=
 =?us-ascii?Q?7KZaqTs12CfvSMnuHpmKbnxBlopHPdSXgBCZq105ZJDVu3a9WwDnXWb6YyXv?=
 =?us-ascii?Q?iGydHNkQjzC9gEpVZdNKLyPLCpEa9GgmgyKNJnLX/fU9JKAQqcNwRnQEdhau?=
 =?us-ascii?Q?1R3cOaMbEISC5nr3O4z/LV3+2nrI9tO6PzPE3C/mytoc/G5OaZLFIUa8sA2k?=
 =?us-ascii?Q?I2gacAcCROPKFvY968jc5s1wPW+ITkbD+AXZyEgSfceXMc3m2MG2B/GnHsUn?=
 =?us-ascii?Q?Uum8SVnh1xvxe8JIZ+Oe7aguwfSuuS9rH3F/BMnLifjDCw9eOAG8qddsw/7D?=
 =?us-ascii?Q?9EUH3WVj05HTDeUIiWmmGeWdQGXDtWNLy4U9YlaA16IpQY2xm2c2eGx8kO6U?=
 =?us-ascii?Q?hvye9USs5NwxZiG/iDhCpTs+XxcJtRyMV9dGjl3QtURGFZYb5b62gmMHUoMk?=
 =?us-ascii?Q?WlzF6m1L+MJ0BJg+VPRTBenPmYSUqkq3ICqelbcaDHDt1oVIRvwMm7DfLAbW?=
 =?us-ascii?Q?QgoqeNfCXSLrR1qAeh5pPMmpJ8TSeQtUIsyPo3pHdaD9UZDPvz2cbAO5CHB8?=
 =?us-ascii?Q?zGa5eJixOqoNH/nX6xPSbhwXZF+byt5/ozpFmz9HIqSQkMo/pDFowCsLFyzC?=
 =?us-ascii?Q?KNZaki/rCR+L2XydRKs7sPwvKKm55L5Kfugr0tLDHxFTV/COaLJ+mE+6Jhx6?=
 =?us-ascii?Q?7sHTsxinBJhy5RjW/hRYx1iVRUqXCmSZI6L7cyc0ed93gzSjRer9L3peQ5MZ?=
 =?us-ascii?Q?zM3Ee8GoUNqDjMW3P0MZf3cQylQ/AvaQrFhWgK++8WNTP6O5pjRNms6HXB6M?=
 =?us-ascii?Q?CSwJHSmQHAsGiUBf0iQrJuA/X6eQLv7mj3wVm+qhZX6dbnanY+yCu5824AdU?=
 =?us-ascii?Q?kRZTHbnQpOiwTwjdXCisH4ZHoaj0BYjllqBlPDazYPKlM2LAEUiKDczLfiZ/?=
 =?us-ascii?Q?2eZucdcCf6IJC+lX6xs8GGryPqzhYeYu9TsJp5M9Ib7+Z1AHD6nAkMx5/X5S?=
 =?us-ascii?Q?A0Uniyeeyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce2ca1c-bd2f-46bb-9473-08ded5b3fd88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:56:56.4197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1yyGWjXX4b3NBsnAFO5DkymjBsUZW6APDnAcsA/zhr15AhBjdVm5BOL8lP7qsRGv2K39ZVwDCy8r9hnHWA2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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

On 2026-06-29 at 17:36 +1000, Alexandre Courbot <acourbot@nvidia.com> wrote...
> On Mon Jun 29, 2026 at 11:52 AM JST, Alistair Popple wrote:
> > Currently most of nova-core uses unsafe implementations of AsBytes and
> > FromBytes in order to read and write GSP commands using the generated
> > bindings. Whilst this is generally safe in practice there is nothing
> > that actually guarantees or checks this.
> >
> > This is exactly what the zerocopy library was introduced to do - provide
> > compile-time checks ensuring From/AsBytes is safe. Make use of these
> > checks by converting all our generated bindings to derive the required
> > traits for the zerocopy checks, removing many unsafe implementations in
> > the process.
> >
> > Note this does require the use of an unstable feature - trivial_bounds
> > - as some bindings end up needing to derive zerocopy::Unaligned.
> > A work-around is also required in the bindings to make some of the
> > __IncompleteArrayField<T> ZSTs monomorphic as the check macro can not
> > prove a generic type is aligned and thus forces T to derive
> > zerocopy::Unaligned, which is not satisfied by all types.
> >
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> I have counted and this removes 28 unsafe statements. :) (it also adds
> 2 tbf)
> 
> > ---
> >  drivers/gpu/nova-core/Makefile                |   4 +
> >  drivers/gpu/nova-core/gsp/cmdq.rs             |  21 +-
> >  .../gpu/nova-core/gsp/cmdq/continuation.rs    |  16 +-
> >  drivers/gpu/nova-core/gsp/commands.rs         |  19 +-
> >  drivers/gpu/nova-core/gsp/fw.rs               |  54 +----
> >  drivers/gpu/nova-core/gsp/fw/commands.rs      |  50 ++---
> >  drivers/gpu/nova-core/gsp/fw/r570_144.rs      |  41 ++++
> >  .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 185 ++++++++++++------
> >  drivers/gpu/nova-core/gsp/sequencer.rs        |   5 +-
> >  scripts/Makefile.build                        |   4 +-
> >  10 files changed, 223 insertions(+), 176 deletions(-)
> >
> > diff --git a/drivers/gpu/nova-core/Makefile b/drivers/gpu/nova-core/Makefile
> > index 4ae544f808f4..27a5752c4cf9 100644
> > --- a/drivers/gpu/nova-core/Makefile
> > +++ b/drivers/gpu/nova-core/Makefile
> > @@ -1,4 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > +# The GSP firmware bindings derive zerocopy's `IntoBytes` on `#[repr(C)]`
> > +# unions, which is gated behind the `zerocopy_derive_union_into_bytes` cfg.
> > +rustflags-y += --cfg zerocopy_derive_union_into_bytes
> > +
> >  obj-$(CONFIG_NOVA_CORE) += nova-core.o
> >  nova-core-y := nova_core.o
> > diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
> > index 0671ee8a9960..6e79ec688983 100644
> > --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> > +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> > @@ -29,6 +29,14 @@
> >      },
> >  };
> >  
> > +// TODO: Remove `as` once FromBytes is removed completely
> > +use zerocopy::{
> > +    FromBytes as ZCFromBytes,
> 
> Since zerocopy's `FromBytes` is the one we will keep long-term, should
> we rather rename the one from `transmute`?

Good idea - it ended up this way because I was going to split the series up to
convert one type at a time but ended up squashing it into one big change given
the mechanical nature of the conversions.

> <...>
> > --- a/drivers/gpu/nova-core/gsp/fw/r570_144.rs
> > +++ b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
> > @@ -23,9 +23,50 @@
> >  )]
> >  use kernel::ffi;
> >  use pin_init::MaybeZeroable;
> > +use zerocopy_derive::{
> > +    FromBytes,
> > +    Immutable,
> > +    IntoBytes,
> > +    KnownLayout, //
> > +};
> >  
> >  include!("r570_144/bindings.rs");
> >  
> >  // SAFETY: This type has a size of zero, so its inclusion into another type should not affect their
> >  // ability to implement `Zeroable`.
> >  unsafe impl<T> kernel::prelude::Zeroable for __IncompleteArrayField<T> {}
> > +
> > +/// Monomorphic version of [`__IncompleteArrayField<PACKED_REGISTRY_ENTRY>`].
> > +///
> > +/// zerocopy's `IntoBytes` derive can only run its compile-time no-padding check
> > +/// on a concrete type; for the generic `__IncompleteArrayField<T>` it falls back
> > +/// to requiring every field be `Unaligned`, which `PACKED_REGISTRY_ENTRY`
> > +/// does not satisfy. Specializing to a concrete type lets the derive succeed.
> > +#[repr(C)]
> > +#[derive(Debug, Default, FromBytes, Immutable, IntoBytes, KnownLayout, MaybeZeroable)]
> > +pub struct __IncompletePackedRegistryEntry(
> > +    ::core::marker::PhantomData<PACKED_REGISTRY_ENTRY>,
> > +    [PACKED_REGISTRY_ENTRY; 0],
> > +);
> > +impl __IncompletePackedRegistryEntry {
> > +    #[inline]
> > +    pub const fn new() -> Self {
> > +        __IncompletePackedRegistryEntry(::core::marker::PhantomData, [])
> > +    }
> > +    #[inline]
> > +    pub fn as_ptr(&self) -> *const PACKED_REGISTRY_ENTRY {
> > +        self as *const _ as *const PACKED_REGISTRY_ENTRY
> > +    }
> > +    #[inline]
> > +    pub fn as_mut_ptr(&mut self) -> *mut PACKED_REGISTRY_ENTRY {
> > +        self as *mut _ as *mut PACKED_REGISTRY_ENTRY
> > +    }
> > +    #[inline]
> > +    pub unsafe fn as_slice(&self, len: usize) -> &[PACKED_REGISTRY_ENTRY] {
> > +        ::core::slice::from_raw_parts(self.as_ptr(), len)
> > +    }
> > +    #[inline]
> > +    pub unsafe fn as_mut_slice(&mut self, len: usize) -> &mut [PACKED_REGISTRY_ENTRY] {
> > +        ::core::slice::from_raw_parts_mut(self.as_mut_ptr(), len)
> > +    }
> > +}
> 
> Yikes, this is a one-shot so I guess we can live with that if neeeded.

Yes, this is a total hack but I couldn't figure out a better alternative.
Given this is the only type that has this problem I figured it was a bearable
trade-off to make, but am open to better suggestions if there are any.

> > diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> > index ea350f9b2cc4..9c85c93f6eee 100644
> > --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> > +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> >  #[repr(C)]
> > -#[derive(Default)]
> > +#[derive(Default, FromBytes, IntoBytes, Immutable, KnownLayout)]
> 
> This is the part my other email [1] was about: are we going, long-term,
> to replace this with a `#[derive(zerocopy_derive::most_traits)]`? If the
> Nova's bindings generator program can take care of producing the correct
> traits for each generated type then maybe that's even better, but at the
> same time I am wondering whether the kernel's bindgen invocation isn't
> going to automatically derive `most_traits` on all generated types. In
> this case, we could end up with duplicate implementations.

If that's coming soon I think it makes sense to wait simply to avoid churn
on the generated bindings. I didn't do anything too smart for Nova's binding
generator - it basically just derives all these traits for all our bindings.
Being able to have it derive `most_traits` would be cleaner. So happy to rebase
once that is merged.

> I think this point needs to be clarified before we can decide when to
> merge this patch.
> 
> [1] https://lore.kernel.org/all/DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com/
> 
> <...>
> >  #[repr(C)]
> > -#[derive(Debug, Default, MaybeZeroable)]
> > +#[derive(Debug, Default, MaybeZeroable, FromBytes, Immutable, KnownLayout, IntoBytes)]
> >  pub struct PACKED_REGISTRY_TABLE {
> >      pub size: u32_,
> >      pub numEntries: u32_,
> > -    pub entries: __IncompleteArrayField<PACKED_REGISTRY_ENTRY>,
> > +    pub entries: __IncompletePackedRegistryEntry,
> 
> This is part of the generated bindings, right? How does the generator
> program know it needs to use `__IncompletePackedRegistryEntry`?

Maigc[1] ... otherwise known as `sed` :-)

[1] - https://github.com/apopple-nvidia/nova-gsp-binding-generator/blob/zerocopy/Kbuild#L153

> <...>
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -314,10 +314,12 @@ $(obj)/%.lst: $(obj)/%.c FORCE
> >  #   - Stable since Rust 1.89.0: `feature(generic_arg_infer)`.
> >  #   - Expected to become stable: `feature(arbitrary_self_types)`.
> >  #   - To be determined: `feature(used_with_arg)`.
> > +#   - Required by nova-core's zerocopy firmware bindings, whose derives emit
> > +#     trivial `where` bounds: `feature(trivial_bounds)`.
> >  #
> >  # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
> >  # the unstable features in use.
> > -rust_allowed_features := arbitrary_self_types,asm_goto,generic_arg_infer,used_with_arg
> > +rust_allowed_features := arbitrary_self_types,asm_goto,generic_arg_infer,used_with_arg,trivial_bounds
> 
> This also might be something that will land soon through the Rust tree;
> Miguel, do you know what the plan is by any chance?
