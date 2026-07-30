Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81847C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD27F10EED4;
	Thu, 30 Jul 2026 11:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="B4JZm9Iz";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDFA10EED4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIPagjjkIe8PgfZt/AkqHswRssNucfTAkmJ/hn1+zly6RGy/8GFoqkdRWE/7+7vG6TL97RB5iOM1o+wUJhwTEnhysV0qAzsPDNyt2LKLi02R6ic1xmInd7gq7ihiyhDSzVW4oCm0J5Oh6dk4jiVEu2o3OGvOm9aPQA1XJNqYYN68DMPAv7AXdbNKMQFn6jT+sReVReOIr1S/GW/MI3727FSnRJypljSt5LS6XZNepjA2j1BMTH/zfP4LP5lXcFL/Y4Gju5dkRnlwijiLAqodlgEHRM23SVmKasHaTtIt1a1CbhLUf9pyPK3oiUECJVesrutDJDAzw2Xsym9vEfn18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR9WwBkJzrbpDgiWeSj7W2y8BCQ9JWYN4OHDc524HWs=;
 b=x4+DEGGZW6oLWjy6MKzqLdjpe9/Bcj7O/F18YLYWaySDEkQ3jplQWQr2PwhU21C4oxigCMNSeWSW/U4lUuCmop0Y8+uMNBrfRq6vKgwCzsSgaGrA9N1xVnl+ZakhAAVye/8Z+WIDy3WSl6YCuZ8EMCGyzCgXk8cPSAS5MVK03zymn6bZRgtDc1x4E4gOmifzOk6yQ+WDoWu0pNvwgVdwBq+I0C1M7OzwyUNqDls47lSXqAFgvP6O5VcNpqvTl1IqAC8xouh6O7PcQ6TuERAcOnqMeWGPVt4a/54MjnfNHj+k7X1hbsIV2OQWfIK+1JVBOA1Ac/wBpDNlClz6TwtYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR9WwBkJzrbpDgiWeSj7W2y8BCQ9JWYN4OHDc524HWs=;
 b=B4JZm9IzwrxK9piMJhrMANp37g3GgbbjDXul9rVPeyjL2qWeRdYMm6QJMVBgK1gmyGVgBwdlUFKL0pHjv5c4IaCu6h3bxzePp/vp/APvXIiYj30qgf1vYRMGa1nxflRnSqT2gclyWI7ypR99CLrppY1LVzFxC5ImezLfCTumBBfr6Gn2jRigJHFvwqM7+MBobBoHbegMYh+qEasO/CoSNORSjMyi5k/PEdxrZ5cd3hKa/z7JMKpPGiXNi5l1IFopt98B2Uz5aEuC5yPZtaNx0M+3ZR6ZplpHpILYV4c92DIyHdDNwbhd/fdgnlGPcOw+Mwa7y1jb+Q3qpCVXKxjBoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.13; Thu, 30 Jul 2026 11:46:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 11:46:26 +0000
Date: Thu, 30 Jul 2026 21:46:21 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, nova-gpu@lists.linux.dev, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <amsx2tAppi1OV28C@nvdebian.thelocal>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
 <amhdA35CcMD_uY2f@nvdebian.thelocal>
 <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
 <57e2b956-89fd-43e8-8cb3-a15aee272660@nvidia.com>
 <DKAKR85QX9UM.1VYAAL82QBWJ5@kernel.org>
 <ammyfspYkXOwMsdU@nvdebian.thelocal>
 <DKB0L93Q3OKI.26PNHHQOIF3EH@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKB0L93Q3OKI.26PNHHQOIF3EH@kernel.org>
X-ClientProxiedBy: SY5PR01CA0057.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb441fb-a6b4-4a18-b161-08deee303017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|3023799007|6133799003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tdpLb8ixnSF49vdMJK6Vw0emOyRJ30QFiDEtOKLq9e/jphm+0lVtELvMCeUomFEm0+4oKAG3kM5n4gLDqhcoys2V796lETTBNb+EZnAWI45uNfzzOxuvUwiyYSLEtGzn1fFLn0untTsd1tvy2yrSAvpNqY/+Jrtr+oUuX0fDVky8kKSb+IE8lQdywjqUJpKKXRuxQvdJTWrxo09BbnM46EiN77hAQxVt92gXMIpnzCo9Dd76Cc8n5AZJQzrOt/dlMLr/s28Mnvszkh+Rw2T+5dpvc7ElVaMwdMcyvFZ5twbtp9N79kD2q8HxpKOmRd9Ifk2AzyIqFw65iPa17w2idXBjbj8bhgqvpCV1TV19P/H+bm6yCzvF/cvk5FOKqyD4a5ih0H9Ky4J7uHYXvkfEfpEAdni4Yd0NYNu9vgKwBuECr5MMz6q165tNd2OH3J3A95HYm7QZOOt/xDl1ongGoxDVxi+EYjZ7VYvBFs4OhHsVSLSbMCJaKjltkpowDcTKQ0slP94fFxpJLYkFH6UAcljRwcPRcKFd/hwrrhP7ZKrD3SsSkvtspk9+bRYcpaH4NIeZiTkyaLPkTtjk0iD8ZRFhB2a5NIzfuFqX4g0LJZmUwIW0TABjQ6RRlWazyfO5peW+QW54Le/QkPfGDRmdOhD6FizeXKCU1/hOHeFcfkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Encb+fSpSPCmJkR87/AFMVjn4rSbmofZVWGS6ghIHYb9lwTwJJAT/od3waHA?=
 =?us-ascii?Q?f+L5qc96qKNh4h/QP8MlF3qGtAov86nhl3Ng9I/sZHaU74MTsM+MRJ6Obdjr?=
 =?us-ascii?Q?GrUDCJtRFL5gE66wfexhbKzPCqmnt7G0qugEeAbB3akHu873SJzGFxtRe1kj?=
 =?us-ascii?Q?ENLH3lW++uKA/adofCC/zdDdnt8itQf+UVvWgpFFmq/YU6I/Eft8gvvDcy1Z?=
 =?us-ascii?Q?FI8m6Ej2VuGqo515RfTR4OYa+U9NOMV50yS3Lbddqk2Gh8DiTq4ibJfePkQB?=
 =?us-ascii?Q?I/o8fP1guj4eqjptxuQmeVbhtgnLEkyyvNajEl3/2zCHcxvLse5ppsO4g5oi?=
 =?us-ascii?Q?lQ6MK9j2sUy32BDp9u9gFvHwYxDU1H4csIvNWDB0RNXoiPn8762N2jvWaICa?=
 =?us-ascii?Q?m/3hDv5qMiVlvlbVsv3H5chugT9bbeXgoqY49v9jgpkEm6mjllOaQTQ2RdEA?=
 =?us-ascii?Q?0yyyKEvD6VhZ9GhKwQTuVeCHH87JFK4Oz7CgqJ36U70RNdd4uWG/Y6oc5clT?=
 =?us-ascii?Q?426LnL9uc4XudVu2WgAfMiHUAChus49i3MIF0Rsf9t9P9UGHhZfXQ1/xs7/X?=
 =?us-ascii?Q?4HGtEr2xJU/5330U3BYpAEwcYaX2cwKPpYu1hKJJhzqbEO0gcNyaItVo76VW?=
 =?us-ascii?Q?IwdYUi9EVefG57ANjD7C3/XSwCIUVHO6A5Nh79qHiArb/B7FbU67WAi8xo2x?=
 =?us-ascii?Q?T2zLPEQb8LIgfTgLz+UGP1HZzgRGSF58o6yeGTtRkoFDPTptGQyAbwknkdbT?=
 =?us-ascii?Q?mJv5bLvFhQS/Zoj115mulbTtCscsS02Mt4tU0HtMnNgrJWUI9X12qG4o3UGF?=
 =?us-ascii?Q?PdIiCl3NyOLPeZ3YaOGyYJrA4likPM8IT24JAsR3NbE7ui+0okFL6uGh11MM?=
 =?us-ascii?Q?7/mkUQmJimJFp42WNLsVzhvNEYuVuNhIahHs1J8SdDlMUe5GKszXjKhK/Uqc?=
 =?us-ascii?Q?NOnZVmfyRmmbTQDC0gXog8S2AfTcjTIZ6fmzc+vJQRHk0/Jr4o3ZOKVnGf2I?=
 =?us-ascii?Q?66g8Xr0uddl/RIvA+3Go5JSTKzew6gH5Pc2oTSDBfoJoRSj1r3uqOx05eSWP?=
 =?us-ascii?Q?06f27ieMhKk8hwUDTABNPPbJuWGnnHD3LfOvYT5JBJ8h+jA0Vn+lVzE/QLzi?=
 =?us-ascii?Q?dGZSUdkKCNSU4iU2kGcs5TuDbZwolWMTYtgGZWh/WKoaxWMvBsYuaV+PD7rD?=
 =?us-ascii?Q?+cTjZj4JFtxo5GIjknUTiZrL8aE594srau9G0ITD/oXiKvXz0FROI1sdAlTI?=
 =?us-ascii?Q?lwRVT6EHmFcgAopDLFWT/2gWvnAHFodnrVRwjl2WSudNMGMj7Ju+nuqMkYyk?=
 =?us-ascii?Q?gHkI4Ite5YQz5j355IxVY5lWBIYAmVR5TuKQgA+444BoxJR1xI3tWtiYjMiV?=
 =?us-ascii?Q?DmWI3zSlRSdNfsrcjds8ZBv0+JoL/KYb/kqo/pocN7vpXUtka+YLtFUfDrWx?=
 =?us-ascii?Q?zKvM9P4K9n1hqARE2nXoTPeipMBSZTq8V2LjkVSNIhT3OKqKBbSJHQrlNsrX?=
 =?us-ascii?Q?woALeKpYsvu7rnLOgJUa5Z/7yWCEtRt+0cysSO+mxNkOcZuy+GqdLZjOyhBh?=
 =?us-ascii?Q?ePxOTAHnH1x4NWTJvnxHX3uezD/y8JnEWYcaoXNA9KnfBgFHMRbrtHT4w1Tg?=
 =?us-ascii?Q?xAabZ4+1h9TwoshRK5ApBPGu7NAbPsBMmDnPRQ1zRS8vj9aFIPKC4PiqYGDK?=
 =?us-ascii?Q?TBa+Zx0h3X9EFCLyM7eqKsT5nLzFqBeQ25/W5K+9473Tmcjq/jdnM6sbpquT?=
 =?us-ascii?Q?W+vMf1D9tA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb441fb-a6b4-4a18-b161-08deee303017
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 11:46:26.7723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGKBeRmqTgYuUqjt58NpXhGGOIoU0JfDbIW64dmY4RB8L1umRP6znop3AIVzgLTyd/WoL7I9GA08R2q0Nt+Hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524
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

On 2026-07-29 at 21:22 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Wed Jul 29, 2026 at 10:24 AM CEST, Alistair Popple wrote:
> > On 2026-07-29 at 08:57 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> On Tue Jul 28, 2026 at 11:49 PM CEST, John Hubbard wrote:
> >> > On 7/28/26 2:29 PM, Danilo Krummrich wrote:
> >> >> On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
> >> >>> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> >>>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
> >> > ...
> >> >>>> For instance, what's valid for userspace to extract from this? Given chipid is a
> >> >>>> composed value, is userspace e.g. allowed to make assumptions on extracting the
> >> >>>> architecture? Or is this something we want to expose separately and tell
> >> >>>> userspace that the chipid is an opaque value identifying a specific chip only?
> >> >>>
> >> >>> I _think_ it makes sense for this to just be an opaque value, but it's a good
> >> >>> question that I should probably try and get some internal feedback on as well.
> >> >>> Reading the arch would then be a separate parameter.
> >> >> 
> >> >> I'd prefer exposing it as an opaque value and provide other information
> >> >> separately; the kernel already does the work anyway, so why duplicate it in
> >> >> userspace. It would also remain much cleaner if encoding details ever change.
> >
> > Yep, I agree. Just want to make sure we get everyone in agreement.
> >
> >> >
> >> > Just to orient myself, I'm assuming that by "opaque values", you mean using
> >> > something that just counts up from, say, 1, instead of using real boot42
> >> > values below, right?
> >
> > No. We'd just document these as a unique magic value that identifies the GPU
> > chip rather than something that could be decoded into anything else.
> >
> >> > That seems like a good approach to me, too. Because I can't imagine anything
> >> > particularly good coming from providing unnecessary details to user space
> >> > here. :)
> >> 
> >> I'd probably not be too worried about keeping it as is, but just document it as
> >> being an opaque value that shouldn't be messed with.
> >
> > Yes, agree with this. I don't think we want to mess with the value. It just
> > makes life hard when a new chip is added thats only difference from the nova-drm
> > perspective is a new chipid. You don't want to have to worry about backporting
> > patches to distros and kernels just to add the identifier for say TU117 even
> > though it's functionally the same as TU116 from a Nova perspective.
> >
> > Obviously chipid would still get added to the header and eventually backported,
> > but having been there and done that it's not a good user story to require it.
> >
> >> If we expose the encoded information separately I don't see a huge incentive for
> >> userspace to redo the work and mess with it anyway.
> >> 
> >> The advantage of keeping the values as they are is that we avoid having to deal
> >> with mapping values back and forth. I kind of like that nova-core uses the
> >> values from the uAPI header to define the Chipset struct, passes it to nova-drm
> >> and nova-drm does use it to fill in the userspace exposed data.
> >
> > So do I.
> >
> >> Something else worth to consider in this context is whether we really want to go
> >> with the key-value pair GETPARAM approach, which can become a bit tedious.
> >> 
> >> I think for the basic GPU information we could have a struct drm_nova_gpu_info,
> >> which contains all the relevant information obtained at probe time, such as
> >> chipid, architecture, VRAM size, etc.
> >> 
> >> If everything is available in a single struct there should be no reason for
> >> userspace to mess with the chipid value. However, I'd also not object to make it
> >> a "real" opaque value.
> >> 
> >> In order to deal with additions to the struct we could take a two stage approach
> >> to obtain the information from userspace; probe size first, then allocate with
> >> the returned size:
> >> 
> >> We can have a DRM_NOVA_INFO ioctl, which takes a struct containing the info
> >> identifier (e.g. DRM_NOVA_GPU_INFO), a size and a pointer to the actual info
> >> structure.
> >> 
> >> 	struct drm_nova_info {
> >> 		__u32 id;
> >> 		__u32 size;
> >> 		__u64 info;
> >> 	};
> >> 
> >> Userspace can call the DRM_NOVA_INFO with the identifier (e.g.
> >> DRM_NOVA_GPU_INFO), size and info pointer set to zero, and the kernel fills in
> >> the size of the info struct (e.g. struct drm_nova_gpu_info).
> >> 
> >> Subsequently, userspace can allocate memory with the size reported by the kernel
> >> and call the same ioctl with the info pointer set to the allocated memory.
> >> 
> >> This way existing info structs remain extensible (as long as the layout isn't
> >> changed of course) and new ones can be added at any time.
> >
> > I did consider an approach like this but having to do the two ioctl memory
> > allocation dance doesn't seem any less tedious.
> 
> Well, it is two ioctls for a structured set of properties, whereas GETPARAM is N
> ioctls with no structure and slightly less type information.

I guess I could be convinced of the struct approach, but there's no need to
do the whole two ioctl dance. Fields can only ever get appended so just do it
based on size - an old user-space passing a too small struct doesn't get the new
fields and a new user-space passing a too big struct can get an error code or we
allow it and return the actual size written.

> > Also my experience is these structs tend to just grow over time and become
> > unwieldy as new bits of info get added
> 
> Note that there's no need to grow existing info groups endlessly; if something
> truly becomes a separate concern we can just add a new group, e.g.
> DRM_NOVA_MEMORY_INFO.

Fair enough, although you likely end up with duplicated information as items
from one group get copied into another which would be a bit ugly, having two
ways to read the same thing. My main motivation here was really just that
GETPARAM is very easy to extend as we discover we need other parameters given
that we don't know what they all are yet.

I was also thinking there wasn't much of a downside, but you make a good point
on slightly less type information.

> > and old ones deprecated forcing userspace to allocate memory for things it
> > might no longer care about.
> 
> This is equally true of GETPARAM; we accumulate keys that nobody uses anymore.
> 
> Allocating for one or two deprecated fields for a single query doesn't seem like
> a big deal; plus we can always create a new info group and leave the old one
> alone, just like a deprecated GETPARAM key.
> 
> > Ultimately though I'm thinking (hoping?) there will not be a huge number of
> > these - a lot of this info should probably get exposed via sysfs anyway.
> 
> I don't think sysfs is a good fit; it seems tedious for a UMD to do a bunch of
> sysfs file reads, each of them requiring at least three syscalls. Plus the
> effort to parse the value from the string sysfs provides, which is more error
> prone than reading a typed struct.

Yeah, that was an idea I'd heard floating around and I thought it may have come
from upstream but I'm not entirely convinced of it for the reasons you state.

 - Alistair
