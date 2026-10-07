Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A486CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87C8310F6B5;
	Wed,  7 Oct 2026 15:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DD1EUKZL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0052310E4D1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 15:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByApR1vvEhYbxgp96sf+0Y5iynOpNBJqqlrabIiLfGOgBVHAj4Gn0pSjJqtrF6IDIC9bKW7XayLx4UvpZRfRCcS71Sb9Ws9H/mhZHjRaeOGaiV8fFMz41UQr/cZC79FXFIhYiR0iPg7MkyLZGif/3OLFx+QIELMJdM1dBF8ogr9TxgzfP26glWzyJ4dl2o9LADKqgjR+MZT67rJMLP4rid+tM3ETFulcYR6GorB0G0xkN7RbCteDM83C4o77FQ46pDjR0ofHWKYVghJfA8VLUP9ybjYuzTVvYJoPR7TDeyhCnVHS3JYee5NdW/GIYYyMWge8hJbRSVM9pBkAasGTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz85Dk0BKnQg1xkZo4YmLVVhLiRQFjdfKkKk4qoiayg=;
 b=wdnUG/2mZ0MMbWyVbtYUZK7wM0xyFJg9LJabpx3vg98BIT4NJv20O29QIYFdfK4IoYUwM6ql4N6H/8RKMzTZjJq8fiN+haS4tx4mpbrH/qFpUYYK+i7PIo99BfMPqP3CyvMVCINL2Nabz2AdJqZEqOIeTOBmhae15nBaSech47tqBYjo6/tI5Ff9kScrRiR9A0Rdv1mEa7Ft4uRnXnmENbugUDrNpBMWNAsQf+JxfjZI/6nVoSjpfSgzQx28PVopn3U0a9+M2XlvFQW5bAqkaAzUIQsj8d1I9oHATXm3IBnkUuhN8cm+N2/LBhR2Ujqaqmg6TsxfxuTP+omjV8Y4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz85Dk0BKnQg1xkZo4YmLVVhLiRQFjdfKkKk4qoiayg=;
 b=DD1EUKZLHbOetCPJ8NnK0UIH/PkVobt6oS/Y/0z/bSvj4dsgjeO7ROO6lOetEUp2MYtsh6sOse6GIiSHK4wAOh5c38HnALgCSwd67aR9p5q/gWh1u4MrNCfsvX2DUnVI3zCMvUKN4looDvfOyf7eYG1zcQ1H6dz97Z3aTEnknnfK/tYnVLUJNHVX2M+YGYkf7yCtuW6QZG4cu/wgYTBQuCORGJ75qaJN4RFsz9G1sLj1BXcjKO5NIKTX4EqOd7juC5oDNj0ezMbcULEldQxSQeyVYuzNx8hx/tXwCeRarTA6M23ikz8189ItNSg9rYO35nTk2DjnXdmKg5RNBim7mA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA3PR12MB660778.namprd12.prod.outlook.com (2603:10b6:208:61d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 15:29:17 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 15:29:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 00:29:15 +0900
Message-Id: <DLYPOE6YLNWU.2PDPIJN9TDEGD@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Thorsten Blum" <blum@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Tim
 Kovalenko" <tim.kovalenko@proton.me>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: firmware: fwsec: use zeroed() to
 zero-pad buffers
References: <20261007080708.124563-2-blum@kernel.org>
In-Reply-To: <20261007080708.124563-2-blum@kernel.org>
X-ClientProxiedBy: TY4P301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA3PR12MB660778:EE_
X-MS-Office365-Filtering-Correlation-Id: 801fe9a6-d056-4902-4d29-08df2487c047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jIgJcCTg9G9RVUnLLoplsSKLsSbKOe6xwJAEtSGoMuPG1iZxcnn6eKAUXsRXCgSxEOpu/5VLz44yF3fA/B8sPEnSzdHrqw6DetBPzy+KBRBgXlGAC+vFhRG+sIgzw2F1oHumL/RgqwkKX8fvALdpMvLNpAaSADQX9fW7PUfsHSp6113cSPd3o0ipm54oAx8IKYAYB5ji8HSd45IRfAzSxGSg89USsPp6hVaf+IpLRZMd3TqwRJUBOIbSskXZL8qkpZu/RZrhvAznzE8ET1i8dWM87zwB69YK/RGPzAAoFe7me9mwW9dx9GFNreDb6v2jujcMK58PLI6tRzygX+ZPB6nhXXWQgWJsKN5rTTf/41g+qn6Aolk59w5egzcxCbZYGNuJqOc01wocc4DugCnXoa0r8MG9dmBFAnhMOfvzhGVCYcBlx+sWYAPvMWXyMVRpKwURzfOArlNChatbpbUXKHLDcqYV/2BYAapw6DvwgPeH/Tgwx0/npYwTIe9xztABby6MTCoYuXKKFoBrRpteNsVByq9F7CSRec8hyysNkwEXqVVkRGC21XXy8mIndLwWl2WcFVGzeS7QLlpPP4KBGum6/jgdCoakG4fedSB9qUY5XTqWXDPe65dtiva3Gi7W9fq3TDKAtzzmWNfsJ/KN5YR2M21hDWZPYoLmK6OqZr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xLSzkzVVNZMVR1NkZIbTNIS2tiejNhUVM4VkRQcUp6ZFdHeWp4UUViOWFh?=
 =?utf-8?B?a0NzNFR4M1Vrenp5U2JGS0RycDgzSjgwYjE1R0xtOU1GWng1QVZTaTZISHRN?=
 =?utf-8?B?aFhwbzJqNEdENWhYN3J5L3pjVG5jcENhVXhhajVacjVxcC84WjR2THpaNXdq?=
 =?utf-8?B?YUNlOUdSL01ibWZaY3Qzb0cyVkhzM1dsbEhOcElQNDZ3aTFnbnBDWjV2MktH?=
 =?utf-8?B?NGNnQy9Vb1ZUNEhjNFJWdzgvNDVOcUI5dFRGbnpzamVZYkQ3M1BMeTdMcTFC?=
 =?utf-8?B?N3I1Skk1eENmYk5ZTE4wb0RpMjdFd1h1a2cweENyU0l0OEs2QUo0T0Z6SGVY?=
 =?utf-8?B?WDh3REQ0N2VvTEd6TVplaURrQ0ZwR0MrVDZyMjdmaXYxNVc1UGlCMXF0Tkpp?=
 =?utf-8?B?bzRrRWpuS3NmOVhkRWx5ZVIvVyt2ajM2eVI4a3NYYnc0NW5CdFRoS09hV1hz?=
 =?utf-8?B?YTdOc3UrZ3hOUHRtNjNXbGwrUHEyNitISlpFSnBwRy81NEEwOUNyVjZQMWZi?=
 =?utf-8?B?QjN2a3M5bVZuVCtPSHVLRmNzcVZDQWI2ZjRQa0RnZDdzL3QvRWxTNXF0TUY2?=
 =?utf-8?B?U3VONVFPcUNtRlk5ZEhBKzQ5OWRCL2l2ZUJQbHI4V25qK1VDdGdiOEZUaGxy?=
 =?utf-8?B?WE5wTEJTcVBpK1VuK25wdU9aTWs4U3FxaVVuWmVVYXByY0FXejlFZ0d6d0pv?=
 =?utf-8?B?dk5hVTQ4MUN6c3ZRQjZacVZCYWhqLzJJSWlBSm1xQmZnTWRDR3FiQmRvSUo3?=
 =?utf-8?B?TGhwU25kK1VpMklkSFNJY1hHbHVjbzdLRHVibGorR1NNRlBVTVF2TFZIelUr?=
 =?utf-8?B?ODkzSlFId1NoYmhwbk5TOWJlaVhnR0phSWZqZFZPV0sxTkJFZDk1RFZicDlY?=
 =?utf-8?B?SG5XZ0lvR0R4dHh5QjFLY09iZVc0cmcxbUl4YU5LYkluZ3FwQ3RYT3lHR25k?=
 =?utf-8?B?eURjb3FOZk4rNDBXam9kdGNUUSswc0Z4OWg0UnpmZ0NWTVQ5bmZLR3hrUTVY?=
 =?utf-8?B?bWh0OXhoTWZ2dUk2LzJ1eUhsamZjSEVJSVk4S1pzUmpBRzlNNkRnNkU1eUd0?=
 =?utf-8?B?cnZoalByODZDVUJyc0VZYjE1dXNKM2NNTDc0Z1ZvMnBjem9ReU5peERSb3l6?=
 =?utf-8?B?WDNMeUtGT21sQzBmZGdNQTY2T1pLczhzTzFwaVFrN1BnRHNHNW4va1gwSVBE?=
 =?utf-8?B?VHZoL3YxNE1Wb0QrTzVQanVmR0orN09LdHJRa1RBVVNNeWswVEFvVkRtVU1Y?=
 =?utf-8?B?T2IxbU9DSUZIcUpvcVVUSTllQUF0NUovaERoMGp4bnI1SisvVDlaZ0VodlU4?=
 =?utf-8?B?Ri9EaXR5S3VPczlITkZuREZtVFZEcWtDQkpOMWFLdmxVdVhyUm9vQUZVV09j?=
 =?utf-8?B?djhiaEdOV0RsREJQUHl0M1VkanNMVjlXbjNuenVqWVYxOVVDVFZXRHRnaEVi?=
 =?utf-8?B?WHZWREMrSkRZTjFlODFBUDlPU3g5cVNjWWlTbzhsWnJxVmF6OUUxczVJeS8z?=
 =?utf-8?B?bnNFdEZpR0hIRGFVaVVrc2hnQXU3Rkc2VmZmV21sdlFVNW1YTUowd0JmRjRK?=
 =?utf-8?B?cStNVG8vM3ZBQ1dXWWVXc1VOMFlMYktTaGc2dmZhdVRCUitrUXhYaU45bEVI?=
 =?utf-8?B?THRJdXUyMDh5ZWJUZmRLVURyVVVoelFFOHpRYW94aHpmVi9qOE92aVN1eFBG?=
 =?utf-8?B?Z3FyVXlxSlhLV1U3UTNReDRhaG43cW5zSXFxSzJ1eEt6MUlyZ1M4d0ZOVHNt?=
 =?utf-8?B?Ui91QzNuN2dHMkIvMWlZVnIrdEkrTGRIMVgwOUt0YVB1TmlHNTd2a2hxNFNS?=
 =?utf-8?B?TThEeWhJbEdyanBINVN0ZTlzblJYZUxKWnBwYzV3SmpUcFE0OXlIbVNqMTMv?=
 =?utf-8?B?QVVCNjFjK3FiOHR5QjR1c1VNdFJOemh6R0txRmtxNzBRQXFYYUxoSXFhemoy?=
 =?utf-8?B?VVBtaVVQVWJQNTJ1WU1vUGFaNjF2NDdYRG1Bclgzb0xyaG5BSEdzT2MzMTJI?=
 =?utf-8?B?VEFrMjJwNXB5bXMzdFZjZklFdXhGMGc5UUJhTUdvMVliZEY1WWtJeitzMm04?=
 =?utf-8?B?WlZISU50d3loeDZVVlpQbUtkZlN3bHhDbGphZllrdVFuaXpoNFMzSVhHbm5p?=
 =?utf-8?B?UVppSU84d3RybmZPNTlSQUFhVHRhVmdaaklaOWNwVDlYOGdQOTJ6eElxeWxM?=
 =?utf-8?B?Q1dlelRpQkE5RUdOWmFZZG9mSzdCeHcvTmZZcWNSWlN5ZDZkNm1VSWdyQXZp?=
 =?utf-8?B?S3Bid3U0MGlpRWppNE0yajBZUGtPaHpiWjZkb3MzekVBb09GcGNjN3NmYlpJ?=
 =?utf-8?B?b0NvdmhMYUFIWjAxemYycEg2STdqa25KS0c5ZlVtc2M3VDBEekplbnV5aXZ2?=
 =?utf-8?Q?z0icdPmjYFcONZvgzJLqTE58rYDkPtEH+mbRuSzpYd18E?=
X-MS-Exchange-AntiSpam-MessageData-1: 9c4oHJpvj5Beyg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 801fe9a6-d056-4902-4d29-08df2487c047
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:29:17.6087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrqt7QXra9lrY5s0E1SK97FpnTPHYETzF92oA2sS+Y6vmeZ5fc5Ld8V3NxrEotAA+OyxoaooKbynW8HVBcAB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB660778
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

On Wed Oct 7, 2026 at 5:07 PM JST, Thorsten Blum wrote:
> Use KVec::zeroed() to allocate the zero-padded microcode buffer and copy
> the bootloader code into it. Also use KVVec::zeroed() to initialize the
> firmware object's leading zero padding.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Add a // PANIC comment to copy_from_slice() (Danilo)
> - v1: https://lore.kernel.org/r/20261006100442.80432-3-blum@kernel.org/
> ---
>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers=
/gpu/nova-core/firmware/fwsec/bootloader.rs
> index ec4d92317a93..1aa08ae8de78 100644
> --- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> +++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
> @@ -137,10 +137,9 @@ pub(crate) fn new(
>                  .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT=
 }>())
>                  .ok_or(EINVAL)?;
> =20
> -            let mut ucode =3D KVec::with_capacity(aligned_code_size, GFP=
_KERNEL)?;
> -            ucode.extend_from_slice(code, GFP_KERNEL)?;
> -            ucode.resize(aligned_code_size, 0, GFP_KERNEL)?;
> -
> +            let mut ucode =3D KVec::zeroed(aligned_code_size, GFP_KERNEL=
)?;
> +            // PANIC: ucode is sliced to code.len(); code.len() <=3D ali=
gned_code_size.
> +            ucode[..code.len()].copy_from_slice(code);

As I mentioned on the previous revision, I think not inserting panic
sites should take priority over other considerations. Besides this code
effectively writes he `code` area twice (not that this is a big
concern).

I guess if we want to introduce a new `Vec` API to cover this better, it
should be some kind of constructor cloning a slice - `from_slice` maybe?

>              ucode
>          };
> =20
> @@ -162,8 +161,7 @@ pub(crate) fn new(
>                      .ok_or(EOVERFLOW)?
>              };
> =20
> -            let mut firmware_obj =3D KVVec::new();
> -            firmware_obj.extend_with(align_padding, 0u8, GFP_KERNEL)?;
> +            let mut firmware_obj =3D KVVec::zeroed(align_padding, GFP_KE=
RNEL)?;

This hunk is fine though.
