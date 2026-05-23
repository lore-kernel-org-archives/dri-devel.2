Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D42BCD5BB4
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 02:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D479510E594;
	Sat, 23 May 2026 02:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UYMjSBTq";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A9D10E594
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 02:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKT7q87yl9hFmMZHKWSaCRT49Ur8g6gP+EG57Q2wta+n9Nxl97dO3dtMeKD4hm+YQXpjScbwjIWYFhigFQnSC4IjaEOutvMa56tp/UoFCes+Al/y/WUnNdPy0EhTeQmeEzvWS6F86hLCXqAse7m9yCYMMETDAINe2Qk5UjrfE8d8sNMCakl+CH30Yr4LTf7WdFyIFZMYbQy8IcPjS1Uf11OS3l0u1uEIjzZ5g2lkGbOT2aUHv8eP2drbk8aVO3qtFLel+MHZ+s/dABZ10eJmkF0j2NSlBCiXdk9VCtLZ9mc061zBO7I6DIOTUXhyywuEzHmnk4uyopOzeSUdCdEOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAaIkhYop4aPi9dqzHLl1iPFbAtbO5w2Cnt8/0qRATw=;
 b=G1WQUXsDOqLYH7Y+vcqgXlv49HgXXBbuNn2Jc0xpak8JT/dxt6l617BooZvYDDDd/sHxtUYHHGil2/RR76uWb1Ycyv+0vM4b/YcvMtJ+fpuk36uF21mhXuodV9o2aZjH9SZIbuLXUcBvDVh5pFtzfntXH52MUuRbEjxG2kyxYIv/5L6HjRQodgXbaW0GaEhNMfarO4kLZQh0dvNsTxzL1z2Iu3Ut5xLhRyCjAX/1JJdfD6WQFPBZInBZbofZrDlAXDtBBtCnfyQjWLXNr6B9+eiQhMvgR6DyqWso0SB/HyqkcD8bjVWyCrh3gf1j7B/GvDxNqLU5bkDRM/2nfUZDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAaIkhYop4aPi9dqzHLl1iPFbAtbO5w2Cnt8/0qRATw=;
 b=UYMjSBTqDoeRECg2GQKof1IAgOxEFbNGNKV5vlUt5Uv2iZYURtwylBkFBclFG5+A+PXmPb/LA6kyPhcaSt7PgrAi5W/DMBkJa/pd6XPkEBmJhHop2mrRUu1SyY2WagQwgKQs+1wtCCfAtKMtzpxf7VxVx4YP1++MZTi+d9pMWihShwBFRdHlBbCIDNCY9LGg4J1UIvi1o/InaNhG/z8gz58xGFUkYX87Sas+HeHxdN+ZpK+i4xkhiTsM91fAVQ4t0XB3/NLyp5pET5xng5mfQLsiBH7ZQmU9qdkUAEu6IGHLkrl2KWObaS5dZA5Rl2eWRAY2eDIHJFJy0srB2OGh+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:48:52 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:48:52 +0000
Message-ID: <33e06db2-a0bf-4d3d-bb8d-ac4c1a042f3a@nvidia.com>
Date: Fri, 22 May 2026 19:48:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/20] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
 <20260519-fix-vbios-v4-6-5d3f210c5602@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-6-5d3f210c5602@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a867833-d28c-4a7d-28a9-08deb875d2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IaCq9cDLsseS6ZAy0C8peY3ZOL0B0/Qz1gy1TyZZ7sYjofFuQV1wvjf6MhDZxE/oCzEuIlTI4SdYsGc3nETgJPrmnT2UDUIKDnwf6FNkSxa3co8OvMTIYGjgNlza0LwQOXLry3m72iRxforck1EmIxfv8S3Cg9irYSB0TNRKafU9AFTWqIMMStl9ee53LPZ0402dbReqNNg2XJVbLjTNPyFDvxfcYOxqaZy6QKSbZQbA3QTcxbrBIF41YIz3QMr+FoSK+up/biPKhqbU9zN4F6qaPc02g7Lk8Ktn2VZiqYtkncxe46EAmWxOU+r6qjig1uQjEqzD3gXNpQYrjtqGdmeqMStZIAAIbTF4yLTqMeZDvZDxdyPzIJPcUHV39HBxEVtlSDDZx/OHCxFAVGpe5z/Hv57Sj8VPsExm76FEdtU0/AkojWu7l8+jkKwW3dJS71YTVtgHOE608HN2SFDoWUJBkH7vnrWnIVZIW2pHkSdTY4B5Rrtfoob9QsefUYoQgLZQialgf+wp27ZbkopJs3DxgNpnch8NUkx8OdXf/m8jwTCcMUzz/mURfwe5uunWbIklnHxbqspDVmv1PYmiWBFwmSzQl75cteCfpBmkkYaHnnZOmJcB+9JE9X8teziVTNxxDrjoivheh2NsxJ4Z8IwrGY4j9emH5ie99wCi5LEdtJw1nohivHZF+9FDU+RA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxMamFESkdBM21DbkM5c1NjeXB3cmE5Y3RHYkUwa0o0Zm5VUWQyWTgvay9W?=
 =?utf-8?B?bS90YVVjQUxDMjZBREdiRVFqRWRlRVBPbkRMWmtNWllGOFU2TFRXeDR4amFS?=
 =?utf-8?B?ZmI0bGQ3eUtxT050WlpPSUNWU3VHVzltbXA1eEpHYVlPSVg3eW9Gd1pvVkdQ?=
 =?utf-8?B?U05odWMvcWNWcDdoaWx1NTM1NXBCVHRtWUUxT3JsUXNyMHhqWTNKaGVwUk1O?=
 =?utf-8?B?ek4rc1V2cU1JZHhzT3dKc05lUS9tVlFBNDZuUmFaMXZGSXhWQ25JZGprK2dp?=
 =?utf-8?B?b0FraFgwYUt1bDBMV0VOWFgzQmZHMHppd01qVlJZczI5WXJmK0hJVXBETEJO?=
 =?utf-8?B?T2N2c0lVMTN0OWc0bjFWL2FXT1JLUW9Sa0ZDdkJqd3pZS0FBajRQSzhTR1Zl?=
 =?utf-8?B?L3c0aHBFcXFDaXpoWEt1R0JyNnBpL21ZUlJ1QVNURWhlcmZlc1Y3bWNnbDVz?=
 =?utf-8?B?NUJ5cjBqQkFodkdnbDhpQU5OcjM1emNZRWNjR2dUWlNOVjB2MDQrK3pXQTh2?=
 =?utf-8?B?clI3eWRMckdCSVpwZCtDNGtrNUVlMXFyem13VWRqRlc3YWYxc2VZTGZFNWhs?=
 =?utf-8?B?ekdJQmZqMzgyTkVQK3RXUkNGTjFqbVFLbWFlOHoyamN6WnI2bHZmMVNDcTZO?=
 =?utf-8?B?U3lBTktLNW14Qy9vdk1oaXhtZEpKK25QVHp4YU5NcWZQLzg2MlVFdjNpWmIx?=
 =?utf-8?B?UEF2eEl2TTh4aFpqeWlmTHh2d2VUZ1ZVd3VXZXJTWWk0bGo4eUJ2WHJnUkJj?=
 =?utf-8?B?TDBWQytDMGNyUWlORTN2ekp5aFdVelZXSjBSQVl4aGtJaG9KcElPRm5sMDlo?=
 =?utf-8?B?T1NEdkdxTHhra3Q2N3l0UlgxUldhMDVrOE8rRUNsSERGMmcrMHNZZlpINFNy?=
 =?utf-8?B?Tmc3QXJGYmN2emR5bXNhOVJnMW1hNGczU3RNL3hzSk5qajhsWnZvT2VKMjRN?=
 =?utf-8?B?eWJBQkQvNzJmOHJQajZ3TnNuMmQzeTlreVlNcXZNYzJNY2czOStUbGx5UEVN?=
 =?utf-8?B?a3N2TkJhc2VuYXJDYnhJRURDK3Q1cFVONFZlaitzZEc5eWd1MGdUUWo1K29t?=
 =?utf-8?B?NWNvZmNQM1pwZGRBcHUyVkdJeGIxazdCOWhLOW0vaGN5YzZlL0hlV2xNY2VL?=
 =?utf-8?B?ckpOSThsSGFCck96b2szK0VHeVhBVERmOWtQK21KK2tvQytxajUrcENCTjRU?=
 =?utf-8?B?YXVqSWQ5aEVsMWRMZlVXRXRiVnZ1RWY3Y2NWdHdmQ0R2Yy9zNC9BcjFYU2dL?=
 =?utf-8?B?dWU3TkNpM1cxT080UzRWQU84dG5DRUZYeVYvaXJVUjlXRGI4VitKUVlYUVlT?=
 =?utf-8?B?Zmk2RU1HcVZ4OFVrNVFMTmh2dVhwRWhERUF5VC9Sb0Y4MDllQ2F3OHoxWUhD?=
 =?utf-8?B?RXFuQi9QK0lYQkx6c0orbnZCOTE2NURmR0NLc0txU0ZmZmxQNjdkYVpFN01n?=
 =?utf-8?B?eFJEbGQ2WlJLZWxIVVUzd1p5R2gyVGlHMEtFT01IbEUzd05SUk0vaHlXQ0Fr?=
 =?utf-8?B?VnUzU0tKYkxnc0VDKytZZ0ZBQ0hMdCtUTklNUXlJMktiQ2pDdTQwcThQRmls?=
 =?utf-8?B?ekk1a0NJeFk3Q1EydGlpYXAyY1NwMEJRVGc2bytRa1B4aFpObEJRN1RJTVcr?=
 =?utf-8?B?RExCRFU5WldMdlhqNmQydHVxTUdjZlFiNW9uZnI0Q3hZUnFJOERxUjVkRlYx?=
 =?utf-8?B?bFNrdkJvdVZlSmdSNDlQWWhOOU1jRTV3QW5WWUFqTlQrMHJXQmU0Y09LTmZV?=
 =?utf-8?B?b2YyS1VLbWVLZFhtMGtPZTVlRXh2SUppMExHbXZ0dVNhRTBWaG5GU2ZYbzZ6?=
 =?utf-8?B?SWxKRm5TTUJKb3RrSW1aL2FGc1Y4bjVLMm5Cb1hCV3pCQzZIdWI3ZDRoY0dw?=
 =?utf-8?B?NmlhRk9oNit2QTRNV3NDNzJMNmNjcENEend3eHdyMjNLNlVWVG0yMWtaUDdI?=
 =?utf-8?B?cS9vdlV0RVd1dWZBTHJNME10L3lSeWh3cDlwU09STGMvek1wV1hWakJpL3Bi?=
 =?utf-8?B?Rjc3VXhVUkdVQ3NoekU3N1p4a2orY0VsTTU0YjczaG9lTXdmR2poNzdTNTBz?=
 =?utf-8?B?M2p1MUl0Y0c2ZXZETHR1TEVFQkFsajl0cFFUd09xOEx4d0lEU2lnak55Ukcw?=
 =?utf-8?B?VkJVc3F1Z0ljempIbTFHdVdlVHVVbVdVdEJlZWJrelA5QWllS1d5VTA3M2k5?=
 =?utf-8?B?RFU3dWQ2bWxvZjRBQitXc2trWXJRZktmaC9CQ2VabEVDY1MzZlFTc1BGblND?=
 =?utf-8?B?MGNOT3RQY01USjNCWTVXRlBmbENWTzlleitDZTNuTWw3S28vcHBzTjRETnlz?=
 =?utf-8?B?VFRJTkRWcmpmZzBkOVk0NWZxRnBOS2VLeWhRemM3MUQzY0ozUUp3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a867833-d28c-4a7d-28a9-08deb875d2f7
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:48:52.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ocGe/cTd/DpBzqp3mUiWnJV0iopvsSEVkX2sYEmO+98zSzJXlycQvPm8R9YwPb9a6x9ysUU8sViPc/X0Kan7w==
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

On 5/18/26 7:55 PM, Eliot Courtney wrote:
> Use checked access in `FwSecBiosImage::header` for getting the header
> version since the value is firmware derived.
> 
> Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
> index c62d918a3041..48a46684e279 100644
> --- a/drivers/gpu/nova-core/vbios.rs
> +++ b/drivers/gpu/nova-core/vbios.rs
> @@ -1077,17 +1077,14 @@ fn build(self) -> Result<FwSecBiosImage> {
>  impl FwSecBiosImage {
>      /// Get the FwSec header ([`FalconUCodeDesc`]).
>      pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
> -        // Get the falcon ucode offset that was found in setup_falcon_data.
> -        let falcon_ucode_offset = self.falcon_ucode_offset;
> +        let data = self
> +            .base
> +            .data
> +            .get(self.falcon_ucode_offset..)
> +            .ok_or(EINVAL)?;
>  
> -        // Read the first 4 bytes to get the version.
> -        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
> -            .try_into()
> -            .map_err(|_| EINVAL)?;
> -        let hdr = u32::from_le_bytes(hdr_bytes);
> -        let ver = (hdr & 0xff00) >> 8;
> -
> -        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
> +        // Read the version byte from the header.
> +        let ver = data.get(1).copied().ok_or(EINVAL)?;
>          match ver {
>              2 => {
>                  let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)
> 

