Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7887EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D6A10E4F8;
	Tue,  7 Jul 2026 16:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubttmP9V";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4806510E4F8;
 Tue,  7 Jul 2026 16:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJcMjOVM8K3bzDz6svNIdFd00P3p8cArKT3zuYS2G2ARI+PynfaZSUkgCol0jxJzO7QhsUKL1teIuB6ZsmpCMK5xRLRi7MejnrgZ5GxeD3ws7xOhP+T6EKN+W3zVYYmgSs/AcZlY0KvORMIh0VYVVffAVLYRgLac0njGDV2qTq2J5F2/pNfUNCidWQsZpAGUdSScbkaXRbmOn1SIS0U/EfYg1L53sXEXfYJ9An8XdOmb3xC+aFaOMr4gXPoJg0Wyq19AjdSBD5w5EOvBZ1q+k7ZZe+MgOGTtYCr714Sj4v7MuTV4Tf9LYkMVLD9EXwDfE9Yh0sCJkfJ7iJ2mLkV9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXU4v5rcQJY4Z8pUE8wrmtvSptma50KtyUmN+NWkDTw=;
 b=l6qU2Or8lK4GCt7PGXibneieg1paZHJ4sMPGwE59r9NVXnDZAkWcn7AwU74tU4PoGPX0KT4ZD56Fz9K5Rn65nwVNj+bDpBWPNnXQ6+FSDGcx21mLho/uDvQ8ZT+oj7pZ3u1wBWOMGm0ppkI3DuyPgsbmRTtFZ9MOO8+cqO2PAxIw+M9eH9T15WrvCvr7cHXGDZpo/HMPEn7iYxE6lnprL5WXi3UcMUIEbRuiAgnbNlYyhTWyUcuzPp8AYP4d7shdkvYahiGLZxBYZxQN3hUSNektUf51ZAuh8rYGP3/IHSnNZlagEJtBOkj3Tx/1Ewj1F5oqGmoRdIx9La81e7AKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXU4v5rcQJY4Z8pUE8wrmtvSptma50KtyUmN+NWkDTw=;
 b=ubttmP9V/6Vbe6wxDbLvbnu/KVyAfGnVHuw/dJRSd9jtveHz+sNOWs+ByoJy4qp8Ykr2sQjJGlx0FVGRafBvLxqanmAcMNVJI12ox+B4ZtIAtS9KKMHN+bO9K6vn9LTLcjn21VDOwf2dgFj2oQ+MEMNpqKeBAAAZmv5db2QvQX9pIqxpJEaeCeDt7/cVTDzxCQxy9SkMuT5tPtYcnfPSEGPhRB1ZLa4baY46qHL2ImoejSDey/5NKK/VfdqC4vt2XVLeJd5esK37C9RrDG5O7849DCq+t9kp6q7WcM6h2kaXnbhh1wFhMgG13Ttna3kLigDw6eE4u+Em9Xfs36OQsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 16:31:10 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 16:31:09 +0000
Date: Tue, 7 Jul 2026 12:31:08 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
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
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
Message-ID: <ak0pzDc69nAmnviD@yury>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070745-unwired-maybe-769e@gregkh>
X-ClientProxiedBy: BN9PR03CA0404.namprd03.prod.outlook.com
 (2603:10b6:408:111::19) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 9684090d-7600-47bb-1260-08dedc4526de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Tc0rf8FeUAb3xM4RahC4fNW0ILHKaIcvLlvAdjDGtoDYQ/kcihMrXSXiJzaO2Fs9ioM/s3PIXvzZGzVcIRywOAU6YGxF6W0FYLQxMh11Ep168RFJsCY8jDraFtNyFmclPfNQ7lmuXkWxv7Fk5OwVf+IYpoc8LqNRxLBZ6BBsjtEG3SWly/T9ltoilqOvQz0HFiHQdu12ieum3/UObCR7q4ZYpoxCW5Ooc0Ea7Z0P0uVEthE5X1Ca1CIZNV9vLsfdo42MDFEJr250nX2XXLj/svCclD5xHlY1E6jkRf+1YPMaAM3Llvtd5F8Pvg8nV290+e37p5AtlHVppzIHMheFuj0EQGv6MEP/8ZaNv8Kg2vrca4DFcb9f7dxWnWfrWYnKoPtCLC9iuPE6OVho6yo01O3//+DgrSXW4dMi5MobUCOHB+Kl5obBoL3UY3jHb6KVn6RP8qkcHMr2qOsdE5H2olIlrk2kBdX26/ILyJTDe9hr5ug1V7VBY4vQNYJo6CJZxS9YUwYC8lmoFJxsAnYSvfl506XrdZlj6C8TaMzjpzceIVK4vG7wia+RuwwDPhd+748xy+1+4jKTA1Yd3FLelgYPh2QTJrfa4/BcqcN4nyUSx2sTCWtF65giRM29LxcOGY3q9hfeX0yYZjgLCnxN7yzsDDWIDrLjaLPMtS7S17s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uANI+g7v0VRbXkGsveP80C7NkwALumbbru4LlnMx93OVs6nIiwKzRh4xvjkQ?=
 =?us-ascii?Q?P6xQRd4EB/kU9TEWQDIQWGWlbxw5J6PfPg9Pj4xKOHfdBZwYxXrESJj98JSe?=
 =?us-ascii?Q?yMQmGL/RHzkW2dcNozz1xgcRWSAi0Ym6nXrZhYq16S/EnuCzD6gILfM06PBG?=
 =?us-ascii?Q?HWzfheU0UI3L1jhnyhloCgB0b40mWCS0rm2ZiIUQfepHmR60S1J6KdRjfRbA?=
 =?us-ascii?Q?pmK/gJe7z0ikgaZs1ObM158dZNqbA+MReua9M5h/wUT3itz/aD1/Wo+1gf9y?=
 =?us-ascii?Q?ERJVgVgiiRko5Rv2E/gYg2R+GQLU89KEGEF4cgeGL4dEH0MPcKmnpao5A3fI?=
 =?us-ascii?Q?PccdoVoNw6TvEaj166dxlyow6acmULEFBlAu7WVXj3Dqjsa2K0JbhJJJXvkt?=
 =?us-ascii?Q?X92Qui94zPWMw6MS4NZWLQSmm0nb4pGqsKeXCHL1kngxcauiqijfykpnCqVZ?=
 =?us-ascii?Q?0eWztfLOwQ97/MhhROL09wcnveTCpRDFU2VohlYogRZWBYPtrbjHOFx1ZZ+E?=
 =?us-ascii?Q?2+JlM2eT/uKXILQ/+5tiMHvgtHu/SFyffMAqdl2Y+JqvGwHTsAUUGV5ZIPEj?=
 =?us-ascii?Q?uzWzs4M+KUosZ1BatLo6XTF/o0UQRz0jpLOJBiv13OcKAkcBMll5R27nClrg?=
 =?us-ascii?Q?ph/YLtogN7MZN759IUHxZmXN9T/pyKTsrjVCo7I5yv3m3KoM1w5RLBBGLKb6?=
 =?us-ascii?Q?8B8ZK9HEj4w/NAh+A1FJ1kHIG7cMpr3KHeN00gufprS0Oqzkmwt3F51bBS/f?=
 =?us-ascii?Q?zyPAa/QCSN/336xWRvAUBm3WHpdEFKybwYXgndTp/jgyq+NIGzpRtgymMfwR?=
 =?us-ascii?Q?81Fe6xbnLHAv1xoy4M6RPJJefUQmg9eWwfa7A3DnCEg3upOLu0yn5dvOHQ2r?=
 =?us-ascii?Q?cN2S1Ph1k6EqmnkDZgnpy4eooxy5ehBpsY71YEZreO0A88hOqxh2zH/imc3X?=
 =?us-ascii?Q?EzgEalnu8lwcombWLVTNHU88vXClvREvia2MoOqI5ny42owNwoDQXnYQa9FN?=
 =?us-ascii?Q?XRIJABP28Eh9mb8ho7EELjlWAIEPi/Sb9Prpxv/LHDcJ46J5bGDDwi4twjSW?=
 =?us-ascii?Q?JJqhIcVnIFeb3+VNSTBCj5BeiQfMsT0rQic5PzozRGHVp8tnoPn984eAB//l?=
 =?us-ascii?Q?8r5C6WRaNAgVilKwX3DxZPFFdsF5/wf7+DoTjmSNeeUxgMdcr5kA1rphXlDA?=
 =?us-ascii?Q?8X7AS9HvX1l6HCp//filgyuRydGayNgo92pfgxySpxd1jlqeKt6awxcPSZjI?=
 =?us-ascii?Q?VfWa6zRypuISay5agGoRKbtX+nzzVvrtRQG7ZWPiP3wOr0G5k0gHgSL97+BJ?=
 =?us-ascii?Q?HkC+KG9gXhjb2ym8Jo8hHEGMyNjnlImbBSYDX7y3qSXqN+WlzryIO6P0oOdX?=
 =?us-ascii?Q?zzQKR+5GlE8vAJ/MYY9AG3CzCpioBefVXZHTSbdG7vGhwUj2FY9/4Dvj0oIF?=
 =?us-ascii?Q?1JGd7x4wShBN0Zzw7HfvD2EGQyUA5NtQxE+s2LLtHtWM2NcexmBFaRUc5s2h?=
 =?us-ascii?Q?43+/wj8ZHWsaK4571tNG/iCLIqHmDKSBF4UxPfIflnjce2KicvbYDRA3v1i7?=
 =?us-ascii?Q?9SmO+5FqejymLHRWQ/4vB8t4fwyN1x0sTYtYuE+FSNfTkNRGz0ci6YWlO7S6?=
 =?us-ascii?Q?NSOMF64yirGBlyabDmR8R6MQV2LZEttCdRyH2svf8HanC4hG0B2y1yqXx4kF?=
 =?us-ascii?Q?tQMnr4E6Cw69Vwfu135Mgk1X4FQFXoerbxkOcMq0sQZpYTZK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9684090d-7600-47bb-1260-08dedc4526de
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:31:09.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKX7gIVgaBQanWIzbZ5HXSfLew8ctP2Zgora8mYQyvWRx5y4PqLdV7f7BcIXqZT0HOCanq4qOiNw2tI9ObmYSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

On Tue, Jul 07, 2026 at 04:13:30PM +0200, Greg KH wrote:
> On Tue, Jul 07, 2026 at 10:25:27PM +0900, Eliot Courtney wrote:
> > On Fri Jul 3, 2026 at 7:31 PM JST, Greg KH wrote:
> > > On Fri, Jul 03, 2026 at 07:16:06PM +0900, Eliot Courtney wrote:
> > >> Add support for contiguous area allocation. Add a new type,
> > >> `UnusedArea`, following the same pattern as `UnusedId`.
> > >> 
> > >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> > >
> > > Why isn't the built-in idr library being used here instead of rolling
> > > your own data structure?
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > For nova-core in this series, we need allocation of a contiguous
> > sequence of IDs with a specific length and sometimes a specific
> > alignment. IIUC, IDA/xarray do not support that (I checked
> > ida_alloc_range and it only allocates a single ID in a range, not a
> > contiguous sequence).
> > 
> > For IdPool before this series, I think it could have used IDA/xarray.
> > See [1] where Alice has posted some more context.
> > 
> > w.r.t. the structure choice, the IDs we need to allocate are channel
> > IDs, and the total range is limited to 2048 of them, so IMO bitmaps are
> > a better fit than e.g. maple tree.
> 
> But again, you are having to "roll your own" logic here, please reuse
> the data structures we already have in the kernel for this type of
> thing.  If a maple tree works, please use it.

I asked exactly the same question when Alice and Burak added wrappers
for bitmaps to implement their ID pool. This is the answer:

  An alternative route of vendoring an existing Rust bitmap package was
  considered but suboptimal overall. Reusing the C implementation is
  preferable for a basic data structure like bitmaps. It enables Rust
  code to be a lot more similar and predictable with respect to C code
  that uses the same data structures and enables the use of code that
  has been tried-and-tested in the kernel, with the same performance
  characteristics whenever possible.

And now it's in a commit message: 11eca92a2caeb

They measured the affect of their wrapper on performance, and it appears
to be ~5%. See lib/find_bit_benchmark_rust.rs.

I didn't see any side-to-side comparison between any native Rust API vs
imported C bitmaps. I'm sure, I asked for that, and I still believe
it's the important piece of data to avoid this back-and-forth type of
discussions. So, Alice, Burak or anybody...

> > > Why isn't the built-in idr library being used here instead of rolling
> > > your own data structure?

Now having more context, the ID pool's primary goal is to allocate
individual IDs, which naturally lays on find_bit() API in C. The
native Rust alternative is considered and found 'suboptimal overall'.

This series extends the existing data structure in Rust for Linux, not
adding a new one. So, the series itself looks justified to me because
it's a logical extension of the existing functionality.

Regarding C bindings vs native API... Yes we lack thorough performance
analysis. Do we have such analysis for every data structure in kernel?

No. So to me it's as simple as: they are developers, they know better.

Thanks,
Yury
