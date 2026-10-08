Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482D7CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853510E8BA;
	Thu,  8 Oct 2026 15:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UpJtE6zn";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013057.outbound.protection.outlook.com
 [40.93.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64ADA10E8BA
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 15:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3t9x0N+zs1B18gGzsNlQz4H9XYgbDlgJS9aXw+UmFLYlWVO9VRczYle5ua245vLMMJXC5MgtjA8uQQaQxOELzGu4dN3PpiFmv/pyRjw7ZUMl0iu+bdD7gwib1dwcw4Wi+GQWwhCjENP9+apdo9bjBRnnRSra4UOxv0BMlvUjOa/Z6B2h2rlfjMA6HbjDWUQGruWcZc+8dkfsm5FEVY4EvZv6apYLFHrfitj4rbhEgRxq7K1QZyh6o22UYTGg0vpnHHhovT5e8n+dgNqkPBDuImRvO584qfD08WrBP2PuNV5ZsVzgpcHtEwSQ3tMygyA9uiCpVjKP2C7lq9w53j2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFmT1fr2mUSC/V5yPQIZC67o88CAHbsCK1OSIM2tEh0=;
 b=MKYGIscNGEIN7WjRk0nScHeXPmIXIpoRo8nM3KMvQlBC0fUrekw7ATOpFw2qKtkJs+LxtE3ESGaxOMlCd/b3SfJBNLXtjmSSVAHNjO2Sl2mYTziW9X9RxU9CbMT6vvSCFMVm7vSz41TJzWTdZoJZkc+tf5VE6kcC7lPESPVJqLCDLsr8eA8wyCGpvLMl7/Ekg7Mg6IfqphARo7YOyFXQHfAsmRBNJRCTySoUnZiWq6ZB8Ol47OKWfO/ZmL9PrSWvTV4MnixfbshftPLNdEBkNuMqyzNNUMrTD2QYcCHTRp3wM0m87fGMtZpdaYorGOPcIofsSBxYr0dNjCdi9FK5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFmT1fr2mUSC/V5yPQIZC67o88CAHbsCK1OSIM2tEh0=;
 b=UpJtE6zn2R/vE8bO4c6uJg3+wKzr5ppNQXvwmkVHzmras87DbD7BS6soTkdYh74nNk41TE9y+wnvi4x2irvvB2/W9MqUui5Tq/ZfW6XQdlSWJvwn6BwuuDXhXyd400KOPp/GpHW1AEYuRapC3FVFSBej6EPaC+kBD80Y2ZAYwJg1Y8lkMRGBymbCSf1gux1BNBSzgB+Bvj1XvuO0sUi3+0QVBo3hqmVKt3sd4CqzYRxxwKnuNyMDHBba4hJpFzQ5sHwaUVI0b+ZawI8EspKnoY/80fyFMqwclCxTI7XUBmrYRuQ5ato14FIx2IRfd1FyNmKF5yhrEsiCa1HnjNUWlw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 15:47:45 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 15:47:45 +0000
Date: Thu, 8 Oct 2026 11:47:44 -0400
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
Message-ID: <ase7IBtZjQsPVWSN@yury>
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
 <aryYkkB9j14xnWo3@yury> <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 81956ec4-1a18-42df-8f48-08df25537f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|10070799003|376014|23010399003|10067099003|5023799004|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yu1ssBUjbo8sg5EYs1xLI3GCDIvqmNMxfsj5K7Si2tj2/ONKdosIOoTc6o47HQy16SWTkbtcuswn+wTfCShh5BSPpj8+/7eZZ1Fs6tmSh6GV33abr597DVsTmyK+H/fXCdg97axnvJkBz9Rv/0hbZrELR21YeEy3Pi3+kU8O/j9iumGTmtXUJecwfXdAnDQq4cPoORHggWFPX30f7CW2hDoVDj1IIbDSs/7UVwfMR9G61yLNPraYeUUxd2jIvqC9Xv/PDd36QBiWgz0osk2Ac2yK4kCmqFCH3hgC1daMZYzkYmtSrrdbcwLFiYwachj85YtOlKktUSSDCq73hT3WOZZ5yF0aNIRRsea4cqwx9tgxmM82B1ukm/NTCMsNSwHZIuwef9bBeDKgfl0jc3RWf+xqBrvttObN8B2m6bpIGB5tQwuAGIAp/WyOZHYq/FWXHoa/SZlHyEJfgtSTBtDeLsgZkSQuGhGxRjAtsqbtbF9hQ3CBIBZ3/5OFT9atZHnYGEJSLhjEXthdwgxuGXPlFqZXyNQSMm+1FEyq72ymE3MhypFjyhZO1GB8b65aVzQfLcDey7sJvWpyyDrQhCO8TFIbbN19uuGJTDOqVk55vxjI1rx99WY2qslMBnPi3mndqR1ti+LXRjDs6EnBptxjL3kqPx/X3LoOSWPq6XAnQl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(10070799003)(376014)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N2aHe4QGDQ8yTgMbX8GjG618ZV01HZWwwqsexjGyWzzIHn3DqFp/NqaoBIk4?=
 =?us-ascii?Q?mQNp4e5SbtBvp3zDIxEAQONXFL8e0sRKehOZay9RS4Cyh4jOAI8B2m5ElI29?=
 =?us-ascii?Q?tK6IW5nnZwVS3lW8anZRXdtzsp6TIU+rnh+02Ev36nNMUsAWqSkSQtjYqEJq?=
 =?us-ascii?Q?0fCaiDP9KzryJWD12yLNjShf2hrfa+qS0eNFL4sZp8yVmYBxKtXcRq9CLWLS?=
 =?us-ascii?Q?xfSzFKIjnVaHiRGB3XE/JAdT59zziEmpcCbJDj4jqnmIkS1ZxqE+tSTKhTkQ?=
 =?us-ascii?Q?zy/lbLetHU9MQ5oInDVGhgopJZwHRFeUi4aO9Y7fyuX7ZD5MkAt+P6q0n2kI?=
 =?us-ascii?Q?nHvDL1mKWX0CV6hbHO/GAxxjhR8EsAebKovrTgLck+KN8cnDi0DFPlxLBgVY?=
 =?us-ascii?Q?ySRGaR/T2iZatOSkM7xv1quVZlNi/Q9CWrpBgHep6wDHEw2zxjrBR/xsAQHP?=
 =?us-ascii?Q?czODFRAiHzTPwQYNfteG4f5N/h/L+tgGpZHmzrr6Z4e4Qgvv7O+WfqpLBfFn?=
 =?us-ascii?Q?cptjE8Lrd3IivQKFTwEGV3r8vOQhZ2M9e/lN2O74yolqIZC94g+Cr2yCsZlp?=
 =?us-ascii?Q?gYjSkQ6h4dsxfzQqD6gIUJVOx0yv7zip+o1O2I+jJ1eq/7wL4PikPn409+v8?=
 =?us-ascii?Q?biCzIWAV73EooFXB/r/P5URq8Vopi5m692nvcqwkVOtGKOfDjUKsEspNTbeV?=
 =?us-ascii?Q?QsIPiq6NvKT7z76UvXo5jAHqeQvymxGr1LnhMhCAchZ6pnOFOsXqDHDyPIym?=
 =?us-ascii?Q?X3lsf271UycE4GOcPw6vyQktXBIywcPTTC+K3pnSnFz0D9TPaJzsO+x55qhh?=
 =?us-ascii?Q?h5b9IlcEaUwS5RidIH5zqx3hmAQTiN3MR/CcGII0e3Yscgk5WZqdFKyelA3b?=
 =?us-ascii?Q?VsS+j5gCbVEqTH4gGm5DaxUvhNWf3AYJZ+JADSiILyIwIR3gIB/blrR+BKRO?=
 =?us-ascii?Q?Qs5N5C3pb0+2qhu9wUCWj6/UQRkoWdqfUV4xszy6g0Oga5Ir5Pri3JH2VUiC?=
 =?us-ascii?Q?8kAi1IUTj+fofDB0tvFntBydr2Q5SCG509j1SNYSde9mV2mpEcob9TuY0OQr?=
 =?us-ascii?Q?yjE/7kOL3w+d64+yF2TTw6ex/Es93NtDnoaTdtpLoZoJa83aeJVOXOIufBac?=
 =?us-ascii?Q?N+y8VXX+5afwjZeTraZKeqPh1JDReQRjStODVLm8p40nPl4wo6/laIDac4Jg?=
 =?us-ascii?Q?vpe30RNsUbG44Tin+tGF4PeYJI3p5UPk7c8jygtjAWw67mcuPztNZNmtVRFL?=
 =?us-ascii?Q?5rPIwiIwiNcr52kSQETzAT+IepxNJSrXRJQSpToy2QabPoUJJ+HcG8RgSVAz?=
 =?us-ascii?Q?1eDY44CdsjTKRNe/ezIuNhcChKbIX1xLlNl5hfA8sOraffxuu8IHG9wFd6d6?=
 =?us-ascii?Q?sUGlZLBDDxP99QEP3SBSCjXyy7yIMEeOfgj/gFev9OYuTxHKkFuax/jzYJhe?=
 =?us-ascii?Q?LHxB95WZIFp1L3ZetodJGxG1hVFm//TvJIveZ3hs3iQKrR6VtRbuFC8dxlJ/?=
 =?us-ascii?Q?uaWpdUXg/h7l/UfGk5TbKqpr/T56vcqvxospDTPaM6HXuW0wJksXL/edU9v8?=
 =?us-ascii?Q?Cqc9Tc7Fph1MtcvcynqEFld1Nnjv8bh9t21KwSqCl4HVeUaSsyU+drVIXvxE?=
 =?us-ascii?Q?dBNdubv6xdBb+NILTY3WyX109udLUodKCsmjKTV/m+qa6bR8Bwoj6r1eXUDp?=
 =?us-ascii?Q?wIzZcgoDzJOErjDpYovX2lAaQAwOnEbD4cSFX9nUX22k0fei7eBksH46vfBl?=
 =?us-ascii?Q?9us/PDGlFfU08R/Z8WNvp5fjbC/eS4IzcTCtQ/u/zjx8LnF6R9sv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81956ec4-1a18-42df-8f48-08df25537f0b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:47:45.5676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3raqKt/yPo7Rf0trolNRgUsWItCtN/zrRx0YOoFDpX2Rin8uVAHhbC5ls3BU7FmG/yyTLdce2wmvvgkBFQ53sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

On Thu, Oct 01, 2026 at 03:20:40PM +0900, Alexandre Courbot wrote:
> On Wed Sep 30, 2026 at 2:05 PM JST, Yury Norov wrote:

...

> > Allocating a pool with 0-bit capacity is wrong. Please don't put it
> > in the examples. I recall I pointed that this object would panic the
> > kernel if, for example, you call pool.next_zero_bit(0) immediately
> > after this. Sorry, but NAK.
> >
> > This .with_capacity() should take num_ids: NonZero, after all...
> 
> This panic is not specific to the size zero, any size triggers the same
> behavior when accessed out of bounds.

In C, malloc(0) is implementation defined behavior, i.e. it can return
a pointer valid for free(), or NULL (which is also valid for free).

This is a very old legacy coming from K&R implementation, then rejected
in C89, and later this all became an impl-def, mostly for compatibility
reasons. See 7.20.3 in

https://www.open-std.org/jtc1/sc22/wg14/www/docs/n937.pdf

Rust adopted C bitmaps, thus creating 0-bit bitmap may go through, and
hit that questionable behavior. You add this example without any
discussion about all that possible complications, and with no
protection for users.

Interestingly, you're doing it for the reason that has been considered
a bad practice for over 30 years ago - malloc(0) with the immediate
realloc(). See the above link for details.

To me it looks like pulling legacy with a potential of undefined behavior
into Rust.

Bitmaps is a way more simple case than the generic malloc(). There's the
only user of bitmaps - the Linux kernel, so we know exactly all users and
their user patterns. I'm not aware of any in-tree user allocating 0-length
bitmap for whatever reason, and such a coding style is highly unwelcome
nowadays (30+ years).

When it comes to rust, things are even simpler. Rust has much stricter
memory policy - no undefined behavior, no implementation-defined behavior
is allowed, no 50-years old legacy has to be considered.

Rust community decided to take the existing in-kernel implementation of
bitmaps written in C, for a reason. But with that it pulls all undefined
and poorly defined behavior associate to C language. We did quite well
spotting such places and fencing them with safety checks.

The 0-length bitmaps is just another case that should be resolved.

If you still think that you need 0-length bitmaps in Rust, can you please
give the clear and thorough explanation why rust needs those 0-length
bitmaps. Are there any in-kernel examples? Any language concepts requiring
it? If not, it's still a NAK.

> A size of zero has nothing special
> in that respect, so why make an exception and forbid it? We had this
> discussion some time ago [1][2], and I'd recommend instead making e.g.
> `next_zero_bit` return `None` on out-of-bounds accesses, which is
> semantically correct.

No. out-of-bound access should panic because every caller of bitmap
API knows the length of that bitmap.

But if you make that 0-length bitmap a valid case, we need to revisit
every function and make sure it returns ENOENT or something instead of
panicking. That, again, must be very well explained and justified, and
all this has to be done before adding 0-length bitmap support in code
and examples.

Thanks,
Yury

> [1] https://lore.kernel.org/all/ao2GHqop_Z_9bsyl@google.com/
> [2] https://lore.kernel.org/all/ao2U1jNaT7waibJW@google.com/
