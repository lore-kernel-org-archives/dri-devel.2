Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEF7E88D9B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7D310E304;
	Sat,  4 Apr 2026 13:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="m9r9MnhS";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020118.outbound.protection.outlook.com [52.101.195.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4871510E304
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 13:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJOvsNynpMqQESKJxcuogfL6f/s+Mqi2HPAWNFM/8wN6NxD8Xa2HTVyNwpwC7CvNzRzi35HiDhy6ovJidNSUXAh2OP0ykD5diOA+U9uL/hF9FlapwaY+n3s2wfpjYWFLUzsQK8NAMtxdRgcQeWP4x2cKz8BSceqMoIm5qphm3Mr9KytioOhjpCDhliwOX4cja3hBDuYkqTz3FRVDJG37lsq/5Gr0LdS4PU/tqDdOBsJnvPUV9TIoSwF5YoXM0Z7e39bFAkhlzR8iLpPaOCfSyx/+D2IWbX0lCNlnY0oQz69oQ59rOfK1y82xTUKXhywUSr8s0dHPGRvWj2MIfdvZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQafTTKW8QMvg8Br182gIY/dOHs6vAPH+R6I+tBzy9o=;
 b=T9fJkeCnObpJvs2qepFoC/vGtDnMP+agM3mgap3UlFzfG8r4xwVNuiUOO1WRsde5X86vCdTuyBbYBwy/l8WX947LjgUjuLGViCVxZtdKzqTHwNlEwe+aMXYveg4dG0FiT8YIv8CJUimYW/7UJrFTN33mc71gCYSrXP6y/Yqgu5VIFS4OEqQpdENT6YIWAN9ggbeORUzeaoIAVrUFWCUrDcGqG0f/adMtGO7iJJ2WDc82Usxe/BHLZFojFWeijNRIMWwE9ahPyJt/s3lPZ7a+fDgsi4jrwy5QaI/s+Q6JPpG66exva1eY3Ci1Hhx9vlYrcsjdvCoDwh/vaD0W9jkWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQafTTKW8QMvg8Br182gIY/dOHs6vAPH+R6I+tBzy9o=;
 b=m9r9MnhSFFystfBBRM50v/5j2a5ME5gdoCnYFifjmiHQ904dBRBNNTMqF0E21LsJ7b3oMgQZZeCknQZxeVLbKwXmE59x71tEyEFr255bvvfg/+QNd7eI9oQ3WKYS7a/5Wr+bs1ZiCG7h/dNGGh0yvNOkJF21lJ5spCrfkjc9OLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1798.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sat, 4 Apr
 2026 13:36:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 13:36:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:35:59 +0100
Message-Id: <DHKESCOZB9HU.1NRXV9J4Z8EB9@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: falcon: align firmware DMA object size
 to required block alignment
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
In-Reply-To: <20260404-falcon-dma-roundup-v1-1-1f56d808b091@nvidia.com>
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: f047ca81-218c-4a34-bf12-08de924f1c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0jBj4xzpajUPbPXpoUJlEqkDuOFdJHTXdu/sZ0wjF7lfRel48uOQvIt8n2aE6OhFMwAUzLQuIiluLw5Z7a2cKexnzmooMNccnHdm3gQQhitQGoL93iPS+tZvvhFnVmHwtoSwkcWQJZOQS8iNymKYo5IbV4xE3X01wJGi63lDgKx7jRdFhbCuoV0VtoBxV+ApCYcs4sjIhjkmlvQwJDltwHEsdGWpET22a0x7fGjziL/ogT+AQdIRlLhpK1xa5h56wwEFJMlqvpPmjcsmTvBUMu9G7VUmDzPmgsBqANZoeKRQSGKBfI/E0ZgQFgpU4W2++YnrwOrdQEUe3eJA8EQGWQhcv7ZCGpK6uDrjnSMCbjffQt7FGwo4Tq9Ykm+RDIMrQ7N7kE4W/pZG2o2WbPu+U8u6cFY8tSuS/mnoZTZSVaJlBg3gflwwihHapVwIER8Fwt4LoiV01yTbeeX8othPl/0JpbIqtHGpJP8C5JaiuagCwKJfEqC/zJdNvhCv7sGBmLTMzJ5hsU+j4JOkP4VXcbEcn1x1ghGk8bnB8e2y+805XCIrpINGdD8263W3rDXFzNBZXxJLN50ZcmYc7HoLA3sevBk4Hasi8ScPopgu/QYiDJoqy3khnCtm3DLx/Mzox9ViD4tRSNc3lnBL7w7StGPDYTzZN4ATBHE7OtdMY2sgDmf3siLVTTd+MC5wCItYUgalduJViwzinDYt5X3mE2ctIN93f0Sv1i9hkJGt5xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdwcFQwT1FsZVlzS0pjdnpTeDJ3VzhOK1VFOWJMeS9VZDFBckNKVkJCUWFW?=
 =?utf-8?B?ekRXb2xQbjdkOXFwNDRMSVpxb2cya3diY2dqWmU4MkF4RU5GMyt6UVFrZzNF?=
 =?utf-8?B?a1doUFpTdzlSRHEwUnVRUGFBcEJYRjVubExzM0g0NXNWMHhEVi9aTk9Bc0U0?=
 =?utf-8?B?ZEFyU0x5NkQ5ODdvYldWdjVsTE1ablhLZGxwOC9qMzhoajZ0bE5NQUphWEJq?=
 =?utf-8?B?VldOWGdodmlZb3hwa3B0NXZ5SHFTVXc2QUhwV3J4UmE0WDJteG4xckJDNE1a?=
 =?utf-8?B?cXNUcENrUGNHYzcxT1RQUEs2ekEzZWhCaDFpaVE3bko0WWZSV25vbWoySzlQ?=
 =?utf-8?B?b05YcXNKUG9CTDRoaERNUWhqMnBnRHhZUlArMzBFSnAzVWtWdnZjM3dleTMw?=
 =?utf-8?B?Y3AyVUFkaXkzNDZvR2t0TnVJVW9sRnNqWmhvamVza0pVQ1R5ZEtkODJxQllE?=
 =?utf-8?B?dXlGaUdRNnRGVWFlWnFOU3g4TDFtT3BQWERrY3pPcnJWb0I4VFRVaDlaRGh0?=
 =?utf-8?B?WFRKOUV1YWwyMkI3ZVY3UUNjTkhKYXBIZTVYdWlZZlhIaTU3RTQrVGp4L3hZ?=
 =?utf-8?B?TFBLZU55WWNpWVdOQWR2Y2VTdERCTUJveEluOHJUcEErRVh5ekNLWWNZZE5i?=
 =?utf-8?B?VnRPNElSZTNiNm5ZSkJVNnZOZmlJUDgveDhYQUYvczJPUFdENXJ5bWFJbnhY?=
 =?utf-8?B?STl5ci9uOVhkSitKa0djVWhBQmR5RHRtNzVSSlBaS3VESVhqL2hwYlVEaUJw?=
 =?utf-8?B?MGxZVHAxaUFWUXdtRTlTcTBQa2xXTlN2Q2ZpT2JSeWhZU2tmanY3aWNDeXds?=
 =?utf-8?B?WTd0T3Bmb2lzdUtIZ094SGRpRzFudTllOGN5aXJWbnByaDkwKzFjMVBLeHY1?=
 =?utf-8?B?RUtYb1VodlNFcE9CZTVWQjU3aHNSWkF4bVkrdXk5bXd0SXNOaW9Pb2tTZzVG?=
 =?utf-8?B?Q3VwMy9kOHhXa016N1FTRjZSSEc3U2dheXRkakNsbyt6dmMxZnNJUnpqZUpq?=
 =?utf-8?B?MWF0Z09UWC84UXhVWE4zTXpPaTJHQlFjZURHK1l1VGpNTmRaNVVQd2E5NndF?=
 =?utf-8?B?WXc5ZkhEK1FsUWk2ejhIdDh5K2lFSTBvUHJqbC9kVzlRU0VBdlJqOE94dXQw?=
 =?utf-8?B?bzc4ZHVwV2M2YWFpb0xQeHhIU1VyUUxEZEVBQWs0UjFzeGY2Nk9rNUovM1VJ?=
 =?utf-8?B?WDhKcVVpUmNxNWVYNGtPUWt2UlRmNlRtdklXYU5lcUR2bEhUc01YaXdwUk9i?=
 =?utf-8?B?SlEwbUZvL0VLUWxUbTRxaENyNGtwYzdXWnoyTm9zNDNiVWJoMmwreS9lbEo4?=
 =?utf-8?B?MHBzTlhyS2tpMUROWTdFejBxSlpINU5vK1Rhc25GandQa0g0Qm03MnZFanF0?=
 =?utf-8?B?MmhNY0xRejhQcDBqTTVNYS9xN2E4SWVyZGJKckEyQTEyNVFyaVBncmFqcW9K?=
 =?utf-8?B?NFdRZ3MwU2Fsb2l6ZVgxenkyeU5NNlllNTlPTWZmRmFodXBWbi9EbEludUVT?=
 =?utf-8?B?ZWpGbmpQOGFRV0k2V2x1Z2hMWW1WaVNjN3l3WDJxT1ZxWjBtbU1pcHhHeHkw?=
 =?utf-8?B?WUQ0eWZXS25KLzRNODJjY1pyS0RZSDg3L0lsWHRjRTF2WEk2RGViSU1SN0Nn?=
 =?utf-8?B?VDRNZnlSUTNvaWVxc2ZYZm5DRHdEQzI3ZHBxanBaU05jUkYrcVpWZnJ3VHVZ?=
 =?utf-8?B?WVlDZmZJdEV0bGtZU2lnSUdHWml0enpKUUxNK0VYN3J0ZTdqc0hJUzRXamxW?=
 =?utf-8?B?R2N4REo3dHh2bkRWWFFRVzQrYmdCZFQvdENGMWU3Z2J4WlFhc0pYUE9RL1Ex?=
 =?utf-8?B?YXNWNmRFV0Z0ZUVxZlZIZ21meUtNNHE2YTZoSjBXd3MwVnpUOVA5Rk1HZU9I?=
 =?utf-8?B?ZTRZVldtWUhDbWtQYjVoNFVjWDdITFNsaElCN3NVK0dhaVhvNWs3d0Y1UGds?=
 =?utf-8?B?YUM0ZmVxVkVveVdXN1I2SUlCWkppYzEvdC9PMmJvS1lZNjdtYi8vZE5idTB2?=
 =?utf-8?B?Y0hUWUQxUkJkQlUzL054Y05vSjVjTytFd3dsdW1XWElWZnhPWm1MZzVQU2hv?=
 =?utf-8?B?RDBnTDZNMDcydUlyMzNoeTB3T1NlYldXRnNxZUN5ME13cmQ3UXVoNlA2V1hs?=
 =?utf-8?B?ZERyUjI2dURwYm1VQS9JMGVCa2lJakNudTVTVUlabGdKOFdiWUQvNkI3bFdY?=
 =?utf-8?B?VzhmTGVvOFFFM1o0Z2UydVdhZVdzVXJYQ2RHVTlMN254OUdNNjRzQTZQdkdM?=
 =?utf-8?B?TU9YNVU4RUc2N3VoUktVSTlTZ1BnQlJia1NMeVYyMkJva2tPbVk1Q0FrbjNW?=
 =?utf-8?B?QWxUWE9kakM3MWNEZlVzNGo2SUZYNTFIMS9FSnhSeGhpUXNUNWYrdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f047ca81-218c-4a34-bf12-08de924f1c15
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 13:36:00.5409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATjL8JWkWnouSFXgZnuhVUUE1abR+nsLHNQ2OJ9FH/DKo+DpP9QFJ+agdwt/Q1dXulk08Ggs3vKyIKp3+eCCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1798
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

On Sat Apr 4, 2026 at 1:14 PM BST, Alexandre Courbot wrote:
> Commit a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> dropped the nova-local `DmaObject` device memory type for the
> kernel-global `Coherent` one.
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
>     NovaCore 0000:08:00.0: probe with driver NovaCore failed with error -=
22
>
> Fix this by aligning the `Coherent`'s size to `MEM_BLOCK_ALIGNMENT`
> (i.e. 256) when allocating it and filling it with zeroes, before
> copying the firmware on top of it.
>
> Fixes: a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/falcon.rs | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
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
> @@ -613,8 +614,24 @@ fn dma_load<F: FalconFirmware<Target =3D E> + Falcon=
DmaLoadable>(
>          bar: &Bar0,
>          fw: &F,
>      ) -> Result {
> -        // Create DMA object with firmware content as the source of the =
DMA engine.
> -        let dma_obj =3D Coherent::from_slice(dev, fw.as_slice(), GFP_KER=
NEL)?;
> +        // DMA object with firmware content as the source of the DMA eng=
ine.
> +        let dma_obj =3D {
> +            let fw_slice =3D fw.as_slice();
> +
> +            // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, s=
o align the length
> +            // accordingly and fill with `0`.
> +            let mut dma_obj =3D CoherentBox::zeroed_slice(
> +                dev,
> +                fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
> +                GFP_KERNEL,
> +            )?;
> +
> +            // PANIC: `dma_obj` has been created with a length equal to =
or larger than
> +            // `fw_slice.len()`, so the range `0..fw_slice.len()` is val=
id.
> +            dma_obj[0..fw_slice.len()].copy_from_slice(fw_slice);

NIT: could be `dma_obj[..fw_slice.len()]`.

Best,
Gary

> +
> +            dma_obj.into()
> +        };
> =20
>          self.dma_reset(bar);
>          bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| =
{
>
> ---
> base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
> change-id: 20260404-falcon-dma-roundup-0edd764a9840
>
> Best regards,
> -- =20
> Alexandre Courbot <acourbot@nvidia.com>

