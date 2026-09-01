Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84366C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B5A10EED6;
	Tue,  1 Sep 2026 19:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="e06X5/8O";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0530810EEC9;
 Tue,  1 Sep 2026 19:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788291589; x=1819827589;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1T/vz7tiw6hhTdox7GA9qhSQCC/xmmKOg4l3pzmlHrY=;
 b=e06X5/8Of2ZgqvmIQzdIASwTeJ9x/wfA7FuNODbrVzzwQ+SAOEFBU7nZ
 7qd1j/auXgwELErEsNz5sEi9d48soZ9/u4kMJawSy8czxqc09kb6vuOIE
 eHof8gL9ilTSd0REOTrbPdGVlNLAszrZQo/LBEhIfzedGe7gig6VlRgPG
 o8acFR4B6QqlL//vzUBXbieKhVpTz3Aa9Q0PM95MyrndLaV5ZuQ9c94tN
 NXOwaVYHdcPt93Fm3q48/0hvWNC7wjrc6zepH1v0wd3/n0vSwIOwpMXRM
 5j0E3uwgeKe4lzr5e4ggIaYY1mX5wnbLQOZZs+4UH03rXt8LQThU1U8nE A==;
X-CSE-ConnectionGUID: MZZrnletSXKz9aaBJzCsaw==
X-CSE-MsgGUID: LtArpyC/RB6K4v6rinZGHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100246845"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="100246845"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:39:49 -0700
X-CSE-ConnectionGUID: t27KqvfZS4+wA+b/sveOSA==
X-CSE-MsgGUID: I5V1PWccRvemGwHohBNrZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="264910623"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 12:39:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:39:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 12:39:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 12:39:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujc2ElahDuv/AEYytuKR6Pu54vvG1UBnIuClnh8MrSjP9v6gX4TlT6USGMdW5YlqWfKtDM8jX7UPDERCJY4WNwuNk3iiEYG2L6HxqrvFSxv0En46aL59Aa9K7Q8p3A9x2bqtjp4kYrwc40zLbvU+NQHcnPi7L/1kgT6uAYfvv0pAWRLnDc72bK9LzQ9WHtExA4PB8WieGVi9MRtIlHU7016wjhL7OB0q1Cd9ftCwttwohVPRui8uEkqBaXjS5iRlWxo6zYmQuGm21DzOAb6vYoi5fFX7iAmQrLAOUZBZIAc2CPfJD73f5ogXfGjf4C+FE+ex3GrdesJCbCqTaLSbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSViKDDXoI+WT4jCORN8u2JcZo64bw06p63eq1/EkHw=;
 b=ZOQWygOcxTMz8dEYgOhE38RpLXpQKsQ5cy//ktj35iZPip/dxn3yN0pRK3CdyT8Vp4TreGJqxsi+pEBuzt58vNOo/YpMcv28zLTVbtLfB7bHOlprNXC6TizpsT/wQ8MXJCUaTQrNwrFIWP/9mL5iFsbxBaZtArsZcjkKLuO6apdtM3UCNSqm8XZb9sczwCEnDV5gPbGD0M+tSSY6bBiy6SrNVHxgDc1zdCuP3cB1xHXyW2UnHUG8Jgkh3uH54rmkHbBcFCkWs9fT9wR5bbwOmygZ/S9AXM3KIteu9hcVYy12lKTNdJDUEgeiz14Xu7ZlqSyOMB8iEZN2eG0S5fG9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:39:44 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 19:39:44 +0000
Date: Tue, 1 Sep 2026 12:39:41 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/4] drm/gpusvm: move dma_addr allocation before the
 notifier lock
Message-ID: <apcp/XJpPdG3jzPd@gsse-cloud1.jf.intel.com>
References: <20260901090100.2024933-1-honghuan@amd.com>
 <20260901090100.2024933-2-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260901090100.2024933-2-honghuan@amd.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8f3d27-c82d-4366-2499-08df0860c626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rcsPz//oPDvvRwT4CfruYRD1CjqZ4Jxv6/9mU2DNqzgxtm9mldJc4yEmptxjvokhFSOwYOyxc87P3qLePgOlATsupm9y0VrU5Pu8bXxD4tnYVa/h5L33n/fEr2DNfT8dO0ZFDNYHGI2kvBYWmUgmo7k1KS79ItSmZHm5I2G/tlnIkIn43eeSNek88dL57JGv/CQvM8fzJExCCPuEuIQdB3RrxNttv6gDzmSszLCipIja4t3t6THxWXWghn/AnEwykkib28PlB++3RI/kHrGGLe8ZJ+mIIV4HqweJ7GQJ9cMZTNApMDvVODIakq5t2cqCkeNpcxpMLRqkWweQFTumyh+UFtT8oiUBYiejajAplDvnCMOf6J0KeOEhBpz0O+tORAwbUCWqyQ9GUK9JCs27V88XtszLBDgUDZ9cRWGru/LSrcaiTx8bMMybNqDkGZ3Oc/VFg1SEDbYvv6xs02MHzc4mOAcT4nTRN33evE1qkF+LphuWhAyWH6HyYyyRvwZxPGfChMhK88Nc3a1mXG/Llt0XcFW1y/XoDSTfnbmZvh/DM0F92NDQAWX0Nnsg7sj3YjEXCemYgw7AP/TMyA6Hp5XolGUydSb7/NlD+74ZEmO4mulFn/FUSqSx53G6k5TDJey0zA02I3hjIuh2MYx3FcCw3U4dF70ATen3xLCuQV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeNZC4R6eSQEHlY/ntrkP1HYzbof8F26z3iXO7znpLWD+FoVjVJgyrWAfTr2?=
 =?us-ascii?Q?6+Z1wfyz6gt8ZSne9kMEaOUkm52WxLsaFGIttUYcrEzPYc3COyXtGVJo41of?=
 =?us-ascii?Q?gPstkBoEoIsXFmHfIbfYrI71o5+Gnbwpm0P5FYOXQ7XM7XVo2fe9A8/RmJ6j?=
 =?us-ascii?Q?Ssez37Fc+74VX7mpolOP7DCmrBN6spnnadkgLXWfoA9BXwqOM4xM9LtgGDh0?=
 =?us-ascii?Q?LSxPtP0VDSGGpth5aiC5ALjaHQ21/9gEVDE0fXEftImOYOpQK/gM6A8lVuw8?=
 =?us-ascii?Q?y9n6E5cDL9qNDmY7S+dmyjsCCP4vwyMuinM7R9sf3LH2daNMxRqssSKh2S92?=
 =?us-ascii?Q?7nDjUC/FShL6PSBRXdizC01oqK6ffrGI5FenHvdEV16uo3A9CvBIpCTxkCW9?=
 =?us-ascii?Q?F+LtBUPTVjybZDD8i/urpQU+D6WMFCixeM/TZpkALJq+5hFlXoZAPIIWDQnt?=
 =?us-ascii?Q?Eiqy7mhq4HRUAh+EmI4VN/SLwnRezzTUFYDKKuh9Kmb/7djKyFA0F3WJSzbk?=
 =?us-ascii?Q?tsOGybmseOPnzml4u1gNQ7oXXYXpaLmkFnIX+VIgkWaoeF0ZjVtpjVXCf+h4?=
 =?us-ascii?Q?deGmSaTH7eZlDCGz3ec2xzDzxdPDZGVs1oqxUZFuikXZB09FxpUFV5XO+2mK?=
 =?us-ascii?Q?16RhVL8Vu0EjNYZJDH/+iwiSKMDtQtLcSjuiZxcQFao2QupLxh5IAE/kjA1g?=
 =?us-ascii?Q?7GhlBHNQ+acHz+SRLYD01qVdOd2GJZPqMOYLlQ9qL3Oo697FSxA98k6nDoBF?=
 =?us-ascii?Q?+erojCevBVBBzJtPSVpMv2V5jTfecAsAK3Liy2Lz9RHtQDCmSt27qF7SKLah?=
 =?us-ascii?Q?dZZ0/6IDOYVEGekrRAjeJq3ikxCGC2dbrJDpAusxT8hynPM+/9LAqCcVQ3ma?=
 =?us-ascii?Q?WaMWhR2BIEprxHcjjpW4wvHmOxGW42SlaRPSMZoVbk7ZBYVI8N2D6E1R+D3p?=
 =?us-ascii?Q?1C0+iw9FqhObsKzUR4SUx4tpSzGUYEOzUhtpDr/7BUNJGX0M1hEngLscXg3o?=
 =?us-ascii?Q?65PYLQvJFEkkh7Epuoegq2Msux9JYd1I/fbIjZz40b7EZIheNDqpvXIURytE?=
 =?us-ascii?Q?A7F/hzLRkDFKtHlhjE/95NhqNKCjQ/kjDgW6GyMiu87R+mz8hZCNJkVUXVa0?=
 =?us-ascii?Q?dPm0D3snoH4yAR3tcieZE2s2rCQrjbhDZbz6kNrUHcojZkGFNyrxy5NKqRQ2?=
 =?us-ascii?Q?onCkDibV8VUwWR5ByYH+MfxJo7+KcJqt3LSWTBEZF0D4T77fIysk/qiSwEae?=
 =?us-ascii?Q?6H58VRpDUxY0feVY4Tl7cWHCL4X3RFtJyohJXFi1jRsyqA+NtyEge//JGnZX?=
 =?us-ascii?Q?2scQ65CF96glOc41z1N6FS4SGYrRU1LXMZarJGFJoAVFu3JYrUXrYF7OSR9p?=
 =?us-ascii?Q?c8+vXgtDUPM5Q6om2ElwG57PSemdeTQXidKbII3eYbzJhO7giGwayn0JjimS?=
 =?us-ascii?Q?ry1hlbegA/g5zrEn7i250LU2EfwdXwxj23sMTPGvKfeOrPG71HbzTnFGyngq?=
 =?us-ascii?Q?J4aLAlOPv6F9vJ5iWaMD1WfB6y+lbdbDLfkfid+rHKQa4+e2VDBS5PFjn+AY?=
 =?us-ascii?Q?dhz330u5iy8UgqXIlIf60G40jHEnNZ58u4FrZle976Ayj9L4w77p1lp/xTFj?=
 =?us-ascii?Q?TNGaBJtVneILOm3Z6Typ54BVVd+fLtVAbSLuy2Oh9vzNkFpGjT0CAkyIagyj?=
 =?us-ascii?Q?jYwgqGYYJJmQuywA014WVBhGGoo94ttCoPFrlKtazVB5NtVWPrzDvz+biTUv?=
 =?us-ascii?Q?nRA9F6QefEJ9tCcLfwge3GtQaTC5hog=3D?=
X-Exchange-RoutingPolicyChecked: SrJJbCeEIpGQMLunjOseI/u1vdonas5wuevC6/BtX7Hd9eDWBsgKzFPDVQuMxiQkKElQ/cDgSLHzc+FE7A3LqPSpLxWjnPkeLEudu+v3F+O6TfoP8mrbBq2uWCYALKWT6lQbsRQmGZyu/NwKl6RsV3zlxc5rjmaYJ4h//Qrm03e9udTgLCXpNF9aMxGtbFD22KJVK8uOt+ij+Qph5syglws7krXNuJl4Ycpzq7gZX8HPoP2GUPJ8TZXNDm9pme+C3OVuf14VausKzczpeq2gluNvUSZ20b3IsNJSqOxJXjLEd3+hcMWP0DwJW9s81QN2SiZWMtw8VLFL3PeTlZ7QhA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f3d27-c82d-4366-2499-08df0860c626
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:39:44.5983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yzLxpuhFCW13K2VZbG28G+EIxE/yoFzoyPT7fkm/8PfMO/kzU3vt4+8mjBuYDqG8uWpihxKfN6z0/oG+sHrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
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

On Tue, Sep 01, 2026 at 05:00:57PM +0800, Honglei Huang wrote:
> The dma_addr allocation was in a lazy allocation flow, it needs unlock
> and goto map_pages. The allocation only needs npages, so just do it
> before taking the lock. Drop the map_pages label and the relock flow, so
> the sequence becomes fault, allocate, then lock, validate, map and
> unlock. No functional change intended.
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>

One follow up suggestion below - not blocker for merging this series.
Feel free to implement this or at some point (we) Intel will get around
to this.

This patch is:
Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> ---
>  drivers/gpu/drm/drm_gpusvm.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index a93eee7ddb9..b507de539e6 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1516,10 +1516,18 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	if (err)
>  		goto err_free;
>  
> +	if (!svm_pages->dma_addr) {
> +		svm_pages->dma_addr =
> +			kvzalloc_objs(*svm_pages->dma_addr, npages);

One thing that isn't great about the current code is that, regardless of
`npages`, the overwhelming majority of cases result in exactly one DMA
mapping. As a result, we end up wasting a significant amount of memory.
If an IOVA is allocated, we only ever need a single DMA mapping. Even
without IOVA support (e.g., `iommu=off` or `iommu=pt`), a 2 MiB backing
store implemented as a THP would still yield a single DMA mapping via
`dma_map_page()`.

Longer term, I'd like to do something like the structure changes below.
We would still preallocate unless `npages == 1`, but if
`drm_gpusvm_dma_map_pages()` finds exactly one DMA mapping, we could free
`dma_addr`, store the `drm_pagemap_addr` in `inline_addr`, and set an
`inline_dma_mapping` flag. This would save 8 KiB per page of
`drm_gpusvm_pages` for every 2 MiB THP-backed allocation.

Then the final piece is teach drivers to understand 'inline_dma_mapping'
in their iterators (xe_res_cursor.h in Xe) to correctly walk the
dma-mapping.

Matt 

diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index b7d987bf76aa..73b7065610f0 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -121,6 +121,7 @@ struct drm_gpusvm_pages_flags {
                        u16 unmapped : 1;
                        u16 has_devmem_pages : 1;
                        u16 has_dma_mapping : 1;
+                       u16 inline_dma_mapping : 1;
                };
                u16 __flags;
        };
@@ -140,7 +141,10 @@ struct drm_gpusvm_pages_flags {
  */
 struct drm_gpusvm_pages {
        struct drm_device *drm;
-       struct drm_pagemap_addr *dma_addr;
+       union {
+               struct drm_pagemap_addr *dma_addr;
+               struct drm_pagemap_addr inline_addr;
+       };
        struct drm_pagemap *dpagemap;
        struct dma_iova_state state;
        unsigned long state_offset;


> +		if (!svm_pages->dma_addr) {
> +			err = -ENOMEM;
> +			goto err_free;
> +		}
> +	}
> +
>  	*state = (struct dma_iova_state){};
>  	svm_pages->state_offset = 0;
>  
> -map_pages:
>  	/*
>  	 * Perform all dma mappings under the notifier lock to not
>  	 * access freed pages. A notifier will either block on
> @@ -1540,18 +1548,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		goto retry;
>  	}
>  
> -	if (!svm_pages->dma_addr) {
> -		/* Unlock and restart mapping to allocate memory. */
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		svm_pages->dma_addr =
> -			kvzalloc_objs(*svm_pages->dma_addr, npages);
> -		if (!svm_pages->dma_addr) {
> -			err = -ENOMEM;
> -			goto err_free;
> -		}
> -		goto map_pages;
> -	}
> -
>  	zdd = NULL;
>  	pagemap = NULL;
>  	num_dma_mapped = 0;
> -- 
> 2.34.1
> 
