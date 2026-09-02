Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98098C61DD3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 02:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D48010E451;
	Wed,  2 Sep 2026 02:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gCLDlhGS";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2216E10E451
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 02:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdbHR7n8UeEhHUYMesHw24mdRPUDpezqckYeJlzEO6gGzaU1siXfKH6l++l8ZvdQHjoH3n5XfdU8E5azDdSRDeMdA9EoV/aOAk8rAavOeIJ/xih1nS9GJR1Daptx+0GNGvUO2OqeD9UMtiy3cuW5ww2A0q3JpxAs4mJ67Je9t0PrMZkuqDFAOdzG5c3GFwfNh5kwY5Y3rHVKY4M5z0z4J02cNMp/t1Z/jpWTF7a5mNvQYBoU9H7BbK3XtInpJnpOkUos8G222P+ySno6Qxs2wzxxIyW0ZkrzQfPyzyel1L5VP89gSugEG2VvEoUK7wjHeufD3TMFFWFF1gxnKE6SHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25QNHZrDoAwmN6v6bzfIpEyt0NU2IMviome29s5E9TU=;
 b=PkeWh+GzoM0NVPup60kNcomtU/g7wbDtWzT5P0JKwOAHYagFWK8WoIUCcAYZzW4ptWIMByIGBr9SeciM5gRjttZsPe+5YKc2lQENcx7PMi2QnW4O+p3nV6Fv6ucGWCRQbgfBbhbd+oQqExTBuwW8JIaAgQAr/yDpQJXG9AeabCtBwRPY9W0A43mwHnuBd9A9Pxt+zvL+PNFX0krmspArbUjAWKStzAvuqKqf5D7W1sr0DVXWHtbC+VTaq7Ea6r/7VQkb756Pdk8FN4mm3x+fFWBrOafadR1pLeC1nrs+GpzPxIwkVychJqYBzmBBXvVMw8uHUACtZeRNwk+1kvhWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25QNHZrDoAwmN6v6bzfIpEyt0NU2IMviome29s5E9TU=;
 b=gCLDlhGSmAc05AaZCUh88CrgXCAILhlt5PqvAxLEqasyTSUh46VTufLMWIkZXo3b9iKKP66LvD6s0VZOytzwJxjJ4K8YeArcC2l01by+I6DApelnkrmY+Isy/mYx6PJ8wvlANT2Uy1ez5xfOUscAvLvKg5os/1kzS6uvm1/+qr4q/6PoFsOoCI9ZUkjoSEB+3TCHF4xli3g2WtmLc4j+JhIUM2+Fybizwp0hBbKr6kzX/0pFVNeXWQ5JU0qQGu6jhQ3+KpMcLCU4DMZ+GGxU1UEw0fVuQX0TqhcclvU814b0par1lGFmVV/MytXdN8tMBiSEx7q+MAfXbr1jtuCAkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 02:38:50 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:38:50 +0000
Date: Wed, 2 Sep 2026 12:38:44 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apdvTgAp5eGezO5t@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
X-ClientProxiedBy: SY5PR01CA0095.ausprd01.prod.outlook.com
 (2603:10c6:10:207::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: e9001ef2-e3a8-47ba-260a-08df089b5200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|5023799004|11063799006|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: YYsAymm4rU9H8gKDZX8321nvb7KA1/xEqIM/rM9z1h9m1Y7vgZodxeAxitQO4iC+MFa3uDkzWEj0a7Dh866jLZUYic5suoLBa24NpqYazR5EHXuwo4axo6GOeAEYuN4ONf7MMLqXiQilmJskO1kKqRufYL2+9r+FV5QYICJxKxJAC+hJgu4SS5gz0w/zNLh+9kuLmHd51p3YKdLdDX32UsIucgQtv8Z/vsxXZtrlSBF6ELZN2FNEok8WiBVJybp/IymFE+ZzC/lSCk5WJiQl5XLG612wUGLNKOx5EdpAukpR/Z5qGfWueDunTNhZfPwZyWXDvwC2rqr2m3+fUBuJsW4YWA5P367jTNbl2f1gxRuEYGqoh6e11YhqAF/nnq5NebvIuzLzbHKUAPoECK9Fl3PDEWZapKRveTh3XidrCH9ZOEygTzR8Z4tfrirXnjkCAy+G2tRGWPHDv8HfysCx2b9Tvban17fSkuLtQhQ8C6G8AML11qTX/z9JXdxJQUKfYoo/RRKAS0oo0UeSzCOCrmmNV8v50pHwUiomilSvR/EEjcb6jPwWZ50vmsYVad9YbXsZRaB+D2CKhH9FmLzMPMvs6Slka9qcj941/nEDNLUveNkhJYk8QEyKXvhuUHHr36xtfe3bPiQP29HHBFjEbp0dPhTu8l4L7i7aice2pGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(5023799004)(11063799006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mP9A/UZlVwpHo2PBUEUQJkuqHCF0Hnr40Lnb2Jp5r1spBQvk78eElheLQzDw?=
 =?us-ascii?Q?Kl6Llls7IrPbfAac4Y08ItjAp0n2OauokhhPrAdJNHF8Pfl/xZ8wwVNFBZNu?=
 =?us-ascii?Q?HZ4PLH7A2mAMYrxGvg/ADkVtKJZhetrflEO49MmE9gS8YHS/C9atBMoZDelG?=
 =?us-ascii?Q?Q38sJxOfkIABlxuSzV2K75tOCgR3kbBxqR94Qb24uN6yZPBxeagth5t3m/LB?=
 =?us-ascii?Q?jwRL347UJULJ71wSu1e1wzvaFq/I585j6DyNOQuP0FkA5cw5aiZLNW4yNeO5?=
 =?us-ascii?Q?BCNL+Z/mlSxyUsbhpp48KRL/rlFv9ygpONaSBrIE/dPDAw5qHw0QQSVSshsE?=
 =?us-ascii?Q?KdsvUOdC1423MH30UEUHmmq85JTz7PXJCJot364QqM2xv9O6G+GFQ+2b/z0F?=
 =?us-ascii?Q?yl1aFygPsxHJCBz+uISTXFw6XSORwrUAP/i2JZc301W6C1p0Nmte2XPY2ngs?=
 =?us-ascii?Q?O4TAu/EPD4PBtTYxePRn5FD3MY5ztFn6C9TKLaYu4OdMGtH7mx2GpmTdeNTy?=
 =?us-ascii?Q?Zb/QgxJlFL6WUa4V3gVc9uOGrKJ/Zv55XFMyOtPPh2OnFJVXNiVwFZOd/XY6?=
 =?us-ascii?Q?4uq+x2XuFbhlcdvm0eU4XXgoUWiATGLWX+kueozXEgOnlvSfTCMIDxie/4iw?=
 =?us-ascii?Q?k4vL9vAKnHWEMVIsctpqbu6vfoHskxWiyEO5bkuuqOE5XQnFz6Jw/1MP83x2?=
 =?us-ascii?Q?cRXl69oyog3A4jrLyf10v/nYWK/FxkEm7BhBcBOF25qkyrE0uDBv8EzMbks7?=
 =?us-ascii?Q?1SjnXJHmDHl2J+YoCaewKhY5iN6S6rOLojW97RhmviZk+8S8hNJugSbB/7Jv?=
 =?us-ascii?Q?YQR++o3WwjEGfbkkRx/Ruu9nO56hofyi6UOa4zROTAmm6Txv3CU3BZmC3jMS?=
 =?us-ascii?Q?xG5h1vB5mEpo48F0c9c64SpEiBC92YD9ciALFsK8lzz7EJPoYqrlObVKNFDe?=
 =?us-ascii?Q?W8jNM37ZILxElThZfW8FNVJjgYMoBjzQ8RyYkNGKcrUDHdqA0ndCDfgeckZE?=
 =?us-ascii?Q?jXuNg1UrooEAw0/oj4pfonyYhxV6MnK1MmDOPUpxbwouVUILKY33/yyWtoZX?=
 =?us-ascii?Q?kZ5XD57VDyYOFevG5I1ibzRGsI2DwHTMo3NpttJbjIbOnKl2smTsVe+M2Cfi?=
 =?us-ascii?Q?+1d7o1TvwIcgUeV9mjF03hhfeF+wDfsyWMG+LKX0zu97uAwA5R/U2QdJmB6H?=
 =?us-ascii?Q?NPJXmQlvT6p9l8HFlx9jwybF7Fm+W71c9ISLg9rA7oGet+jiD7YpI8uGH4t1?=
 =?us-ascii?Q?VXlxC/PNq19Q2g87jaT2wQ+b/I5+P6LnWmqOq+YVcWQiSGovtAVdYSjcpEbe?=
 =?us-ascii?Q?lZR+zVIUuJKqgqcOHeJ4N17LtHCC5uq97/MjvRWwFcbYZ0skoC0GAKdzl/9f?=
 =?us-ascii?Q?MXlwTpwwDehra8CIutBuMLFki2FLliQY204+9a6PQ1/aFlVz4Wcgzreg6U8K?=
 =?us-ascii?Q?C4K+wFWzqSa8Bu5Fq1vo/phjfdGPsDf+hkYZS6MEIx53/un/hHAZWQdsD0Mo?=
 =?us-ascii?Q?gWoOSbJE2B9y2PNIEDGolvtmuCGFwyA3r1gKqWY4y1qJ/BjhyinYTvJqf1Yz?=
 =?us-ascii?Q?6XQNdWzCM4Lssxl6IGotidcqsxe9yJv5tXFuOEfp4fDsAn4O1tOQ3Qe09sKf?=
 =?us-ascii?Q?RVNMotNSvJ7pyrG1VbJbaH1/KFTyoCjDWuOxeU8GtarP13MWGpUQkF8EIq0Y?=
 =?us-ascii?Q?aSTakMmLq7eA+tg6hXz5qFZeanSv8hk8ArUIuKspa+wS9duLA/+Y0idUFvYM?=
 =?us-ascii?Q?B++uf7HI+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9001ef2-e3a8-47ba-260a-08df089b5200
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:38:50.0170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMwra0QDOGiEalRwWowkgImNLIL/zTJsMcwzjYoxA85KrInD1whq5MhPgeHbLXorFLXtV3Lj1/e4NoeRzAX0XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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

On 2026-09-02 at 03:01 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Tue Sep 1, 2026 at 12:38 PM CEST, Danilo Krummrich wrote:
> > On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> >> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> >> index 0c12ef145981..740466af268d 100644
> >> --- a/drivers/gpu/nova-core/gpu.rs
> >> +++ b/drivers/gpu/nova-core/gpu.rs
> >> @@ -138,6 +138,11 @@ pub(crate) const fn arch(self) -> Architecture {
> >>          }
> >>      }
> >>  
> >> +    /// Returns the implementation identifier of this chipset.
> >> +    pub(crate) const fn implementation(self) -> u32 {
> >> +        self as u32 & 0xf
> >> +    }
> >
> > I missed this part in my previous reply. Besides being a bit unfortunate that we
> > have to reimplement what boot42.implementation() already gives us, I think the
> > value is not overly useful anyway.
> >
> > I get the intent, architecture and implementation complement each other, but in
> > practice we are not interested in the implementation bits, but either in a
> > unique chip identifier or the architecture.
> >
> > If you look at the nova-core code you will find exactly that, we either check
> > for a specific chip or an architecture and I think userspace will be intersted
> > in the same.
> >
> > So, I think the uAPI should provide the architecture and a unique chip
> > identifier.
> >
> > Before we circle back, I know that the unique chip identifier in nova-core
> > technically contains the architecture for obvious reasons, but my point has
> > always been that we can give the decoded architecture to userspace and not
> > require it to know about and extract it from the chip identifier we consider
> > opaque in the uAPI.

This is why I removed the opaque chip-id. If it's opaque, and the kernel
provides the architecture what information is user-space allowed to derive
about a GPU from the chip-id? Nothing? Everything? Or everything except the
chip architecture?

Nothing seemed like the only reasonable answer, as it's always best to have a
single source of truth and deriving everything except arch seemed odd. But then
architecture alone, as currently defined, isn't sufficient for user-space - it
needs the implementation in some form to derive the compute capabilities of the
GPU amoung other things.

> IOW, we should not think of this in terms of the numbers/values exposed by some
> register. All the users (including nova-core itself) don't really care about the
> values behind the enum, how it composes and how it is related to other values,
> that's just an implementation detail.

Right, the question isn't how this information is encoded but what gurantees
the kernel provide to user-space when it returns a particular architecture,
implementation or chip-id and what assumptions is user-space allowed to make
based on the results.

> All users care about is that they have an architecture and chip identifier to
> compare against. I.e. there's no value letting userspace think of the chip
> identifier as architecture/implementation tuple, since the implementation value
> by itself is rather useless.

Except the architecture/implementation tuple is exaclty what user-space needs to
eg. figure out what SM to compile for.

So yes, the implementation value by itself is rather useless, but so is
the architecture. That doesn't imply that providing it as a seperate value
is useless. I've done some research into our current SW stack to see how
implementation is used today and it's basically used to subclass each GPU.

For example the base arch value is used to fill in a *lot* of static information
about the GPU based on architecture, and then the specific implementation is
used to over-ride or fill in yet more static device information. In fact in
userspace it seems we very rarely look at the architecture in isolation from the
implementation, so in many senses providing an arch value on it's own is also
rather useless.

As a concrete example the way this is currently used, in both CUDA and Mesa, is
a lookup table for arch+impl to figure out eg. what SM version a chip supports.
So having architecture seperately decoded but a chip-id instead of a seperately
decoded implementation would mean user-space just has to look at chip-id for
most things and ignore the architecture anyway.

For example Mesa currently has this to figure out SM version:

static uint8_t
sm_for_chipset(uint16_t chipset)
{
	if (chipset >= 0x1b0)
		return 120;
	else if (chipset >= 0x1a0)
		return 100;
	else if (chipset >= 0x190)
		return 89;
	// GH100 is older than AD10X, but is SM90
	else if (chipset >= 0x180)
		return 90;
	else if (chipset == 0x17b)
		return 87;
	else if (chipset >= 0x172)
		return 86;
	else if (chipset >= 0x170)
		return 80;
	...
}

And to be clear we don't care about the specific encodings in this example. The
point is the SM version can't be looked up from architecture alone, it needs the
implementation as well and if the only way to get that is from opaque chip-id
that's all user-space will look at. Eg:

static uint8_t
sm_for_chipset(enum chip_id chip)
{
	switch (chip) {
		case NOVA_GPU_CHIP_GA100:
			return 80;
		case NOVA_GPU_CHIP_GA101:
			return 86;
		case NOVA_GPU_CHIP_GA102:
			return 86;
		case NOVA_GPU_CHIP_GA10B:
			return 87;
		...
	}
}

So I'm ok with providing either a decoded architecture and implementation
xor an opaque chip-id. Or alternatively maybe architecture includes the
implementation (ie. we rename the opaque chip_id to architecture). But treating
the implementation and architecture values differently and only providing one
directly doesn't make much sense IMHO.

- Alistair
