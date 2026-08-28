Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E2C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DB5F10E463;
	Fri, 28 Aug 2026 06:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iYk38xhu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73EAF10E463
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJrVasVf6tN+Sno9vEbct7F+NJh9xztQzLiy1ndbRHwi4/kLhoHFsgoNPVMnZPbbt8woa+zEydt3GUXKjdfHS0YDChdzX63PmC3QBoamK+jaX8M74v+q+xoMHL1MNWzj880NmGK5rwellEaaegi56B9GSbf4mDwNalPBh4uZdwF4rAVVduOnUTkDlAIZ/AOe7RGN3XGaPNr2ks4rI3Tjks6m8U/0iIewcr6+Gi7fjksYEvvqj8+1kF87dAgIh1bn+euV5PImEsXfhe4+SYvUlbtfII0WPXLEoSG2qENcEngacgQPCq3y0d9zs+3JBKMMOcAXMTROKcSs4pVeQ0F5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf9TBbMpDPoCNKk50D4fxAvBba/tTM18WV0JG7NA7o0=;
 b=NiRmW5oD1ww5Mfgo4cM8lcPD7f5lTnWKzdfjlStFDUL/5DgBZbQ/O0YrqWeMP87cp9VAso8CWUbrJIYro7CiGunGK7mOvRy2yeZLlWFfQEybFCdBCwX1Pl9VHsry4H7EOtwPGISmNlz78qRVd0eOdlcsfH47fBN5B1aw0czz5BtJ3zeWWqXWeg2TyZBkp5kKVAzPVYdBSeMF1DT8ArVm6sdi1Yn2upP7c5QzPE0wEKmUAdsOVM2SafK2C18ZE2J9ynna6E43kSBgBAyj4oY52a0hTKNCOE4j1PvW4A44mLEWOqZa/HbdyKPiC38Kx7HWBujp30xM9IBwcsrgTxIOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf9TBbMpDPoCNKk50D4fxAvBba/tTM18WV0JG7NA7o0=;
 b=iYk38xhuqFCJlRWesruKd/IybA6aWglwzcf5hPeZhD6u8nl6D3Q1ma0hXCGWPfwTS0SI9QkFlfxJWdx1o/rpJuI+ojL8Dv/VUfsjneB8cipGGl2jVrS6aYNVbMtqmfmZRZTzLOlO5ZQ9alqz2D50CcxkduPZ1AU5u8DhI51I182c3e77Eh5WVqQEjIiSQy9T6fya2/Yn42wY+SZadO+xD+spioO59shInECaIFub0I9DXi4NjzuKl0bpn2JSZtW0XVlmSa+yO7cRpdazC2Lc6r1HMsM3JuyRwKdHJ/9brTDzcAUHKWUVM3UTn9F8hURbcbZsWgZGB3POBVUPbA07uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 06:05:04 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 06:05:03 +0000
Date: Fri, 28 Aug 2026 16:04:58 +1000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: M Henning <mhenning@darkrefraction.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 00/11] gpu: nova: Export parameters from nova-core to
 nova-drm
Message-ID: <apEk5I-63o8QM4gJ@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
X-ClientProxiedBy: SY6PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 960839f3-18bb-441c-892c-08df04ca4d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rFwei1ejsyLmNJbeH8BOGi9a5wZZYZkHyGvm/E6iT4pxL0cxOv7a/XWLQm8xCk+rnmVmRm+zj9COBAv5bjoX8Y3lpHe0RmULlDHNOLoBpKQbX4pnDCJuiSA4UV91XLrgjF+vAhMw76ACTbhzDnp15VUrnO7XpYAXTvKWWCeinfuDXbckisDqZbat1Uez8khkJgPmWpEwVbDiXhXBm00J98zWhP1mIBNGocQBcvUuYgW6MaRAciuaRy5c2UH5h96Hbjl7sBGMz6ra9Ofh5ztnGUdtwGXpyLfn/OF9txkahdcyw4rKugF7zC2eMM4NukiD+ZDLQZlaOB6VdzdL+fxabkWVxT7GXp+GmNGXk3qYuUG0WUk2WeUHKwDel+mJE841v5CZeX8SCmApl/9OP6qtTouku07lxeGGETsqqY8qY7dU3IdwuUnQQF0r1LUhchKCCdHubTp1MJoCRqqlfA5FsViq/FxRvbFs9yGAMVjgSqgJVLcGETHBsBhWz6o8+HZ+VmfxsJ1+DIw/353ZhVHMFBRH3+PdvWZJx/yHeHHwye5Zao4zzQsNvYbKQJvQNT6vTjfGPn8lbdobkSz2Jc6CBw7KkYJBwUjur+fgdJ5Bouij0kAqE3I63FQtugx0ZNXsVYLbguZHoUllIFRNZpDkz5okR8F2+0Tu4WzyUtJvwzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pbeu+lhzMkrF7mhCJ9fcp3cXo7GUw/87nnOGM+6+LjzOR5Jt+ZJcnB0moq1?=
 =?us-ascii?Q?2U2blgoX3kg+y3kKf9Z3JiT763VfmEBOaQz3V2SUbZUU7Y8KpaSYKuAzouqS?=
 =?us-ascii?Q?8JrS7Ir2QZOlhmm1dsWtM+1h6R/7GdcC+MYi8n4LPmIXAhAzjK2Mj3uZYuUH?=
 =?us-ascii?Q?3bMh1MrnsszXRw2mbi/zpmmry0iBfaYmoswrkhVn8lcVs/DgJJnk+G0UXPwG?=
 =?us-ascii?Q?l5/GQvwVshhQBf5yoQZSL7P4Ln/LogDPzcJYJAQRDjLkDyjINJCBtXRSMeKd?=
 =?us-ascii?Q?3ND7RVEjOVXU26AzDH4/GSb+OZWg74MT1eEnfBe2YkV5t2vICIh9U554T0b7?=
 =?us-ascii?Q?0xdBx3PsHzjvfd/X0ISvAfKu8ncIVfvKIntA4sW40V200hPiesogq9igwHvv?=
 =?us-ascii?Q?ZLGviVBd0/QlXlDEuReuwVvN9k8ZLwUWZRnUdJzMywviG9GHWADxGB0tqk4j?=
 =?us-ascii?Q?St+mSAw9HQve3ZCY9TPdZWXCpIPSaM/I7AapWqhPFpOzRXVqYqhAkQhq1gTW?=
 =?us-ascii?Q?eZOVlLxNZ8Y9yJKqqMWPaScPj+GXOfiWOodjQaTGe2lk8vb8PuD+Hgkw9gYu?=
 =?us-ascii?Q?PowjSjqYM12ylxdV5tUZv6URRaXC2jVPJ6VSDv04v0NOuwea7VbkOqBd2pmK?=
 =?us-ascii?Q?kpPkopI6j1M/KzM/QeNwdk6bXx19goiuZhEn6MuiLOfs8ykGe1WSF5kM/xmj?=
 =?us-ascii?Q?AgrA0dph33jB5M5bwNak/y2t/JBpq2D1g0Ag9k5M6B60YgVCmR3pM9C4NnsW?=
 =?us-ascii?Q?pMvoQewGqljM7GfCLecRuIQCOzDddJht+/hGhgPrA9IyKK8I+tZIjemrID3Q?=
 =?us-ascii?Q?3T+bknHFfCtZYILXHreAJNHjn7cCQO0wejb98tM1Gv0T8YMtayMsO5UmIyjK?=
 =?us-ascii?Q?qDJPqqcx3tmQSbyui0lsBb8IMiijUe5CfxQHNAoZCOw+mdv7vuOi6DFRnQbU?=
 =?us-ascii?Q?HcdRuK0JeT4ttKqjd04YttbwCCZRseBtOMM6dcgsIwQxs2/rSAhWIZ7ovhc1?=
 =?us-ascii?Q?9Fxvmea0IdCpSWtwPzwbEwt1BahtQLTQM5nmRSbgxt8SlX8gjTL0Rt1mjdhq?=
 =?us-ascii?Q?XpErB60HgVORVX+Wd5TdeELUpmjW69idg8UwBHZlaLGRY4XHUMHvrb+/F/c7?=
 =?us-ascii?Q?lgO1iaDR1sNAHABklVBNlkse3b+XjsiH8pk4f44MWhKuBQrSfS0v3SljpIb2?=
 =?us-ascii?Q?xevIndGr5BvfAuTv3IwHmRwE82TP4bfLKi7qgvxhRuvjYopbKeXGCcuCVXsL?=
 =?us-ascii?Q?bOzOvbCRMeLIMJgfv8rcgv8dVDAG5skugSBxGCIA5mZN59T0f3RUrnEcv/qC?=
 =?us-ascii?Q?maL4QyaIiJsCnSlsTKda73dQhX8uyQG6oOdJQg4pBFcHAaJG4bdu4hNaqLWv?=
 =?us-ascii?Q?SAvZa/f/VmYx+kmAKXlOZInWjmZ6AZ3Y9jtfp/XW6ZVnm9HIcmUEWdPa+8qV?=
 =?us-ascii?Q?ci+hbPapZeEkUgd2jeaPxcUqnMS15xsgsX3DKMZIettBt11sUNECW81Tq2u+?=
 =?us-ascii?Q?CzJVpp8BhoZwyTI9WU2R93PvuTlGLlAjpLVKlwUFx2nfNSq2Ah8URiICW9Fr?=
 =?us-ascii?Q?866vBAC5l8ItpD+Zv5X9HiGk9+99SFf+1C3xdhLFFnWklQ3s3npCg+ur5OCc?=
 =?us-ascii?Q?3qAV2F1m0nbaiq6erdzZcs3c88F0xM+MGMV70H2XR+oIBo5/2/8jHV28yBEW?=
 =?us-ascii?Q?DY8Q6N4fW7njFaTrJwf+1yuUQYsxeg8x50PcBAd3YltfFSEjM6MCcPyhDDw7?=
 =?us-ascii?Q?6WApzeO+ZA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960839f3-18bb-441c-892c-08df04ca4d1e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 06:05:03.4839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyQS0L8oN1XjVHzjkP8/Tu/E7KWx7oX62n6NQojZBLfhzKlh1BaDzAoQvXiT4iTy+oUCvj+aSuXk4HfPnmTPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

On 2026-08-28 at 13:35 +1000, Alistair Popple <apopple@nvidia.com> wrote...
> This patch series adds some basic GPU properties via a new GPU info
> ioctl. It builds on top of the "drm: Higher-Ranked Lifetime private data"
> series[1] to correctly manage lifetimes of registration data shared between
> DRM, auxbus and nova-core. It's also based on top of "ForLt/CovariantForLt
> split, auxiliary closure API and DevresLt"[2]
> 
> A tree with this series applied on top of all pre-requisites is available
> at [3].
> 
> Properties are exported via a new NovaCoreApi type which implements methods
> to read data from the GPU. This has been implemented in a separate module
> to make the public API implementations obvious and to keep them in one
> place. Auxiliary bus drivers can obtain a handle to this type using
> NovaCoreApi::of().
> 
> This handle can then be stored as part of the DRM registration data and
> used to interact with the GPU via the nova-core driver.
> 
> A new info ioctl is introduced which provides an info type field and a
> method for reading extendable structs containing GPU information. This
> series can be tested using the drm-test[4]. A pull request containing
> updated tests will be raised once this has been posted.

Pull request is here:

https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/1

> A pull request for
> Mesa has also been raised but is out of date. That will be updated once
> this series has been merged.
> 
> Changes since v4:
> 
>  - No longer export chip-id, instead export architecture and implementation
>  - Add a separate info ioctl with types to read GPU info as suggested by
>    Danilo
> 
> Changes since v3:
> 
>  - Use an ioctl to return all parameters rather than multiple key/value
>    queries
> 
> Changes since v2:
> 
>  - Addressed review Danilo and Alex
>  - Minor renames to better align with HW based on internal feedback
> 
> Changes since v1:
> 
>  - Address review comments from Danilo
>  - Add an API call to read VRAM PCI BAR size using nova-core
>  
> [1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/
> [2] - https://lore.kernel.org/driver-core/20260626183630.2585057-1-dakr@kernel.org/
> [3] - https://github.com/apopple-nvidia/linux/tree/nova-drm
> [4] - https://gitlab.freedesktop.org/dakr/drm-test
> 
> Cc: M Henning <mhenning@darkrefraction.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Eliot Courtney <ecourtney@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: nova-gpu@lists.linux.dev
> Cc: dri-devel@lists.freedesktop.org
> Cc: rust-for-linux@vger.kernel.org
> 
> Alistair Popple (11):
>   gpu: nova-core: Add public driver API to nova-core
>   drm: nova: Add DRM registration data
>   drm: nova: Add GPU architecture enum to nova-drm UAPI
>   rust: uaccess: add UserSliceWriter::write_truncated()
>   drm: nova: Add an info ioctl
>   drm: nova: Add usable VRAM size to GPU info
>   drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
>   drm: nova: Expose a render node
>   drm: nova: Report GPU name in GPU info
>   drm: nova: Report GPU short name in GPU info
>   drm: nova: Report GPU GID in GPU info
> 
>  drivers/gpu/drm/nova/driver.rs           | 18 ++++-
>  drivers/gpu/drm/nova/file.rs             | 83 ++++++++++++++++++++----
>  drivers/gpu/nova-core/api.rs             | 68 +++++++++++++++++++
>  drivers/gpu/nova-core/driver.rs          | 46 +++++++++----
>  drivers/gpu/nova-core/gpu.rs             | 43 +++++++-----
>  drivers/gpu/nova-core/gsp/commands.rs    | 27 ++++++++
>  drivers/gpu/nova-core/gsp/fw/commands.rs | 12 ++++
>  drivers/gpu/nova-core/gsp/hal.rs         |  2 +-
>  drivers/gpu/nova-core/nova_core.rs       |  1 +
>  drivers/gpu/nova-core/num.rs             |  2 +-
>  include/uapi/drm/nova_drm.h              | 82 +++++++++++++++++++++++
>  rust/kernel/uaccess.rs                   | 14 ++++
>  12 files changed, 352 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/gpu/nova-core/api.rs
> 
> -- 
> 2.54.0
> 
