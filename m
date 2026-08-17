Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE4C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B7710E91E;
	Mon, 17 Aug 2026 20:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEnCCKz9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3033D10E8F6;
 Mon, 17 Aug 2026 20:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgDn7Z7OQU64mx0dxZWOfz6JayuMhjM2u7pXcR5ndxCMqaKblgg9m4AU8ZRoV14e3b4QRbGTlw1oNyhEAOinshYn7gb9wXoMu7Hpq1A3xQIvv/L/cCEKrpGTTF/u8BISDrfY0kKLsthHJfnRxls7ThH4vN2tu9TnlQSHM4XNCtgNt36kF62VJ1TFhLWhel+PACNXFTv84fVFtntGQRwVF4n61a27VELeW7bJX9ToAuKtCYrrzcr0ov8LyZ7vY0ozN+FZjxiIo7TZ46jl4ZjHxYAn5cP93okXb+MfKBBm/ZdkX/TjkAKKZGHlmdFUdjq5EuhBeBDqgYb8xZwXChMZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdFnVOAoH1aU1raZRPAIbs1Z0NHTrGAzUSBK4NaZcSk=;
 b=PwGBxnQh7O7y15nBCljIEkjjZW/D3l6bN4vNAByxmQZrjTlTYXKCsOx0Ca+/7H6EqtVbnAHalP6fEyPQvOBRpVMBN60CM9C0iiWHvQ39OHsWsi264fiTbfXv2rD4t8sqqGf0/al/03Y4DBV5qZcfhUbxVpTA+3mBQ1fNFu3nWvvPE3k42QQhNAYNTyJfxFlwD3VN929Y25xc036u6CoycMQ4U/CujI3xDGlnCHqKEJBrGPME25IhnwltBQmiHJbomUljQGVbFyDnO6kBDX3Fkm2RLjdGpeRltBEytMv0vYQha+44ZWfXKrZdf/UekQdsjq5XoskdBed9ya+hCELRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdFnVOAoH1aU1raZRPAIbs1Z0NHTrGAzUSBK4NaZcSk=;
 b=rEnCCKz95Zx8TKKfPe2tN2llmzGTUDv0X+eGusbEiE1EK2usxRQ/Bm4AX6KO3AkT6rSkf5ZeELUQwZ6d8VziJ6WGgqNbOJbTN7uj6kdjgD+pAlMTRYH1fdCvy2Lwp7ZEbfwsI8M0bN7wyLTYndQhGAvINSlPV/MYpIwzBv+Fcr5jaxzm7O3ysFRO9Ikkyp9MmeUYQxcRw7HSvARC40GHTlLjxAK3MTMrrTxiuzmHBpPRUQo3FcSAv/W0cx2lfYMdGAIuXaIMocnAKmy+wK8TFp7xc3FJkYmDrC+6UrTog4/yyUTgBV7748F8/1RVOsDW1dhKjr5Rxcd4AtpTWEfU1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 20:20:13 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 20:20:12 +0000
Date: Mon, 17 Aug 2026 16:20:10 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
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
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Message-ID: <aoNs-obzDfNn3WJc@yury>
References: <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <an4xDp29VX8Am0uR@yury> <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:408:fc::11) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: f80b7eda-c57a-4da8-b3cb-08defc9cf0e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|3023799007|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: p8WzfAoyduPFtWxK5YiRmTi2Ocy/pPOuE0NsQer7QovwGZCDR0VeCsTJxhqjmzkYbxwAFmQp32PaxUEN86I8c+IjrxXrmtAOSxGL9F8cPxjub5dsmkA58WSaBmfxQLMFONiu0qLFQgrWoqKDBUpJjDL20CnIZaWL0qfF6V1WPjGG22Lcua22RdG6imCfj+6JmVzpyb+8YLlg9yb2uHeashyBawI/UsCFZ/02/DA+nJ9d1A/S0GD74NToWI5vcgQ+G5ZBTEVtcFl32aP4JWeya5BV9IqA5rvAF2pmo2X0kFTxbn087ub+DjkbJ9j+zt9PmXueyh9uN63QEyTbiqbB8lQxvbplCV4I+VadBQAEC5xDesc2YAtduk3kQmmpmuBwIItiSgxqeuIgnU7HbBWtTrgyiaUdXC1NeTVBeTTmLZIdPFR3fqBUNqEL/BoR5/cao56VWIR5xB2SQrNEZR4o3FP9ND6okB2O6sQuP1hHJbu/Eog2kpW5QtIVMqxFlMQstgGFleIHR25ujJ8o02LImLwoVuAwSlv7pZnr/fEE8REXngRaAKFYq1G7JO2NvJqtBu6TppW0IfSiCkLxUtzYuI+T6v+Rq4mPa5eg/8rUEakr7wetEGOm+5dtKty/IkAeSEp3C7E6Q3m2DvSkgIRRQ+vOlHo7Bn50gV6wpk8V7Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4KsvVkv5NTifSkzyHDOdWvyoFHtIbKMwq9cdWQIklSkcfOGcqz7lT0KE/SP?=
 =?us-ascii?Q?i6kWYi+N7cfNH4PktbK+dwjsZHqUv8W/4nkkiLGOeP4It7yhv3pBa4rXBG3A?=
 =?us-ascii?Q?YR7ShlAw5senvaxzbcrV5DVndiw8dAHLV04K0asOfnPK7it2OU82bT37XWqx?=
 =?us-ascii?Q?8yqNYLhwWOWkxHZUxcIqk5IhjdCkri9/Mlq7mZdGE5AbCJyIKOY7UboKFjvq?=
 =?us-ascii?Q?7CYL6Cmcz0uQU3SMFGP/Xe4PtIfORQBOznm0+Pu6vR2axmO+ABHk2qfl3BNM?=
 =?us-ascii?Q?rB7X7mzVV1PHydEgv5smIjV0ldW/cZ9Z8ANH1eSBfpUEYBnzUcOPu2vSD0/i?=
 =?us-ascii?Q?sg8Ixb2jlZ4xSkjTftrCIMb4IUHQKsrziQHqbPWpmPhfZa1RivlLuMWCLmAA?=
 =?us-ascii?Q?dmB/XqczhM/G1Svn4b/6gN3QUYSaDqYmZTfyTqrzHNVHsHQNoSANiuIm07C3?=
 =?us-ascii?Q?XNTK5lmTHR5NbQ9oWe8vrrWuwCglikb34QYsUaLpmEuOGXmHneNVk1XdDkEH?=
 =?us-ascii?Q?V5F3i4ipYzAl+GNQ9/kcW2BQnJqN7Sqfthcpd3spHb7BrW/8yj/TI5ySs3//?=
 =?us-ascii?Q?LknyHjBVox/Jw4HrTT8pYJFo/83fR92GelpgX4Bp1aHH9HX52iCJIh7Gu8Dv?=
 =?us-ascii?Q?qGEwCYBj0HAr7dLLBMVNLQKnhLHJY1X2dYepxNoIy+VqIHyajryOk6feYl1T?=
 =?us-ascii?Q?362QvE4eVlimdMNZsFh7HhrfO/ym7PPnw1wDIJAWvTQEDG7JhbRdeyKiHQuU?=
 =?us-ascii?Q?AiEP8pI5rtQXEDswE3VZDEWdJCkYvrJFNHVtC2zR8HoziOkYSbGiDol5tcnS?=
 =?us-ascii?Q?RfyENHX4uNN3C98WLjpDO8R7JM5umLza+eQgBtnAfHePaVXXon/SBpL2B+G6?=
 =?us-ascii?Q?txdZQW1TVUwu8ctae2oUS4SuHU+kiDokTKgs+kUDkH/caHP9olz4uojCwcFU?=
 =?us-ascii?Q?qWnyNhl2z+lom7z7Mt7hOv7t+Oqlw+e9n2E0ujtBRP5CLwc/AjVf5c+eOZCb?=
 =?us-ascii?Q?WCeFMBZ9PBl/budhFM4BaHm+Q8ly1iv+LMGWqdw+iBs7bhBEs6um6wAAWgBS?=
 =?us-ascii?Q?Rrh1SEZ/Aqdd/6gTSQ4I0QgxN+HCgP3ebQswC5GBSdDql+J/24Kf1ZpOmLwl?=
 =?us-ascii?Q?CwUbP/nv/A7QoatihiYl4FtyyDkauwPVF75alqG4cl9d+pjKzYJ8ouWuMDl9?=
 =?us-ascii?Q?HKdbastbfFLexCKUejG3RLzdY3trArqFLcdeQkOYDu5+o52pZIndxOAi4NXH?=
 =?us-ascii?Q?CQDjxE05RfmVT98AFY+uZyTcOWhYwIR+lIudCsNFgzMocp2hITEM9Imos79X?=
 =?us-ascii?Q?DD7ZeIts0H/FpOl80jjBKe30p3h2lWgay/+Q/DCd2xiW0alnbbzC52SS/haE?=
 =?us-ascii?Q?JrzranM7PA52uURpuleN60R9IY9sEKpH7U8MCpkH6y4H0pcH1eSwmBfIVWQV?=
 =?us-ascii?Q?MeaW2AL7+lr+YqaF2y0vjO3K2m0zwDItect2lWmYDSvbAmdPgun19wy1bmCn?=
 =?us-ascii?Q?TYRmUH8koZxg4+dzvp+sE8tT11pAG0pKPVuCM/WlUrqOVTocK8UxX9JbtZTw?=
 =?us-ascii?Q?XteaZbtCkzEWKetgQiFRYgJo2xSusGiossfpA89dbqi5QcVguGwz4VLW+juT?=
 =?us-ascii?Q?4vKqSuMLNLh6Jvck9YT9OHzBQgdvtpbSOJTfaJcaboq3pLhFJ6qG3lYHcTVp?=
 =?us-ascii?Q?sNHPIvhb7nGOzEgg7NqKFdwRgkjJAgat2e8xzYVIZ1f7RYHB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80b7eda-c57a-4da8-b3cb-08defc9cf0e0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 20:20:12.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRrnMQ4zt/Erw8RfQPCMXolRrC+UoyyEgonfnzAe4zK6i6GCzZuP+hxLw4fOzgmBlb3zEpNqwcttfQSHG+ES0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

On Mon, Aug 17, 2026 at 04:03:51PM +0900, Eliot Courtney wrote:
> On Fri Aug 14, 2026 at 11:53 PM JST, Yury Norov wrote:
> > On Fri, Aug 14, 2026 at 05:08:43AM -0400, Yury Norov wrote:
> >> On Fri, Aug 14, 2026 at 01:54:24PM +0900, Eliot Courtney wrote:
> >> > > 1. Provide a nz! macro to create constant non-zero things. Provide some
> >> > >    constants for common alignments
> >> > >
> >> > > Potentially, we could use build_assert! for cases it is provably
> >> > > non-zero but not a literal (although tbh not sure this is a good idea -
> >> > > at least not do this initially). 
> >> > >
> >> > > So either: nz!: const { NonZero::new(value).unwrap() }, or, nz!: some
> >> > > build assert gated construction of NonZero. A general nz! macro could
> >> > > also help ergonomics for other use cases too.
> >> > >
> >> > > That looks like this:
> >> > >
> >> > > pool.alloc_area(nz!(8), Alignment::AL_8)?;
> >> > 
> >> > Actually found that if we implement SizeConstants for Alignment then we
> >> > can get Alignment::SZ_4K etc almost for free.
> >> 
> >> Then maybe pass SZ_4K directly, and allow the alloc_area() to
> >> calculate the alignment:
> >> 
> >>         pool.alloc_area(nz!(8), SZ_4K)?;
> >
> > Even worse, you can advertise the function like: allocate a contiguous
> > set of channel IDs enough to represent XXX bytes of memory with YYY
> > alignment. And that way, you'll be able to do:
> >
> >           pool.alloc_area(SZ_8K, SZ_4K)?;
> >
> > If my understanding of the function is right, it would be a clear
> > improvement, because the user now doesn't think about ID channels pool
> > as a set of bits, but an abstraction over the memory access technique,
> > which it really is.
> 
> If we pass SZ_4K directly, we are back to using plain integers, which is
> not what we should be doing for rust interfaces according to Miguel. Let
> me send a new version of this with my Alignment constants + nz! macro
> idea, IMO it helps with the verbosity.

I meant that if you have 8-bit alignment and granularity, you can
create your own enum and pass it as parameter. But it's valid for
pre-blackwell channel allocations only, so not applicable in general.
 
> I don't quite understand your point about memory access.

Neither me. Scratch that. It was a hallucination, maybe somehow
related to the 1st day of flu. :)

> The purpose
> here is just to be an allocator of IDs, not memory - it's just that we
> have some contiguousness and alignment requirements of the IDs
> themselves.  The values we're passing in just represent numbers of
> channels and constraints on those. I think that callers will naturally
> want to allocate a particular number of channels, not a specific amount
> of memory that corresponds to some number of channels in some way (e.g.
> USERD?). On pre-Blackwell, OpenRM makes channel ID area reservations for
> vGPU power of two number of channels and and places them so the base
> channel ID is aligned to the number of channels. Sorry if I have
> misunderstood your point. Maybe we should rename `alloc_area` to
> `reserve_ids` or something like that if it would make it clearer?

Yes, reserve_ids() sounds better because the parent structure is named
ChannelIdPool.
