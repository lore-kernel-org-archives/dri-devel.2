Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B8C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE6210E185;
	Tue,  1 Sep 2026 05:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISKgdxrE";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013055.outbound.protection.outlook.com
 [40.93.196.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA18410E185
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyhUDbOmVGWSNCHTCZ+O3c9hhzuCi+3CGrB6pWjxBCXGhrT1MEWbJYTF7OxjDl5ISdwEl14up7TRuMDaVtwoP9APVBNoVF51MeafS825z2OO9yi/xQXTZK8C0Ip9ZGiZevR0Ojwirt/68e78EqK7CSuOdjpFMD8T+4MlgM7Ii52+mJMvOxUH16GSdGrJbMT0jG7bs/m9mFMw2Cs/a8HgV+C8BzyqOcNymbZgh04JCv+QGcyxfUYaZbpY3wlI2HHSNExvs7Pqc+DQWCga35SDE6DHybHN4/6JsfjbvHSXo9o/dMXWIGNWTQh2HOEaPE7Jpu3lzMjRvkxYEGVHIorEPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtR4lZfOGl7aqpZYBTDUHbuDmN/z+qhPGBBW0CkMnhI=;
 b=OlX9Biij9I2nNHb2W07O1hwWrzZ3FRDqK1uDmSAmZbpPzs20AaWjp5iNMzZgVrPQklVIyBMt9Ahaq57B6BH6QEwHAV21G0GBSeAZTtO5AthykkUCL87jRy2iZgnf0vSwqNAMPeloNhoIQ24iXWSW0a8MeXoZWNIbTz4mYyv0fZlJ7iaVhKNZ767XN4+Hkoiiz7rbZzzOD3Y726aYsCHMuyLf0Ss/TWVMt0tw/A3ViFRrZUD3+P627xsXm9rsAK7cs8G7OZnXpruuj3iAoNfjVqt/jLcOl+W40o4RoTpV02X9W64y+auFI1Jio/9wZ7FfrisCxv2kAdkk4casORJ7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtR4lZfOGl7aqpZYBTDUHbuDmN/z+qhPGBBW0CkMnhI=;
 b=ISKgdxrEBoayP6raz9RZBBQw2GgLhwAux1Ru7XOu6jzluiOk8haqQebEOZFc74e9dGsdNf/sx2TuNO0G2NXag5NjhUN8jYoxnw22+TmRTfdL48YpLwZ3vuIP8aD/tThl+yeg3PfVkn1nxLF79EAX4dQu+sbiW16cXCnUZpr6YJI3AyUTgirfvBh6Jck337VjrhE0aH7InonZVtjCCYV2IqJpdRxkM60IEQQDIc9Gz4rEMGtPg1zg5KMVo2f9I9tPeoIR7zAK1OYKghrScyqoJ2p/sqU2EqOxn9svue63YN0P8i3tNvXoJLPC3+WfPMbF2wfg8rtNg1I5A0LNdW+Bvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by LVUPR12MB999160.namprd12.prod.outlook.com (2603:10b6:408:3a4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:24:53 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:24:53 +0000
Date: Tue, 1 Sep 2026 15:24:48 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Dave Airlie <airlied@gmail.com>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apZeL83cEzPygI57@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <CAPM=9tw6nv7UbMvKOGSsZKKwoZwCG2hvwGk=JjmsxQcH=wGfqw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tw6nv7UbMvKOGSsZKKwoZwCG2hvwGk=JjmsxQcH=wGfqw@mail.gmail.com>
X-ClientProxiedBy: SY8P282CA0025.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::30) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|LVUPR12MB999160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef5c6e9-effd-4dd3-3c14-08df07e95a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: lAR8ZdArWZosQGL5n/Z1bDQgNOvHUvgwT6RE8KsmBJF2QfY0vubFp5OGD6D+OoNSTFDNEyO4NfgbZxIXvRMM4+mrKS9l31HDeojTGbd1JN4BWFWnzQV9JJ49MhgR8/uBBI9P8FMmLSQxdbhldPUHLNOOai3tv69eMXRW7LfdHGONKcUio80NFTLUnrNwHoKjUwU5v+ChQ/oXS6qN6yEiAWnSjqzWfTbgV2fGP6FSoeIVUdQ3ZphpqeCX0Xim5HFW+gd4yWKx36Ybx+xtuWUGi+/E63pzVRc69JwQSXfBvnOrCjiWQnv/XVy3YWunlFaGn/LtHyWpg0+WV6GOAixbIWGyyOysmZ/cBenIpwZQQZOsKYp8N59g5NIbdp6Wqn/QiAcQq6dwPhlhmqcTHa6fwplRTuDPrWLE0kYtJNAqNpSs4ErObI3J9yJWX4NTnaKvhnXjUFznaPA2DebPAWaPPKCMlcUHmM0rqzXcj1lDnZUSkj+5CsB3YV5CfVcUwrc0cE3wkRS0kss7X7fF2mwi1NFvN3wzwgOA81zT1m1wKzohwFgvjzpc0gzR5AJoK7lSVeovTF60A4E3sVR4D96YMTwtdf3yl6hb1KCZQOhsSKBHIX9e08MnK7fJAQHVb/xmoJ8UWeP8MZpkmZuwNO/WOL4eJSPz+2UvGv7zDKr000g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6c1wsOgURruGlRbAqABLjXudnhnx/VkbEKC23kC8yhA+bA65xSMMDNMQ1xZ4?=
 =?us-ascii?Q?TRSPW8NUAhzv/42/WUojSTo8alFYi2EHMTkIXrAabZcbX86ZMstM2tmm38vm?=
 =?us-ascii?Q?khMpgZhYy3fitHBmlUaoOPbO4MoAyutsN6GvMDPwnIVeoPMx6RhZDHyzxSKN?=
 =?us-ascii?Q?fgAb6QzX5cgzM7jeu5osQxrW7hrr2z1teY3mIvveCSxVC01KU+eJwEgr/14t?=
 =?us-ascii?Q?53iaxnjxDWPCEIfpzx8z2APIHToLU548157dahCDE+IcVq4i+VPQ81BhJZoK?=
 =?us-ascii?Q?qyCwz8zEIRHdVVzXguP2u8aZg+HnvGWoIrCf01s4b0ULnPsmVB6TSsySoEOM?=
 =?us-ascii?Q?8QmNctiiyO57MQNHcoESDTrstEFeRi7ksFVmc9ZZ3SCRVJwFcqEkT/R7tSGz?=
 =?us-ascii?Q?josfF61RzO7HSDH8IpIY2kIO8bUkuTOt9xpz3TGWwoEOUrbv7My3q9i0Wila?=
 =?us-ascii?Q?Vfqfw0ii0wuxxZgTMvWmmO4xGL/rP7cl7FCmdpg+woqVfbCtYnA4pGUaeFyx?=
 =?us-ascii?Q?ITxIxpIQmMZUopuqAvrpLEc0btNp7E0l1dHTJOizXGHQBqjAypy9O5NdowAP?=
 =?us-ascii?Q?/YUuaWYSaKp09EqMwRYTqzK62kNeQgq+esL1Su7qlghVbfL7FCuBuU+d6VCF?=
 =?us-ascii?Q?8nEp/BHZN/PTRA68Ul23vOvniwIhme/ZFG7s5dkYgChwKYr2pOU1492KYyLi?=
 =?us-ascii?Q?1LAvjvI2lUzloIWFYgILqAe7l2flTwwdeBjp+t6Q3s94itLaoE7Imfa3m5VS?=
 =?us-ascii?Q?wisdq3lWzRBQTCEqTCTIDdM6P0G3pOn12+UDgFERRsdTXGQugvr4+ax91mCp?=
 =?us-ascii?Q?U82Lhpb+NgF+8BDOsk4GqUrvfivgk1mrd7DV4ah3sbv+kkRIKuyhDG68R9ow?=
 =?us-ascii?Q?w3mJniAIHe/PTHfOLmV9ip4/Z/ZPmfvNKSvPfvcSKiffyuJknsTWnowZRwv8?=
 =?us-ascii?Q?udMxFqXq/+Jw+TdnGKDV+RM0zcSBxBiDRiAUqb7GxSc27JVfj57PtZ6AZSkv?=
 =?us-ascii?Q?/BN6um5C67nXGHk/7/d/hMB/a0drHzSjo1zRBC/U1GE97CQ8v7F+IYP1wyUp?=
 =?us-ascii?Q?KRUbjcbwdp3tY6tqAEtWx0wOECndj6UP9cSr/jl6qTeTgTuo9nE4q3rnrMYl?=
 =?us-ascii?Q?bfzOWufAze6F2Sr1ZJF60qe6UPdpC1Ka6wIiWxkF75TX+M2PCp3daARUSbj4?=
 =?us-ascii?Q?MCEIx9InaB4Ja8uO0yfOYj+lp+PYoyxoe9tejKMAhQgkynfphI8o4dczVT1/?=
 =?us-ascii?Q?WBtQmS4/c67dxvkNDXAOboUe+z6gHVRVsV3Zs88pyxh0a7HS2YEgPfBnrjEM?=
 =?us-ascii?Q?sn3cg9/Fmhjp0yUa/TxTc0Bs0I2bICrztJFHQ0AHqQ7ePQI2lVJA6TK4m5B6?=
 =?us-ascii?Q?Epfptxo75sBcpD4HAcL1CgKhInJIXOGI/GV4hFZJohoHAvRo4OwtRD9kWUKD?=
 =?us-ascii?Q?W5ZCnBcGvgoRI7gb2bv+49pI5u5+lZQHrhQx8CUkXi0ovDq+NlWUczlNF1Dk?=
 =?us-ascii?Q?BN3nuPzBKq4rUjCZNZTc60eHQ10HVT8XD37NPJOFB/pgqYaei0193SG/vDNr?=
 =?us-ascii?Q?A7QVAWcsy5Ebt1CM8LCg9DpGHjcaMhU+rWHYdkz4sD/68O21mW9yC1wym94K?=
 =?us-ascii?Q?CvZSYWMKwQf27Kd0q7ionMprJ6Z73+bOGPCX0jj/+YmHdPI8Qa+54Ye7G7KN?=
 =?us-ascii?Q?7imZOr4U88s3/ymiCVcaLUk3foA/wlmeY1lBaNo7XQkZQB+OhoxWNyTPoziV?=
 =?us-ascii?Q?RtSEO6KY1g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef5c6e9-effd-4dd3-3c14-08df07e95a16
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:24:53.1098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wN+r0fleMfzbQroQs/yRBSYx7o6VaCbASp1xPNWUr2QGMYYABso8Kv26dRdOfhGtH3axXaihOfsZGUsc8/uOFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999160
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

On 2026-09-01 at 14:53 +1000, Dave Airlie <airlied@gmail.com> wrote...
> On Fri, 28 Aug 2026 at 13:36, Alistair Popple <apopple@nvidia.com> wrote:
> >
> > Add an extensible info ioctl and use it to report basic GPU information.
> > One of the first things userspace needs to know about a GPU is its
> > architecture and implementation, so add that as the first field in the
> > GPU info result.
> >
> > The ioctl selects an information type by ID and writes the result through
> > a sized userspace buffer. The kernel truncates results to the supplied
> > size, allowing information structures to grow and new logical information
> > groups to be added without introducing new ioctls.
> >
> >
> 
> This is a higher level for the future, I think we have two paths for
> getparam type ioctl.
> 
> Either we expose a big struct full of values with a add to the end
> mentality or we keep a long list of value pairs, and userspace passes
> in a list of value keys, and we return a list of the values.

There's already been a fair bit of back and forth on this on this series and
this is where we ended up - a bunch of info ioctls returning big structs full
of values.

I did wonder if io_uring could be used by user-space to efficiently pass a list
of value keys as that's trivial enough to add to drm[1] but perf wise didn't
achieve much over just calling lots of ioctls, at least when I tested with a
mock key/value type interface.

[1] - https://lists.freedesktop.org/archives/dri-devel/2025-September/524469.html

> I'm trying to think ahead towards native virtio context support, and I
> think having the sequence,
> 
> open
> get_all_infos
> create vm/channel
> 
> might have the most optimal ioctl count but also let power management
> avoid booting the GPU on every open if we never create a vm/channel.

Power management is a good point - thus far all the info is cached in nova-core
anyway so there shouldn't be much impact there regardless of what interface
we choose.

Thanks.

 - Alistair
