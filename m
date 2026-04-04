Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08587E63FFD
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B0410E02B;
	Sat,  4 Apr 2026 22:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oCGuKtgH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD73910E02B
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 22:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m22UI28HA9acouALQN093rutrZR6So0RnvVPtL6AuKyagSqtpcoVTuPkBCjpjS8vDCOFCVm+rA4k02R/COzlGAADJYP82qa/pb7jhPYLfrSw6OiMeOwzmAMi7zPWnG+OlNHrHrVo2JQh4mh9wdkZe6lR+9qZ7sd8wgs2Wp2PwEqtdqRP9wkd1KloFDU0QFMGQRPP+aNauKdcSITddW5E3ikSntNte7ycQHnbrrbvoJEmXX4dCgiLe7gdnjXqtq2O+Ya1/iipwf/Czo9JjprAgtidY3K32fxhoJ2M2Y60xNzTLzt8o1vwP83F+29tXME5ebLKGxURbis5ZIj4k5q0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOLYXMCCAKagByDUN7UlwfqYHB/zUBl+dwr80UvXS/s=;
 b=DSH8aqHyS5eaEX9umbpIMhYGSIgoCEfBG3eGTdcKAr0mCV/4kyVogRZeMUhIOOZhcHQAOzSiessy+Dd7/C4Kd+np6wkEBoUbfQPSLvghnoQCWcZANPOVAXmhklecz1rnKMqKtzpMhatPyebQ1KCfIBb9ki3WQwWFIvdkjC2+kxcbCov5UsYEMu76jAkVWW900vjJQHYw7F3KI/xOTfuQwajChWQ7mB1S9loQjZZvV+Miq/ApUGQTH1doeKUpG/GdWmb20clOz3M9D3oDMAiUPWruiw+ksrAjzzLk8gjr1aeVLn8vi78E7JI2M7jiFkjN4ZWDXbg8gkIDn9oPEmIU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOLYXMCCAKagByDUN7UlwfqYHB/zUBl+dwr80UvXS/s=;
 b=oCGuKtgHyb1+HUvRjf2gkMed7Tmws2g/OdI3wYsV37GWzLi9vzVFIAWHCEocg2koH7QohkWVaYUhU9hPu56wMaWcgRDn6gPZ4etk67y35nggI7Qs6OEpjlMmu2E8CPKlG4HGWrhxjS8zniwQMqg0BKEoeiarYgF/fYrZvySzviKWVD7DMAsnUiEc89w/GzhNnpmd4HVDSkdW1uKRSSsbvHCw3PFoNGkARIrmwnJXrx9PhcQJT0FvNj/L3zdqI24ZZbDzD4m+kmmjWqAkmvnH7Bi9S6qWVURuxymbsmawkRKPYWW5LVv+hReCcst7tKMeP6NkVgIK1BBYUL9CimLZOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB8020.namprd12.prod.outlook.com (2603:10b6:8:14f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Sat, 4 Apr 2026 22:24:12 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Sat, 4 Apr 2026
 22:24:12 +0000
Message-ID: <f7cdbcf5-0df0-4cf3-9710-31a5415973e7@nvidia.com>
Date: Sat, 4 Apr 2026 15:24:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: falcon: align firmware DMA object size to
 required block alignment
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::45) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c04afb4-abf6-488a-b8b5-08de9298e5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: mkFB7B6lcqcjQDtSHBxiZ6Pe1om1gqOle3ev1u6olunaHA7VuS+OQecuDSB/HDcLXc/w54Az2zKFTOAYyEoI8hGfeclnU1CG8x9oWeGnKds8asoGwNANisfx6u6HU4yalR3gUQVk5v+cHvVAbpV9u6sOWdzb6UEH+AzQW2bYgo/oP7edy/3qj7rUwL0eD6wP6NaOacuwsTDM8NIMFuICre8ka0ZfWMEQs+kz6OnUZbXIKUG63ke+v6o1ypJucV4VI5Mo4reGOfHcWBLgSesVjzJKmd85Ufj7iOg3+8kcEkaIhdmP1ERRM4rBAhDNwdVxfLIDTdTRp2I2rdeXmHar49a83RvJ7hA3WtMaxW5p0YZpxMz+RZ3JB93J2wuQU6GZ7/TdWteSJfuwz9GgWYqHbtWN/Pt6yG/veqa5xMJ89JhDNHe3lCKHPlIyjsYpymf6/gueAb9yaP/Fhx2cd9Lk4ITd79xZ33fsxtGtjTAcuL4SHTgSrgjKNgZ4/+AD6ObWPgjdhWwV52ZlDxl7p8Lanmv2vYamCz6Wd6HeXjEZPvtnXZMUkD+85viJOyh85VCakz0GvnkI2ohz4Xaj0HSoWhaJl8YHa2c5uoHsuXOWdTEmQfSneEsparkf34vtbzgfHrGbDEV+0KseaihOV5/qzwFPYxUfJGbDb700AskRoguTgIIUU4Ll0RKD/6733DysvUExZBoLPlN2IP+apzHDePJNai4nqZcFhP2fUCKzcww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjRWNVMzbVBWTkRqUjNvdy9GTW1EUmNTRHQ3ZjBFTVJrcjBQS01GdmFJNGNM?=
 =?utf-8?B?NjVRcDNuR0Y4c01OVkJwU3NOaW0rZjlFWUYvbXBWa1JBNUVPZ3JWWHdjbTRz?=
 =?utf-8?B?d2pXa1JMWFJTSlhHWVBWb1EvSElDTW1mNGpSaHRyb2RDZlZqbU9HU2lRdHUv?=
 =?utf-8?B?UjNuTU0xZmd3K1Q0ZUxRR0REQW42aWRaMlAwOGZ1d2RvN2pZTzhrVy8zMTFI?=
 =?utf-8?B?R0FvM01RVXB1MW9NK1hUeUJSMkhxM0NXVXZ1ZHkwQkhiYUZiZkJvaU1NaEJO?=
 =?utf-8?B?ejc5c0JkUDRVcmoyMVlJUitjSm1oamlmZnFWcXF2UFZ2WW1YVjNqMTE5UFdS?=
 =?utf-8?B?bndiN253L2psM3VOajlFc3BXNVpQdTVnNWhCSHZNQ2crWXR4c29zT1YyOEhM?=
 =?utf-8?B?TXlnZW80dnE2ZzNQTWxuNmx0NDZUS0tQTEJyZFRqMUpobWp1R3A4b2U4WGVw?=
 =?utf-8?B?U3dDRUpteTRzZkZwWUFRYTlkOFQ1MmhKaEhneGRVbC81UHJJclZ2dWo5dWdV?=
 =?utf-8?B?VEppajhzV0JYYzFBRkFqU01QUEJCbkpuMVNBNUJUejg3QjJPbmpxdlBKckE0?=
 =?utf-8?B?dVJ2SVFMTGloV2YrSFVYb2N6TnBDdmt3NktNT3oweG82VDR0NDVIeWNRZzZE?=
 =?utf-8?B?Zm5tR1NMSnBLUUF0NE8xbFdzQkZrbjlrekdVMXZ2V3NMWnY3S0RFQTVqaENH?=
 =?utf-8?B?N3B0VjNXRWRBTHJtdDJ0bDF2VGZRUTZUNk01K29YOWpQaVVGckdVWHVDRXZC?=
 =?utf-8?B?YTFjMlg3cG5XU3FqRzB5RjhhazZuaWNmY210RWZibHh2QnRPWHdONFJFWENz?=
 =?utf-8?B?MHNuQ2FhVU0wdEY0WTh0a2pYTlUwZ2Zsbk1tc3dpVTFzRFJDTjBuQmZYWHU2?=
 =?utf-8?B?SEpnZ2NvU3NWaU0yWXV5cU9KcjFQMUhZNVBtR2Vtc2hQZFZGc1VWK0JRQVdj?=
 =?utf-8?B?bWJKd2JtQzBDYWV2SCtXSXRpTUZRYUpKV3lmcjFlWGgrbFFiS3h0YmQ2bXNa?=
 =?utf-8?B?Z2NHblA1NFpTbHhsOVJ0MlozaE0zWENsVXEvWk1YZHVUa0J2UnpZeWROZmpC?=
 =?utf-8?B?ODFkazFxcFNuZlN1OWpZWDFDUVQ1akNtamNjTDByR2JIdWpyK2pLSFl6dkxz?=
 =?utf-8?B?V3BvNTNQbkNQc2F0YUdZZWRKYjhUdjlPSUtpYTZxODBHV1piMFhBaDB1TWJn?=
 =?utf-8?B?bUhvZWMydlAyOXlmbVVDV3Y1eXN4M3pDVTBlOEQwWnVZSlFoUVRyWWUyZ2Zn?=
 =?utf-8?B?dVJrQ3NzcXpTekZPb3piWDhIQTFqQU5Vdk4yQkxDUjN6M0ZWMDVNV0VRUm5m?=
 =?utf-8?B?eTFVdEw5ZDBvV2ZwQmg0ZzhVbDM4VWJhVmlwM0NaREowQWJvN1VYMGRsSDFN?=
 =?utf-8?B?eUFtdXg0WmdnZXZKTHhaRXBPbmd5ZmpKdW9ISFRvUVp5RUhGMm9OMW5VWFNj?=
 =?utf-8?B?RnRqbjlEM1U5azN5Z3dzdk83VE05bnJJd2RWOHJpSHVXRjNTSjkwMDJKdWt1?=
 =?utf-8?B?cHBERjRwSitnVjlBQmdubTFLVG9wbjBWL0RsYlFmTkFhNWthZk9pVSswcXBu?=
 =?utf-8?B?c1FLWW1QdFBqUW5Xd251UkN5aHZIRjV6WUxlczV3bE9rbTdyVDJYbGpkNE5y?=
 =?utf-8?B?VUsrSnVML3d2L2dXaXcvUWQxd0RvK2dKTGRqMUtaSEo2MFlXQ1ZiVVBQMmh1?=
 =?utf-8?B?VVV3SG1IaWhzaFZscnhLOEpaYm5uZ1pjRE5mYTRPMWFIRTJXekNucmF3dkt1?=
 =?utf-8?B?dmVJSnhTdm0rK25BN256RlYyUjAyUW1JU3dta0lPOW91cTY3clB6bENoMTdv?=
 =?utf-8?B?UlpnbFRHeE1TWWdTdlJ3Mk10THdGemFXRFNhWDVDNlBtRkZ3cXMyRXhVQWZz?=
 =?utf-8?B?UzBvOXEzSFRoTWV5VGVCK0RhSHV1cmlKQnBvMGdIanFMUGNJVmxIbHhmYXFG?=
 =?utf-8?B?RkJFVnhKangyWmhzR2ZBcEt5ekNucDNCOFVWdzhuZy9jbWE4TURybXc5RUFB?=
 =?utf-8?B?SE5DL0FrUiszSy9selZtTWg2QmhUN3lOdVdzQXpuOG4rN2QrWnZ6UTlkV2dV?=
 =?utf-8?B?cU13aUM3TjJxWldqMlNqZnRXN3ArR2NMbTNoN2djdVNBRUxYUlF2NkpIZHo1?=
 =?utf-8?B?UUR4NDRLZWppSlZ6dm1pWFJtQUJveTBGMmFRdERwK1p3SC9FODRhbGQ3V0Rx?=
 =?utf-8?B?b0EraVFxUzlNSlUvMWlKQTgxdUo5bjUwY2NLSHFORXJiZHlpcUFFeXpaL3VG?=
 =?utf-8?B?dU83dVo1WDJjM2ovd05DcVlUek5mNGlXejFHV01ITUhoM0tmVHFmZG1BdWpm?=
 =?utf-8?B?bFRKaThXVHlWRENGQWpNeW5HdDBLRGhmZHV6NzR4d1VTdkpUSnROdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c04afb4-abf6-488a-b8b5-08de9298e5dd
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 22:24:12.3941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8CnYE1659vE2xkzUbc7HUt6KzFv4MhoCLNq8FQKxTwfKFmEZm29KBHxqp89OHISH4N0KsavWh7HB7oTGIiKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8020
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

On 4/4/26 5:14 AM, Alexandre Courbot wrote:
> Commit a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> dropped the nova-local `DmaObject` device memory type for the
> kernel-global `Coherent` one.

Hi Alex,

The diffs look good, so:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


A small typo in 3 places changes the meaning enough to throw
things off:

The subject line should s/align/pad/. Alignment normally means
adjusting the starting address, whereas padding is what you are
doing here.

Same in the comments below:

> 
> This switch had a side-effect: `DmaOject` always aligned the requested
> size to `PAGE_SIZE`, and also reported that adjusted size when queried.
> `Coherent`, on the other hand, does page-align allocation sizes but
> only allows CPU access on the exact size provided by the caller.
> 
> This change runs into a limitation of falcon DMA copies, namely that DMA
> accesses are done on blocks of exactly 256 bytes. If the provided data
> does not have a length that is a multiple of 256, `dma_wr` returns
> an error.
> 
> It was expected that all firmwares would present the proper adjusted
> size, but this is not the case at least on my GA107:
> 
>     NovaCore 0000:08:00.0: DMA transfer goes beyond range of DMA object
>     NovaCore 0000:08:00.0: Failed to load FWSEC firmware: EINVAL
>     NovaCore 0000:08:00.0: probe with driver NovaCore failed with error -22
> 
> Fix this by aligning the `Coherent`'s size to `MEM_BLOCK_ALIGNMENT`

"Fix this by padding"

> (i.e. 256) when allocating it and filling it with zeroes, before
> copying the firmware on top of it.
> 
> Fixes: a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
> index e0315fda576b..eb0cf1f7329a 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -11,6 +11,7 @@
>      },
>      dma::{
>          Coherent,
> +        CoherentBox,
>          DmaAddress,
>          DmaMask, //
>      },
> @@ -613,8 +614,24 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
>          bar: &Bar0,
>          fw: &F,
>      ) -> Result {
> -        // Create DMA object with firmware content as the source of the DMA engine.
> -        let dma_obj = Coherent::from_slice(dev, fw.as_slice(), GFP_KERNEL)?;
> +        // DMA object with firmware content as the source of the DMA engine.
> +        let dma_obj = {
> +            let fw_slice = fw.as_slice();
> +
> +            // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so align the length

"pad the length"

> +            // accordingly and fill with `0`.
> +            let mut dma_obj = CoherentBox::zeroed_slice(
> +                dev,
> +                fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
> +                GFP_KERNEL,
> +            )?;
> +
> +            // PANIC: `dma_obj` has been created with a length equal to or larger than
> +            // `fw_slice.len()`, so the range `0..fw_slice.len()` is valid.
> +            dma_obj[0..fw_slice.len()].copy_from_slice(fw_slice);
> +
> +            dma_obj.into()
> +        };
>  
>          self.dma_reset(bar);
>          bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
> 
> ---
> base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
> change-id: 20260404-falcon-dma-roundup-0edd764a9840
> 
> Best regards,
> --  
> Alexandre Courbot <acourbot@nvidia.com>
> 

thanks,
-- 
John Hubbard

