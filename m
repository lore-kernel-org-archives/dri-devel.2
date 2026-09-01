Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9032C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C9E10EEE9;
	Tue,  1 Sep 2026 20:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EUkEvuwV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FA3010EED7;
 Tue,  1 Sep 2026 20:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788292979; x=1819828979;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VFrj/q27PY8hVpasW4m1wQ/zxOSnC/5RiYJo1psrjI4=;
 b=EUkEvuwVSY3CL61gBiML9ZoATremk/pblhy8dQKnNVLfcu3UM1EVyqpP
 Uz68VerZFIvMenjICzw1DRKIgzS+qx6+D1IgKUh9gdpmT7H83UJtBqqk3
 SKuKz3YJeTDqan34UlF09qpauEDO8l3+3m+vqb/c+T3H7Pg8Q8oPSGDbd
 LHieeTLP/aCLJBR69JoCwaWMUQtt/ZJDiKkSgAEqIW/lpgIAxmE7rna5n
 FxOQ9SnRc++OjHOjwgS/exaDn7qsq+hYfqEso3yCwhV3iBenzRvynBl3X
 WHaetjiZDjE2gXI+bFFnz2HSqlYMtRm63QSkolGr2Ihgws8XJg8QMga7p w==;
X-CSE-ConnectionGUID: eCX6h0K5RYuabRVU5BJ6Uw==
X-CSE-MsgGUID: NJYvppD1QOKAQQNGkhzhOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88498133"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="88498133"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 13:02:58 -0700
X-CSE-ConnectionGUID: jercIzXFQwqEiR1AVE/cWQ==
X-CSE-MsgGUID: EBtL0uI+RXuvfFRwTCpryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="264915974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 13:02:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 13:02:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 13:02:56 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 13:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+8q9VPGzQO/LgT8x1jGxEWxiw8EitWmObT6KFZvVoJ5+cEzCKU9aPjXWNFUs+ke/ocnr4vx1IXWTgPsu3LoMzrdCoPWJDIXOzJkwnKSl7xuNnmzjY4zJ6jAxdQkot63DUqpfV+2uf+8mVQJtZzijkgaenn2bxZA9bUOeaFH2uj4a9jwTOIiW/zbno+1nxLHpBvih06HUjjW2DyBL4skfnpjXWxmDLN15KZ3XVBlNg/fKbqf0ohwTjndBlmbHXMEbA+ZPMMaIX4M7MoQ9+buhrXi5ynwOk4LYBI93n06Vya9As4+fwzpH04FTQHWDwu63GmXIwglrtTQ6LwsmHvq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95XC07Bjbe3KpclBl3ZLzezxDrDRRkasV+y2wHYHK3Q=;
 b=SruBxhFTGH0a5XLEa/qSN8v4Ahl9Ri8/Xq1QoUxB/lFwdpqt6ukOE7WeCin+bJRfkrar6ovR4pPADuLq/Y+OB+YZDsBkgzJXMNbaiT40lyEP5X6vDjhK2lAd8ehhp/tMaChDivaSjuFHGVsniRM9cRSmH2X9HsjwpDUfU5xAi7nvBMdWoSgJP1wbMfNeppVP/jDnErMpy7bMLXT5u76o4X+4N5c2Yh+PQs7UWdRhg7OmwMPH8McWm+FONaG7MyCI0erGXhvKayZclMmYSCzMlWqkUHqjqWPmlnxGwDPH+wS7gm9xG4pwfh8xRuYhFVwDIlH6sRIqTttGGcON7mPt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DSVPR11MB938433.namprd11.prod.outlook.com (2603:10b6:8:37a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:02:55 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:02:55 +0000
Date: Tue, 1 Sep 2026 13:02:51 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/4] drm/gpusvm: make the DMA mapping step in
 get_pages() optional
Message-ID: <apcva2LimMW3QSQ8@gsse-cloud1.jf.intel.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-5-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901090100.2024933-5-honghuan@amd.com>
X-ClientProxiedBy: MW4PR04CA0279.namprd04.prod.outlook.com
 (2603:10b6:303:89::14) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DSVPR11MB938433:EE_
X-MS-Office365-Filtering-Correlation-Id: c5770740-73bc-4e54-e207-08df086402dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 3Z8Hju12KdtQiicU9thD9nwKYruW2+DntL/jUzes3pDBCgqDIxJLCTcD40Z4lqCBqtoH+CmuVDN0gM8BNj9I7dXIiR21CmkyI7oxUvod+0NB8nk4l6ERSq5D25wuq0vLjZds/EMZ1JjaHWYVkB/NcuuMmPDFsBLs543+3d00sJmTdqQ+0uYo2rM5XlXnLO8d+Xiv6p9pBEXVSe3JIC9Xe+BC2hISKwvGPVPbOOxDy1Rmpkfd70ZZk6TUeitbj68L86Kol8YTZWmgY8T6HTYH9+ewzacPeLf/uvOSlssyzL3iAWH/HL9cUUgmZB38bFtmkYKZve9g9l35Tdsavr++q1qOCPkSyJC/uNEZzRUgyRHae+TLiiEMjiybyfAUTRSGiJOQhHof80tFd9GAga5l5Lj6sDNQkxz3KvWVn6zue5ykBHjQgiGA3rkk1dkkn7wQ44daxS0bAyIYNAtPmtZXfImjDpn87g6kfPjeNIjuD19LDvsao9QM4DxMAvkBfoFd7fUKUBsH2crh0Z+/Fdc35l9Ky1Or6L/0chaat//TMOdKSOxgMBCoWl9A8rH7O/a6Fprmw0wRa4B74PXXbOLYDIlQPNwpoe3f1KpTzTlBCsQPNiVPxeQWBhwMr/i/4qW5/16Q0hRXGuhZg/GG3P56YHf4XzSTWUiqXGq6mlD1AsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SAVD5vNvfEkA0fYXwqKh/P82vHarSZbZ+9IQVXQScSApWPBsbrcBE/SK1Cw?=
 =?us-ascii?Q?AyGzKMi2be7SGJJYu9BdZz0vTEFWWGJhnZUCm12HKgA1QFy+KREWzLYZInHV?=
 =?us-ascii?Q?rUVOwy1M5RDgz7J6+KUFGpNnpXVpMFatrJ3zs/6zaPjGobl/FKTh7KVB/wCT?=
 =?us-ascii?Q?RM6A/GJXmoeHpx9wTgDVrmzmvggh9lP66evCs6gCQ9H+QVx04ccSzlYOQ0LM?=
 =?us-ascii?Q?cYoofbyn6NRX71RAxlAd2wXfJEezTdDUi9QvjVy9LCTP75KXdFRzNazrqI6+?=
 =?us-ascii?Q?b/AsxOJ7W4ckNeq1ihveBpdbby9nBgZHS68F/kycGTkin/tn3w36ukeZOKMQ?=
 =?us-ascii?Q?Dni8I8hB3I75Eyuq/r1tpWjG4293ccnilNJTRj1L/CoG7c3V6ib+iURF2QUM?=
 =?us-ascii?Q?QGRRu1kv7HKvF+nvnnYAPYRythxDnMW+UHE1JtbVgyNXCgaA6If5UXF+dVNS?=
 =?us-ascii?Q?mvDSl5kQ5b0tcHDpN+3GujAel+HYu4CCrESnDyNDu+0e+4biPPq+97q+ifLv?=
 =?us-ascii?Q?OFTs4qowukLWkIAsPCgIAm53Jaa/1wOXr1OeCPL2Tl9VbWBpWd6jHqtxgvVU?=
 =?us-ascii?Q?S4V5Ch6ElGg/gBdbfp9HGl3MtUxV08kWI6UAjY/dOI/L5lnO4ZQUz1RFGGnW?=
 =?us-ascii?Q?siPeYselq05gL/CciDXorrPFKXDc7BbMu8gm7L0d8BoHOR2K1HCkJcDEtKys?=
 =?us-ascii?Q?Tdc9AiTkJhsmHJdrOFCt4gZeJlVFlR63mwfjDGhWLnophLWembpiW3vRNPet?=
 =?us-ascii?Q?jynOLHXC0D5zgzIQS/7l8aVmwfKxZxSUxofIj0yAWEJUAPi5dbjLVX+hinm/?=
 =?us-ascii?Q?hqVkLz3+i9/HneV3ea1ablXUzKcT77Zfh/9LwzRl+jniycAV4FqCkDLy92dG?=
 =?us-ascii?Q?O/cchYWcaIcy3mZ1c9ILLCUoInvuIJ6JuFdWZ9ewHGt9YvjZv2lfKJJjSk/w?=
 =?us-ascii?Q?Y3obpElAcPMycjF5KjCyhitqxy8N7ZhqPqCg5BoXr1YZnfJgAy2xwpNT/qec?=
 =?us-ascii?Q?gD+dMdJEI1ip9bnBYRdIregy40ogE39t6KTIXH3l8MpjQNXI27z0+Xak9syl?=
 =?us-ascii?Q?c7B5dWDxuAMw+snDHw++bYXdT6iw8RIRHkkGCTNvCGBZqtrxA79GxJciygce?=
 =?us-ascii?Q?ChX8Y5iWnPI4PLIFCVGsfFvxqgkZKiaTMWtbHbAJZNTjv2VO7hqJUW/WS4DD?=
 =?us-ascii?Q?GqGFfC9oYKsZMrWZ0ybp3+Lkn1GutOc2p5CDV2GNSUUEmaewcTDZwF0OP9lx?=
 =?us-ascii?Q?4/rNB23MnnqAgwHYZb29o/ksKajMB9s5xTP3cE/o4LwRoRlIR+tRbytKg6Nk?=
 =?us-ascii?Q?Ptixo8HfWqm4eQl58VAyLngLRovhAur6XxVyBnrSnvtcC8xkey5t6QtmJ7sT?=
 =?us-ascii?Q?1ePhGnW6Q/nEH+7BR+GZXPFLw3ApLzhdls5dPPDgOmCrPvOUtWV3GrN4Sy3b?=
 =?us-ascii?Q?Qb6kLOfTfN70dsLhavaAJv+Q+KxC/8+cdPX3cNN8b7eKhN1SCmppYj6qHvcY?=
 =?us-ascii?Q?6AqUKMFTh+pt6dpzo8TeZacGmyFQNxSRhBXlJjEI/XIJRY0n9ICRbUTwjpTY?=
 =?us-ascii?Q?vWWSy/bdls6MbZK2iqCQqeJgQTG7ZZOGh1MlhxYBV9eCNxO3zMn050MN/6+v?=
 =?us-ascii?Q?WNtiikjLhYz+r8hVsSebQdjreY4nFTFtVbsm1THbFdDVNuniYP3AawcNOVlB?=
 =?us-ascii?Q?LtSyhMAQICLM+l5L+f1jwQ9qZiiYBhFG0yr1e9om1W54m4+AB2fr0NhR2P46?=
 =?us-ascii?Q?2gl24igaFFOy/g6+v24cAEbqg2/+gRI=3D?=
X-Exchange-RoutingPolicyChecked: HD2NmSTYrVbs2OSBSZI1dbzjYUGgihL9NwqbasBMsmdKPvCVlwaLmaABUtlbltIxUzxt4kTMKfade/6Psih7bPSyH6myBD/DKpCdzNOXk0J6zcGbNhsTQs1OdiYYgbnHkuAodV9g48nLBS01FNZYPLZeHNzua2MY1N6yHKog+Ht4yumZdZIV7IYZ01fpBp72NozqtzDbIu95WXgNmxrcMnbizfrFBq9ajlcDtG+8+wtkZ/cMMrAhcrB41CSWgwYaW+oGXSZqwUsCNReazu2TNzao+AeQYEf0IywG46KhLfskk22OMunqCECIEPp6GhbOoFjrYHtH1aXEyU28LEu69A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5770740-73bc-4e54-e207-08df086402dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:02:54.9712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJmhDFGb3E0mkDVUdZQ0cMQ2J88nMuY/rMX36nvtaXnn/aXTHMnRPmRHhy9EnjOSnRPcqzIsSuui1fbnavHbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB938433
X-OriginatorOrg: intel.com
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

On Tue, Sep 01, 2026 at 05:01:00PM +0800, Honglei Huang wrote:
> Some drivers (e.g. AMDXDNA) only need the CPU pages faulted in and tracked
> by the notifier, no need DMA mapping.
> 
> Add a drm_gpusvm_ctx::no_dma_map flag. When set, get_pages() does the
> shared HMM fault and records notifier_seq, but skips svm_pages->drm
> validation, the dma_addr allocation and drm_gpusvm_dma_map_pages().
> With no mapping state to check, the fault is redone on every call. The
> default (no_dma_map == 0) is unchanged.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c | 44 ++++++++++++++++++++++++++----------
>  include/drm/drm_gpusvm.h     |  9 ++++++++
>  2 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 810f801a9f7..0156ee82d7c 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1663,6 +1663,12 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>   * On error the instances mapped before the failing one stay mapped, so the
>   * caller must unmap and free every instance regardless of the return value.
>   *
> + * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
> + * drm_gpusvm_pages_valid() never returns true and success is only a snapshot:
> + * the caller must recheck mmu_interval_read_retry() against the recorded
> + * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it until
> + * its work is visible to invalidation.
> + *
>   * Return: 0 on success, negative error code on failure.
>   */
>  int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> @@ -1689,11 +1695,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	int err = 0;
>  	enum dma_data_direction dma_dir = ctx->read_only ? DMA_TO_DEVICE :
>  							   DMA_BIDIRECTIONAL;
> +	const bool map_dma = !ctx->no_dma_map;
>  	unsigned int p;
>  
> -	for (p = 0; p < num_pages; ++p)
> -		if (!svm_pages[p].drm)
> -			return -EINVAL;
> +	if (ctx->no_dma_map && ctx->devmem_only)
> +		return -EINVAL;
> +
> +	if (map_dma) {
> +		for (p = 0; p < num_pages; ++p) {
> +			if (!svm_pages[p].drm)
> +				return -EINVAL;
> +		}
> +	}
>  
>  retry:
>  	remaining = timeout - jiffies;
> @@ -1703,7 +1716,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
>  
> -	if (drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
> +	if (map_dma &&
> +	    drm_gpusvm_pages_valid_unlocked(gpusvm, svm_pages, num_pages))
>  		goto set_seqno;
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> @@ -1721,14 +1735,16 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	if (err)
>  		goto err_free;
>  
> -	for (p = 0; p < num_pages; ++p) {
> -		if (svm_pages[p].dma_addr)
> -			continue;
> -		svm_pages[p].dma_addr =
> -			kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> -		if (!svm_pages[p].dma_addr) {
> -			err = -ENOMEM;
> -			goto err_free;
> +	if (map_dma) {
> +		for (p = 0; p < num_pages; ++p) {
> +			if (svm_pages[p].dma_addr)
> +				continue;
> +			svm_pages[p].dma_addr =
> +				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> +			if (!svm_pages[p].dma_addr) {
> +				err = -ENOMEM;
> +				goto err_free;
> +			}
>  		}
>  	}
>  
> @@ -1753,6 +1769,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		goto retry;
>  	}
>  
> +	if (!map_dma)
> +		goto done_mapping;
> +
>  	for (p = 0; p < num_pages; ++p) {
>  		if (drm_gpusvm_pages_valid(gpusvm, &svm_pages[p]))
>  			continue;
> @@ -1771,6 +1790,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		}
>  	}
>  
> +done_mapping:
>  	drm_gpusvm_notifier_unlock(gpusvm);
>  	kvfree(pfns);
>  set_seqno:
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index d2b6f3d2b84..ec7b81957b1 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -254,6 +254,14 @@ struct drm_gpusvm {
>   * @allow_mixed: Allow mixed mappings in get pages. Mixing between system and
>   *               single dpagemap is supported, mixing between multiple dpagemap
>   *               is unsupported.
> + * @no_dma_map: Only fault the CPU pages for the range; skip the device DMA
> + *              mapping step. Used by drivers that consume the faulted pages
> + *              without needing a DMA mapping. In this mode @drm on the
> + *              drm_gpusvm_pages is not required, no mapping state is recorded
> + *              and drm_gpusvm_pages_valid() therefore never reports these
> + *              pages as valid; the caller revalidates the snapshot itself, see
> + *              drm_gpusvm_get_pages(). @devmem_only is rejected and no page
> + *              type check is performed, so @allow_mixed has no effect.
>   *
>   * Context that is DRM GPUSVM is operating in (i.e. user arguments).
>   */
> @@ -266,6 +274,7 @@ struct drm_gpusvm_ctx {
>  	unsigned int devmem_possible :1;
>  	unsigned int devmem_only :1;
>  	unsigned int allow_mixed :1;
> +	unsigned int no_dma_map :1;
>  };
>  
>  int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
> -- 
> 2.34.1
> 
