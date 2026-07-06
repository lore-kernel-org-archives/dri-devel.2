Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8F5C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A1510E799;
	Mon,  6 Jul 2026 07:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeLSQ+ll";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40310E1DE
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKpO3Ct48mYm3epxE67d4pvAznDHJL+wITOB6S0FHuBCEO595vYuzDtcEP/ZzHA0rUWZCekOek8ghCE+FUg+nFpHjhAInRcRXPkbu2NAIDVVr1CBR7OMz4R3FU6JuqfZh6bRcEKkN/MY30kCNRtk/bUn23ZpsqMYC7WgEoOOhl4TT/Fx+kZV0rsJvbZvZr+xdZv7OZx2mDpn17rNh941J2ROxT2lm5ZMHPcPBeq9iIUBvIsYAigMf9dMyIrpZlfXLffIoJUcbsu3Nro8uqH3wj157o75nCUi8Q+C5Ol5zdeykQ++Oq4G/F1VOSzABgx45QkHzw9X43Hcri9MupAtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUmE107rY8OW5XXYU9Tyxjvgb4NWNIEHBXy44iiEAck=;
 b=mNWxB5PPt+eW2370TNfwT9JoxwiIn9y4GxXlwONJ9bemkJIIryyVP+mbLmrzNN0JRXMixl+KcG6OcREqKELeQYUK1nOmjsHYwO+S+w4HcpsMLbXDzBDWz/Sa2dhOKBZfFAjAPQwbHXsQ95YXSMvQd3XlyLr0LB7lAIvBihzwNDEvJAbXuMO6ylKicuhjDc689tKu+0bISLQCrRF7LLrD0kGy0WJrp8Uh/Q/mXLNo7HX8gycfeOONS4nVHbn3h9lX6a8I+RuFDrM8mB+hL+qdq/hJZd4uDlcqSIsbq5NCNvDoJ6owIKeyQ8p6d0IgCDhZzYp/I2BFs+aZJgd8wodrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUmE107rY8OW5XXYU9Tyxjvgb4NWNIEHBXy44iiEAck=;
 b=JeLSQ+ll8FZwRebgTEYnYe3gDXs2smvVDmEPWZKKXnCMTxnn5j+QCs5HyKwiXGAqCvH4A3ovUFpkgCK1arKPV5d5Izmqh3mNBb6SbSagg2gyXnMEJCGF0i8Eq+021Yl1xRv0UMEI6/JB9PhtGQpGT40xvvVLahEz2IfFHuOHNBr0v6135zeOYVq57ScVZBghCE/s1Z/VUaas5Y9p0FLNR0ouJR/71fOAaMf8/NaJd7X3HmnwwiazILErT4dN6S1+FiCzpa+zLG0EA7jMC4ZhV7yUsBohMorKzCuopmimByYHRpXjrTtzj0fF8vabW6B8gpr73qEYbb/X6J7QnKypSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 07:16:00 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 07:15:59 +0000
Date: Mon, 6 Jul 2026 17:15:51 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nico.antinori.7@gmail.com, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH v2 1/5] drm/nova: use `zerocopy` in firmware.rs
Message-ID: <aktV7gUmA8TDYL8l@nvdebian.thelocal>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
 <20260702120324.40388-2-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702120324.40388-2-niyudi.honda@gmail.com>
X-ClientProxiedBy: SY5P282CA0125.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b71453-54ba-4e8d-0a6a-08dedb2e6e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: FpDlxIOQNNIbDUvHUkweVsda9hH/XyOQnCXSX+DV+y2tyyZrDKwJSevRjTQ1TEP+8lv7kCUC86xeGQIraMrMG0e9w5NAmAsurpf6wZah5v+a5NYf7mOJ9fclxqUpX79MdbMULEVpFkvPC4ny+RwcM+hgQs5/YmUHWTZ8LvzDLghmLBBkwKy7IajAtsCiA7qwXnC+J5MwZRJHLcXwg2F7e2jcwGKrk8XRgdHf/GohmUJHjfOFX7RPl1binwDj3ty9jWyRQwQ3qbVRaD/IKdwOG7SX/MrxYHk+NL0MKDR/2nnRTQ6PuE9vVI1wVnpLaD2J8UZaQma+4noAFTe/XlVmixZfeV/w29KY8Nr5Lxr0tNNwoGizTqd1T0ewZt6SB6BrJKfrw/q4AYNNgtVkWpt/EPSif+uTlOqdzfwTTIeoLSZKg09bHiLI76I2PvQfXfsb/nV2+Elfx2Q2I/JU+gESqcHebfbs4MKhxpX1r6JxipKRzVMQvFhKZ6ifwxkubo0yMzkpdmV3uNHK6ytYty/q3aWLyFXNqn4ae78Ge6ZifyEeEdubL4+KZPjU5g6eUxDdmXra1XCQQiC7WQHJeYrDODq/kPGQjcSDntNLQW0qlaxUEIUfU+10AbXxLt7m4HwBCQd1Fc1+ltKXtO3j5ueO4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/Glx3c6+KOg21fwtX1afd5ZjhM/2K/LRvkAIb/VbqVB1/qnN+ea2nXdjfHw?=
 =?us-ascii?Q?QhOT0c+GS0B/M4bBwQHb+R0woZrMJxOUaO63W9c60sDeshs5Qult8yugTqOn?=
 =?us-ascii?Q?DXMB4kwbSQE97D/GpSjClxdC0yb/SinRA87xK3Ab3mLtw6bt4wgHi4nNLdO2?=
 =?us-ascii?Q?Uepub6X/hXhOODYXQItXld/diieSAPEnARiGqEd28oarmASzLtNdLStvrtcI?=
 =?us-ascii?Q?y/eb7eko1PcqP/EMNXpX+DHfhFbb8orKJaaMYjDoeWTSwKFgYZALMOrXFBSn?=
 =?us-ascii?Q?fhYDik7RGugRqmX3H/3yFZnwgPAhyTUNOK9i44ediN/+q258lLdJlzi6gSVb?=
 =?us-ascii?Q?wr4E93WF8LQh6p1NcVElxatSAHU1hSaYE5LYxtfFVSed5MQjExlo49ZhCBg/?=
 =?us-ascii?Q?MFLzLhnAIWEUF+o63oIL8B3IhWKI7Logiuc46UhjOLAumdhjfoHahwKN3MDM?=
 =?us-ascii?Q?IeXaiK7QOjaaliqCJjjPUmIzq4M6eSXvl+XolJHtYYRl10SJkQNIB5CDdy4k?=
 =?us-ascii?Q?pwMic+MSXKUY3K2eDJagYYajRQ4xQ/Pr5g/L2t5O50YGrucAZOURWbDqmXNE?=
 =?us-ascii?Q?sNdecqbAL3rIfSfX+neU6VwS0RTx1xMBp4hj30qPzTrtLHAsP6WtciHa7GDQ?=
 =?us-ascii?Q?q6NIbeLW6ZYk/RThN40fxidVuSmX7MX9tUhDseKkWqEpQhmnJ4qF6zLui8NR?=
 =?us-ascii?Q?zC5cnvUtC3jq/pwn7rg7eA17Y0uI/089YjX30JUqICPBI9sa4gRFIG9gQFqj?=
 =?us-ascii?Q?0lMXio1LjE5/AJMe6glf7s7P2wH32H8Fy6K/UA1KN8E2zrolpZ2/iP3ETuY1?=
 =?us-ascii?Q?T2i6B6o2fXZujJu6oqrXDDj6WWoI40Ykn6ngeOhZOveECSbCLezIPA18ObWP?=
 =?us-ascii?Q?0FP7LjNmFcNnoC0yuobilfsODj80Folyz3geyKjO0Kuk94lRh1oW3Jnqm+2K?=
 =?us-ascii?Q?s1+kf3BIZtpD5v/P+9I/K636zOKl/a59sds+sTA0xRXBRD7voKv8Eb11zMaW?=
 =?us-ascii?Q?uosRSdlqnaa1ndNLOSpbdpBqwoEYO1xefC2ShYzU0AgOQIzHUbHIP56aCJ4x?=
 =?us-ascii?Q?5VXX0lOqH+IYP59ufo/ZXPRP9E0/L8PmcSzyDhUIHtV41YN7ZKfLDZKXPQ6B?=
 =?us-ascii?Q?31CE/mlRQ0td7RvgKyfuE6eowMK3mgtcek9vTW7UR/3QnHkSyzAV70tp5Tgd?=
 =?us-ascii?Q?qQbVYxRZMT7R4O7yNXHgjEZdL8UntTIAdczsgUUL0bPfFVGDTaPxk6D7qE2I?=
 =?us-ascii?Q?oV1PrvB/xZgL9Ch4lP1AJ/HOg2PA9PnPaDG9B+hpVwGPQ21wq1jq4u2rGaOV?=
 =?us-ascii?Q?gz55g0jrxvywgQxI602AkZsYiukosn+Wh6CB+FmBIpKJlgxNLT7bV2gaE4xa?=
 =?us-ascii?Q?Oe/6NFOR9zStVjmadMdfijhQdUC9FTZkgMZhdvx+GBpTA7TEhtRCJh8jTQe+?=
 =?us-ascii?Q?4yek44DL3RGUPVGFeeJcrah1G0dnZP01jIicfOXJvieM1QAm+2JZIEq8oia+?=
 =?us-ascii?Q?CNoFxVecHZk1NNCz8SgEA7sIZRNv5C5mENgZ6n/oTVpAFTW8kLNectgGCg43?=
 =?us-ascii?Q?P1vzpiWoxxqnTvHhQGWA35ujz+8elXF9lXMbR3H1i+xLORmABzOHfc8sU3M4?=
 =?us-ascii?Q?2B3nVoEQlLBOMQF+nPOyPtZ/CtAxczv806GEN+H+xqiZRv6HV3Ub7ts1RSdP?=
 =?us-ascii?Q?Hyxbnmxn/dpcBPVKVbsRLLz2g4XE4xWh7oMQMgYCWCNeQhReVJoZId/VFe+T?=
 =?us-ascii?Q?T3HPxyHpWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b71453-54ba-4e8d-0a6a-08dedb2e6e17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:15:59.8896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYLUpIqI4Iex7yJ/WUHE3S3MdyNBmSPo2hrumME2AU8gqq4dqyBtBv8SiH3RyAbvSAjFiFL1o6Tpvq+DeiGwPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
> In firmware.rs, replace the following `transmute` traits with their
> `zerocopy` equivalents:
> 
> - `transmute::FromBytes` -> `zerocopy::FromBytes`
> 
> Update call sites accordingly.
> 
> Note that the module `elf` is untouched, as the bindings generated by
> bindgen do not implement `FromBytes` for the structs.

Also I believe this module is pretty temporary and going to go away.

Everything here is pretty mechanical though, and looks good to me so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
> ---
>  drivers/gpu/nova-core/firmware.rs                  | 10 +++-------
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  4 +++-
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
> index a94820a3b335..80ce0df244a8 100644
> --- a/drivers/gpu/nova-core/firmware.rs
> +++ b/drivers/gpu/nova-core/firmware.rs
> @@ -11,8 +11,7 @@
>      device,
>      firmware,
>      prelude::*,
> -    str::CString,
> -    transmute::FromBytes, //
> +    str::CString, //
>  };
>  
>  use crate::{
> @@ -347,7 +346,7 @@ fn no_patch_signature(self) -> FirmwareObject<F, Signed> {
>  
>  /// Header common to most firmware files.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  struct BinHdr {
>      /// Magic number, must be `0x10de`.
>      bin_magic: u32,
> @@ -363,9 +362,6 @@ struct BinHdr {
>      data_size: u32,
>  }
>  
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
> -unsafe impl FromBytes for BinHdr {}
> -
>  // A firmware blob starting with a `BinHdr`.
>  struct BinFirmware<'a> {
>      hdr: BinHdr,
> @@ -381,7 +377,7 @@ fn new(fw: &'a firmware::Firmware) -> Result<Self> {
>  
>          fw.get(0..size_of::<BinHdr>())
>              // Extract header.
> -            .and_then(BinHdr::from_bytes_copy)
> +            .and_then(|b| BinHdr::read_from_bytes(b).ok())
>              // Validate header.
>              .filter(|hdr| hdr.bin_magic == BIN_MAGIC)
>              .map(|hdr| Self { hdr, fw })
> diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> index d9fafd2eea5b..66b9f4d1b41c 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> @@ -25,6 +25,8 @@
>      },
>  };
>  
> +use zerocopy::FromBytes as _;
> +
>  use crate::{
>      driver::Bar0,
>      falcon::{
> @@ -150,7 +152,7 @@ pub(crate) fn new(
>          let hdr = fw
>              .data()
>              .get(0..size_of::<BinHdr>())
> -            .and_then(BinHdr::from_bytes_copy)
> +            .and_then(|b| BinHdr::read_from_bytes(b).ok())
>              .ok_or(EINVAL)?;
>  
>          let desc = {
> -- 
> 2.34.1
> 
