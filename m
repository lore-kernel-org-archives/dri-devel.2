Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA39606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=arMjr9wf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3149E89321;
	Tue, 20 Oct 2026 11:17:05 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC3289321
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPQQroJ+BQG/6VZ3asy2h3NuO8N+8KqF7shXnyOZrWoDdRe4/x/owFmGKNWPC+nbhAGFuLa0gT3jagH0jlxurZcK7xCJDJ+kFL4WkV0DPhCfRuHS07GzLYmoAxd9hNHlOgKzLf22qjtWcG+soKLwgZLM2eG57L5EIck8oasqDjFxfcgwW7kGfLiWeTmlZXu/evNGSgMyOAt8LerM02S5glYkXovRh4L1vEWX8YEN+9sluL6DEpQ7sb/q5NpVM2jsc5K8+KzPUFMlR8OJGnB9WF/jr7lGksOb7sU6Y2SDT62g/wi8LfFKgEMWhoueZbL7UavxHxfglynyh4W0PfZRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwAiG+IuDFOhS4WdMboHbI/OdvEEQ40mmizdjnVgry8=;
 b=EtccXJyMlHM5199j7hbbn5RgVKD7qVDR7JcaItjAR61OTkf1Ahs1e75qtVvN//sYE5iWi1CzIqVL9Bt2l3wrCWtfIXGYdqPQnmNiprx1ZNlNSJKu2Nh2LkpLCRhzdBiLp8MuFXYHCou54/FxyBbl3Rx9qASVRrjSFQXAnY4tkiTBrVHSm4tEpdZ91ZIvimBBcqHjYekycKWyCvBqGNV0AdjIO/vDulHva0Ko11NkGtGmrxdzJpobihNCRy4m7ezxVx4mq8WOUKLcn+oL7AxfVQ0xqiizfRYQ9q5MYuiiKm1T7HKcA6ZQG8zZHHJ2Aku+/TJ6Tbi5+V0U+ZQ97STwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwAiG+IuDFOhS4WdMboHbI/OdvEEQ40mmizdjnVgry8=;
 b=arMjr9wf+9/yjkzzNyKwRK8w7GgftXJQWxYtGfKfCEkX6bUp6HBPWhym0K+RWHEVegCaLGGU8v4SrzhyG1zxemWsDqWJuiKP6E9xpndGej2saAe4ApQTSPvYoHk55JNIEq5z2qy7EnzIg6wIepUBUt7Ouvz1v0+w4viL5MHh/4jiGjgKNe4heB4Osc+W9yQVyKNSfgkKbnFw9qZBIQ0qzyT4pG5SbStXbOHyNMFVyjyxC1vnPluyoTBtfbLE6uqlpYxEcpTYU8Z/d2aR5P0bzd30sMYrx7zi/oH7czDgWV9xzQQo3fizuTCuS+5CfWeQeM2dTc7KEdACRF2J8ReHbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Tue, 20 Oct
 2026 11:16:53 +0000
Received: from DS4PR12MB634945.namprd12.prod.outlook.com
 ([fe80::24ec:530f:4816:dc]) by DS4PR12MB634945.namprd12.prod.outlook.com
 ([fe80::24ec:530f:4816:dc%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:16:53 +0000
Date: Tue, 20 Oct 2026 22:16:26 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH 0/6] iommufd: harden DMA-BUF PAL setup and release
Message-ID: <atdKZpEJVZY0enR2@nvdebian.thelocal>
References: <cover.1792477872.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
X-ClientProxiedBy: SY5P282CA0105.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::6) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB634945:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: cc70fd08-054d-4ea2-bb8d-08df2e9b9e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: rNK2r0RfxZomZjMtrbKrFKEg4dg6P2Fh/gaZ1F+9pLygdzHgOcKpN6jl8UKlMdyTiht2HcgaIsGNDubVP5+uvKwb+lZ+pcIWrMULlNJ7+yFr8TRpGCy8s8ghw7BZjPmGCJF5Ooyl+N837pIbm85lLOwbst9xOYLKFy1edHWgYoB3mHydl7t71karkgLVFyTN80+j/c7nL7L0J/9CKjM3MtgqA8SqD8K5BlqYMiF5+Efyiu9CQufZC1o2Jgt81DxlyqA5oz9E75HNZbSRjnzFZx6n4YqoHXDNgTxpbPAlUWm10jXmV78S6v5e5UqPkMAzRTJaDeWvOYrMcpyRytPTHJGa1aUiHSouYvwuxY9SMggA758tiWtn52dZm/p0p7rOWLCVugMG8QdMr5t/E1lqCKNi/XIwt4cbG4VYpQSRbdZLWNXWb5kn3CoqKGrewu9E/zdz3EeUSb4jx0R8YfKFlKQ+MCAxk+9mjrAVUSygP95nFrg17lhWBDSNA0DrBO7aLt+f8ya3d2bNXo9EhHo17qR6mOZTkDCnbhAUIkn0BIqURT7LZvAQuZTyXWajG1eTiUjg7BwVZAXqsgU43DuwvpdM+OXeEDMgXpPZX1clunAfO64A4AvvHOIK/Fuf5n0bBGf0oZD7eijd1a9GPBPMgN8MnYKA8PcymL65oI+zY8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB634945.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCSbc8oFHTP3XVV3870tYP8v3rm4yJl77Ag2j78lqq04pmPjp4RKMxbce0F4?=
 =?us-ascii?Q?eOrap6E5hk3qyLOq1h7B8aA05NncvE6hOkjTAZm4Tmxwh6rZ/HG6mabl6DTk?=
 =?us-ascii?Q?Hj1aR76xPU2wr6XZ4x9ScjFcdM6IQjSICCTnxGw2soRTsWnhbcmJ24JjFxHZ?=
 =?us-ascii?Q?Ge83jNySJ8wTJauJxtjB0/zTQQlN/Bz194FTdXZ+iztKROXPaVD6GxRrMJIT?=
 =?us-ascii?Q?RJjA4ENbP4hSfzv7PVfYVlTjmnrda9p/pxOKj5IXesHgVa+ykxrR3BXRusdn?=
 =?us-ascii?Q?FZ/hnQz9FCMGP8gQrMCy/NQTpjH1CUvJ4LQ4xwhFkoR5bzv5jk/wPtE2+qr5?=
 =?us-ascii?Q?jmwZZTCA1bUBUaDODwM3KJ+Tfonax0945I/YDcqA4MJFExFdrEA9wQLze8IZ?=
 =?us-ascii?Q?6GhM6a8SZs3p4Q0YhsYaNTePHSu+JMvn3m46b81Q3jAi3M8BMNPhlgIcGOv0?=
 =?us-ascii?Q?Y3nzEuPoQAyTVqgugMhswVoEIAykIXwOvBL9U+j2Abc6SwDU9a11i+B3V8H8?=
 =?us-ascii?Q?IoebGYkFl24cmTE2KUQXNAYSotmjU3iM33nE5do6xEx0vJkmcFc4n9Ywaau7?=
 =?us-ascii?Q?Kwm5zcbD+16CWnyZPYXPcVxiZAVJYamG2xjZX3TymqMF7OJmFNFnUYjq9Thh?=
 =?us-ascii?Q?HdA6aU2qEUrRts/bkbBdeWT22Hs0j0CNFoVykbTb/ZVS2tun8xIKWdYwJJMs?=
 =?us-ascii?Q?XNJuYqwBbhxzN7Rzn28s/ImEXZK2dBvU+XBAclJCcpYZtdJsmZhHjpOUXEoj?=
 =?us-ascii?Q?odTmKGUqo616NEHHsR6gC2MMuxF4R+S5Fqb/+9eUuBjF59HsY5luTfKsG4cL?=
 =?us-ascii?Q?89Mp9P/NQvBUM6Lr3gPFCnX2KWkgxmZ12px9n/R14hbZ3JwrHOGHMmx/JKzc?=
 =?us-ascii?Q?ID0tsL6pzkVFdwUUjO6Bi91h/K/0Bne+rAmh7AkcitfMOlcmqtJ9dIyHnLLA?=
 =?us-ascii?Q?5HViRKnyanWggbYKHJ8VSHyEzc19GOeBwzg0vUqrAn+lYfxDyUs7YD+RQTf0?=
 =?us-ascii?Q?R6TbnQNKK4+PfteuZySWT0UPhNDd+GncbCkiv0FQdIAr8BqFM9Az4SsWn+d/?=
 =?us-ascii?Q?7ddRUT9v4th1+Owtv2qBEafJyhrhcrK8CqiUGJIchtsyj22K+pchTj7J76ci?=
 =?us-ascii?Q?Rjr1azp663wSk1sxiC9kGw7dGsFi5XxocVjkrr1MWjpDEUHTWM2xiD43SfFI?=
 =?us-ascii?Q?LTOINKfSPX5A6Ulg1FCoxyKJ+kZSwVh0FfpSqSiWqOy5FjTehBSvgR5wGBcL?=
 =?us-ascii?Q?kD1OrbyOdbzvgNYUN31BEI6lqowvirVz9WPuUjzmGylVdNtVtaGyEHAFtJr5?=
 =?us-ascii?Q?P9g30TZYxe1BiMEfXgSsRpSV7EOjFwxtJhdyMkJuJrV1jNHi9Whr4qrWjP2E?=
 =?us-ascii?Q?fDS0PNiPDcBNJgJj/y7Vc3G4wx2RYa/t5a+B6dmMZXaXiotYAHSyI7HmlzOC?=
 =?us-ascii?Q?vuE1oEbldFY5m6k0qs1dCGWgFv22dYrgmqEMIAgIlVKBJY7oUkYpAo8V7pRl?=
 =?us-ascii?Q?1Mc0k+zoeCNDIyUja6vZqca9Lc8x692yj7WFyhEXG/oOboDEAv5a6YAnrbGD?=
 =?us-ascii?Q?rEEx0d0IwY0x/CqOXiKU98ZFptRbMJ/r/zTJ+x9AyYGzGLhVOat727OaSikq?=
 =?us-ascii?Q?gqNgHOb/wDlIvQaeL52f2v9pG6k+eJEMHY1ibGxhExolmKCSsHXhlySwQR4P?=
 =?us-ascii?Q?JzrluOhJHA3QhvdmlXTp1ii65tyxBcSHEfiNfTDU1rhu3MLzmLk/C2s4mIYi?=
 =?us-ascii?Q?DF+mzkxB9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70fd08-054d-4ea2-bb8d-08df2e9b9e2a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:16:53.6365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pk8NIe37UhdEhiT85jBJ2R9KxuFeLJWdHfc/fok7omkJ5pmHqdH1jKbwdSjF/ZPWQEKoWnytoGqGJmyYhaeYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 at 17:37 +1100, Karl Mehltretter <kmehltretter@gmail.com> wrote...
> This is a narrow companion to Jason's unmerged DMA-BUF mapping-type RFC. It
> fixes setup and release problems in the IOMMUFD PAL consumer and adds fault-
> injection selftests. It is not standalone and requires this exact base:
> 
>   c37cf2824740d ("cover-letter: Add DMA-buf mapping types and convert
>                   vfio/iommufd to use them")
> 
> I used LLM assistance while inspecting, testing and drafting this series.
> 
> I also tested DMA-BUF paths on a Raspberry Pi 400 and Pi 500+, using their
> stock Raspberry Pi kernels (6.18.39+rpt-rpi-v8 and 6.18.34+rpt-rpi-2712).
> Both passed offscreen CPU/V3D byte checks. The Pi 400 also passed five raw-MJPG
> payload-prefix comparisons through V3D; this was not direct or zero-copy camera
> DMA. Neither board ran this RFC or IOMMUFD PAL. The Pi 500+ connector state and
> mode remained unchanged; the tested buffers were not scanned out.
> 
> RFC:
> https://lore.kernel.org/r/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/
> 
> Jason's branch:
> https://github.com/jgunthorpe/linux/commits/dmabuf_map_type
> 
> This series:
> https://github.com/kmehltretter82/linux/commits/dmabuf-pal-lifecycle-rfc-v1
> 
> Diederik's RK3588 testing produced a useful trace through
> rockchip_gem_iommu_map() and iommu_map_sg():
> 
> https://lore.kernel.org/r/DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com/
> 
> Jason noted that this showed the same private-IOMMU-domain mapping need as
> IOMMUFD:
> 
> https://lore.kernel.org/r/20261009125338.GB13920@nvidia.com/
> 
> That trace is motivation only. This series neither revives my warn-only
> mechanism nor converts Rockchip. Jason's feedback on that mechanism is here:
> 
> https://lore.kernel.org/r/20261009124259.GA13920@nvidia.com/
> 
> Compared with Jason's branch, this series:
> 
>   - preserves dma_buf_pin() errors;
>   - publishes the attachment and successful PAL list together under resv;
>   - unmaps and clears the published PAL pointer under resv before unlocking;
>   - keeps callback state alive until dma_buf_detach() returns;
>   - calls dma_buf_unpin() while holding resv; and
>   - tests pin/map failures, cleanup counters and retry on the same DMA-BUF.
> 
> Patch 3 follows an earlier forced-window arm64 QEMU/KASAN double-free report:
> 
> https://lore.kernel.org/r/20261016194022.62065-1-kmehltretter@gmail.com/
> 
> The proposed release order is:
> 
>   resv lock -> unmap and clear PAL -> unpin -> unlock -> detach -> put ->
>   destroy the pages mutex
> 
> Questions:
> 
> 1. Is that publication and lifetime rule correct?
> 
> 2. Is c37cf2824740d still the right base for this companion series? If not,
>    which tree should I use?

The discussion upstream on whether the PAL approach is acceptable still hasn't
settled AFAICT. I'm starting to look at alternate approaches but don't have
anything concrete yet. However as part of that work I have rebased Jason's
branch onto a more recent upstream (v7.3-rc5) so if you wanted to rebase this
work onto that it could be useful.

I haven't had a chance to look at these patches yet, but if some of them are
fixing bugs in Jason's series it might be best for us to fold them into that
series, with correct attribution of course. Anyway I will take a closer look in
the morning.

Thanks.

 - Alistair

> 3. Can these lifecycle fixes stand independently of moving final mapping
>    selection closer to map time?
> 
>    https://lore.kernel.org/r/20261016202653.97339-1-kmehltretter@gmail.com/
>    https://lore.kernel.org/r/20261019184123.GR13920@nvidia.com/
> 
> 4. Is the per-buffer selftest control acceptable, or would deterministic
>    setup/release race hooks be more useful?
> 
> Testing:
> 
>   - arm64 QEMU virt: two boots, 24 selected cases per boot, zero skips;
>   - x86-64 KVM q35: two 24-case candidate boots plus one focused four-case
>     pin-failure boot;
>   - a one-defect x86 control failed all four pin-failure variants on the
>     expected erroneous successful ioctl return;
>   - x86-64 GCC 13.3 built the exact head, headers and IOMMUFD selftests; this
>     build was not booted; and
>   - KASAN and lockdep initialized with no diagnostics in candidate runs.
> 
> The QEMU/KVM campaigns use mock IOMMU domains and the selftest exporter. They
> do not cover a non-selftest PAL exporter, physical DMA/IOMMU, forced
> invalidation races, or the complete IOMMUFD selftest suite. The x86 negative
> control validates patch 1 only; the earlier patch-3 report is separate.
> 
> Testing with a non-selftest PAL exporter would be welcome, especially failure
> followed by retry, invalidation during setup/release, repeated revoke, and
> multi-range buffers. Please include the base, config, architecture,
> exporter/device and full dmesg. A full IOMMUFD selftest run on another
> configuration would also help.
> 
> Thanks,
> Karl
> 
> Karl Mehltretter (6):
>   iommufd: Preserve DMA-buf pin errors
>   iommufd: Publish successful PAL mappings under resv
>   iommufd: Clear the PAL list before dropping resv
>   iommufd: Keep the pages mutex alive until DMA-buf detach
>   iommufd: Unpin the DMA-buf while holding resv
>   iommufd/selftest: Check DMA-buf pin and map failure cleanup
> 
>  drivers/iommu/iommufd/iommufd_test.h          |  24 ++++
>  drivers/iommu/iommufd/pages.c                 |  24 ++--
>  drivers/iommu/iommufd/selftest.c              | 111 ++++++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 121 ++++++++++++++++++
>  tools/testing/selftests/iommu/iommufd_utils.h |  30 +++++
>  5 files changed, 298 insertions(+), 12 deletions(-)
> 
> 
> base-commit: c37cf2824740d833b21eb816e21f94836100291f
> -- 
> 2.39.5 (Apple Git-154)
> 
