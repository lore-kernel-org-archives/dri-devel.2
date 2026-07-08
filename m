Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC20C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C9710F2AF;
	Wed,  8 Jul 2026 20:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBNN4zKr";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321EA10F2AF;
 Wed,  8 Jul 2026 20:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocmFHMVUUfwbX6cUplugbsSKBmss1104xkHq47ohsM6X6zZb3o6gIP5rb7G7iA3ezkZqWAHPv1GjHp0GbhpJokRrPsdd6mjRrGjkx+ue/4NZ+UVzH5Djb9Z1MRBt3VB74CDPAwrH8w1UjAj/M19uuISLuX2OQZ6Lry1AO45Ex0m6YODonmLU960XJKuk1kAWhjNzdm7ex0/KheREp4s4wBYh9EFZkpEiIK7OVjGTqRwWweQX4iEem+ik4/Q26pBNNUJe0cZHms29Bp57TWK4beoL9JNeuBkzx+55gX22/gaQgxCfv7JoJudIAo/Iel14lWRBdyenu/IwvHful1YcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z751E8LzH2G0qFrVNhebmggZafYiaXmFV7HM6xuBE0w=;
 b=v/0WYDA+1R8OnKnuhYYkdaR9GeJO9rczsf2woQz7rKGPM5Mj61x9qwc6BgvW3aovbJaKDM1vQhz7vHY1zOjOCTym9op3eRlfW/WhYMtPdGefhOTniqJzR9chOKtki7jMP+FN/GStleNyujLR+1gmoKuBY30MLT5Ps89sNKQZfROjbBpnRTuGlLNWuwutlFd1DC22f6erfHF9PmKYQjAfBZVC4JLlB9ivKvPjQo020kmGeD5kNHbEQMGFRGozqQYI90E7xmp7m/L4pstIp8zDy0YtbtLNYtaOLAiEXYG2zyqlmqxpEKf+SzjaIJ/ImgG0ePK31wICr04qGBPG/2XuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z751E8LzH2G0qFrVNhebmggZafYiaXmFV7HM6xuBE0w=;
 b=MBNN4zKreR/vxa4DaQ2moTHZwW8Buoxvw5pQZeXwrKR6NpIyYiRwLRhqabXVDx3z8rqkiCi0h2DbFMfY6rCnLkq5F16eNzvTmARLsfOV3codR2KL3HbBSg+yvWChhYSnqfud80aza4BbWcChrPpNSNQBePkrdHO0h3RFVbhFluFBlf3FQ1FFwPlplSJvB8a6BNhBsBn2+bqD9nLEteWWzucSLkLXcbsmMirH2yoAoYBo56wTB8ZGZ3+CatejNtyCmVmtxv6if/tOzRS1rF52aEeG5tNcDKgitFyaIV98UiX6tA/Vst4stAeO9rSf4tB0mXFXGpqvP6q2qY7OPRlMxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 20:37:39 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 20:37:39 +0000
Date: Wed, 8 Jul 2026 16:37:38 -0400
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
Message-ID: <ak61Embrj0qH1vas@yury>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
 <2026070839-quadrant-gentleman-2334@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070839-quadrant-gentleman-2334@gregkh>
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bd1b02-677a-41e3-e1f2-08dedd30c0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6IimAm168xkeybcIFtOiR71ul4ynEmXLloOuy00DuAXXOX8z7a5zYGF+tlTO5DdJUJUetbCDubD6n4Qc3B4ZbX520xymiD687VUzhcXbQJ/eqK0804Xjfr5t5in8IgYuyi3FXvLiCKBJcr3cbsdMnEUlGB6ApuI4pktfOB7X4wnKPxRD3pFEETR10uorptjtuv/kzuIsOqYZvQR9WFozy6bgEz3Ftpy6vgx69SXsnsvagZppjyl7XhqDhUrqLuGDE1pn20wO0GcZ2UrfpGibo7cUwpLQZfRjWZOLNphXMwqmiRaCx/50KxB69hPT5/XUnEAeqWTYR1HMqPadDrDjOuVGK9EZ4cFVWqxMVhhAkYnah52j6pO7fQmf1yzdZtYpIhm0upI+sJj5SGhplX8oyW7Q64X+8ZvwEcojYykWWJsbWKO4U6ty3d7kKzs/jqDDOL1ztKQJtJIe7KwoPe+RNY6hcZurRh1X81dmiTFSLmHqkpGANQ+xNvlZvBT/1UUIDSww24aWkroPZZxq0K2nj2jx1BXo5RHDAGPGRwR7ioWp5GuazkAIbBnR+beQ8dhnm1uQBqea3LDnyPBEGERYNJaEN2C3AS09906GxzCaPIgYrw9amyeqlKwZj7sQ6R3kxFq9Ny543jOFcIMzjm7kQvybnxm8f6Iv8NV3oOiFRaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8FHoGb6SK8GHE+nYN1bMZHHM3Tl3QoBhUhxXfkr6XDmTKPhqYFEN6P799nJ?=
 =?us-ascii?Q?/40mmB+xEf6bpmbkyzJwWU/wsyxdU8ZjJG5lZiTj1itzWzP7378DeDhusOPM?=
 =?us-ascii?Q?BJv8uWlZ8InsHDy8A9hv9wpk42pPtx2V+THJ1jwJPoIuxZtGl5KJUwP72zOh?=
 =?us-ascii?Q?m3OSGjKEe3P9miLkO/8coR7V81HhbmAiN16JX3o1gg/3y/d/KOe86fc4smvA?=
 =?us-ascii?Q?bIXxGZAoqBp4X/Tte9S62bRnP6222BgtnNDD8cvGHbjSRUjy8C6woTxlzcaT?=
 =?us-ascii?Q?pAq3hXRSe+xnpq5SnTpdc/ZnYGTWhyCz0IpGuYWAoNp6Q+gHNjPTu12Y8pr2?=
 =?us-ascii?Q?eIwqzUj2hD4CMPhIA1uyYdJcBNxts9dVZ//g9zg2uZL5YXuBMHmA0XNfWLsM?=
 =?us-ascii?Q?uu7xj/BiRkfDEnq7zhMCm6nETNhPbiWj8B5NgUmxkoeAwkLmEKdn+IBYj2Es?=
 =?us-ascii?Q?cn8Cd1SGLAqmVyNSxe1Gb35yKQHLOvXDvkGfS+FCu6pilt8ZqLHI0+Ek7xyq?=
 =?us-ascii?Q?dTrcqBUbyWz4+b8oLqGbKC+yT+xvHznpJZcvQlRIHRKHAMFV1H0HPOWj2aXR?=
 =?us-ascii?Q?Kjc92MdNYs41W/kBGobgx5FP1P/aPNV61Ef0WXS5pXk08QUclj5w8L+dxX5Z?=
 =?us-ascii?Q?+OoqNSK7fdgrHFSaGU4OcyuYo2e0eM08Y7GR3n24MvsqiZCeA/QpCPLOqnT/?=
 =?us-ascii?Q?7sC4jKUjxx/pixdFKM5mIZ8TzOn5deuM/tdwoXqCoOxLKNipvQHeszqnFwdh?=
 =?us-ascii?Q?bY6/x9GzrI5e0wGkHilUi0LMf1zGSwZYyKhFIY2AtR+lP8AQwU72J9Owu6X/?=
 =?us-ascii?Q?vZetAtRLonEpd+0i8r7KyCShR1JE4zFZ0XkM8ZXmfxMsKb/S3uFS14ZoDqAp?=
 =?us-ascii?Q?HXRBVyJal6ua8ipHvbzs4hkBIDoZqqtTHFm6GQmsI6o1/hb+QEOQ6PdR84oK?=
 =?us-ascii?Q?e1QjvqX+Z32sJz0nkDZEfNnO3GGSl7VA05XjvOtGPWFXqlHfcg8JMrqR1MDV?=
 =?us-ascii?Q?w35dDpZwH+uluhQewP6LKgmSfiSp7QiBhoHOFlrAgSX1W3xfE10tVVdVk+Et?=
 =?us-ascii?Q?3mO83faAwsgGTGbwvgKcVnLa4zqHrcM0J9hfUImbVyWA063j1i4DdKgvitA7?=
 =?us-ascii?Q?4qKzSyyUrt9N6A5lGq8pmoY/xcKtfS7v/b5rM0tKs05qstjith4RTwd6XzGw?=
 =?us-ascii?Q?8xSNNqr17y3bFF6XCZcET9nA5okl2L+lkXdvHFpjKaIE/2ImEYDmcTnxlCiF?=
 =?us-ascii?Q?qXRNKE9GZT0Qyoaos5xKu4Sts7+fr82GiTie7PkxJLQWBMolVfhK6gOz6Pwp?=
 =?us-ascii?Q?7p3wOnZMlB8VtjFdmt6J7QPykgxGcvc37uQAAHf4iQXUAfT7AtC0TKAcAx5T?=
 =?us-ascii?Q?3eael+sWPwfMbxXJYf67Iyj/hOD15PyJQcIE6V0AWwmO6QzbZKTKkdc9EQnk?=
 =?us-ascii?Q?d3pEtm1zRFK5q6NEx0uN4qi8if6tEsySwbhkUeYpPXEZGJiPvGyaWR7avOZR?=
 =?us-ascii?Q?MBW7XzFetOEYub4fzCFalPLuL52iCfSXU/o882C22kDT51fFdyy49tdZDZ05?=
 =?us-ascii?Q?X9w/B9ttCz/d0NNIqnx3cmukM3Qod9x7X0j16vXEdoBcKohCgux2LGCXP1DV?=
 =?us-ascii?Q?rtPl8N9LozuKeIsdMQmgWFs0UB1ggETWNkNcF4rqOr5hIfO+tMUO2oiPv8Qc?=
 =?us-ascii?Q?+WOvW1jSZhTHej9IHrhsakRN3SXwZDBl9bbLILK/bK6/dTJO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bd1b02-677a-41e3-e1f2-08dedd30c0c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 20:37:39.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvWtObSdFs1FWn4ISKD1rIBj1wFBXa3GVUwOOT9+G5ga++7x9JuYAr4Pu45uAC3c3pkUUjn89w8Ro5GfaQLNlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

On Wed, Jul 08, 2026 at 07:33:16AM +0200, Greg KH wrote:

...

> > I asked exactly the same question when Alice and Burak added wrappers
> > for bitmaps to implement their ID pool. This is the answer:
> > 
> >   An alternative route of vendoring an existing Rust bitmap package was
> >   considered but suboptimal overall. Reusing the C implementation is
> >   preferable for a basic data structure like bitmaps. It enables Rust
> >   code to be a lot more similar and predictable with respect to C code
> >   that uses the same data structures and enables the use of code that
> >   has been tried-and-tested in the kernel, with the same performance
> >   characteristics whenever possible.
> > 
> > And now it's in a commit message: 11eca92a2caeb
> > 
> > They measured the affect of their wrapper on performance, and it appears
> > to be ~5%. See lib/find_bit_benchmark_rust.rs.
> 
> You are comparing the C vs. Rust data structures here, which is not what
> I am proposing.
> 
> Also, is this code being used on a "hot path" like the binder stuff is?
> 
> > I didn't see any side-to-side comparison between any native Rust API vs
> > imported C bitmaps. I'm sure, I asked for that, and I still believe
> > it's the important piece of data to avoid this back-and-forth type of
> > discussions. So, Alice, Burak or anybody...
> 
> Again, I'm not talking about Rust API vs. imported C bitmaps, I'm asking
> to use the C structures like maple-tree and idr instead of open-coding
> logic around the bitmap code.

I understand your point. I asked both questions: are they sure that bitmap
is the most optimal data structure for the ID pool, and if so, why not use
the built-in Rust bitmaps? The answer was: yes, it's the most optimal, and
using built-in bitmaps is suboptimal overall.

Burak, can you share more details please?

> > > > > Why isn't the built-in idr library being used here instead of rolling
> > > > > your own data structure?
> > 
> > Now having more context, the ID pool's primary goal is to allocate
> > individual IDs, which naturally lays on find_bit() API in C. The
> > native Rust alternative is considered and found 'suboptimal overall'.
> 
> Allocating IDs is a probe() thing, which can be as slow as it wants,
> right?  Or is this some other hot-path where performance matters?  The
> patch was not very specific as to the tradeoffs needed.

I am a bitmaps maintainer, and I want them in Rust to perform equally well.
The ID pool case was just the first user. Even if bitmap performance is
not a critical path for ID pool, my role is to make sure that bitmap in
Rust is implemented well, including the performance part.

Said that, I recall that bitmaps performance was important for the ID
pool, and Alice and Burak spent some time optimizing the ID allocation
path. Particularly, added a logic to avoid allocation of small bitmaps.

Thanks,
Yury
