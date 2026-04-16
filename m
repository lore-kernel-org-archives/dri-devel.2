Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81032F8D753
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CBD810E25E;
	Thu, 16 Apr 2026 15:54:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZ/sS5+m";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0195710E25E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZRzdNvj0wP030qXApGgqlAvqH/mWlpW+MXGun+aLp3GYxjg0ZfRwk5kFSlhkyZkTWvacTv5lRZAhlQb+eMuH4TWFJ4Qff1Mm5NcV5beqsy54yA/Dz5wy+GCYYHRFPMrmcgl8vaDfg+rF7Nuk/zHmQazIUH5wPFVq960nKWfGWFeCnrPlP8Hkd4dPQFPCFsFY0zVFVvgQcNZBmd12OetoGP5MhmEBfz+/LBAsv320m1UYFonD5L1XoE6afoBc+Z17pusIejQrE3zb3aLfucfL9+P573hASPME/67N/PSbqI+T5mWix9GiArWO/2G/d3oJLpIIRt4YrC5sZWtFgnEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUFGBiv4VXEDGc3B0ww8Qn8UtMP9GSI2wl4v1oXPDBE=;
 b=V8a3048qqGiAWQLAfqWh5vd3lCst3ITJO7SPzieO7bxdxuKSQd7ujYebbo1W6rfOUtydyJ7/hCV7gRnGiGCvlud3dmgAvJDgZRUe0UYu76+Nxvz8pQPLVVRWCRbujbJosmdzkFgDGCfn0iBQqYULvG+se89PnjjWJw3R9XilcnIeRBIKLx60I/d6AfdLziXh8Bu+tqSDTYAJd8IhNLuOrTe5WetQnaSS5OqMELdF618SJh2B/xYaENEzC/6Nnum4VDqFeD/7RR0r8zYFtq9IVo6XNCL0KdEtVQTbHn2f9gU/Zb8QH/wczawZd5Py7frsP6Bs5OArAJiROjbMgiHhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFGBiv4VXEDGc3B0ww8Qn8UtMP9GSI2wl4v1oXPDBE=;
 b=AZ/sS5+mvb//yBgJ+ayGaf67PHR3GkiNOyEuP78aHyDmqVSlyBbOlsrhiQXS5OWFBiOvQmqMshVSktG9e6rt7n3FCSxKquBwbsVnZO5OIiuK6FP6BSMHChi4w4GoFwil2omv4lXN0+x5RrGcpqLVXLpB1gZYL2SRcbwG2CsDGeQkyOewYNKEjsrF51yVuF1Foc9+pGdGAZOE7r6MBqSRzttg3mckzWR9l3RTypcdWYnKvA8o6pwuvBnPYXqDLEeDzrV2L506T4vSwlCOSZbO9jYpjbrcDrECvmzOvq3+i/oqF+tvvuoVPd8F87DDOaUEZP0o80neHXWSiuAjcSxhig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Thu, 16 Apr 2026 15:54:09 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 15:54:09 +0000
Message-ID: <530878ad-d650-410d-ae18-e376f0805af4@nvidia.com>
Date: Thu, 16 Apr 2026 11:54:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] gpu: nova-core: vbios: construct
 `FwSecBiosImage` directly from BIOS images
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-10-705d30d16bba@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-10-705d30d16bba@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:408:fe::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 713d2dee-8b6c-44c6-8f56-08de9bd06554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0ruXusDyZrKw1t7UBSolzXxxa8f+p3GYmJQDbfyCVJWiNa0v+zlhz8XUBDEwU1mw3RgVzPsvy5qcdZfaisgoSCcKfzvsC0CYz2y20Tug5D3xiSglvfFBdTgvsK2d/0wyROkgLnHlOKWY8vFmSfNvXERzyG26ETLU07Y0ht5nOeGzGOIij1izpFoLxdqafxMIw87C57+X07IW2F5yvUGsjKCA7dM/EjANxFHLB1tmI4o0Sq6FS3spJm9Z6rCnhVrcLUGdFDO5PhVawrLKIRgS51drp38Nqdkq37e7iRaZmoQdIB6cOaV34jVaMqCQxMg2ygFwFnBPGZl/xy1jKq55nszjnaL4+OO13yk1guuR91NCO3Sddulgs9BNExe87AddEqL/bYT/GHYcoykIqrGGHaeBS2CgC1ERA1/WdQq2FPlHFDnIg0nmiswEr8swiMAXGoigv8i76E9tY2w3MyTIyFNmrxACpGoZ0/1Lyet0nMExdUKh9ecW3/Gtj7xIKvnmkg/I8utR2GX+uQaKnx/7CNlphzIuTi7HpPNWXekHZ+YBlx7Oa9FUuEH5JRh6t8T+rt9ujElYjU6kUCWyS2Q72yMKAeqg1NA2h32nFYWcwXM196LHvGnihCy7g2FgzVhIGR32a7/zA3oF1UoeP5wpS7OpcTKNAeZty6VcalToe8NoGNuvLwgXjM5ZAQr2QCCQBNwAJuTysGIBtT3OuM9Xw/YUCCFyvlPHciUTIAYIDzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BWaHVmNW5rSlNxdkRnVEQ1NVZhL2poVGZ3MVZpbU02V3gxSVNjNVA2VEUz?=
 =?utf-8?B?bXBLNjVUUFpyMWFwNDVHYzhyWXlEdithWDljTjB2YmJjZDFJVVRzY0dIQVM3?=
 =?utf-8?B?alIvQUQ4N0xnUVpZdmtxeGJQbU5xUTgxTmJHRCsxQ0dFM2N6Sjg4YUZWNGdZ?=
 =?utf-8?B?L0ZYaDJRTjh3aUFBa05NY0hNSk9JeDhVeTJ1SXlmTGJGODh6Q2t1KzRLT0FF?=
 =?utf-8?B?VHVUM1k0SEZBSXY1Tzh6RjFmTnFHNTFpSWJ4K3QvWlp6RjN0bEVYMXVJYWdU?=
 =?utf-8?B?aDA0ZEwxY0lWTEhzYkRpUW9lZDZ2MWp6RUNzRldQTkI2S0RTWW9GRncrd2Zj?=
 =?utf-8?B?b3B6VkFrdWRRZTBrTExvSHZpamxGaUNPRGFrMXZsSHpHR1pHaXRiTHpDVExm?=
 =?utf-8?B?cjlWcmpvSWFRSHNxbm5nNS9KVDZ1NWpKOTg1RmVGQ3NQbk0wM0VaZ1hyR1ha?=
 =?utf-8?B?YjJldzk0anA0Z0wrSUJBQUliVXZBd0wvdTM0c3pWanBPUmwyaFBWK0RjYXpD?=
 =?utf-8?B?QXprZ0w2dDhWSU1NUkRzVTVtMW83V1NyZFRySGhmYThodk5rdm45YmlwdzRT?=
 =?utf-8?B?dCtheE1nTS90R05wbEVNT1RLbUE0M3lIVGN6SWpBNWxKNW5MZ2FWemVaUTg3?=
 =?utf-8?B?d2lDTE1QOXA4RWFwcGJGWVBMalA4ZHdzYUNtbk83SDJzZ2RaZXdqemk3YjhP?=
 =?utf-8?B?Wk00OVN2Zm1KTjR5bUZuQ2R4R0Vnd2wwenhMUFE5WVJaRTVvazlsUnVndjNq?=
 =?utf-8?B?am1SZk5IS2xoaVVGeXJ1clJiUDl2OGJZRzdaZkptMU1jdzdwNU42ZWtlRC9S?=
 =?utf-8?B?T25vY0Mra1dNQnowWFVYWnlXeEpwNWFoNDZqSEgvSS9JeXgvQ1k2MmhKT2pp?=
 =?utf-8?B?bHVYSXhHYUtMOHJ2eVhTbStzbndiYkNBaDV6c0xHT0thV0VSSVJLYThCLzFl?=
 =?utf-8?B?WW94NEdSSEdHZVVNV1JrZkw2NWRiTXZpWnNvdkdmS2FKNE96MkVMTjNnUFNp?=
 =?utf-8?B?Z2d2ZmFJK2VnbUlyNEdXLzByM3lGSGRqeFk3bXpIb0dSMTU4Mmt1eWNFNktY?=
 =?utf-8?B?NWk4UEExMG1tbEp3VUg5UGU3YXFiMDVRMGZSUUlydFh6bVpVbUEvdVgySy8w?=
 =?utf-8?B?UzVzSkw1L3VZSGlqVVlOcG52OW1vTE1IT0lkbjIwUjlTQ2xsbFlUYXIzQmVL?=
 =?utf-8?B?TENYa2dvS2VmVUVFNXpGMG1HWVlRV3VOMTdQaU41QTdqRWFtTEhZKzFBUUN1?=
 =?utf-8?B?OE9oNVV5Z3NyUFpjL3hES0VWYS9rb1JzbVQ3d2FvSXlzYzFWYkN1T25ZdW9I?=
 =?utf-8?B?TnlCMXVmTUQ2RGMvRWxUbjZ3SUt0TWZiaEN0SjVNWGJhbkhrb1VNazdkUDlx?=
 =?utf-8?B?UHl5Zk16MVJ1bVFyQ2xIUVlvOUZxSzFKT2tSaFdvelFHVnVFODR6cm43V2Y3?=
 =?utf-8?B?d0sxRm1WdmlaV0RwaE1obXN6a0sxcVJJa1BPVFR4bU1sNmhmRVdYRUF6OWNu?=
 =?utf-8?B?N2lKajkxSmJhRUxqbSs0MU1BWitoVjJzQ2xoRGdJZElvdGNQcHRrWndTR2N4?=
 =?utf-8?B?eGJYUU5NR0RzbFQ0U0E5Q3VIYS9wYUtMclpzK3BBaENocWhSOVNjMHhrdHB3?=
 =?utf-8?B?UlVhdzJZOWNRSE1QV2ExWWZDY3VoQ3dUU240UjVZMTc0WDk0VHVBdzJyak0w?=
 =?utf-8?B?K05HLzhnRkJZOWtkS1VUREM4R2VqdnVwd3UybFBYSWIvTUdnTlROWFNwQ1ZI?=
 =?utf-8?B?cEh2SlpxWXR5N0RtNHEzZXRycW4rd2RLckVWOWk0NFNQTk5vTzZRSXJZbk1i?=
 =?utf-8?B?VDZNRGNnOENidkx1T053YUp2MFoycHBUQ3BDQjI2akd2TytkaWdpckZLRzVw?=
 =?utf-8?B?RVFGUVFTMnhrYlBpTkdQMXJPMld1allwSmZ5Rm5PN1pMcjFmbEswMGx5VUFu?=
 =?utf-8?B?Y0MrdzEwbW85NnVYa0M0dmRSN2xQUEdUVUFBeERrQ2x0UWJYZU43Z0VDcVUr?=
 =?utf-8?B?SkwxTHZyVUM3aVBCWmtzNnJ2VGw3TzlwbzMydDh5b3Y4aFBKd005dmw1SUxO?=
 =?utf-8?B?bkhNK04vcExDWHZLbEtWRllidGJSQXE0enJaUW5YK29XQ1kwcmJyaG1lRWVN?=
 =?utf-8?B?alpJZUh1Q1FKdUdEeU04QWxubzRmRUt0YTJJRWx4UnRPZmxnTVJoMHNTZ2N3?=
 =?utf-8?B?bkk3emhzeW5ackV3SnprWlYrQk9NS2lMbXU5WU5TeFNZSWxGcUo5YmdWdXl4?=
 =?utf-8?B?S2xVb3cxZXcwRHVQRVZkUEVRRGRLMUtuMEFJNlcvZzd5ZVZDanlaalVSc3VK?=
 =?utf-8?B?clVYSndHbStIanBzbUlNQ0NJTTNObWE4SHB0bVQvWkxSZWJUNVVqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713d2dee-8b6c-44c6-8f56-08de9bd06554
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:54:09.0290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qNs/zS/Bom/XLaPOUWX/GMLMyIb9CbzNGC+J6RFAIrwCuHleEyzSq6GMEr+iuHfGzYzz9MlUy7VAohC/4vBLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
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



On 4/14/2026 7:54 AM, Eliot Courtney wrote:
> `FwSecBiosBuilder` now only contains `falcon_ucode_offset` which just
> gets passed directly into `FwSecBiosImage`. Remove `FwSecBiosBuilder`
> and construct `FwSecBiosImage` directly, as a simplification.
> 

nice :) The reason for the builder object was, we wanted to have a
'calculate' phase and a 'build object now' phase to avoid the problem of
partially constructed objects. However, as you showed we can accomplish
that without an intermediary objects.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.


> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 98 +++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index d71ff5de794f..5cc251c73800 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -233,8 +233,8 @@ impl Vbios {
>      pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>          // Images to extract from iteration
>          let mut pci_at_image: Option<PciAtBiosImage> = None;
> -        let mut first_fwsec_image: Option<FwSecBiosBuilder> = None;
> -        let mut second_fwsec_image: Option<FwSecBiosBuilder> = None;
> +        let mut first_fwsec_image: Option<BiosImage> = None;
> +        let mut second_fwsec_image: Option<BiosImage> = None;
>  
>          // Parse all VBIOS images in the ROM
>          for image_result in VbiosIterator::new(dev, bar0)? {
> @@ -254,14 +254,10 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>                      pci_at_image = Some(PciAtBiosImage::try_from(image)?);
>                  }
>                  Ok(BiosImageType::FwSec) => {
> -                    let fwsec = FwSecBiosBuilder {
> -                        base: image,
> -                        falcon_ucode_offset: None,
> -                    };
>                      if first_fwsec_image.is_none() {
> -                        first_fwsec_image = Some(fwsec);
> +                        first_fwsec_image = Some(image);
>                      } else {
> -                        second_fwsec_image = Some(fwsec);
> +                        second_fwsec_image = Some(image);
>                      }
>                  }
>                  _ => {
> @@ -271,15 +267,23 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
>          }
>  
>          // Using all the images, setup the falcon data pointer in Fwsec.
> -        if let (Some(mut second), Some(first), Some(pci_at)) =
> +        if let (Some(second), Some(first), Some(pci_at)) =
>              (second_fwsec_image, first_fwsec_image, pci_at_image)
>          {
> -            second
> -                .setup_falcon_data(&pci_at, &first)
> +            let fwsec_image = FwSecBiosImage::new(pci_at, first, second)
>                  .inspect_err(|e| dev_err!(dev, "Falcon data setup failed: {:?}\n", e))?;
> -            Ok(Vbios {
> -                fwsec_image: second.build()?,
> -            })
> +
> +            if cfg!(debug_assertions) {
> +                // Print the desc header for debugging
> +                let desc = fwsec_image.header()?;
> +                dev_dbg!(
> +                    fwsec_image.base.dev,
> +                    "PmuLookupTableEntry desc: {:#?}\n",
> +                    desc
> +                );
> +            }
> +
> +            Ok(Vbios { fwsec_image })
>          } else {
>              dev_err!(
>                  dev,
> @@ -621,18 +625,6 @@ struct NbsiBiosImage {
>      // NBSI-specific fields can be added here in the future.
>  }
>  
> -struct FwSecBiosBuilder {
> -    base: BiosImage,
> -    /// These are temporary fields that are used during the construction of the
> -    /// [`FwSecBiosBuilder`].
> -    ///
> -    /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
> -    /// [`FwSecBiosImage`].
> -    ///
> -    /// The offset of the Falcon ucode.
> -    falcon_ucode_offset: Option<usize>,
> -}
> -
>  /// The [`FwSecBiosImage`] structure contains the PMU table and the Falcon Ucode.
>  ///
>  /// The PMU table contains voltage/frequency tables as well as a pointer to the Falcon Ucode.
> @@ -898,33 +890,34 @@ fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
>      }
>  }
>  
> -impl FwSecBiosBuilder {
> -    fn setup_falcon_data(
> -        &mut self,
> -        pci_at_image: &PciAtBiosImage,
> -        first_fwsec: &FwSecBiosBuilder,
> -    ) -> Result {
> +impl FwSecBiosImage {
> +    /// Build the final `FwSecBiosImage` from the PCI-AT and FWSEC BIOS images
> +    fn new(
> +        pci_at_image: PciAtBiosImage,
> +        first_fwsec: BiosImage,
> +        second_fwsec: BiosImage,
> +    ) -> Result<FwSecBiosImage> {
>          let offset = pci_at_image.falcon_data_offset()?;
>  
>          // The offset is from the start of the first FwSec image, but it
>          // may point into the second FwSec image. Treat the two FwSec images
>          // as contiguous here and subtract the first image length when the
>          // target lies in the second one.
> -        let pmu_lookup_data = if offset < first_fwsec.base.data.len() {
> -            first_fwsec.base.data.get(offset..)
> +        let pmu_lookup_data = if offset < first_fwsec.data.len() {
> +            first_fwsec.data.get(offset..)
>          } else {
> -            self.base.data.get(offset - first_fwsec.base.data.len()..)
> +            second_fwsec.data.get(offset - first_fwsec.data.len()..)
>          };
>  
>          let pmu_lookup_table = pmu_lookup_data
>              .ok_or(EINVAL)
> -            .and_then(|data| PmuLookupTable::new(&self.base.dev, data))?;
> +            .and_then(|data| PmuLookupTable::new(&second_fwsec.dev, data))?;
>  
>          let entry = pmu_lookup_table
>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>              .inspect_err(|e| {
>                  dev_err!(
> -                    self.base.dev,
> +                    second_fwsec.dev,
>                      "PmuLookupTableEntry not found, error: {:?}\n",
>                      e
>                  );
> @@ -932,34 +925,21 @@ fn setup_falcon_data(
>  
>          let falcon_ucode_offset = usize::from_safe_cast(entry.data)
>              .checked_sub(pci_at_image.base.data.len())
> -            .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
> +            .and_then(|o| o.checked_sub(first_fwsec.data.len()))
>              .ok_or(EINVAL)
>              .inspect_err(|_| {
> -                dev_err!(self.base.dev, "Falcon Ucode offset not in second Fwsec.\n");
> +                dev_err!(
> +                    second_fwsec.dev,
> +                    "Falcon Ucode offset not in second Fwsec.\n"
> +                );
>              })?;
>  
> -        self.falcon_ucode_offset = Some(falcon_ucode_offset);
> -        Ok(())
> +        Ok(FwSecBiosImage {
> +            base: second_fwsec,
> +            falcon_ucode_offset,
> +        })
>      }
>  
> -    /// Build the final FwSecBiosImage from this builder
> -    fn build(self) -> Result<FwSecBiosImage> {
> -        let ret = FwSecBiosImage {
> -            base: self.base,
> -            falcon_ucode_offset: self.falcon_ucode_offset.ok_or(EINVAL)?,
> -        };
> -
> -        if cfg!(debug_assertions) {
> -            // Print the desc header for debugging
> -            let desc = ret.header()?;
> -            dev_dbg!(ret.base.dev, "PmuLookupTableEntry desc: {:#?}\n", desc);
> -        }
> -
> -        Ok(ret)
> -    }
> -}
> -
> -impl FwSecBiosImage {
>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
>          let data = self
> 

