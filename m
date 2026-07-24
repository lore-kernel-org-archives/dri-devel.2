Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D94C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9E010E072;
	Fri, 24 Jul 2026 18:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ig3+q04G";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611510E072
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWEP3wVrGAnTiDgRKJZ5pO9OiEYi2O6UNfDQa4fIZRCeNZcv0dEkr1mJvXy3Eh+ku1ZypqiLa/p9adcVJ2I+ex16Z1mZ7wBNprwGCAc5DV2OOwB9z2pOTezdeeLY89I4F2WBHJy5BjR/RQEEfk54x5ENsVmeSX+Rzq1lQd37xjskKBvrc3BqGZvgvLA79zSF+3fBT0MOlbcmDXZv14SxhdqNBhChI5OckXPDsIrm2SO1Rpv2unXoObO5m0EyVMxfL5La27QuEtX+RATJxx0WIw9NtftsqW37uirsE+WGe/gwNx0Bittcemghk7GYH8zRKrPatBSKeegcOa98nnuP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgkV+ZvU6cVHG2a7rF+5ajLGSVWITQ8xJqLd8uiQZ8o=;
 b=CDXCXj1eAiNOWcB/7VznWJEJfOQ+DuV7hdoTjY2waXP/fHU2viIuEHYkIIp3riEXZ9ibEWbcPp8vtQJlrgQZv0pV8AAaMVCgxbGmncgZSRPM6nbpE85dELrnTIbiFh4bpRwPc7qc0yKdfK0eUkNmYzGwiNC8UotlH07PhDwntZ8RzJXMAHiFtlkVhaNzS3v1N4O8mMrCcrM918xxsoTQLnEnlhOaTBIpzlSkEMwAnwDqY9IEaIDa5MqVGqkES2k2U9XrRtW+DW/f9A7ijLzIx1xMMgShtfrbo+FybMNOvaevUI3l6o9Occ5Nh2lEWo7c4H1sJKNKCHFEGgJGa7kp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgkV+ZvU6cVHG2a7rF+5ajLGSVWITQ8xJqLd8uiQZ8o=;
 b=Ig3+q04GCTO51U2Q0ttpOGn2qUKNepNe0vu0hfMf2/pgne3Ay3MKOmwzywN6E0O0BiWLyv5fUgwdtJX7tZ5d/0RdktJE5a1OFeZp+txnmCYUYkHmx8dDGwi7d4B9Hv/lnK9tgD08HAU0dDQymQxnxUOOvoW/uStcVpVPOAC/GZKIXeBPJgjSmwZRT5CXfWIKmM5u0EYcpoDA77DuekQ1otBP9hHtP3TLIcgv8Q5DJ8wndGZy/oW4gL332dCMyr3NI3BqEkPGBL6jn1BtuNEOf15n9Er/KKyYKN6ToNU0mAuFOpYorxiR+Gnl9i5N4rx1ZNRkE0zp0ejltrkyZzUijA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 18:10:42 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 18:10:40 +0000
Message-ID: <e7ba2c90-6d4f-487e-bd25-56d568ba1f26@nvidia.com>
Date: Fri, 24 Jul 2026 11:10:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gpu: nova-core: falcon: use I/O projection to check
 transfer bounds
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
 <20260724-falcon-dma-projections-v1-2-957028a7c0a7@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260724-falcon-dma-projections-v1-2-957028a7c0a7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:332::35) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 7481c31c-c8e5-4413-df6a-08dee9aedee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HX0Q4kMcHNTBAAY9qNfUyPEAEbmdE8SGQhpjNfsbkdKMkEpjlNA5seN5eBthondmXoIT4FLim0NQs6SAi6kqjC0068wplK0eh1syhpP089YG4d65v410dzBs4qphFNzmsSfl1uq+o+Q3L9Rs9tfKetYkcE+xZh2cTKf09iL2EtRncTOV4TKj6c2iknHAyaoJEM/Km4fRcKdBhQLlAgbQUlkUeGfQvSkh6RyR9O3yf/HcWJGPb16JVxUSmpWn9WR6SxNZmmW1gOtvkk9Qpejm/yHHrijDFRY0zhsMRl5adYFK2CbB+CQsox53OY91f1+UwlRc4X0MzMEbFEzgoGlvb8HydIGATtMDP5w/WOsn+w7PpTWnbakb1EON/gCB6dXcTBb8TcZ9fWPJhCBc44bm/3OPlk9d0EmNkjff8nyLYAyWZUC9UDrW7HPbeM4BOO4jrGJzZoCVSyhtw/NELybIj2R7SLIRDktt99iC7Z81vwDR2HJJLtDOg0x0GMWR4FBi0DPiV7ElTxwpTDvztSye31X2GAhOOE95IjteuMUVwGDuhbWOylwzY1W723wQIEmoOpw0A6bCDfUizddnVwFZBRQEsjG90oQhj8XKZIbZp+3XTJyyVLR/o4+H05N3XfkXKMcxplUfQC+jdn/GLzaXinMVgfc0R0IXM6GV1sjRqIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2UxWEVDWjl4QXp5TDJ6cVhkaU5ycWRVNWFiVTU1UEJ1NEYyUnhBVDFaWHZP?=
 =?utf-8?B?RXRHeDRKL1d5QlRyUk92SU5IeE1xcDYxMG1XNVl3M2RBdDk3MXdyL05CQkJV?=
 =?utf-8?B?Q1huS2xsbklXWG1CVGZQMC9QL2lROENGdGpUc1BtY0hxNGswZ1NZNDMzU2Vq?=
 =?utf-8?B?eUd5VDBkQVBCdXBWOEhPbkhGMTZIN015bUxpODV3WGNFcThFWDMzcXhsZ2hR?=
 =?utf-8?B?ZlUrWVdNMGY3dWFGQkZIYzJhc0gvL003b2xZTG5hQ1pLS1JBWXUvT3cvelpD?=
 =?utf-8?B?WkxEanAwTS8yeG53anpNSHdERGN5R0dBQk1EeXBvMTRCQmY3amxyZ0NRVWZu?=
 =?utf-8?B?Zno2eVNXNEJLUmpLYjE5S2poNXNST2ZBcGhCSStvZGFjY3VwN3dNWlhtVU5W?=
 =?utf-8?B?WC91a0xGejM0NjRTL1VNdHNGOUxkQ1FETnMzVko3Qm9NSTVUU3YyN3B1OFhO?=
 =?utf-8?B?RWhrUDFVa0JQY25pYlYrMUlCVjRSN3BTRmJmT3ZocVNhNnk1UU84c0pYWDJt?=
 =?utf-8?B?WTAzVThmSUpqd2puZUZDNkJuRjdIRWpmMm82OHV3SWFsY0FaSTcyU2M0ZGFP?=
 =?utf-8?B?R3hkZ3FtZnBsVVFvMlN3NG5iZGVZSmVVS3pQRXJIZHRWWnM5OXN0d0VwR0tu?=
 =?utf-8?B?dm5oc2syeXFVOVY1THVMa3VBZDMvaUl3L05CeDRva1hWZnNDZ2xmclhTaTVV?=
 =?utf-8?B?c01talBMcjVvUlRLaWo4WURhYTVSdU16aU9IS2RZdGEwaHdqRmhlOXJxeHRu?=
 =?utf-8?B?cXcwOHpiUnpINzhEb2ZERGtUZTFrN2wvV0puZHlhYUt6RGw5OGV3M1Rwajd6?=
 =?utf-8?B?UFczMTNDNU1BaGFvWlVtUVI4ZXFXZHp4TkRJRlZUczh6TzBiTHRLaWhBT1hI?=
 =?utf-8?B?T3VpN2NVdklabW9jclUwdmxvRm5CZ2M0WjdkUExJQ25QbWIrZ0hPZHBGMXgz?=
 =?utf-8?B?MEtmUkxueWlVOGo5TnBJdWF1bU41MXQ3cmdOelVjMmdNTDNzYUxuMHNKWlVT?=
 =?utf-8?B?T0h3M2NZYXRFbitwenhsejFkVG5OclhscXZ4SUFYU0E0QmxnREVFSkN1czlP?=
 =?utf-8?B?ZE51V1lib2d4SnhOU1VaVzlicHNDalJCV3d2VDNGdHhHWVhTYXg5UzNsRDlh?=
 =?utf-8?B?WUtrbDR0YTFnSzJyMkRZNkk0UE1kVlM5ZVNvMURzYlI1UHV3dS82NFFHT3Yz?=
 =?utf-8?B?NG1KVEtyOWltSTViSWYwU3E4UVIvenBWaXdTY1NLSXlmRk9SMThHTFNibngw?=
 =?utf-8?B?M1lwb01WRlYwZkJzL0RHMGJPQngyY0sraTNOeU1QWUIrRytaSEVOaWtHQ3Rp?=
 =?utf-8?B?TTd5OVdWckgwMDU0Q3p0QlZ1RWRLd0dCNXNLK29jcmRkeWlHUVoraU1FSERh?=
 =?utf-8?B?dHdKUnM2bEhHTHJNdmNvR3VSODJwSUVCbnR5cnZBZVE5a2MrSHU1TGg2TjZ3?=
 =?utf-8?B?cU1oUDB0WG9Xa1U1Ymt4Q1FLU2tDZjNKbmhyQlgvU1BUWFRjK1owSGxJNXJn?=
 =?utf-8?B?Q0htY2ZpalN5QUFvNENmSXcrcURPWUNkZzcxNmhnTE9PenVNSzhvNXErcWNt?=
 =?utf-8?B?WFdNMk1GWUQ3THl6Q09DMURORENHQUpuUEdhTlhLaFd4TlppcTJGeitHcnR6?=
 =?utf-8?B?WG0vNGtmaWsyU3ZCd01lbVVUQVNodkdjcXlUT2xBekc4WWhiaGhnUFRTdnBp?=
 =?utf-8?B?RWJ5V1F6bEdtcG54ZFhJRjZvSHM0bkgvbDVvWkxBaXpCbldGWnZ1WFVUak1T?=
 =?utf-8?B?V2xrT0JjNzg3bk1KRnRLMGNtbjBXTEFEeitoZ004QjYrWmI2Wnp3bHUzSWxJ?=
 =?utf-8?B?VWowSGt3bnU3RG9ybC90ejFyZ1NUR1J6VnVacjlwOUhBMCtoaDY2ei9oUWhM?=
 =?utf-8?B?MzlObW05b0lLU2NQZVBBY2FiMGpyVy8vdTZ0UlovZGVUck5oc2RpZjNaNGlL?=
 =?utf-8?B?d3QzcUdLMit1MUk0MTFCUGRXUWROUzZEQ28yajV1RUJiYnpmd21IaWNDUGZH?=
 =?utf-8?B?Q2phRTU3VTVZdEJKTGZ5UVBhUFZlQ1VyZFpBcVZ4V0RGU3k5WVZFWnZGR3Vj?=
 =?utf-8?B?cWg4RVRzL1dkL3ArdG03K1BPTmRTbHFlRUwrazRndzVaMlJER0ZNYktGTTdM?=
 =?utf-8?B?WC84cVp3eHVYVmF5cmg2cG5tYVBkVU54K1lqc0RoeS8xL1JlUjlOV3pHaGRN?=
 =?utf-8?B?bURWTzdWQ0NkREU1VGRJMXdlV2o5VWxDdmdSdEdJMFJXdjJsSlFYK1MrOFho?=
 =?utf-8?B?VHFWZEJpQU9XWi9ZZVhmYS85Mm80MUJRUVZ5K2k2Q1hqVjVkN2hPcVNMc0g5?=
 =?utf-8?B?ZE1wLy9Yd1BIWEsxRnRtYTdvVnBJU1ZyUXlQSmx2VDhjWm9naGREZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7481c31c-c8e5-4413-df6a-08dee9aedee0
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 18:10:40.8186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShGTOUOQawX72jjl7hFmitW5OwgI5tLFjat7iAuj6gAzg4cxEjNrH/lkZs7uioDY4rqcKljH1moB0jYK1hK/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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

On 7/24/26 4:10 AM, Alexandre Courbot wrote:
> The DMA transfer routine was computing the start of the DMA area by
> taking the handle to the beginning of the coherent allocation, and then
> adding the transfer's start offset. It then checked manually that the
> upper bound was valid.
> 
> Convert this to an I/O projection of the same region, which returns
> `ERANGE` if the passed range does not fit within the coherent
> allocation. This removes the need to perform arithmetic on DMA handles
> and to explicitly check for the bounds' validity.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>   drivers/gpu/nova-core/falcon.rs | 55 +++++++++++++++++------------------------
>   1 file changed, 23 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
> index cd05985f5ee6..344cb1487295 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -12,6 +12,7 @@
>           DmaAddress, //
>       },
>       io::{
> +        io_project,
>           poll::read_poll_timeout,
>           register::{
>               RegisterBase,
> @@ -511,20 +512,31 @@ fn dma_wr(
>       ) -> Result {
>           const DMA_LEN: u32 = num::usize_into_u32::<{ MEM_BLOCK_ALIGNMENT }>();
>   
> +        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
> +        // need to perform.
> +        let num_transfers = load_offsets.len.div_ceil(DMA_LEN);
> +
>           // For IMEM, we want to use the start offset as a virtual address tag for each page, since
>           // code addresses in the firmware (and the boot vector) are virtual.
>           //
> -        // For DMEM we can fold the start offset into the DMA handle.
> +        // For DMEM, the start offset is folded into the DMA address.
>           let (src_start, dma_start) = match target_mem {
> -            FalconMem::ImemSecure | FalconMem::ImemNonSecure => {
> -                (load_offsets.src_start, dma_obj.dma_handle())
> -            }
> -            FalconMem::Dmem => (
> -                0,
> -                dma_obj.dma_handle() + DmaAddress::from(load_offsets.src_start),
> -            ),
> +            FalconMem::ImemSecure | FalconMem::ImemNonSecure => (load_offsets.src_start, 0),
> +            FalconMem::Dmem => (0, usize::from_safe_cast(load_offsets.src_start)),
>           };
> -        if dma_start % DmaAddress::from(DMA_LEN) > 0 {
> +
> +        let dma_handle = {

Sort of "conceptually pre-existing" problem, but "handle" doesn't
quite work as a name, because handles are supposed to be opaque
items that one just uses to find and refer to things.


And below, that is violated:

> +            // Upper limit of transfer is `(num_transfers * DMA_LEN) + load_offsets.src_start`.
> +            let dma_end = num_transfers
> +                .checked_mul(DMA_LEN)
> +                .and_then(|size| size.checked_add(load_offsets.src_start))
> +                .map(usize::from_safe_cast)
> +                .ok_or(EOVERFLOW)?;
> +
> +            io_project!(dma_obj, [try: dma_start..dma_end]).dma_handle()
> +        };
> +
> +        if dma_handle % DmaAddress::from(DMA_LEN) > 0 {
>               dev_err!(
>                   self.dev,
>                   "DMA transfer start addresses must be a multiple of {}\n",
> @@ -533,27 +545,6 @@ fn dma_wr(
>               return Err(EINVAL);
>           }
>   
> -        // DMA transfers can only be done in units of 256 bytes. Compute how many such transfers we
> -        // need to perform.
> -        let num_transfers = load_offsets.len.div_ceil(DMA_LEN);
> -
> -        // Check that the area we are about to transfer is within the bounds of the DMA object.
> -        // Upper limit of transfer is `(num_transfers * DMA_LEN) + load_offsets.src_start`.
> -        match num_transfers
> -            .checked_mul(DMA_LEN)
> -            .and_then(|size| size.checked_add(load_offsets.src_start))
> -        {
> -            None => {
> -                dev_err!(self.dev, "DMA transfer length overflow\n");
> -                return Err(EOVERFLOW);
> -            }
> -            Some(upper_bound) if usize::from_safe_cast(upper_bound) > dma_obj.size() => {
> -                dev_err!(self.dev, "DMA transfer goes beyond range of DMA object\n");
> -                return Err(EINVAL);
> -            }
> -            Some(_) => (),
> -        };
> -
>           // Set up the base source DMA address.
>   
>           self.bar.write(
> @@ -561,12 +552,12 @@ fn dma_wr(
>               regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
>                   // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
>                   // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
> -                (dma_start >> 8) as u32,
> +                (dma_handle >> 8) as u32,

This is a "whaaat?" moment: shifting dma_start makes sense,
but shifting a handle does not.

Thoughts?


thanks,
-- 
John Hubbard

