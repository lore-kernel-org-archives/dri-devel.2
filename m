Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1777CC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADEF10E8EB;
	Mon,  6 Jul 2026 11:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X8YQKUz3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090F510E8EB
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdA7oxUQWcE7x517XS5EJraT5kW7K1VxZqif0Mi5xOIbtloBJdJcs2rFdkC8hsapOcM4WSNerBW1pCcIFs3gqPj5K3aJDexJKMz72O085BJBwM4R4otJmOW0l52tRG3ehTR9kkSkZlaYRq2CI/pxq71q+iDT4m6MHdfIUD1QDY+/Ngpl9sE3nvjLCISzlZYKY0I1QkCHkpdFAw5rk1CK500yGmPkidgDVhcm6RZwWAuNoxyBZGi8LGoycAefI7hVEDRcoYG4nlKVgARPXbSd2+wpoI7RiY3pOVTjXVc/7bqjOIL4stp1ZqFAGHOrOggEXpg57kQTgCBQ1i56sslaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuoG0Jr9iGeean18Om7YPNfgpZWf/OJBt6h3s32EVJ8=;
 b=T7rZ4k/tYx+yWq2Yh9biWHFa410bfpsB+Dr5pYKH3TI84XMfFKS0+ITnpnT9efoLHS6gwp4QCUe/STE7cwTwq9O6d5g1qP8WqruDv+8nKFgsbWpXAtlZ5mFGyK1Ul9UV2/hU2Lp21cRh3R0Dw46eMSlBb596oYIlR2eXr0NA0U8Qrt90QEFM3YeO14UTEKLS2EfmY3N49zV17RZPU99x7vLeCwI4v0XGVTwID+mo8U0uXnZ1Q7qqB1PuZ3FmySwejDKhQqqSn6HJzzdcQPTZkNEWY+sy2Dh3pd4fuBy+MMdmxRqnE8/ZfyOwM7znnqQbaYKcF2vRHRtTp0skh4ry9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuoG0Jr9iGeean18Om7YPNfgpZWf/OJBt6h3s32EVJ8=;
 b=X8YQKUz3kBqCVMMOVITbxzWGB7haKvev9ziRr/wOdAWBic1KxLwJ0Xu1laHjQJ1MltufRl8qDBygP6sa/MxCnzHXdZR1aOYrgR3LdP6/h5KGP5PmHc4hRTxoBiv0UlCWoRqMDXACRNqac3Hp1/tp+7VyfSIEFOqgeA4W1F+cxFGEecXsRbinYMXmyLZmuwcmtWO8qH1cXW847MMh/9a1ADN81sVTwvHkA7czVplIuYmwtV5ANPqejyFbA4CC0gNGx2a785gu6zTrljIJlqytA9HR9hwBTPYYb7gxGF8hViRq/p2barAwp7CdCJ2UeIHCN8/LCoZMW/utEQt8WLw3+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 11:44:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:44:06 +0000
Date: Mon, 6 Jul 2026 21:44:00 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nico.antinori.7@gmail.com, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH v2 4/5] drm/nova: use `zerocopy` in bootloader.rs
Message-ID: <akuU7CUj1CgKsdmP@nvdebian.thelocal>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
 <20260702120324.40388-5-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702120324.40388-5-niyudi.honda@gmail.com>
X-ClientProxiedBy: SY5P282CA0088.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 889ffcc6-f3b8-47f5-95a4-08dedb53e278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: LACYINWY1WFohg4MHykJxtLGJVIy4u7QbKJbqe7OhS5nDYHCWr+KqVBi2+Vi6iLd8je4LynnLLjPA44OfMGN5fQAPMcx5yz/+BNbfSlVQMTOyhY2hkRFnkQ4XjTlZd3WtNFltLa7z53OTUty8xi4jA6Y7fn+94VP+jJOTZnVs7ftaK2USnt/wli2UHoqT1nNoayXoJC/nS6ij5ENVAUtz6eO6ZcQYVr5PBtA7scntVLzjNmf23zaOcObriBqhVfq3Ug1aH5zgSkRfnui929RJDTp0qBXXvqRhfYIWaRYOyJJ9YRJejU4kX+hMbQeFFTthN3JL1ZEmYCEpHCR9BaAAVvUXtDww5ppXhWHTYk11Ro8FEz7y0ZnyY2xPD/KFpnmBEUD42K7JQKGh83hyrKK1GmkMLDIonRJU2jNy3QTuTiXE7ceu+iN5M3CWRMB7v/9GxplsMbcD8MTu0Eh6yJwKuBdmykXQEf/Bx+pMZpxc4AtIuzDaYfWB53Wo9yqXpsou8fwQ6dbXg0cUta1USqRxyyp/wn6kITI7H/X9LYH7E29xEIlAlGkHywrcvWFKxQ31E+oRjZb+rrMn0M2lVi5lxq6bMNW7WRuYzhhMB+Ix2POUErKi0m+NIqoJh//jxVXhmTL8ei0Wnw+/mvN+EOYyHUIYyGzu00HvNBVAKooOFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wmgx6mRmy/I9KRfcBDDcFKVEBNV05GCcoagMO3GfJ2FyTDPYcTSHhvm0395s?=
 =?us-ascii?Q?ChBeOjLv49nrHXxjCe9m6rVBj44asefU4BmNqcTKfyljXkBUMCRxMZQTovAU?=
 =?us-ascii?Q?ybdf5I6/MhtkAN3Mq1vUGlDietDGWu+yvvYMU5dTFSVaaeVOIPP9Rlswct6N?=
 =?us-ascii?Q?xhQ+MNND8T53BeJ5dFPrX/Z0nclf3WCWJ2BRgUwCmp/uVFX31r0H+zzYZ54f?=
 =?us-ascii?Q?pYB1chqbUmZb7yDEZfEsEQv9OFzMsONEYZOp0o7Wy5KhuBnSu06DdTSciADv?=
 =?us-ascii?Q?woRXgXiUO43VVw/xtE6vIOgMxpcQ6AyT/EXvB6ZoXQWCLod1LHAGw1aBww3T?=
 =?us-ascii?Q?BhHKWCX1bn7HbE1a8Klmf7oZVE58R9/CCFeg+uu9JhQtQCnO5n5WYBy7iH7m?=
 =?us-ascii?Q?kFvth/Ggeeda6xjCzkdX2HadEAP4kYDXi+gnuu16wsNBVAHX5/+/5JDcoqko?=
 =?us-ascii?Q?8CcOIvymH6mNvJA64IG4ixqQEJHB7uJLVxPJams7/xJU1w+JMrPdj1PXnE15?=
 =?us-ascii?Q?4uMyzK+7xSXdvwaBsO1moMmdSkvrQxC3xD8OPZVyg4kPyF5JqfWTtzN+Y3JI?=
 =?us-ascii?Q?lnVhBToFps/5gilBSgmCDPs4ZBQn9VXJXAGANb89BD6dF8ZAc1ILqu4ieGNN?=
 =?us-ascii?Q?KXcC+9vZyYJtn7SQ/XmSXYBTC22mmYt8POcvcWvGJYYqJOpLyDcGzoB+9pRP?=
 =?us-ascii?Q?sem1tFH7E83j/XYWKeR9belz1NW6B9sf3hsVN9HMxrwUJXV1wj3xG/49f/hX?=
 =?us-ascii?Q?CcXDsCBDQgmYntBxYafNIAexjxLLfk2+MqtwQT/4lCUm4nWRh3oa0+lRU7DJ?=
 =?us-ascii?Q?JVEsF2Pwt9wq47eV7uZLCNmSUDS1fYzsqMsHlSQhdhVwGZfFse54aVWNDGyT?=
 =?us-ascii?Q?dqgK/sFf0KRAMSw33vOt8Ajjb33BRC8vs/FAJqIFTTMVe9wSU2L/YvtN6nA6?=
 =?us-ascii?Q?b44sW5AV1oze9WVpbM4slkUhn2nfMJ3OWskit/+gOPo8wZrIT9q65HEetYly?=
 =?us-ascii?Q?IUFoBhLbqsklNY6dtqCnABIlubQ200gbsXWDLQPfDYgK2m7jJwrv1fSq8jna?=
 =?us-ascii?Q?8OGruO9skaK9rYbs263BuXjfeV+CzRiNUmMGsm6EDLh3kO8cCtxm9hCQVvUE?=
 =?us-ascii?Q?gTk8GC4t4Fl+MnYo0Zf21C/GcP/me5dOMsnENwUhaCT8Z2/owk//+6PYegxF?=
 =?us-ascii?Q?43c7ZiSM07uMR7r18D9YQlRcgVwuoegPv9lvHngxpYJWkOfDbcvsBtIuBuiS?=
 =?us-ascii?Q?a7RATtQaPrAFf321Rybqew2OAeSP4/EwEpD2t8QWaJKA6FNyRIP2/HrXzDLa?=
 =?us-ascii?Q?z3UevO3fU9QUVE9Vb2/P3vi/JWOxpYzGiO1X1G8E5Ngjfh2ra+yMMQbRH4tj?=
 =?us-ascii?Q?NdCd6qGYTdfWlD8WGKXT8OiKARpWFi/+bDDh3+qfpgmnzA9sTceVqWXp1WBq?=
 =?us-ascii?Q?idlx+upi/QGV7war32EvwITCL8xmYgMiU72TflNZ5WIviN1xMupI2aodthqg?=
 =?us-ascii?Q?jUAp46C9I8lDb75EqAL9QWmmH+fGR0H03ui633IokkF/LJqfUmYJ51D+unm1?=
 =?us-ascii?Q?CiR+5VtsjbCxYs2H7v5Zw92RZtkLNJW80EekuUX/w7Gge+kGh+fnps3P9coY?=
 =?us-ascii?Q?uZBnWCX+mADjyVwNmQSBw49W62UkMbAuA+Gj2ls1TzAxI93cHp1WLy46A22o?=
 =?us-ascii?Q?QN0EDQ9ZdSM7uHNWDCxhOc32Rb9Li4r7R8ZSiADJO2ovjl74ubgSmv03ip34?=
 =?us-ascii?Q?mtfWV+D8PQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889ffcc6-f3b8-47f5-95a4-08dedb53e278
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:44:06.5594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQFvXHsWyItrbxgL7Xdra3sujeieldY5uoZQjgmUaUDprg0uOuxVtweLND+sBeZV4q2PEizTOKeH1FNIIGxFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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

On 2026-07-02 at 22:03 +1000, Pedro Yudi Honda <niyudi.honda@usp.br> wrote...
> From: Pedro Yudi Honda <niyudi.honda@usp.br>
> 
> In firmware/fwsec/bootloader.rs, replace the following `transmute`
> traits with their `zerocopy` equivalents:
> 
> - `transmute::FromBytes` -> `zerocopy::FromBytes`
> - `transmute::AsBytes` -> `zerocopy::IntoBytes`
> - add `zerocopy::Immutable` where necessary
> 
> Update call sites accordingly.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> 
> Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
> ---
>  .../gpu/nova-core/firmware/fwsec/bootloader.rs | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> index 66b9f4d1b41c..03d3090bd9ef 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> @@ -18,15 +18,9 @@
>          Alignable,
>          Alignment, //
>      },
> -    sizes,
> -    transmute::{
> -        AsBytes,
> -        FromBytes, //
> -    },
> +    sizes, //
>  };
>  
> -use zerocopy::FromBytes as _;
> -
>  use crate::{
>      driver::Bar0,
>      falcon::{
> @@ -57,7 +51,7 @@
>  ///
>  /// Most of its fields appear to be legacy and carry incorrect values, so they are left unused.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct BootloaderDesc {
>      /// Starting tag of bootloader.
>      start_tag: u32,
> @@ -73,15 +67,13 @@ struct BootloaderDesc {
>      /// Size of data section in the image. Unused as we build the data section ourselves.
>      _data_size: u32,
>  }
> -// SAFETY: any byte sequence is valid for this struct.
> -unsafe impl FromBytes for BootloaderDesc {}
>  
>  /// Structure used by the boot-loader to load the rest of the code.
>  ///
>  /// This has to be filled by the GPU driver and copied into DMEM at offset
>  /// [`BootloaderDesc.dmem_load_off`].
>  #[repr(C, packed)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, IntoBytes, zerocopy_derive::Immutable)]
>  struct BootloaderDmemDescV2 {
>      /// Reserved, should always be first element.
>      reserved: [u32; 4],
> @@ -120,8 +112,6 @@ struct BootloaderDmemDescV2 {
>      /// Arguments to be passed to the target firmware being loaded.
>      argv: u32,
>  }
> -// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
> -unsafe impl AsBytes for BootloaderDmemDescV2 {}
>  
>  /// Wrapper for [`FwsecFirmware`] that includes the bootloader performing the actual load
>  /// operation.
> @@ -160,7 +150,7 @@ pub(crate) fn new(
>  
>              fw.data()
>                  .get(desc_offset..)
> -                .and_then(BootloaderDesc::from_bytes_copy_prefix)
> +                .and_then(|b| BootloaderDesc::read_from_prefix(b).ok())
>                  .ok_or(EINVAL)?
>                  .0
>          };
> -- 
> 2.34.1
> 
