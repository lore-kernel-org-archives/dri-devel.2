Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F04CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50FF10E58E;
	Sat, 23 May 2026 02:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZwjGeTk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8700D10E58E
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgVAzY2IAU3qvbKhC2B+tpxg6s+lA+UBKq7qktLBVj1qlzqOIOQ/zqDEJEUhU9d0YtXRzQWnpOb4ZwO7AA2zE8rYm0s4bb2OfmcrmKX9zEnM/ei0y6wVQ3y7/pPR1dnqGjDmBxq97IwfJcDZUwaIVBwpjaYn2O1+PLW17rzGTyBGpybvf2RyVyxwrwTOSqR/phVImgdwc5J4ddZS16P/usp5OMlucvYb+BXLRvBHrxMa3VzBp6T0/0Ln3qvPloaAgA8vj7sEN+WYrNBF0tek2JXIPUkNUq8FnA+9iaa/iBQrpnYuPAoedx8mGAG5GjlB9cYKCxyqm6vx5c5RH9EyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0Mrek/nqkBSFuKBCBQyMvOStSUEZWcrQzbXtTNXmY0=;
 b=GjC8cHj0b/vHEsUH2ViK/rVPaKly2zEjHRp6B8oFoK6XhNg4cQvY/kO8U6B9qNGb7FqPsswNIZliB2xhZiplmpiJbN/7SrC40iAXZ2l6Jc6m3AU4tli6GWeWy/4pNu1W2TIVQUURk9VbaJoUaCAutSANqfoV/HSnd+P5ujyy9gc639uEdC2tOduwMSwz8tavY+G2/Wy5tR2Viq96Xt7P/ydusuKe79kdgC54g2fGKJVeCoK3GhVOgeFUj9MN2V/rvzVcgFBw7XTO1wJ7Dj5MWfySdMOBYYVnScF2BLZ1D16SgmwdAcgRMMPSCEypCmGNK3TuY3n9wN89siZv7Dc/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0Mrek/nqkBSFuKBCBQyMvOStSUEZWcrQzbXtTNXmY0=;
 b=gZwjGeTkhaVv7GLEg0o9CmtDU21HxWPDlojNWVwv0X2h9soUaMnERhLWi5a6o6bvgGy0bOVxrxg/AQra8UAqAun3OCw0Jaf3Q63WSe0C93E+qeMEf1FF/yoAAHGEFydPa+tsaGA6GJu4vK9fFyVSuhWIUBFEqXp7yKj7ZhBQtP39E4b3AI/Lyvhq+llfQ7TJZhkP94W6r7lLOrKTWsHo7KmfIKzPHJ5XhUWWyTIebyb1tvgilW10teNjPF6FUEoawCIxjb3sUhF9BPzUM1ixOHqjao6v3rPRaFpiQCLtzH3XGgqAEuNMuKWOUQ2z48M2ufb6PMHdxFGqUSBZEijpHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:48:25 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:48:25 +0000
Message-ID: <f19fe4cf-1764-4a6e-99b3-4605873b4c2f@nvidia.com>
Date: Fri, 22 May 2026 19:48:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/20] gpu: nova-core: vbios: read BitToken using
 FromBytes
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-4-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-4-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: febab77c-d3ed-4f13-bc72-08deb875c2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: CvdrsGL4aF46CtyKijLd8U3JXLXGlSD0WVaAAQ8AQ3Tk42qPX2wO5TDTuXykXjvAHVyrkbn6Tx0jQzLGOdCrO+RZgUnfM00Ild/tDPOwRmoQ0vSzYo5iUty8sJx0jp9TB4ITUndEeFLP3hdznCHAN2d9g6qZtx2lJHbCT3ky2EFZid9QUvUp2smLCpmmX24iduw4lQlE+pwctv+xqkTnLDIu9Lwxw3+ICHsn/ghwZeIojCnVHyTuYKhM6WFr6Emt5Uw+NRSU/mBF+rnQgLwM0KkbJN2cDIvEKVFnBqUeOMRnv82JpZ66J5DGCnDC99CRDXQMGNbQiuZNCG4u/GWtlZw7Nb3xMt8UvxL20l6YEL5cBkIYSfCrUFGphh8oTuuQepcNo2vC530/CVfyFfXBBdPV9BFnzD6zoXm/Jn4KWRUy1CXcN4R5qLn8u64xNDa4/87CPgqDgPalxIFBPvVB/S68usaTaKwISyaDBl2Sh5afmIwDEPh4oarDZjRI3FBqGTQY5f+LslQgio16eulTmo5O8j3L8ylRbud/49LMrMWth1THvx3GMkwH5K8rfwfNu8OJzx6RBYklejmbSFHq9PqdFAB0SId+dkKSZe2UH6uqnFLaZR15XvH3/MJkQnZFCk4fhABk2/zfY193NQLBy8jiADSFdu39MneJxs4PUWidJSdHQfWcCe2nrAaP9hwv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tlNVNqejBycG1YSzVjSFV1SWp3UHFSNzg5QllwNHI1Vi9nWU9LTkpkREJX?=
 =?utf-8?B?ck1Yc2l3RWFBTVd4SHFsQ2lHL3NST0NQWEdSOGFiWnlWRXhmRFE5aGVGVVU0?=
 =?utf-8?B?eXpUUGRxN0tNNHg0blI2V25PT1B4eWRHQ2FxdzNOOHNoSHBRMnRlMU5pMjV2?=
 =?utf-8?B?dVFQbERYcVZHMW8vNEExSEF0bUlJcTdZeDRsT1RTWUROa3h2M0FGZVdTZ20v?=
 =?utf-8?B?SVdlQXJWZTNJRTJrNTZSQlhDT0dQNi92L2tFaGViSmVDQVhQdXVJZHNNczVj?=
 =?utf-8?B?UTkwSVcxbWJ5KzQ5ZzVhTGFBTFZtNEZBMWI4TGdod0lzYzB4SmJhNTVoQS9k?=
 =?utf-8?B?eFZNL2tvOURHT2lLQm82TXdNNktOYmZNaDUvQWxsUFBnRmFtclB1bERTalha?=
 =?utf-8?B?dXBCNEV2Ykx0QUpzclRLWVEyYmNjMUVEUjM5bENRdDBOUTVtMWo0V2hrMkRs?=
 =?utf-8?B?a2hPQWFNRXJiQ1luRXNqTjI5cmREUmZJZjdkdlZuZFMva0NDVXJzT3JlU0hC?=
 =?utf-8?B?UFFWN1orWTMvbXNGdlE0dnRVNUJBRklFdC9QOWJNY2c1R2JOcHJSWXNRMm10?=
 =?utf-8?B?N1BmSGhDSEJFUEVZaGg2S042ZkJTdU9jSjNiNXVJMUZtaVh0NEpwYjRnaWti?=
 =?utf-8?B?SVVLK3JvYlo3dU1UY1lBQW40cHpWME5tTWI3d1hhN0pVNCt1QXI4b1l4NEEw?=
 =?utf-8?B?TjBjNXovb2VRak1DTTNKU1N1bEpyS0xudkZ6bUtEQzZmZTh5QlB2THgwdGVp?=
 =?utf-8?B?QnpGRXlYWTdxYmVlaEpEakZQUlZucGlUVExRamIybXNuUEoxMFlsMmtkMEcw?=
 =?utf-8?B?YVdoTkRPQllUbmVVZUMzdjl5dTJvU3Q5M1J1WkVDbWF3ZXRUVWNieEk4N2hR?=
 =?utf-8?B?Wmk2dG90R3hIU29aYlhyOHZxN1NJTjAzekVacm9ydHI5anRibWhqMVJRellC?=
 =?utf-8?B?c2FxVUwydmZDSk9zYmM2N1NrdThlZk5wbitCNkxZaXllQ2Q3Y1IwZnJuanls?=
 =?utf-8?B?ZGpOcEhoS0IrMTMzRzM4Z2xpNEVydFNNdmVDYjRveWp6SlB0NHVYT1pWaEJD?=
 =?utf-8?B?SEZzczR1Z0pzUFhJNGtvcEliWGI0UDBKeGZDSmFxTWhxZnB1OUFweEQ0Y05H?=
 =?utf-8?B?QVRBSllTVGJETkhBdW1xTGNyVzdNK0hVbHBaSUtBTUlQL1p5bXhQNDQ2dkhZ?=
 =?utf-8?B?QkEzenhmcTJyeFVyUjFMaWVrVHkzNUluSENWNGI0VjlBRXdQd09MaTNKL05i?=
 =?utf-8?B?ZU9EZVpVbG1XQnYvRHZQcnoxY285TksvU09NelAxZkpyZ2Z5ajZCeHplRlln?=
 =?utf-8?B?ZDYzTi9BNlhiUnBsR0NjUS9lRWhJc05aM2NqYzRjQWJrdjZBT2dHdElFQlNl?=
 =?utf-8?B?L0xFakRqNExvM0xkMWpSKzZONkxXYzZLMmRXMUtsNDk2QXdNR2htWmUwb0lr?=
 =?utf-8?B?MUhoUnEvWkFOUGx1M3QvV3p1Zk9tbUNWaFNkRHhqam5oTENUbTE1RDNMZERn?=
 =?utf-8?B?STljb0F0NisvUmZZcUhwcnNNVnlrR21Ld09yb3FQUW9TdDJwcHkvTmhTa0pU?=
 =?utf-8?B?UGh3ZEVRekZpQXk2Zzk5RnRTZmo3MnRCaWlXL1hucm1talBFd3Bzb2dqcVZE?=
 =?utf-8?B?WG0zWmx3NVJ4QVNYYVpEdmNqbG1ET1Vpc2taWGhkQU4xTEhlV1ZHNnlxcmFa?=
 =?utf-8?B?TjNudjZlbm1sTmp4ZFVvemJCYUxCUGdkbFV6end6dU5VaFNGeTNBb0lNKzg3?=
 =?utf-8?B?NHMrMTZ4K1JlTjVhdFZNYlY0Y2tZZWJhWWhnbFZ0TWFMTVNHb2I2ZzY4VDBI?=
 =?utf-8?B?M09pNS91VU12Y0F0WEJ6MHhGUDJBeFRMVXhHcVlwOVlHNnpRVmRYOXl3TUVw?=
 =?utf-8?B?NEFFRGxLdFdaeVJLZWFFajlseXc0dE4yRytGNGk1TFFkQUtqcFdxQ2xtU2Zy?=
 =?utf-8?B?eHFRU0RJdkFCcCtlaUE5Nk55OEdSRDdyc1Y1V05DM1YyVEpVOWxhUFZuaUM2?=
 =?utf-8?B?NElMVVdPclRodWdWZlZzN0Iwb09SK0VmUTV0bG01MTd3dmIxL3I4TTJpcVRq?=
 =?utf-8?B?Sm0vTDgzTGNuR1pRUGFTalFhenpJeVdMTVZ3NzVTd0lxYUlxaFI2MEpWMlJV?=
 =?utf-8?B?M3lKRHdEV1d2dENWaVhqTlRPMUJVM00zWkFiS2YyczdZMjhTWlZBdUE0RDhF?=
 =?utf-8?B?eTUvSmp3ZktBdU1WMjNUMzlBT1hxSEZHWngwaEhpT0M4YTZTNzFkNTRjejFa?=
 =?utf-8?B?SGlMSkYrV2tYQ0hjeUl4eGFML0N1YmxPa1g1OU91SVpLMU9qWkFGdXJic01R?=
 =?utf-8?B?ZUtHNXZEdDFFamNuSXRPNFdxWGVHWWw0Wk42YlRFdnZWcFM1U1I0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febab77c-d3ed-4f13-bc72-08deb875c2c3
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:48:25.2895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Tbs+khv9m+uezAaaogmagUo1XOUDSx3RSOXonUm4IuC+KeSLRKW8bAYOzzNTsTlVimRKBM6Rx7QYVqhsotgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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

On 5/18/26 7:54 PM, Eliot Courtney wrote:
> If `header.token_size` is smaller than `BitToken`, then we currently can
> read past the end of `image.base.data`. Use checked arithmetic for
> computing offsets and simplify reading it in using `FromBytes`.
> 
> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU table in FWSEC")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index 79eb01dabc6f..2ff67273fdff 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -486,7 +486,7 @@ fn new(data: &[u8]) -> Result<Self> {
>  
>  /// BIT Token Entry: Records in the BIT table followed by the BIT header.
>  #[derive(Debug, Clone, Copy)]
> -#[expect(dead_code)]
> +#[repr(C)]
>  struct BitToken {
>      /// 00h: Token identifier
>      id: u8,
> @@ -498,6 +498,9 @@ struct BitToken {
>      data_offset: u16,
>  }
>  
> +// SAFETY: all bit patterns are valid for `BitToken`.
> +unsafe impl FromBytes for BitToken {}
> +
>  // Define the token ID for the Falcon data
>  const BIT_TOKEN_ID_FALCON_DATA: u8 = 0x70;
>  
> @@ -505,32 +508,28 @@ impl BitToken {
>      /// Find a BIT token entry by BIT ID in a PciAtBiosImage
>      fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>          let header = &image.bit_header;
> +        let entry_size = usize::from(header.token_size);
>  
>          // Offset to the first token entry
>          let tokens_start = image.bit_offset + usize::from(header.header_size);
>  
>          for i in 0..usize::from(header.token_entries) {
> -            let entry_offset = tokens_start + (i * usize::from(header.token_size));
> +            let entry_offset = i
> +                .checked_mul(entry_size)
> +                .and_then(|offset| tokens_start.checked_add(offset))
> +                .ok_or(EINVAL)?;
> +            let entry = image
> +                .base
> +                .data
> +                .get(entry_offset..)
> +                .and_then(|data| data.get(..entry_size))
> +                .ok_or(EINVAL)?;
>  
> -            // Make sure we don't go out of bounds
> -            if entry_offset + usize::from(header.token_size) > image.base.data.len() {
> -                return Err(EINVAL);
> -            }
> +            let (token, _) = BitToken::from_bytes_copy_prefix(entry).ok_or(EINVAL)?;
>  
>              // Check if this token has the requested ID
> -            if image.base.data[entry_offset] == token_id {
> -                return Ok(BitToken {
> -                    id: image.base.data[entry_offset],
> -                    data_version: image.base.data[entry_offset + 1],
> -                    data_size: u16::from_le_bytes([
> -                        image.base.data[entry_offset + 2],
> -                        image.base.data[entry_offset + 3],
> -                    ]),
> -                    data_offset: u16::from_le_bytes([
> -                        image.base.data[entry_offset + 4],
> -                        image.base.data[entry_offset + 5],
> -                    ]),
> -                });
> +            if token.id == token_id {
> +                return Ok(token);
>              }
>          }
>  
> 

