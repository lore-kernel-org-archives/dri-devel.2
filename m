Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B48C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB5A10E6C2;
	Thu,  9 Jul 2026 12:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FuFepVnm";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BCF10E6C2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6VnQFQMJboEutpruA02G8MRu+iYXcYsRVlAlE1pTmUKTbryHlq1nPqxFCCYn5M5hU/ISBqE2+gc9Uzli8bddUCTVXqtoiDpjCUkDh7vuG5+l2j99S9/3G4OBqspX3sKOWE/wVbVlTjXrGqM74MJ7cLMD+GEO857HU2S9xnW5nez2gWeehk864sRtjF1LhuIWMzabKqlR2RBxMPkTj6Z/tRzClVVjiPn+y61lxwKmwJd8funsLV97xt4j5GW98JetbenhgElIl0BQihiTqGBhmIlGGnia3ltSAzV9UPtlrXjqu2PkCU07ICdGbrGqFN7GcG+M8rddbfuNInAebNrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KITAKGZpS1mQehdAFnpuQfU/MlWZzM86d+l8EkGUnl4=;
 b=rUC8xRH1dvDchfli+e2gUKaEppTitBWwhVwUSrQpioc3sFi67bpsVindEZ9QJcFZiMWnF/Om2aJkDkv2HonnSSaKHY8bRZemAyDssO4VvT4ZhPMnj+xK1+mJAHAWf7OchO4NsKOWfZjpm2syZdiSH1fP2FN/KoSiNzbPtu9AeCGl518ZjmaqJ35F5ocy0+OjG75YfbXwdwyLHxA0dlbps0oKGXY5wF/XCDPzsIZ9b0E3CXzlIOEhE6s6Ev9IvHxLbHMX148ZlshlwwzoFliqGk7VNkKe0HnyhvpHyzxy/mIx/wXZjvS/cFyJeacaL5Q8FiETZmyaXMViyCal/Lam/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KITAKGZpS1mQehdAFnpuQfU/MlWZzM86d+l8EkGUnl4=;
 b=FuFepVnmMNHNkXcO9A+UeA2UOpqf18DzwFALNJfTjHWkOSTkSiky+b/i+qwguQeRWU+QK95EXbQkorzDj0FpHL8wdAg6JadZYosfNCaYVGl8RkXRZAfOnCRGu2in6SO3CN5unldsKWyx/m18PJgEG0BdiM2Ut+YU4eP4SjqZc/EztwD/61IC3p+l3c1RqDe/lzgQTbLMNjCeuQKVsQrgHEMFDyZZP+1AMiRl4t585+a7luOx8UHzRu5cB1uodPMiTQBPXcCzHT9vG3HYDJC83D236ip6dhufBC5VyafvIb0EzuryIZB0ZGc9etWyLFNUOaC5qQji/UpyJzRMZn+HbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 12:35:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:35:06 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 21:35:03 +0900
Message-Id: <DJU1LZQLJ38P.2OHWQWKDYJ86J@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] drm: nova: Add GETPARAM parameter to read the
 GPU chipset
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260709085204.565159-1-apopple@nvidia.com>
 <20260709085204.565159-4-apopple@nvidia.com>
In-Reply-To: <20260709085204.565159-4-apopple@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a8f3e9-c0a3-48eb-bc50-08deddb681c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|1800799024|366016|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qF3EWl7T1Qi4j4+JG7OwKvkuhPHbK03/6eLeoqd7ex0zPVDOaF5zpOWEBpxyNiNZsTu0OEeAsB+lmmHbgvr4yRLIHMuMxEFzHY9oxVRhXE4BMACas/9lP7PrrZpRgARKx2iP6inpSJMS4rYTlHJV2ZKKgkKJ+0wPzdwLDHhOOmayP+gASBWfbM9Vfpj7VR+FvJK1lMzbAWuVZVKrVGre8SXMPZLpStnx/oKHY2v71rV5fL9MvX+wqYS7HkLQEpsfEUL5qA9ommOww99ACLsd4h5y5oqJ5bMSsXl+ugTsxqwYpyR5fPE4yGqfdJubmlzs7RGBPCaYL4LJBhfHeHcyoHo5u/F0dokCkZhgoZHW3yI4GnetmAZNkmKTo/OnpfxJV90Un+6xRHfWB5NYm8egRiNSUv3jEcS/Abg4OJO+NrSKuOAHNGDjZYI7w7qcz2/QeBsPBmUOk24hztcahzkEngtWjoUiwdf57stdQfrlhEGSheikTCxLH1KxS3CmQWfp/RUdBMGuhd/Hhg66Tk5mAmBm7KtONMtEwDv+1W6lnaHzvJUrnrkAPBh2g1xLXYRJBGXgYPMs6mXuFgfEimK8pgyWmJTZA6A/yYGO+Rp8h1+N30bOWPZX+1hzry9VMBhrMEzai4XZQ6oQazosMlgqsCsBo9GkBS0zfjpGeas0muM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHJwNE9VSTRCd0NXLzdaZ2VmQUMzSldUTGhIUCt6T21IMnFBam03WE1IL2hZ?=
 =?utf-8?B?djFVNldPcUpJekVUUkk1TnFNZ2JYQUFETTI4eGZhbnVtMTR2ejR1SW12T1p2?=
 =?utf-8?B?RSt6V0I0OVNTc3dOOUc1SWxSVGx4ejdtakxMMEViYjl2ZThIY3E1dHR4RUdK?=
 =?utf-8?B?WWtrc2kxOGlnK0VMUjl2UTJJOWxCU0F0OXQxQmpRRDlrSWtFTGF0MzFuZzNw?=
 =?utf-8?B?T3BaalhuL2Ryci9VYWNtQXo3OTJRa1VQcmV0MWdEcGdPOUpodGp5czBzSnlP?=
 =?utf-8?B?bGx2RGVMRHZYaWwwVElyNnlZbzlJcFlFUmNySU9tMzhQbjM3OU1EOGZGTmhN?=
 =?utf-8?B?eUhzT2dYSEM1M3MyeHVlZWJ5aWtoVWdCdStrM1BMRTVSRWpkSG5VSXgxMzhO?=
 =?utf-8?B?L3lBclVoY2c0czFhVmplbU5IajYreWQvcVZrMzRsckcvRlJmaEtsaE11bVV5?=
 =?utf-8?B?ckVGNVA1Q0VPYnhRaWlXMHhDNFhXVjB1RHlwaVJualFPOGZmOEFJdE9UM2JW?=
 =?utf-8?B?NEdqb2dSY2VoL3Y3VWtGOStJNE9WbjJGK3o4a1VmSjRtaG4vcS9CN1BrU1Ro?=
 =?utf-8?B?ajJzMDcrSTFjUkRWam9uK2hadUs2YUdNT0ttSjhIejlxMU9HZWcrYjNvTzJJ?=
 =?utf-8?B?RGJ2VlFlRlhUaS8wQi9FdGdESktJSzlyQmNMbW9sNmJpVWdrdlE2RkRTYnZ6?=
 =?utf-8?B?SW5BUVl6VlhVUExlY1NyRHpIWXBHclJFd0ZEeW9TSGxOaGU0OWhlMnFScEdZ?=
 =?utf-8?B?b1RydGl5RVVUdDFXRVZtcFFrajlwYVlXeGp3QURkWUZxNXF5MzlnTmZrUkVz?=
 =?utf-8?B?bUNsSTBsSUlUeTU2WnZwdE9BcWdqaXdKZU1JUWRwY28wR0grejl4YjFoWEYy?=
 =?utf-8?B?VEUyMFU1RTdqSWx1b3BSenFMcXUrS0NqTjlwdjRYRnhmQlBOZUVrV28wcHNV?=
 =?utf-8?B?cCtGQkZQd2FCSTMyVHltUW8wNytabml2UCt6RmtxQkdHMEZQbGdtSVBhUHMz?=
 =?utf-8?B?S2ZZNGpnM01VMUVDRERLOE5xSnVTNDZ1YXpFZ25RZXhyL2Ixb1ZkNUcva2x2?=
 =?utf-8?B?TG9aS09lL0N1clR6aW91NEo3bncyYWtoaGo3QzFkRFpCeXdzL3lvN0ZrL2pr?=
 =?utf-8?B?OW1Ia2FGM21UL0hBUFlyNjdUNnF5RzlqbEQ2YytncDhOMFM5RzFRc2JaUExj?=
 =?utf-8?B?eDZVOXZPblFGcUlhaUd0ck5kSlVSZXlwZjhUakF3MHIybFZGR1JIcXVqSHZk?=
 =?utf-8?B?N1F1SmN0NW5iT2xXZjIyNDhOOTJtN2VodWQrN1NENjBvUGttdTBLTmlxV3E2?=
 =?utf-8?B?L1czNXR5dDRicGFEcGZ0TERLWUV0c2N3d1BjdEttQnhhTkR3ZnNVL2d2UHBi?=
 =?utf-8?B?TnlvZWNaSExmckJsSHpjcnh6ZXIvdS9JSlNFenE1eHVrd2hLdzhPYTduaXpJ?=
 =?utf-8?B?ZTZPdm0rMDdjeEl6UUVmeUk2ZE1FU0tndHFVcFhZYndXNTRMTmZUaFlPR0Vs?=
 =?utf-8?B?MzBESUZCamsvS1l3YXZ6TFpGM201bExlTldKYmhORWt2YlNCMVdiZnJ0WTNx?=
 =?utf-8?B?SnVySjlESitzaDJsdWVOMnJHdzVBbHlZV0ZsdER1a2dyc3ZYNHp3bDJhaGox?=
 =?utf-8?B?Nm0rSDBQaDZEbDM4bnUzdWdwdk1rc0NVa2FvSFJkdmpGUjZ1Q0dNTHpaaWxa?=
 =?utf-8?B?M3VrSGdiejVlQ3U1WUNZZzZlUk5IMnpHUm9VSmU5UzNvK1pPTGh5U0ViVnFi?=
 =?utf-8?B?czZjNVNKQWV4N1BqOXpYRHN2dmdBTndqb0I4V0k3RDgzMFVFb2E2QTZvZUxB?=
 =?utf-8?B?a1h0TURDUTFwaGJPeUVnT3pMdm1Pb0t2bXl6cW1aOUlhVjhXQ2IxTG1aSk4r?=
 =?utf-8?B?L2VBTGxMZDFDelZTcEVUclQzMkdYL1FHZVhXdFhtT0VsWmNoV0RtNk1xbkRv?=
 =?utf-8?B?cGFjVFNuNGV1T3MzTGg2cEx2Y3BkTWxoU0FsRzlEdXNOQTlLT2RpRlpJWEda?=
 =?utf-8?B?R2w3RlFpUDZLOG9tYWJhdzZHVUl6QjdPMXlYZk1VUGFGV2FiV1RBWE9NZndh?=
 =?utf-8?B?NGlDTFRWa3dLc0FhV1FVTlZTUEpsNGJ5cHA0TjBoWjJvdzlFNDhRcmlsSG5E?=
 =?utf-8?B?aXdHOFA5T3VoUWFLQlhSOGZydUFEbU1kNG9HUXI0Q05YaTdiaE5NZkh3bTZm?=
 =?utf-8?B?UmpneFVZQjNLbStIKzlDdDgzS3czZ05qQVJkQ0dtSENzMnJHS3FqQlpxQUdm?=
 =?utf-8?B?N1RZWDlDZ0dxejk2OTRTMHlHeWlFWmE2UU80N01rdEVXa1V0M1l2WWRscG4v?=
 =?utf-8?B?bXpvd2NGbFdqeHd6cHFWcS9MVVBTSFpxTDVxMW1zWlozTDhMeFlnVjFlVzNV?=
 =?utf-8?Q?3CdFSoMcI4CPctZjCvelf8dXye5SS4SsVOQ+JVtt/S9xP?=
X-MS-Exchange-AntiSpam-MessageData-1: 63w+S43jMVuGEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a8f3e9-c0a3-48eb-bc50-08deddb681c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:35:06.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlWL48o4O3AAf4iplGDHBESdJhfyrIg8g/HdEFMmrhio8X9GoNRHKOPeutxQNXzLK8Q4xuhwvKBsMLGzLRVKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
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

On Thu Jul 9, 2026 at 5:52 PM JST, Alistair Popple wrote:
> One of the first things a user needs to know about a GPU is its chipset,
> so add an ioctl to return that.

We are not adding an ioctl though, just a GETPARAM parameter.

<...>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 43c3f4f8df71..1f4c5f3aa8ea 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -10,7 +10,8 @@
>      num::Bounded,
>      pci,
>      prelude::*,
> -    sizes::SizeConstants, //
> +    sizes::SizeConstants,
> +    uapi, //
>  };
> =20
>  use crate::{
> @@ -34,12 +35,12 @@
>  mod hal;
> =20
>  macro_rules! define_chipset {
> -    ({ $($variant:ident =3D $value:expr),* $(,)* }) =3D>
> +    ({ $($variant:ident =3D $value:path),* $(,)* }) =3D>
>      {
>          /// Enum representation of the GPU chipset.
>          #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq=
)]
> -        pub(crate) enum Chipset {
> -            $($variant =3D $value),*,
> +        pub enum Chipset {
> +            $($variant =3D $value as isize),*,
>          }
> =20
>          impl Chipset {
> @@ -82,39 +83,39 @@ fn try_from(value: u32) -> Result<Self, Self::Error> =
{
> =20
>  define_chipset!({
>      // Turing
> -    TU102 =3D 0x162,
> -    TU104 =3D 0x164,
> -    TU106 =3D 0x166,
> -    TU117 =3D 0x167,
> -    TU116 =3D 0x168,
> +    TU102 =3D uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU102,
> +    TU104 =3D uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU104,
> +    TU106 =3D uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU106,
> +    TU117 =3D uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU117,
> +    TU116 =3D uapi::drm_nova_chipset_NOVA_DRM_CHIPSET_TU116,

If we are going to remove the actual values, let's at least generate the
right-hand side in the macro as it is just verbose without bringing any
new information. The following diff lets you remove the `=3D uapi::...`
for each chipset declaration.

The UAPI definitions come technically from nova-drm (and are defined as
such), which introduces a dependency of sorts from nova-core to
nova-drm. I'm not saying this is a problem, but mentioning it as we want
to make that decision consciously.

I also think the introduction of UAPI variants and modification of
`define_chipset` should be its own patch, as these are pretty
mechanical.

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 202adfbfa176..5b67f25399de 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -35,12 +35,13 @@
 mod hal;

 macro_rules! define_chipset {
-    ({ $($variant:ident =3D $value:path),* $(,)* }) =3D>
+    ({ $($variant:ident),* $(,)* }) =3D>
     {
+        ::kernel::macros::paste!(
         /// Enum representation of the GPU chipset.
         #[derive(fmt::Debug, Copy, Clone, PartialOrd, Ord, PartialEq, Eq)]
         pub enum Chipset {
-            $($variant =3D $value as isize),*,
+            $($variant =3D uapi::[<drm_nova_chipset_NOVA_DRM_CHIPSET_ $var=
iant:upper>] as isize),*,
         }

         impl Chipset {
@@ -48,7 +49,6 @@ impl Chipset {
                 $( Chipset::$variant, )*
             ];

-            ::kernel::macros::paste!(
             /// Returns the name of this chipset, in lowercase.
             ///
             /// # Examples
@@ -64,7 +64,6 @@ pub(crate) const fn name(&self) -> &'static str {
                 )*
                 }
             }
-            );
         }

         // TODO[FPRI]: replace with something like derive(FromPrimitive)
@@ -73,45 +72,49 @@ impl TryFrom<u32> for Chipset {

             fn try_from(value: u32) -> Result<Self, Self::Error> {
                 match value {
-                    $( $value =3D> Ok(Chipset::$variant), )*
+                    $(
+                        uapi::[<drm_nova_chipset_NOVA_DRM_CHIPSET_ $varian=
t:upper>]
+                            =3D> Ok(Chipset::$variant),
+                    )*
                     _ =3D> Err(ENODEV),
                 }
             }
         }
+        );
     }
 }
