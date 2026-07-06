Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C87DC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826AA10E8E5;
	Mon,  6 Jul 2026 11:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/+L/X+K";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8AC10E8E5
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owLbz9Klh99XDxTNMnYcEvNr0VDTUY2oshYlQgMxVmESL+v6vBS1JCRC8nvFe4zEVd88Y4wv5Q98o8vnk4DMOIF/xQSG4dZaL0kjEX/dC8dqiMxKSzBT+O89kP8cDxc+fmPrZ0hVq7mPzrrd62pipHdS6siBtrwxCWpqXR0kynfGN1pypq92aQQAud7Zr54TJr5Zae5mpE3qkTQkqPlp4X3DlCslL+pZdGeNGqJepVkWInofYv19n4vuBZUWcPUA0de8RDC+ExWEZ5FYBYerEZtaryixn6UV2CbALdbEVTvdUA3c9ql5hCbb1m5If2HRRtJOi7dVSyWyLi8Wr4WRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIYzDQDPqzFaGTI7BnAoIdUaWn32jjWILd/cD300sdU=;
 b=HAFU3kUg/aT7WTGVY7B/7rGyHE/WeNWu/0+W49YdIyOGire0QCaBevKiu/aQRwuojlipydYG8tlAV8+SBqIVPSI1U0xbW0H6LWSCCyHSofS6sibjnbtfpiWUZ65ehi4FuiZpz84gAXPJZTTtulzVp6/W1haGtgWqW7chZznxkzuGiiqjixJu+6siFEfOO6W57LDSBFPKkoToMaWTRbvFFNqOBBv4ZtMGUw98WNOQvAgx4CcVWwkte4phcTyjJdrMtwqtwjv2BXFPrxubFQ/jaTpaASPBEMJLS0XIMgLyLVCKaX3GB4EAKw2Zf+w2uLeDsU1bvHD/x1lrgx19xRAmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIYzDQDPqzFaGTI7BnAoIdUaWn32jjWILd/cD300sdU=;
 b=Q/+L/X+KcVYSKjEWVYC1L0B4rXT0hEpelXCmpgBHOW5Z7A55KJOI+2jC7JubJZmDR+bEK5jVZ9i6ndP82Iezpeio6L0BBz7N7IQlbZGUX6XTz7RNh4lTbxybu14VZi/VS5hlp/ajfSl72rSo2vBycEvem3LxsVAdyH6qA86zkHZBHXG1ajGlhREaA3ku/guZfKvBJLLxmg0ZXi376a6PSLshbckJJszTdn1EVKsPWMLYLwSrjqIrAHYlii6OM58N7j4bdpM8xPvz85sTUA1971cN2N8o62AS7OjQJzmUZXBu/UI+m3tgivduG8tcEt2Hf05UjjwgibahJUoRgHnKkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Mon, 6 Jul 2026 11:43:15 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 11:43:15 +0000
Date: Mon, 6 Jul 2026 21:43:08 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: dakr@kernel.org, acourbot@nvidia.com, nico.antinori.7@gmail.com, 
 aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH v2 3/5] drm/nova: use `zerocopy` in fwsec.rs
Message-ID: <akuUWHkAPHC31Va5@nvdebian.thelocal>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
 <20260702120324.40388-4-niyudi.honda@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702120324.40388-4-niyudi.honda@gmail.com>
X-ClientProxiedBy: SY5PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6372a3-df04-4668-301d-08dedb53c3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 0vNEhyJV88uTuufNzO/ePB7bylM4+kSAhxTS+tAAct550cME6wSTnB0E03W5myYa7qwdWLAyumyVqdLQo+saOUf19t075xKo/UYWxCYsifgwCzZwgeOOORhz/mbjZsgeHOjW7xk2kfLEC/Quo7BYLxrYVEMEC3xHU+urw2tfdZ1C12Z0vWyevOOd5Uk4R9fMJ6XUwRB2uaHtHoXEwJA3krnlOQIWjeGWfwsoVERAJEAaw1i4aoef4QJHfpVtxJelepStfSaJs7FBjB7tLgP1EDO4QF7JHMD8MxFv+EuCgz5Nt+TVLyJC8k5yM+CX5N4LcUp16cQxlDeqjZ0Ciyp22MBH0Xj2dfGzchIEZWVtHo+qMc9qc24G/k0Of8nHPkJrEBmmRkEw3o/ZfWnFGN3JJFREBLFkVEkAz9LT6rrKHF31G1QZ0I7cLL3NueJ4JLSV+xyztKVTDhKidvtHnIoqJauex4eQQtaUFp46ul8kdYJWklqS+cz1wAAg8cueECgz8CWH/qoNlN9GJoQIJhzl9V+h5KVzWgR9GD90JftAOp4ttmiN7eQtSHv737DMR23nN00CCHTKe8f3m3GfswAfYmqBvyCfZbt8pSUVYtea4Puhik3Eh8+tPVtBWF4+KGQEKSnCMiJZR1MZkGxrqv72EyvHZzGDvycAtPbQrAwejPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fY4wlkHEljzI/9Ag7Z49Md9LCG1pYs9UOCZXh2NQIOfL3h8ILFb/nNLJOLUP?=
 =?us-ascii?Q?4ZBBqQZFnb96NIrL9G/iEIs1SExoPNB0Didj6PLkx8HkMNGk52Q23tTkrR+q?=
 =?us-ascii?Q?k7yetxQpBH/sSyGanyKdozh2iQoE9vn/CSetsZ6F2hd+0sQFIvuXABcVZsDK?=
 =?us-ascii?Q?OxdzEzRJwkpm+JP0222f6SBjd6amlIR7KPhj9K01/kOeLdm1uwQGpHXXVvcA?=
 =?us-ascii?Q?QulpF8+srCa4XhZNky6/qAFmYNRJwequzhSqPkSCGcLl8PTtGxSL9xCRy5Zn?=
 =?us-ascii?Q?CkbaStiOaVUzs+bWlAQuSPfLpT/mypmjDTn5gOdYJFqxLWnvh0kBZAt6VqKF?=
 =?us-ascii?Q?NmrxKcR8vwb69sCAs2Tvqr0etjQW1YhGS6hmqY+DUBiiFaJ2rXgX+xJw8w2H?=
 =?us-ascii?Q?ZnL7rOrnjRONf07Lz1L+HcBgm2zue/HdKKa4RWq3AjfNbr9jndGlkhiZybmI?=
 =?us-ascii?Q?kfK6EHJRUUpcycwMLhaBMh5cYdtUB86tH5I9eJfXsqXVIYtgj6xFggo1yosf?=
 =?us-ascii?Q?MBsnp5ttPPDs9e5QlIW/NlfrM1HpgP2qaac4o4PSlYgVItb4frkw878DURsQ?=
 =?us-ascii?Q?CtaXdZjpPdUXzkj0fjttQlVHNpJtVy3yHXT13gdsKCg5OfYP35N+NWlh+pzg?=
 =?us-ascii?Q?f2jDHnklUWtqnALBjQwELyA1mTVSR8ATwHnsyb/QHW1APVruIQufk05FHP7u?=
 =?us-ascii?Q?cuV0Dm3izvwEeYQkraZiYHYZG4a/Ri0nclr9aoRSgSqBmmaFWKS39Pnur8Ix?=
 =?us-ascii?Q?guqIk9TaQgTboaZ2EZIxs0Tn6h9Bttt4zFMk/q2FWxQMacQKFxrErXfREY25?=
 =?us-ascii?Q?RPQMsBUvEDnYvradWUTjFvlTRw9KgBLqg2aE9WjeREgdbr49M46W9oTWjyqI?=
 =?us-ascii?Q?SmpH4OzcHs3nZuJRbYAyRjYrh4UBYbSBbBd68YvI8sUsPhL3gN0mU2w9CFjN?=
 =?us-ascii?Q?OzpYaybOXav47xKNq1q0ncheXIfQiwWuNthzEPrX8/biLD2GPTy5+pC6e2JY?=
 =?us-ascii?Q?ukptY/nylYunrwE+zV1rmZDHHWmUFrOJdDJojJccRb2P2//6koVOYw3PrKTD?=
 =?us-ascii?Q?+OouL5Vx38TBqgmDC031AlqoNt9OGBnbozxkpKuU93kSg/Q/ahNDVJfkVLcI?=
 =?us-ascii?Q?sIpGlnO0xLVqTm8KIylrir6vjwu/L09vek6h1gFA7IuzAnkvmImzbPeyaiAh?=
 =?us-ascii?Q?hwnRCJPzfE8p+/a0o6+4I5V10EwRnuv6h7po1GYE3dMJf73d4Oz+PiCI2fIr?=
 =?us-ascii?Q?yL9y41rQgPfx3hBCQ/8YqDXVoTr4Ae00+/ta3gn2WR9KbcE7bBQAcpUjjapU?=
 =?us-ascii?Q?OqFGSb5Krnc6C+Mx0p46KOQsZYAzcr9kjR4NjxokWbnGXRUWODLia1DOK3z1?=
 =?us-ascii?Q?e+3c4sl0zI7kmZfwy8jlIS3mjFAnCIWOr34WOBptDUbfgDxzSg7RjOOUS2E5?=
 =?us-ascii?Q?Mh/xa1odVBpzoZ3+tCRphZRQlI1QpmBD7zuraX2S9/MvQ+Qs7kmok012qvuq?=
 =?us-ascii?Q?PX9TpiFAXrrUG9Ud7ku7R/fuRlAGaOo/nV+NeRBcmhW+8cKkuPLpl3jfySxK?=
 =?us-ascii?Q?LBq33hEn3qOa+yv0li1R3M3/N0dq5P/SNFZLCvlfSYjgT4TYLldm58fu7NeX?=
 =?us-ascii?Q?1aCIfHVuuENb3K/UEvnkiL9sbucYQrAlWoV+kZ6Gj/wP05R5FE3k0876dndx?=
 =?us-ascii?Q?LueGIASLNbN8R4yBTQaF0B3tth5URvUjHfNr7DXmoBpeXySuUXyndB0+sIh0?=
 =?us-ascii?Q?yq0P4pv8Nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6372a3-df04-4668-301d-08dedb53c3d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:43:15.0124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVeDjTdaji4z9TU7uAcHHfxyCVf2uk/IY797L95Glg2tI1YLIOy+s95NJILjEPELq+kpD8f0Xwrv2/UoZbGQBg==
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
> In firmware/fwsec.rs, replace the following `transmute` traits with
> their `zerocopy` equivalents:
> 
> - `transmute::FromBytes` -> `zerocopy::FromBytes`
> - `transmute::AsBytes` -> `zerocopy::IntoBytes`
> - add `zerocopy::KnownLayout` where necessary

Argh, ok. It makes more sense when there are more things in the list :-) That
said I'd also be ok without, but either is fine.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> Update call sites accordingly.
> 
> Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
> ---
>  drivers/gpu/nova-core/firmware/fwsec.rs | 49 ++++++-------------------
>  1 file changed, 12 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
> index 95e0dd77746b..1b75cdc02256 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec.rs
> @@ -19,11 +19,7 @@
>          self,
>          Device, //
>      },
> -    prelude::*,
> -    transmute::{
> -        AsBytes,
> -        FromBytes, //
> -    },
> +    prelude::*, //
>  };
>  
>  use crate::{
> @@ -49,26 +45,22 @@
>  const NVFW_FALCON_APPIF_ID_DMEMMAPPER: u32 = 0x4;
>  
>  #[repr(C)]
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes)]
>  struct FalconAppifHdrV1 {
>      version: u8,
>      header_size: u8,
>      entry_size: u8,
>      entry_count: u8,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for FalconAppifHdrV1 {}
>  
>  #[repr(C, packed)]
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes)]
>  struct FalconAppifV1 {
>      id: u32,
>      dmem_base: u32,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for FalconAppifV1 {}
>  
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct FalconAppifDmemmapperV3 {
>      signature: u32,
> @@ -89,12 +81,8 @@ struct FalconAppifDmemmapperV3 {
>      ucode_cmd_mask1: u32,
>      multi_tgt_tbl: u32,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for FalconAppifDmemmapperV3 {}
> -// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
> -unsafe impl AsBytes for FalconAppifDmemmapperV3 {}
>  
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct ReadVbios {
>      ver: u32,
> @@ -103,12 +91,8 @@ struct ReadVbios {
>      size: u32,
>      flags: u32,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for ReadVbios {}
> -// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
> -unsafe impl AsBytes for ReadVbios {}
>  
> -#[derive(Debug)]
> +#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  #[repr(C, packed)]
>  struct FrtsRegion {
>      ver: u32,
> @@ -117,22 +101,15 @@ struct FrtsRegion {
>      size: u32,
>      ftype: u32,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for FrtsRegion {}
> -// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
> -unsafe impl AsBytes for FrtsRegion {}
>  
>  const NVFW_FRTS_CMD_REGION_TYPE_FB: u32 = 2;
>  
>  #[repr(C, packed)]
> +#[derive(FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
>  struct FrtsCmd {
>      read_vbios: ReadVbios,
>      frts_region: FrtsRegion,
>  }
> -// SAFETY: Any byte sequence is valid for this struct.
> -unsafe impl FromBytes for FrtsCmd {}
> -// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
> -unsafe impl AsBytes for FrtsCmd {}
>  
>  const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS: u32 = 0x15;
>  const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB: u32 = 0x19;
> @@ -151,11 +128,9 @@ pub(crate) enum FwsecCommand {
>  
>  /// A single signature that can be patched into a FWSEC image.
>  #[repr(transparent)]
> +#[derive(FromBytes)]
>  pub(crate) struct Bcrt30Rsa3kSignature([u8; BCRT30_RSA3K_SIG_SIZE]);
>  
> -/// SAFETY: A signature is just an array of bytes.
> -unsafe impl FromBytes for Bcrt30Rsa3kSignature {}
> -
>  impl From<[u8; BCRT30_RSA3K_SIG_SIZE]> for Bcrt30Rsa3kSignature {
>      fn from(sig: [u8; BCRT30_RSA3K_SIG_SIZE]) -> Self {
>          Self(sig)
> @@ -228,7 +203,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
>  
>          let hdr = ucode
>              .get(hdr_offset..)
> -            .and_then(FalconAppifHdrV1::from_bytes_prefix)
> +            .and_then(|b| FalconAppifHdrV1::read_from_prefix(b).ok())
>              .ok_or(EINVAL)?
>              .0;
>  
> @@ -246,7 +221,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
>  
>              let app = ucode
>                  .get(entry_offset..)
> -                .and_then(FalconAppifV1::from_bytes_prefix)
> +                .and_then(|b| FalconAppifV1::read_from_prefix(b).ok())
>                  .ok_or(EINVAL)?
>                  .0;
>  
> @@ -263,7 +238,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
>  
>              let dmem_mapper = ucode
>                  .get_mut(dmem_mapper_offset..)
> -                .and_then(FalconAppifDmemmapperV3::from_bytes_mut_prefix)
> +                .and_then(|b| FalconAppifDmemmapperV3::mut_from_prefix(b).ok())
>                  .ok_or(EINVAL)?
>                  .0;
>  
> @@ -281,7 +256,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
>  
>              let frts_cmd = ucode
>                  .get_mut(frts_cmd_offset..)
> -                .and_then(FrtsCmd::from_bytes_mut_prefix)
> +                .and_then(|b| FrtsCmd::mut_from_prefix(b).ok())
>                  .ok_or(EINVAL)?
>                  .0;
>  
> -- 
> 2.34.1
> 
