Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B5CD98F8
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0596610E24A;
	Thu, 18 Jun 2026 13:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEVc6j22";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E32C10E24A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 13:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebt+n/zutTVeweY3QZFGmOCm83xVOGGZsr51aRJlXH6dr/WjqeQDoRAWuPKQ1oymFnirXjaHNFtBn6oFIBqNiRyMRkjpQ1eEDa1WiJ9XGDFsymgFhAwwwF7y+WH0i7llPUV5VOHxZqqV/M8s8BQ7iN7BWInZt/QxLlogWPwh7NQAoK39kTrpF4m6rFDWCbi2L9I49eUkpOUSJiW+nMvEhy2U5Y8ij4gsuW9HrSRAJtlGWsCVJcWOA9njkXwmUY7teULaqUL2qCl0yar5do5fUvSF2zBotc77P9NGH5I1zp1mFH4d87RpcUMS7v7hGOoKIy47qInk7mS8qMyeali9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=523uGqr3hkd6Edk7MI8EhXOuaEmOd/y4Vwb14kHf+dc=;
 b=Lv9tyhRhiJXUpZ71t1Pnx2ScDSmcmUT2q7K4fWDakMMZHYxCBwll+LtgZhBHZK4Q5Qx9qD1fueECOqIN97rt6NxsVOLBtfu+JwSXfofdj3rIT3Ne/pSNkdJWyQcubcGwZgiH0gar4JE1O+fG5IFc1qqiGkwnNV4xCmwXsd3R/puJ/NkS84Qhua6dPonsxxsERcTs25N/ks20zP+JOc8IDtrJe0Ga7z3wosDMXa3u3JAIHH5eVr0SpokTsuLcJYihdyUPjo7ucYunLKlXyOHRTWbYkR8JTnO6HIpzaq+TH656IPVWYKJT2Chw1MjOdCAl02NhkXcRSZnamD+I6DE10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=523uGqr3hkd6Edk7MI8EhXOuaEmOd/y4Vwb14kHf+dc=;
 b=ZEVc6j22sdgRv34/ZGNdnbpPUJK7SvsVt3YR2XyTZemp4dL04+48UtF7ruNHNnr04RiXILQ2vm8EEZTmoZ9XrQi0Z0Yi35VtUMm46Neg8VCo9zcBsTwe2EdJTvYhYlUSnP5gRGFMrqPgiZGidHJvU6KGa1SOOkPD4sOr+N/K1Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 13:30:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 13:30:44 +0000
Message-ID: <923343e7-1f11-4e29-8278-917fc65c75eb@amd.com>
Date: Thu, 18 Jun 2026 15:30:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Add entry for Rust dma-buf
To: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Matthew Maurer <mmaurer@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Burak Emir <bqe@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, =?UTF-8?Q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, Eliot Courtney <ecourtney@nvidia.com>,
 Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20260618132628.3811068-2-phasta@kernel.org>
 <20260618132628.3811068-6-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260618132628.3811068-6-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:208:23b::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7e656c-616d-4148-f15a-08decd3dcc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|921020|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uqAV7HxmCbtEYyqkEhbggntUNNNEraKL1SaptGU1I5RZ3sy+uP5rOeaGL3H3M/7bw5+qqHzrElwtHIqCd2UaUMzRoLBUupKiE8CxV8S7d2vWPoDM7Sq/XWhoCxeAvuYud+aOhAAUcwozNf1CsIM2W+qaKeXtlVeUQx2Y1CBYTQRAtQWXTh2NJzgoHsiXzP8juflTyM0aVKS/JTophOAYZ22mrh1HGR5UnfO5pIj8SZcnoh9sKhQwu4xX1e3iS7Vj22heT0FzLGLv5HI6iGGEFVx/owzcAral4mTgrdh/uQ3/lSNARPFkuiHUXKL4S3j80yhQdUT/Sl+1OuCct6KVJN5Nj8y8KjCY8MPzKyZhlcyLk2FYpP+85MDPzIndfx+2LAGiOg5K/wF87RyV9wDB3x6sZwWE8lneOpl7/SB++DVqYWrlIaqG2ugVtY/TywugL5Zga6vlWDDA6K6ZeUrzOWUKfa0SHk0aN5kVCgB7bs2bUvmSxEtRoE5Kp3y65Y3i3+LXOXEPnO3dKEI+Pi4xX0bu0pvQqrEdcQXozcod5w8xQIOfRcgkeri3n3BMMBGkpK3oUDsgWTiu0c5OF1Ina9rFOTbLJ9yF++peyP/FuzqVCsJB/phks6Y4Wlg93SZ+iQJ5m/MLakHtvzCTF2U+qMwZpBfjKRWkQfwamJWIeohUeWm84KWfP5k/ZmOjUEOqQ++9lc/tqKMz+sMH9Tiq/OchZd8MgDfqj2ZWEjLufz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdET1lhOGExbkI1YnVJWVIyV0NOdGtuVzdDOC93dUhtS0NRSmpFMDZsM0Fr?=
 =?utf-8?B?QXMzUXRla09MNzR5ZXR5RkRPYzFjdXc3Y2lqdmRSbS9wdUsxY1FHRmR2amtU?=
 =?utf-8?B?NTBYM1c0SDhaZHlrWXp6WFZWeVY1a3V1ME5KeDBxVFZGYW9Fb21OazRtME1K?=
 =?utf-8?B?eTVFcWptUW9XNzJhdFh0VXpJLzZIZEsyb2pkZ2FHaXBuM0NEMlo3TUhvbHhM?=
 =?utf-8?B?aU5ad3B0cGVWVWUrRnZ1eHFhWktvZ3MxVkJHUlRNRzdVdElERlBSMUpoc0RQ?=
 =?utf-8?B?bmdWWlBIUndFNUFvRnAzMUR6R1V3LzRRd09OZUo5UGlvangrNU1Rb3ZOYUl4?=
 =?utf-8?B?Qy9YcjlYalBhNnlrOW53Y0xYcnZEdzF6YXY2VE5Tb1JoTnUxeVptazBhcDRv?=
 =?utf-8?B?ZHhMaTAxblZmWnM5TjljNjRsM3RBampiRkc2blhOcHRPaHMzbHBab3BPTWpT?=
 =?utf-8?B?T2ZrNGVtSmx1R2EwQjBMbjE1ekxXYmF6UURnQThrUGNaUDQvcURSUFJRaEts?=
 =?utf-8?B?dENweWxXaU9sdmI2MDUyVW5XSitrcG1TSmlOMUF2NS83RnZvVEFldnRXN2pW?=
 =?utf-8?B?b1pzSTRBZGFDM3dpb2U2aE9EYUVzSmt2ZWpxOHYwTHZtOFJ5R3RMMU1MWTlD?=
 =?utf-8?B?d2pnY2w3NDVKNklUZmQwclpuUjVocVZiU0dGS3VydEdoQ1JMRXhIVURUQ08x?=
 =?utf-8?B?REFrZHJkODNieXFUL2pUZ2dWS1F6SVNrSWcxUlNQYjVzaG1GZTFjelIxY2E2?=
 =?utf-8?B?NUxtam1WLzRKc3E2TVBVV1p2NHJ1Vll6V1lFVW5rSUVEcHpCNWNDZUpRYm0y?=
 =?utf-8?B?NCtCWXNNWWNuMnNmd1NHNW9JM3c2NHRXWGlsNzZFQUw1WTlIN0owRmFGeXV0?=
 =?utf-8?B?VXFBbEtSN1ZTWEhDZlBoNkZxNEFTSVRvUVpYTGpVQjVXQWYxUHpIREJPWU1F?=
 =?utf-8?B?dHZDU0lSZkFBUjQ2NEdKbVVtbHYrRXVOc2hMT2tDOTRtWm1ucHB3Y1QyL2RJ?=
 =?utf-8?B?T2dkQ040RFBudEw2V2s2WTQ1N0pKdTZUK1puT2ZnbTY2M2xsbnArZmsreWRT?=
 =?utf-8?B?Q2pHZXNnVlNvUDFWRWNBK2dlS3pSQVgySTBQUit2NVhhWnA0dFVTR0RKTE9i?=
 =?utf-8?B?bU1RbjlCaTh3VHF5N3gwTDNmek56MkxMODBsSGVsNXF0K2d4aHlaVnJ4N0lG?=
 =?utf-8?B?ZmR1MmwwaUdVYVFiaGtpY0RVTEFNNFBqTVJ2cTArUGdJOVJoZVROQk5iY0pN?=
 =?utf-8?B?UmxlVHBvdjVkazBEcytmQWpYRkhhQkZLVDZEMGlQYVRqNjRPV2lFNEJxRFhU?=
 =?utf-8?B?b2tNYnpBVzVaa0RKQUJLOGZWWTJsWlUyT0E0ajVRS2ZtRWIwYmpLbm4xTm5P?=
 =?utf-8?B?ZEYvY2Z5dTUxRy9iOC82SkZGUGdXZEFMclExcU53SHdCM2JKdkExdFFIRmpE?=
 =?utf-8?B?cDFiQURPdjMwOVRLczZHbWYzQVJ4NHViaFZiN25uRWFEQkN4ZytWejNZcGJh?=
 =?utf-8?B?dUdZSGtEM0NKZ21GSUlsVmZaMmlYam0xd1hUNjVCQWVZZ3RLS2h5N21talU0?=
 =?utf-8?B?Wk82OWY1RlU3ejFDZnB2UFkzMWZDb2pwK1cwMC9kRkRoVnRHRzhYWGUvU2ZT?=
 =?utf-8?B?N0xDbGRhUjMxK2R3Q2tVWGhqc09ubU92Vlhoelk4Nk10NmgzK3diNm9sY1I1?=
 =?utf-8?B?cGpUcUR5MWpwL1pQNXRmUVZZYTNwRW9ibzdwc1c3YjZ2VDF5b3g1d2dQYTYv?=
 =?utf-8?B?eGQ3UXd3RFRJNjRLWUx3U0cyNEYzNFd4d3ZHb0F3Z252bjE1ZkM3Y1FyUU1v?=
 =?utf-8?B?a1Mzb3Q5ZVc3R2U5WFpFMFlZajU0U3A2ZXVrd28xbStMSm1SMUV1am9sa3J2?=
 =?utf-8?B?OTNkN1lpeUZDeXFma21veUd3TmZUM2E0N1hPV0ZHSDU3R0Z5blB6TFl3VUln?=
 =?utf-8?B?SDZRSHJiV2Q5dStNNC9mY1BIZTNCZXBuYWloVmNTa3NRWk5wVEE2T1NSb0tj?=
 =?utf-8?B?M2Q2UnErVDhoYVZZenEyTVFkNzhteE9IM2syQUZtYWRNQ2JFYTdJQkR5ZDlY?=
 =?utf-8?B?SEpPQVl4bUNVRFJEbXJWWGlXTzYxeUN5cjBBZVorRC9Fajcwd3FkajY3SzQ3?=
 =?utf-8?B?VXJqNER0S2hWZktnSFRabVcvZG1SOU5PUFpSRmtQQXg4L1FGRVEzRG1Ydk9o?=
 =?utf-8?B?TW9YZElaL3ZoZDI3SGdJb3hZWjVYOUZ6WUpqbWM3ekt5OEhYbEZ3VVBZckIw?=
 =?utf-8?B?VTZ2eU5MZEh3R1Z0dFM4T2d5TnpLaHR5MU5mbDFKME9uUk94b2EyalZ2U3gx?=
 =?utf-8?Q?q05kQxhXJPauM5CZd6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e656c-616d-4148-f15a-08decd3dcc8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:30:44.3721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DfUYwXvs56n+KsauFzwM+EMWtareSTC9dzHesgFyi1mfYEDBRZl3+pUs9BQzy2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421
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

On 6/18/26 15:26, Philipp Stanner wrote:
> Rust does now have abstractions for dma_fence. These abstractions are
> quite complicated and require expertise with both the C and the Rust
> side. Therefore, using the existing entry also for maintenance of the
> Rust code appears reasonable.
> 
> Philipp volunteers to help maintain the dma_fence abstractions. Add a
> corresponding MAINTAINERS entry.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ae6919454c3..8b03eb2c578a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7535,6 +7535,7 @@ F:	fs/dlm/
>  DMA BUFFER SHARING FRAMEWORK
>  M:	Sumit Semwal <sumit.semwal@linaro.org>
>  M:	Christian König <christian.koenig@amd.com>
> +M:	Philipp Stanner <phasta@kernel.org>
>  L:	linux-media@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
> @@ -7548,6 +7549,8 @@ F:	include/linux/dma-buf.h
>  F:	include/linux/dma-buf/
>  F:	include/linux/dma-resv.h
>  F:	rust/helpers/dma-resv.c
> +F:	rust/helpers/dma_fence.c
> +F:	rust/kernel/dma_buf/
>  K:	\bdma_(?:buf|fence|resv)\b
>  
>  DMA GENERIC OFFLOAD ENGINE SUBSYSTEM

