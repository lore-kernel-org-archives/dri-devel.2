Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AACC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F40F10E388;
	Mon,  6 Jul 2026 11:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EZS9c3KD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5718F10E388
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul6g10mqri92QaA7hXU3gd2PwhVxN4zaYcQsbrbJTt28tvNnT8UtfyUilEVdcNYgpH2jNL7vaXSu8KgQqXyZfNQWYATSWg7ne63EFGHHbqBu2YXcfGygdvJxvDO2xFPmQjUO5pBGqgrtgjlY6wdYm+Cbww75ythNMa7nZ6kVxc9XxrM6DQr0AhXWzXrUgLPOg1jIcomOMIIG5+jkyNOadrK79IvBEPg1UzNF6V1ziWtLd0ESpCEnEAsKwvFCcVeqp+ZkkOPsi6/QDJWI1ua+O3OiaNzqpzGSCk+AwOwsQ8m+BT5K7GbB8tIrkxw3t3bdYwWvzL7nDap6m6VB03QSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d25tWwoYG9bw3mYq0ibSTJGpCHCGv1szzmzuij4q1/I=;
 b=u9NNZ1lS3SYsUFJZuG4WPDEpdU5ruI4oW8lf3KqgAqEAxBlxFWjLtqtqCoMPMGciTxX21RB7ZMMZT7d2DQCKpFUrI7vEzFOOP6SV5LlJ7JSnn2z0ue/7NRaX8j2VXcnQN2Em8xjEN7/wYPlVGR//GYF5BeGDRTzk5ylAS53w8qAKuZ/zPxDpqjsR+eXSEfVRnkxt3puWqORIYmVJVL5bSIR3fCGlTwBncwEL105YrkOQXwOD/MfrBTCHWkoeUkdbr7kUOo/yIn22dOVTZQcJqXblMaRq2XnWSsOOrHg6yNZuvEo8+7V1UOJFKnNz+T6R7vE/PB/fGK/6h7r/wWozCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d25tWwoYG9bw3mYq0ibSTJGpCHCGv1szzmzuij4q1/I=;
 b=EZS9c3KDwNQGIbUFtB9p7wmzffPShR2fqVsz/SWQoCnUI4LaLuvoBYuuMR5abmvE1f1D0uOHwiTHZIqdMHV+k9h+VPjFHGe4mNOhS0JiO9xa5j4I0upjtH2phr/U32P6OY4hBSQ8QJyC/LxMUTc1zYlsPO+Y1TF53R078UygPoxWOHN53Zf2ttc+14tOLgg/E4IM0YIF+iDGHFVLfsgZUgktBUWqcqwB7EKm5Bp57GOKTVvurktIUwMPV7aQFAMWJhjrIIe95BnCTHUaVrOhSOP5PMparE4ocojK0YWzWW6pCyruErataZJdM61FUxPHThQPkOGnF3am5fmaLqE/gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 11:39:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:39:47 +0000
Date: Mon, 6 Jul 2026 21:39:37 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nico.antinori.7@gmail.com, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH v2 2/5] drm/nova: use `zerocopy` in booter.rs
Message-ID: <akuSs22rTkn6MXqr@nvdebian.thelocal>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
 <20260702120324.40388-3-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702120324.40388-3-niyudi.honda@gmail.com>
X-ClientProxiedBy: SY6PR01CA0017.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::22) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e0a11f-9e48-405b-593e-08dedb5347ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|3023799007|6133799003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 2ZZnOkkO62wNoyzMmgrfCiZJQbsm2fZD+3jDWeIPQL217BtzIPlRsvBLFBAgrLMdQILIPArdaFQjhQA2ObUwbwbg7peY6rKzQKsZY0LkvMaIT2xKEmgpyarl9GGDb7HZ6papjOIRidWt0vEUrgLHoZpBbI2Nv8bRNhFJ18KbyEnYBniT8d1Qg7602UXU8aZZcroGCCotq3ZVsrEgGzdfaX8BOTJedBnmfi4VNdj//Cst7Ku7sqoZUSGhAzOapcqWYFDWzf/RKp9342Oy7M/sN2c3LaoVvvEyVzNDx7mD+ByYFB9/Kjg1uDFiYkXdoL+u1iQaUhCeHptepYuoPXckKvRumj6xWJtHBjB6950wqqrffI3Fm01J1bEj/UFrKhIS9+ej1MCbs6w84k61I4fl3Hot4aNa+LAFDWGKVkQYUC98mbDscSw3ic3iMGw5xCwjEwgBFKqR0nlnSTHxd3rcbjWAO6WgLAYmJ92nfRtgyenU16bmh/8ifdgfd5nfHWXdCfHxTi5Yyw+g7vviOaoD5GZSyNfJqQKVq2mAd0V9sGZwV7dw2nKknU2kRIM0XaV0kpQzExMXwzLiC7mKX2AGLDD5AlrlxTMcGe4UVnkz4LwTDMxwBFUS9ZyqMn0+AlrLwChC5jD6bHJiPZWED70QIFSZXS6Tb3OmSiqWma1uxpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvT51/k8tNtJrVlplEXkJt3UuQmKWC7TjJPlWTl01wzBmCmLIL5Yw9ymAESe?=
 =?us-ascii?Q?A9/hJxfHpScrnED6mjSSUlt18iVHUfC0scFHJDiyqLHU4bud05c7DeBjyhfz?=
 =?us-ascii?Q?VM5fiXT3IzJyty3HINB7It3A9xsSPpdUXAKQZfeYKZsJ0efrJ51Gpg8mgX6Z?=
 =?us-ascii?Q?CiuRGPpaSJ5fx4IbLuM1sFvMxuG6r5wVw3bmPrTrrtvjpouN3kYQnXqEvQ5+?=
 =?us-ascii?Q?+XgEZ4gy7JmnXL3fffytK4tZPflWShx0a0blsVVqEYtlk33ID1+L7TH+B5Oa?=
 =?us-ascii?Q?/J+JlqkV/C+VBW2BWOoLmmir5QSNEUQLe3KgdtGryfniZyDEDTcT5ySUM4Ld?=
 =?us-ascii?Q?eO9Wxe+sgwFf78EPMAi3NB3VfZh0ZtAIhISLUEZT95k9zYICQDy8K79ZKhCC?=
 =?us-ascii?Q?QQUpfc0tI+Dpnc/MerkwfFmp4aOlTsG3QjBv6R/nw6cg/FvDTu2C0Oe14d6G?=
 =?us-ascii?Q?REZqS7nZU0jeh84Mz4lbmy9SBbOOMfbdrk/LXen0D804eqkq6vEkY8/arVwO?=
 =?us-ascii?Q?8K53o9INS5laVrjl3YjjvI2wpAkyS8XITXjc5+ZVb89XFb+kYui96AnjtwT7?=
 =?us-ascii?Q?wzdHtqZjxL9+QrUz92PAIgmMunr3fi+iUJUhlW8NmRIf+65gotql+aSjCR0N?=
 =?us-ascii?Q?T2/yK/1wMrCz3WXcns0VY1Uk3i361TAFki2YzFGvYbr1QaiVArqaShpTWrFt?=
 =?us-ascii?Q?I27wphTVxxLtbUYAQCqNcx+cHfuUqh5nP1jKcozRrnpLxUNiTrB3K85SZ4IY?=
 =?us-ascii?Q?wWxbk38NeGJOxgJDElpoOgI5U6sxkSBaNGUb4HxAsce4XF+cjTDmOeH8G8U1?=
 =?us-ascii?Q?HrpEDp0DTusp31GNs7bU7QqdybeFD8Rq9VlSYYoiFRWeX+FBdKQEipuXIRWK?=
 =?us-ascii?Q?H+q1s4/6XI591AR3GUcZV9P/5qCkrmMvvGyhxgPsl/m8xpM3JhUeG07f1HqB?=
 =?us-ascii?Q?QiIIaUsZjk5YFxu2Q/t35NVwLTvFnSrTIPC74mJTisRY6gr+8/TH5k4lXNJE?=
 =?us-ascii?Q?g9SoV2AqD3zX58CiIB8mGCxzUpuO0+2zDdY/POwLZ9QUIlIJN/DTot/3BxbL?=
 =?us-ascii?Q?VXWmO+vnmlQB0os52HEiZFS4atjwX1GTycshkC63OuWWnP0kFS5l8xheKMIL?=
 =?us-ascii?Q?KF4Gc6WV5gvp/zRvTrby2i1At3YDpZHoqBpsqTUcxPRYoJ/qUpNl2Ir9Lq4n?=
 =?us-ascii?Q?hkWqW7VTPwTyUxwVoK2FlvlgjdzyyG22L/VKwzB6klS22QAyySWOobFTvO9j?=
 =?us-ascii?Q?wH8VoiIpFJt43nM56M4q3RKMhrXBLe7j0Z0D0Q180SebLO68jBwmdXBURw0g?=
 =?us-ascii?Q?yrt4+B1ZAWXM4VV5oPN3jTbkG1MTQEY5czLha2Yb3u8wbhopV7b7f893c6G9?=
 =?us-ascii?Q?RMmzXiAdN6xAwtHgwd2yxnvjyCDPxSFIrZTtD5MfTP+1c082sbjmtiwCX5Pj?=
 =?us-ascii?Q?/1TA1W+14nhOyW7v2bOZKMyIVHvHthHyNOyQaD7ZA6pUAmAy6iK6dwPY3JtY?=
 =?us-ascii?Q?/o214IqU93FM71QQEZNu40gUTYNzBL9zrXCMoU9p9e+fgJXM2Yr9nG6mjtLl?=
 =?us-ascii?Q?n8zpNE9SaSLj4qt9vfgGqtLIWCfYtTnaogy+JEDVqO8ILdMa2YirWy8egvU8?=
 =?us-ascii?Q?UmYSMk6mr3tmUodOKH+dp9zPo0y56aqON/7tGOWBTcAiQqxoYxn3GbbVTcTH?=
 =?us-ascii?Q?p6a1jaLXRwzSETssGVrjmVykwaNLMgAb+m2d+JPABIRIBbun8JUP5Eqv6NYz?=
 =?us-ascii?Q?JvcqqHPNgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e0a11f-9e48-405b-593e-08dedb5347ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:39:46.9307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SeF+pr6a9mpfyMlCqSiXYXM1yo9EIfDZlEPs31jW9xHRk09aQqFUg92QVc1qhs8Vn/Oo0jPTaXU3Z61KozMxmQ==
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
> In firmware/booter.rs, replace the following `transmute` traits with
> their `zerocopy` equivalents:
> 
> - `transmute::FromBytes` -> `zerocopy::FromBytes`

Having a single item list reads a bit strange to me. I'd just say "replace
`transmute::FromBytes` with `zerocopy::FromBytes`" and if you want to list the
types it's replaced for you could. But that's a bit superfluous as it's clear
from the patch anyway.

But that's a small nit really, everything looks ok to me so feel free to add:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Update call sites accordingly.
>
> Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
> ---
>  drivers/gpu/nova-core/firmware/booter.rs | 26 +++++++-----------------
>  1 file changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
> index acb7f4d8a532..fe9389b84b90 100644
> --- a/drivers/gpu/nova-core/firmware/booter.rs
> +++ b/drivers/gpu/nova-core/firmware/booter.rs
> @@ -10,8 +10,7 @@
>  use kernel::{
>      device,
>      dma::Coherent,
> -    prelude::*,
> -    transmute::FromBytes, //
> +    prelude::*, //
>  };
>  
>  use crate::{
> @@ -43,7 +42,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
>      let end = offset.checked_add(size_of::<S>()).ok_or(EINVAL)?;
>      slice
>          .get(offset..end)
> -        .and_then(S::from_bytes_copy)
> +        .and_then(|b| S::read_from_bytes(b).ok())
>          .ok_or(EINVAL)
>  }
>  
> @@ -52,7 +51,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
>  /// Such firmwares have an application-specific payload that needs to be patched with a given
>  /// signature.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsHeaderV2 {
>      /// Offset to the start of the signatures.
>      sig_prod_offset: u32,
> @@ -75,9 +74,6 @@ struct HsHeaderV2 {
>      header_size: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for HsHeaderV2 {}
> -
>  /// Heavy-Secured Firmware image container.
>  ///
>  /// This provides convenient access to the fields of [`HsHeaderV2`] that are actually indices to
> @@ -144,6 +140,7 @@ fn signatures_iter(&'a self) -> Result<impl Iterator<Item = BooterSignature<'a>>
>  
>  /// Signature parameters, as defined in the firmware.
>  #[repr(C)]
> +#[derive(FromBytes)]
>  struct HsSignatureParams {
>      /// Fuse version to use.
>      fuse_ver: u32,
> @@ -153,9 +150,6 @@ struct HsSignatureParams {
>      ucode_id: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for HsSignatureParams {}
> -
>  impl HsSignatureParams {
>      /// Returns the signature parameters contained in `hs_fw`.
>      ///
> @@ -170,14 +164,14 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
>          hs_fw
>              .fw
>              .get(start..end)
> -            .and_then(Self::from_bytes_copy)
> +            .and_then(|b| Self::read_from_bytes(b).ok())
>              .ok_or(EINVAL)
>      }
>  }
>  
>  /// Header for code and data load offsets.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsLoadHeaderV2 {
>      // Offset at which the code starts.
>      os_code_offset: u32,
> @@ -191,9 +185,6 @@ struct HsLoadHeaderV2 {
>      num_apps: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for HsLoadHeaderV2 {}
> -
>  impl HsLoadHeaderV2 {
>      /// Returns the load header contained in `hs_fw`.
>      ///
> @@ -205,7 +196,7 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
>  
>  /// Header for app code loader.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct HsLoadHeaderV2App {
>      /// Offset at which to load the app code.
>      offset: u32,
> @@ -213,9 +204,6 @@ struct HsLoadHeaderV2App {
>      len: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for HsLoadHeaderV2App {}
> -
>  impl HsLoadHeaderV2App {
>      /// Returns the [`HsLoadHeaderV2App`] for app `idx` of `hs_fw`.
>      ///
> -- 
> 2.34.1
> 
