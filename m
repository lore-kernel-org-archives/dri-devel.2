Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17E5CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E32D10E4FC;
	Mon, 22 Jun 2026 07:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DNbo6VTo";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D8610E4F9
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAnvnaYk3WAWd8Tv+uaHXsH9M1+WqsgC1Udnt6tT0e+0U6uTyBUMbEqg6C59DPG7zWn4CycOVr1TP2r90Y44EJhX4hy4EYpoXe1Guq/atVz5F2IwlOsv2OVBjc8UmVjuKLGZdCz1DSDpWuS2fLmRte92stpnY0RFSqW+XLhY3xP/gAekdjib9zm/CukQwFLoiqugsrmMuKnx4x8RALjZRDKIKYsJl/JvE7cRSKkoFh7ORwPVr+jrbukmd6rDrNaoG4ItYo8Q7XpCr1kL2ziEV37FHHxiaLis/ZPeZpprxkwUkD/+PmK6lCNX0rm/fhq/OUFPBgHy7CrJwcA+3RUA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/T95D5hvmP0ICcMioP99Wbsd8HkzS0jtqwF8DtcBPo=;
 b=ueSBmfxbxPvtLU2TDwMr2gdnT1t08p61n+39VONtub9cRqCdfqnf4R7H1JKYQzWvZ6wvbwC35oABmZUrzhI5FUJgcM+YnZpAQ4Ox7NFvlKJrTtTdiNBBlbCEH92V/kC1mL1z8M4C97yz20gY+NW9VksXX/H/iLdXOwOXipg1afoS2RBv+D/Rt4lh+g3BmFdQdtWk4jAkV1+gxVD52z6JDaANiVUeizptrEj/rxxWkIYE6WzDMAwiju9UCohw05/BoLFaC7dPDVupIg2d6v7LSYHKuf+7EWm8W8NfWvr4VEGf0UPzU1SgSltOh9jJFEIz2wmtKa97z5J+ptdkoXEK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/T95D5hvmP0ICcMioP99Wbsd8HkzS0jtqwF8DtcBPo=;
 b=DNbo6VToV3HBnQI2e9MObrQm+UL3Em6pVzevEC5kGBrY6aY/WLLWi1SIEE0He3jGqNKbtgam9iYAHGuyUn7ui5UOcBor7kE6nJ/Xlfs9CHpNpSwBuRYbfDy0UJSK+1AMoUcPnPNlYyzaByaAcePiAo1/foTNtdOPxmQwAWz4Vc2CdCBUg+SgsDGsGUQ8jBO93jXX5voRz0mdVbFq7opxT6NX41nZqvBtaE4VyxaTVWvmCPf2WrE4HEEB7/nvPokrT60+kZ6Hd/i1mXLwaLBm66k9y2si7zmEMxJ3mdc7CVpEvHsmczQbkdjobtEQG1W9VyPtMvVaLXWGrl4XQfQmFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 07:45:51 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:45:51 +0000
Date: Mon, 22 Jun 2026 17:45:45 +1000
From: Alistair Popple <apopple@nvidia.com>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>, 
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: Re: [PATCH] gpu: nova-core: parse structs via zerocopy
Message-ID: <ajjj1yyMcrCA8H19@nvdebian.thelocal>
References: <20260621143647.264770-1-nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260621143647.264770-1-nico.antinori.7@gmail.com>
X-ClientProxiedBy: SY6PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::7) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: d56b44ed-c989-43c0-7dad-08ded03247e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cz+0AzCBmETp2fVIzse0l4VsUxQYnY6tQo1B0s9nqfhYnYRyJGCYyCiVdQzwwJaa+1dX32jddRL+LWo9Sx1SppqCS4qTRMT0mlS8rxPJDGWQfix0TyglZ7MFVNa/NWWhwXaJe8PA5xvRuoy9P0RDYfm7JSqEOfmHD1MYKPL2/z/U/3/PxQwdZZW4OxFa+IRhC9/4FAyaJ61DovSHSfoM+UV/WEsKy6tIHZAN1tFgMRp3CV30XDeysuoq/LOES6jlCFDYFNEGBJ75hXgZ9FusyFjML7z5xK5K/3iaQcrsIv5/coWPIiZCSQVApLs3LTB+oG0vwlCWJYQSSS3IXetPZH50REyrjGkrcv435SQtAEr1DrVOivXdGYO4tNYHmYxMrTepRvk2x80mB1ggMBowrPG+8LA5oK0+enHj+lPiPACXjl3V5s6fyRxbuDGiDsp2YaXA/GB/gCc3m7A54qfVbQIMpBO3ZvtgpS4uJGNkLNf2jFWfZfPJJ0ubHjxJLiUqqZsjNE9QX0E4tHi6t8xhMdkyLK0lhiUJ2G6Fdt52Anp/vM+cxcK47XmCQg6Uw2XNeHn3EvqTKA5YFtbX19ANNftKqZZtoXXLt8ceb2L4ZLKrQrbrIBQvtpECkjYPOJi889rQ0q94ifCo1ZmZpjFgYLrTFZT2ROrrV77BIfFGaW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GxkbrM8CX4GxbfChZqhOlU58oF/j2IEGidEAaxp66j99LnKQJ9R/2raTUf?=
 =?iso-8859-1?Q?WXXFktpQJNBiBv6FL5l8wJbXp9APVeL2bUshJKdsnWt+tSmlqd1oLtQb+I?=
 =?iso-8859-1?Q?R5KRSSbr7kdmgTgS1T611rPOE5/ocW+gyEOXTgjHTs0+1cp2gL7nY5Tk8J?=
 =?iso-8859-1?Q?Nmcf0op52ROgcpfdwPF+4OaDLusNwZ5osJcN1rmxJyepUAOrIrfNcmLGOk?=
 =?iso-8859-1?Q?n1JZ9cc5WVyiMcByXZU1NtytPkc1sv5FGfJlC38mZExx5IDv8EbsoK4Zfj?=
 =?iso-8859-1?Q?DPN8ucHmlDrnirBcIAoJejFIsDIorRR8QpkjFtmDJSZA8eSiPUmvKgHxrs?=
 =?iso-8859-1?Q?8qU10YADTv2VsYGUQULEH5R2ZMYMYaLpR1C3Tj1N1vXdSNJuIAkGW5iyh0?=
 =?iso-8859-1?Q?SkXQtJL3Roo+fzju6w2ZSQGBVdcZ4gHikD+N2gW9bPPGXISmk4UvXqhYLg?=
 =?iso-8859-1?Q?RDuISF7Ea2Aj2SF5jVGJBI3luTuf4TxXI9xj8YR54pYgfxTRRlrYKRzevR?=
 =?iso-8859-1?Q?8ugVGJ4kNWQe11DBaUwPvd8u4Ns9ut1xNHu7CDnpBaGjLycINy6LC1W2no?=
 =?iso-8859-1?Q?y4O/xcza1gitUn5kzetDwPR0VtQ29pUTIAlfdJJobauKvlMk0zoAepL6cO?=
 =?iso-8859-1?Q?nNMZvN/9ytUwRpTBeqfv2cj5uTTv9USPCoSIAsWss4+jK3EQN5Ur7EEBvZ?=
 =?iso-8859-1?Q?28eaduLKKbC0JErZLo7NiKokuB7D+iZz27jQWNmy0lNUht1K2gVXfWcB15?=
 =?iso-8859-1?Q?QdHOEdeKU/Gd/dQaXTLjOyIZ2vV9unWGWGq23srE4zgahGzlMQVEzmlIQe?=
 =?iso-8859-1?Q?eWZfAxPvMz1tZMN5UAQWMJ2uMKmG+Z6xjChUcpgDYB0BebifcwVML7cN1s?=
 =?iso-8859-1?Q?09J6bH3zbDbXd8R1hcx3U1y3/MWVL/BcYAdcyDGUb12P6ZcKxg+SDF8ecC?=
 =?iso-8859-1?Q?/IiGQ6GYoFEGPBM4fCJ9dDOMFfIzBiYehXTe1eem/G2OpPm3hHGmWzfB35?=
 =?iso-8859-1?Q?r3nQ9s0Nkus36V0IUXX9LwyRRYDm80EQuL5afbSWMDRR+fpVb0hd05xiHb?=
 =?iso-8859-1?Q?dhECcxxRT5qEo7rMz/BaoBD7OBUVjlzI8WyMwJ8C4/nyUp70YL1zw5X53d?=
 =?iso-8859-1?Q?mFeLJK4rTpH/l5DbkhFBGltBRJk1qDO8nJxQjuRH5myOWMEAVucEJda2TY?=
 =?iso-8859-1?Q?E6euUpItubNNVItIJ/38hDQfotq3UJb22IdXnhPD7JGhVx83gStKG4mzX5?=
 =?iso-8859-1?Q?HxeSWUitJvlJnhB0FOeM8lCKW+WZ5O0+Mn4W+Y11ChWe6gWOR9hnQXpJI7?=
 =?iso-8859-1?Q?ntibp76WE2Oq4TOI+4QPY6+BG5Wzj6EKSybX1SppzM+5m9MkLThLzkBDIf?=
 =?iso-8859-1?Q?qWvcC6Bp5MxpHp1vPrQnL/tg7My/KwuQotq4QXH43/IeT8lVeE6fzJEhji?=
 =?iso-8859-1?Q?4nTWE/9B8TqIMqZo/vXAcppUHYIVJ8I2K2jMp/nBjOu+HW25zzGO4VrN5N?=
 =?iso-8859-1?Q?nKvmeEsKqGoXQ4Q7/RpQxypUQqmHEeikAbWWFDc/i1ga+jiyTT1MD6R3x5?=
 =?iso-8859-1?Q?/k1qE31PcRHZGzPR130kdsKhdQ6VvXx5FRku+M2/3uYV9HPPBonzjdAXX8?=
 =?iso-8859-1?Q?nb95HF9duzHeKufiSkqCRPyilsUs/n41vLzjUIUnAXq7qX4XEa/XhI+rC6?=
 =?iso-8859-1?Q?L6PVR72HC5oHfApmwi6A7A39DBvT7dsNM2tsL+JrvJ1Y9UaUpTXeVmLYdx?=
 =?iso-8859-1?Q?5DqqXLaJNyUT/WOsKpjn1c8Stn0Js9gemuGiICP13UQpGs56LOOGinIjMV?=
 =?iso-8859-1?Q?cDegZR0O4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56b44ed-c989-43c0-7dad-08ded03247e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:45:50.8844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhEZTndQMBejGV6kUflRsTv5N/+Lb/6oqeW7v1nRZj25dNbfeeRENz9W4mGL7mM1GAaEkR2dltZSQwEP47ZdhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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

On 2026-06-22 at 00:36 +1000, Nicolás Antinori <nico.antinori.7@gmail.com> wrote...
> Replace the unsafe `kernel::transmute::FromBytes` trait implementation
> for the `FalconUCodeDescV3`, `PcirStruct`, `BitHeader`, `NpdeStruct`,
> and `PmuLookupTableHeader` structs with the derivable
> `zerocopy::FromBytes` trait.
> 
> This change eliminates the manual unsafe implementations in favor of a
> derivable trait. When this trait is derived, validity checks are
> performed at compile time to make sure that the type can safely
> implement `FromBytes`.

Nice, this looks good although due to some code movement this doesn't compile
when applied to drm-rust-next[1]. Would you mind rebasing on top of that? The
changes required should be relatively straight forward, they are mostly the
result of some new users of transmute::FromBytes being added to vbios.rs.

Also what is you plan here? I have also been looking at some of these
conversions, specifically those involving the generated bindings. Really
appreciate your contributions, so no problem if you want to continue with some
of the conversions, just want to make sure we aren't duplicating effort here.

 - Alistair

[1] - https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next

> Link: https://github.com/Rust-for-Linux/linux/issues/1241
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
> NOTE: Compile-tested only. I don't own a piece of hardware where I can
> test the nova driver.
> 
>  drivers/gpu/nova-core/firmware.rs |  6 +----
>  drivers/gpu/nova-core/vbios.rs    | 38 ++++++++-----------------------
>  2 files changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
> index ad37994ac15a..0afd1d3fe5ad 100644
> --- a/drivers/gpu/nova-core/firmware.rs
> +++ b/drivers/gpu/nova-core/firmware.rs
> @@ -86,7 +86,7 @@ pub(crate) struct FalconUCodeDescV2 {
> 
>  /// Structure used to describe some firmwares, notably FWSEC-FRTS.
>  #[repr(C)]
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  pub(crate) struct FalconUCodeDescV3 {
>      /// Header defined by `NV_BIT_FALCON_UCODE_DESC_HEADER_VDESC*` in OpenRM.
>      hdr: u32,
> @@ -117,10 +117,6 @@ pub(crate) struct FalconUCodeDescV3 {
>      _reserved: u16,
>  }
> 
> -// SAFETY: all bit patterns are valid for this type, and it doesn't use
> -// interior mutability.
> -unsafe impl FromBytes for FalconUCodeDescV3 {}
> -
>  /// Enum wrapping the different versions of Falcon microcode descriptors.
>  ///
>  /// This allows handling both V2 and V3 descriptor formats through a
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 8b7d17a24660..754812bcbdde 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -13,11 +13,8 @@
>          Alignment, //
>      },
>      sync::aref::ARef,
> -    transmute::FromBytes,
>  };
> 
> -use zerocopy::FromBytes as _;
> -
>  use crate::{
>      driver::Bar0,
>      firmware::{
> @@ -301,7 +298,7 @@ pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {
>  }
> 
>  /// PCI Data Structure as defined in PCI Firmware Specification
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  #[repr(C)]
>  struct PcirStruct {
>      /// PCI Data Structure signature ("PCIR" or "NPDS")
> @@ -330,12 +327,9 @@ struct PcirStruct {
>      max_runtime_image_len: u16,
>  }
> 
> -// SAFETY: all bit patterns are valid for `PcirStruct`.
> -unsafe impl FromBytes for PcirStruct {}
> -
>  impl PcirStruct {
>      fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
> -        let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
> +        let (pcir, _) = PcirStruct::read_from_prefix(data).map_err(|_| EINVAL)?;
> 
>          // Signature should be "PCIR" (0x52494350) or "NPDS" (0x5344504e).
>          if &pcir.signature != b"PCIR" && &pcir.signature != b"NPDS" {
> @@ -371,7 +365,7 @@ fn image_size_bytes(&self) -> usize {
>  /// This is the head of the BIT table, that is used to locate the Falcon data. The BIT table (with
>  /// its header) is in the [`PciAtBiosImage`] and the falcon data it is pointing to is in the
>  /// [`FwSecBiosImage`].
> -#[derive(Debug, Clone, Copy)]
> +#[derive(Debug, Clone, Copy, FromBytes)]
>  #[repr(C)]
>  struct BitHeader {
>      /// 0h: BIT Header Identifier (BMP=0x7FFF/BIT=0xB8FF)
> @@ -390,12 +384,9 @@ struct BitHeader {
>      checksum: u8,
>  }
> 
> -// SAFETY: all bit patterns are valid for `BitHeader`.
> -unsafe impl FromBytes for BitHeader {}
> -
>  impl BitHeader {
>      fn new(data: &[u8]) -> Result<Self> {
> -        let (header, _) = BitHeader::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
> +        let (header, _) = BitHeader::read_from_prefix(data).map_err(|_| EINVAL)?;
> 
>          // Check header ID and signature
>          if header.id != 0xB8FF || &header.signature != b"BIT\0" {
> @@ -533,7 +524,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
>  /// PCI Data Structure. It contains some fields that are redundant with the PCI Data Structure, but
>  /// are needed for traversing the BIOS images. It is expected to be present in all BIOS images
>  /// except for NBSI images.
> -#[derive(Debug, Clone)]
> +#[derive(Debug, Clone, FromBytes)]
>  #[repr(C)]
>  struct NpdeStruct {
>      /// 00h: Signature ("NPDE")
> @@ -548,12 +539,9 @@ struct NpdeStruct {
>      last_image: u8,
>  }
> 
> -// SAFETY: all bit patterns are valid for `NpdeStruct`.
> -unsafe impl FromBytes for NpdeStruct {}
> -
>  impl NpdeStruct {
>      fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
> -        let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
> +        let (npde, _) = NpdeStruct::read_from_prefix(data).ok()?;
> 
>          // Signature should be "NPDE" (0x4544504E).
>          if &npde.signature != b"NPDE" {
> @@ -845,6 +833,7 @@ fn new(data: &[u8]) -> Result<Self> {
>  }
> 
>  #[repr(C)]
> +#[derive(FromBytes)]
>  struct PmuLookupTableHeader {
>      version: u8,
>      header_len: u8,
> @@ -852,9 +841,6 @@ struct PmuLookupTableHeader {
>      entry_count: u8,
>  }
> 
> -// SAFETY: all bit patterns are valid for `PmuLookupTableHeader`.
> -unsafe impl FromBytes for PmuLookupTableHeader {}
> -
>  /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLookupTableEntry`] for a given
>  /// application ID.
>  ///
> @@ -867,7 +853,7 @@ struct PmuLookupTable {
> 
>  impl PmuLookupTable {
>      fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
> -        let (header, _) = PmuLookupTableHeader::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
> +        let (header, _) = PmuLookupTableHeader::read_from_prefix(data).map_err(|_| EINVAL)?;
> 
>          let header_len = usize::from(header.header_len);
>          let entry_len = usize::from(header.entry_len);
> @@ -1013,15 +999,11 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>          let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
>          match ver {
>              2 => {
> -                let v2 = FalconUCodeDescV2::read_from_prefix(data)
> -                    .map_err(|_| EINVAL)?
> -                    .0;
> +                let (v2, _) = FalconUCodeDescV2::read_from_prefix(data).map_err(|_| EINVAL)?;
>                  Ok(FalconUCodeDesc::V2(v2))
>              }
>              3 => {
> -                let v3 = FalconUCodeDescV3::from_bytes_copy_prefix(data)
> -                    .ok_or(EINVAL)?
> -                    .0;
> +                let (v3, _) = FalconUCodeDescV3::read_from_prefix(data).map_err(|_| EINVAL)?;
>                  Ok(FalconUCodeDesc::V3(v3))
>              }
>              _ => {
> --
> 2.47.3
> 
