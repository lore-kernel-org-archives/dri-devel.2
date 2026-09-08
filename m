Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00874C79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E614210E978;
	Tue,  8 Sep 2026 03:18:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V2dFzJc9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1769F10E945;
 Tue,  8 Sep 2026 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788837494; x=1820373494;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pVtNXzCUVfONaGSWaDHNkfj8wusOa7Aap+ReBx0nRfw=;
 b=V2dFzJc9lRUb0KNuaZiB9gwAMkOAdpd+4+q4bczCG/4IDXDq9WtlQM1w
 pMnTsw317CDaYJD3jxAtrQ+Hd746A7SPklHJf4nePrnW9l/F8O9d1yJSV
 Wu4zdJSgXhIMoVh30hA9sBR6EzhpZGXjEdLU2iT1wBihbmPY0fUSXnFEX
 zFAgXeEfX9GZresSi6K5ZT6dFBU2ZeYHasokONBAfK7DIDj8xHR630Wlp
 rVl3MXd6WuSdpJth3qz1oMLty4oS2UBQt27W7d2DaKxRYtt/NEh+rqjSW
 HshvuayntbIDGnZQ9BFr3GT/5bynFPSz11KRr255brs78e3rsbg/SRFjl A==;
X-CSE-ConnectionGUID: iB4huy3vRA2sQ5D6fHPCiQ==
X-CSE-MsgGUID: 86XaFBXUS+afeJdE10C0XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106746122"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="106746122"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:18:14 -0700
X-CSE-ConnectionGUID: x6nNEmgbQO6uDjlyIS4org==
X-CSE-MsgGUID: 6Z3fO4G3RdOUZvmtMt+YxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275003393"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:18:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:18:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 20:18:12 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5TFgTmr2iOr5dNPX8tIHUZlrK5iq+PDI43ZJsI1ndcROh9CpAzZTvNAl/eiIz8bNlq/QJkrbByaTUSLO7C9ThplG3ts96soxUlp+j7XApJhVXR6Jv2On3/4G1QehQogVajG4jzLgRTXyDUiZLM2rpxlLdYmfRajJDEjszJ5k+CgywdSG9GCU0flQClNtvF8kb+Vgitat44OprVfU4YblR1mlya6gK3PvCiPKSoXPPOJmgS8HJL4GUyu/bpkprozuoRCjLTu6uqRdPQJ6osjjcpq0BIZ5uPm0uAk9genNDBfkRVSH1aCYAo8BmzQjrBhHcmG3s+MQscPO6SoGrjvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sei4nUBUDwPkR6DgWmZavatzDdhI+dhxQCN9qnGBQ4Y=;
 b=XKGJgD8WSQ1g5udn1bOb4oWy4tAYsnCZrJSRZ6qeWfkGc3pqwDQa7Ug717i26QKko7E+zroUGhdte7n41MC39O/G0d6ocbgTcqhXxX6nZxk1Fgw+KrcapsCTb2KrJHjYFu5dOHZ3qJa0EOBTFdBkTCIGJ7Nqyr3q33Pqx+39k/2lnP4gjkBlxK5MWloM9+D4hwqhiRxc6aLl9jJeoWGbYcRZ2WgCqBkUk2zDn3ClpxPiwxvc5AuO+laDpQaTROazVw3ycvQZbTig+nIS190zyUZSuKTTMEY7FtB8ZQ5hpCc+FVcMuhUTjqOWiLUAfO3XnyvcYpyZH5dz7Ejrj6mfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:18:10 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:18:10 +0000
Date: Mon, 7 Sep 2026 20:18:08 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 6/6] drm/gpusvm: keep an IOVA mapped range dma address
 inline
Message-ID: <ap9+cKNSFqX94F5k@gsse-cloud1.jf.intel.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
 <20260905133142.3628027-7-honghuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260905133142.3628027-7-honghuan@amd.com>
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: f2250d64-83c5-4685-0600-08df0d57cf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +AQVCcCt2gw8fJy6JMjaANRqyGp7hLATuzJwtE5XmGugAvq6vLs/cXnS79iE0cr1SAcEB2dSuBbw6f9Xf0C9En1C/AVnV2/Wad4DTsA76FipAkoaRT5r7HBFyRvxStaL7F0TViKKTEsdgpjjloZh5XuJjjcFDJY49fkaiFU5dYu2bhInB4B1v/m+NZamQTrVCKlG2+qqd0fvICe1Fkxsdc2HkJETQQ0TlzWz4SBEFVnIUpltcRmTQA54tMChi6gwV0ngQsgsH21luJHqYg6hYjeQBZ13cEEmxVKHEF/28bDJMZafXhYcsT20cCRod2S6KNoEGJEgI33oIdi74l94y/eyyJ7f02+rZQ4NGFHhkHs5CKtg/A03P1IdTUxd25l6sxExRvxg+BZ2l3OVE7UwQ6IFpXwRS1AqS4bdxTT9VIGMB7RWnagS7qwADPpq3NbJy4LdSuA44x2gxopA+bvgnaGtsD3YgLQzeSZz5c9EPrCNAu3Sv9HwJUu7G1K3b5HAZ7q6TUEI0pQbaPceh8gPKfK8fUHjVz4yXNBe6lc8lsS37lM6JI9RWLKV/yS9Ksz2euJd7uoZK+DidosuyvYmHykiyQni6vMR/YVpIJFSV54g1V781rUJ8JpHpmSigrGNDZAcN4BVSL7nfIQ8vpvBLHZyoaMrKG4BtIN/F9Vu/oM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3fDvupozIUKvmAmIY7wc/wofhONeTnCnOhRPG6M8sSdVuTWwvvm17WI5ZKX?=
 =?us-ascii?Q?xu/esSUuGUWryCQ2F2YWPOKTY8mnpfo8FB+xPUtQyiH2Q2oBAQkpgoqGqdJL?=
 =?us-ascii?Q?VtV4jtiPASlL8B4XABfwGVRh+bbJ4R5axkDnEif4SRnBWLW+sCp0wmw8a0Ni?=
 =?us-ascii?Q?0Est3mTyIY+7O/pSLyAG1MFOssIwRgTIlJ2+WXJoW5Io+6alCPvhClnlOKTO?=
 =?us-ascii?Q?HVmEwuArlNeO+Zch/R1q7pJH6uf+l5xjxau3MHhfVQ8QxNGsybRCwZG4okgC?=
 =?us-ascii?Q?lt0pDD1AJURTu4Nc+8eqW+auKP07W9MEFS7uGWfPxa5BiRKZ90URDz6u/st0?=
 =?us-ascii?Q?Xi6IS7JrfCwWK854OnB0re4VxcyBQgCVo6E/6lWtiMnKHGn+6WcfyUyfILFW?=
 =?us-ascii?Q?Y1pJXJC42pdcqRMh4mYR40M32wqx1CQRX4/KVSCK5nMUWd2LZezXD6iymm1d?=
 =?us-ascii?Q?7j3eCK2CSbiQyQn2cFgXT4k5+AA/vafxlDCjeQUvkg8bi5oIdtf0kkDP0sSs?=
 =?us-ascii?Q?ZTLRocU7hxIrBAwyH9r1ml7Pi0/DZUdvBkbB2wTdp4Wc90+YJEZVgynX5DuI?=
 =?us-ascii?Q?sH5ark3DfspAne3wv/vnoSG7Ev4P0BNE7ImFAEFm0oCUZqfk8GcXYbT7iNUO?=
 =?us-ascii?Q?MM8NRocA9mC3sy5ecsEsRwHIk1tXTWfxOW8lia6RT8cgVRpkOvLdTJme4Wqs?=
 =?us-ascii?Q?Gmhw0XueBlpTFLq/QcvdApDouGAE2xlyGDVv8lP354tyFa0BIGZ1Sb2zvoYQ?=
 =?us-ascii?Q?eQIqZrFVNp3SzlPnWLaUs1ZAOHvsQZVIMjgjOMljMn5EczTGWPYjSN6Q5Oon?=
 =?us-ascii?Q?GorDKe8VsmUSNfqsD0Vsq5/SJpbNKbV5FMwyg5E1yckwPcqh0NNcXJ2OpFnu?=
 =?us-ascii?Q?OKqT/Hh70nnZ+bPakZ0Xzi/LQe7e5ayVHi9mDjAGTAC1/0TSHf7X5f0X81fx?=
 =?us-ascii?Q?j1aIFiCV/u9srTp0qtzHJ2+EOQ61IWNrwHMscE4Bc9hBFJFWtqDyRo56C2cW?=
 =?us-ascii?Q?UKTP5eD0Uyr+2C0DPxXiqrhdC8CBZv1uqhP6I0o0XminzYe9+fxD81aPQ9NN?=
 =?us-ascii?Q?N3SydbMc0icPHKEft5FrtxUrGZKg4GahqotFpn1LZwtiE6hjPj/7FG4kSIUQ?=
 =?us-ascii?Q?yluRk+FFHaCVRREsoI5tl0LDEDY5zGQxxnD5/UWo0HU5QBpDhNXt6rb9ka/3?=
 =?us-ascii?Q?BXUGQCHDEr3gDUb3sfHhOlvtmufSTEdGWHf15NYfm/Tudsn0a8UWSja2D5R1?=
 =?us-ascii?Q?hmWIZkX/9z0rp8Og8bGXnJJH5PWtp/iw8JCQn44YM3tH88l9Bswet6ksJNYu?=
 =?us-ascii?Q?TntR5iFgjXfy8yUPEFmn1nNemnB1r5xePjDWdSJAxmwjIQ6s/yMCTQyB46X6?=
 =?us-ascii?Q?9oUTHgJiXsbFZR2TEM/5fRCPFHeo2LN+E8RvwAgS67jN4YVTBLAETOIHSolY?=
 =?us-ascii?Q?AmIIMkpHlhb05Kn+gN9pP0/FK8ITY1h1pmjNR8wocIzL6dGpQ8sQUBx9o0T9?=
 =?us-ascii?Q?DzTrQhPRTo4eOndOV1+6OqJ5jmUsOv4mN1HqiMKDQvta+Q2W5JuoiH/hgF/Q?=
 =?us-ascii?Q?5WpGCAV5UtzvFCdxUJxqRpFh05/LOCpYuTeQVQSn/Xb6cApTr/xhgqgysKtQ?=
 =?us-ascii?Q?M0shu7nmHqa8SWnyFSfSyJlcf6cvPmStspRGBhQkutpVGKSpQnnsX4H5l4vw?=
 =?us-ascii?Q?quAlv79SVSpFl+ZN5vZvldJi0cU7wBqqgjIUGhbfiZPolh6gKOg9Z1xbDhHY?=
 =?us-ascii?Q?akA1Sx5vlin1JsGmwYMAsqEfZpw5CNU=3D?=
X-Exchange-RoutingPolicyChecked: zmovUanc2cTEU4Q2ERkQqugj5Hhuov/AUj7nNeCDGYJjz8vrQhZuxT5K7kY7mxjcQLD7zlABFsPEy1NCJHDD12y4w8pGdB5WO4UFrRrbyFVikLby2cNUtkMAQwwW7lUy8YW2wuYhPLj46cCt02q0awKcNDsvH0A/bdQNHXt2JTQ7lkVEDGJq1mHSoe4BB23CgWNyfbCAyxhhBTiWg/p0CMq0xZPHPEEWVZsKPvmoSGmDQA6alIJisxj8U2IVJKBWIg4ox1i1NphFnzWSr7u/5NqEDdLE63Lu5m4lZMmLdkBea8V81KxyW0BTtcJOjw73AgsVFCJi9Ixa02F2IfbakA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2250d64-83c5-4685-0600-08df0d57cf6f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:18:10.4814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDjB5qXdmFjDMb2uaMeRr0Yuy/WdOq0CXtiflAGcbJRcc5tGYhmsSq3Ibuima/pbmXRoboXexNWmbbQ417Zdvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
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

On Sat, Sep 05, 2026 at 09:31:42PM +0800, Honglei Huang wrote:
> dma_iova_try_alloc() reserves one contiguous IOVA for the whole range and
> links each page at the next offset, so the device addresses run
> contiguously from entry 0 and one entry describes them all. A 2 MiB range
> of 4 KiB pages then drops the same 8 KiB array as a THP backed one.
> 
> Fold only when state_offset covers the full range, which proves no device
> page was mapped in between, and only single page entries, so the order
> kept is 0 and stays true. Widening it instead would tell a consumer to use
> a huge page for npages separate CPU pages, which hangs Vega20 on amdgpu.
> 
> The kept entry no longer bounds the segment, so skip the unmap walk when
> it has nothing to do, keyed off dpagemap rather than the flags, which are
> not published yet on the error unwind. Consumers need the same
> distinction, so drm_gpusvm_pages_first_dma() returns it alongside the
> array from one read of the flags; xe passes it to xe_res_first_dma().
> 

Nice trick for IOVA allocs and variabled sized mappings like userptr.
Looks good.

Going to megre entire series to drm-misc-next shortly. Thanks!

> Suggested-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c       | 41 +++++++++++++++++++++++-------
>  drivers/gpu/drm/xe/xe_pt.c         | 23 +++++++++++------
>  drivers/gpu/drm/xe/xe_res_cursor.h |  5 ++--
>  drivers/gpu/drm/xe/xe_svm.h        |  8 +++---
>  include/drm/drm_gpusvm.h           | 13 +++++++++-
>  5 files changed, 67 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 2c7c4c89dc4..b6c9d3a07dc 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1242,7 +1242,7 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  			.__flags = svm_pages->flags.__flags,
>  		};
>  		const struct drm_pagemap_addr *addrs =
> -			drm_gpusvm_pages_first_dma(svm_pages);
> +			drm_gpusvm_pages_first_dma(svm_pages, NULL);
>  		bool use_iova = dma_use_iova(&svm_pages->state);
>  
>  		/*
> @@ -1259,7 +1259,15 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
>  			dma_iova_free(dev, &svm_pages->state);
>  		}
>  
> -		for (i = 0, j = 0; i < npages; j++) {
> +		/*
> +		 * With IOVA and no device page the unlink above tore every
> +		 * entry down, and that is also when the range may be folded
> +		 * to one entry, which must not be walked per entry. dpagemap
> +		 * is set before the first device_map(), so it is also right
> +		 * on the error path, where the flags are not published yet.
> +		 */
> +		for (i = 0, j = 0;
> +		     (!use_iova || dpagemap) && i < npages; j++) {
>  			const struct drm_pagemap_addr *addr = &addrs[j];
>  
>  			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
> @@ -1491,17 +1499,32 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
>  
>  /**
>   * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
> + * @svm_pages: The SVM pages instance that was just mapped
>   * @nentries: Number of entries the mapping loop produced
> + * @npages: Number of pages in the CPU range
>   *
> - * A THP maps as one huge page, so the whole range needs a single device
> - * address: the dma_addr array can be freed and the address kept inline,
> - * which is where the memory saving comes from.
> + * A THP maps as one huge page, and an IOVA reservation links every page of
> + * the range at the next offset, so the device addresses run contiguously from
> + * entry 0. Either way one entry describes the whole range, so the dma_addr
> + * array can be freed and the address kept inline.
> + *
> + * state_offset advances only on the IOVA branch, so reaching the full range
> + * length proves no device page was mapped in between. Only single page
> + * entries fold, so the order kept is 0 and describes the range truthfully.
> + * Larger chunks, several huge pages among them, stay an array that is
> + * already short and that a consumer places with one PTE each.
>   *
>   * Return: True if the mapping fits in a single drm_pagemap_addr.
>   */
> -static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
> +static bool drm_gpusvm_pages_inlinable(struct drm_gpusvm_pages *svm_pages,
> +				       unsigned long nentries,
> +				       unsigned long npages)
>  {
> -	return nentries == 1;
> +	if (nentries == 1)
> +		return true;
> +
> +	return nentries == npages && dma_use_iova(&svm_pages->state) &&
> +	       svm_pages->state_offset == npages * PAGE_SIZE;
>  }
>  
>  /**
> @@ -1656,7 +1679,7 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>  	if (pagemap)
>  		flags.has_devmem_pages = true;
>  
> -	if (drm_gpusvm_pages_inlinable(j)) {
> +	if (drm_gpusvm_pages_inlinable(svm_pages, j, npages)) {
>  		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
>  
>  		kvfree(svm_pages->dma_addr);
> @@ -1772,7 +1795,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  
>  	if (map_dma) {
>  		for (p = 0; p < num_pages; ++p) {
> -			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
> +			if (drm_gpusvm_pages_first_dma(&svm_pages[p], NULL))
>  				continue;
>  			svm_pages[p].dma_addr =
>  				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index fa4b29da0b6..7fb2fe1f826 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -831,9 +831,12 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(xe_svm_range_first_dma(range), 0,
> -					 xe_svm_range_size(range),
> -					 &curs);
> +			const struct drm_pagemap_addr *addr;
> +			bool contiguous;
> +
> +			addr = xe_svm_range_first_dma(range, &contiguous);
> +			xe_res_first_dma(addr, 0, xe_svm_range_size(range),
> +					 contiguous, &curs);
>  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
>  		} else {
>  			xe_assert(xe, false);
> @@ -865,11 +868,15 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  		xe_bo_assert_held(bo);
>  
>  	if (!xe_vma_is_null(vma) && !range && !is_purged) {
> -		if (xe_vma_is_userptr(vma))
> -			xe_res_first_dma(drm_gpusvm_pages_first_dma
> -					 (&to_userptr_vma(vma)->userptr.pages),
> -					 0, xe_vma_size(vma), &curs);
> -		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
> +		if (xe_vma_is_userptr(vma)) {
> +			const struct drm_pagemap_addr *addr;
> +			bool contiguous;
> +
> +			addr = drm_gpusvm_pages_first_dma(&to_userptr_vma(vma)->userptr.pages,
> +							  &contiguous);
> +			xe_res_first_dma(addr, 0, xe_vma_size(vma), contiguous,
> +					 &curs);
> +		} else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
>  			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
>  				     xe_vma_size(vma), &curs);
>  		else
> diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
> index 0522caafd89..c3a037e5f34 100644
> --- a/drivers/gpu/drm/xe/xe_res_cursor.h
> +++ b/drivers/gpu/drm/xe/xe_res_cursor.h
> @@ -233,12 +233,13 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
>   * @dma_addr: struct drm_pagemap_addr array to walk
>   * @start: Start of the range
>   * @size: Size of the range
> + * @contiguous: Whether one entry describes the whole range
>   * @cur: cursor object to initialize
>   *
>   * Start walking over the range of allocations between @start and @size.
>   */
>  static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
> -				    u64 start, u64 size,
> +				    u64 start, u64 size, bool contiguous,
>  				    struct xe_res_cursor *cur)
>  {
>  	XE_WARN_ON(!dma_addr);
> @@ -248,7 +249,7 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
>  	cur->node = NULL;
>  	cur->start = start;
>  	cur->remaining = size;
> -	cur->dma_seg_size = PAGE_SIZE << dma_addr->order;
> +	cur->dma_seg_size = contiguous ? start + size : PAGE_SIZE << dma_addr->order;
>  	cur->dma_start = 0;
>  	cur->size = 0;
>  	cur->dma_addr = dma_addr;
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index 7eb80d4d6db..2ef4ef026cc 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -223,13 +223,14 @@ static inline unsigned long xe_svm_range_size(struct xe_svm_range *range)
>  /**
>   * xe_svm_range_first_dma() - Resolve the device address array of a SVM range
>   * @range: SVM range
> + * @contiguous: Where to store whether one entry spans the whole range
>   *
>   * Return: Pointer to the first device address, NULL if none is populated.
>   */
>  static inline const struct drm_pagemap_addr *
> -xe_svm_range_first_dma(struct xe_svm_range *range)
> +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
>  {
> -	return drm_gpusvm_pages_first_dma(&range->pages);
> +	return drm_gpusvm_pages_first_dma(&range->pages, contiguous);
>  }
>  
>  void xe_svm_flush(struct xe_vm *vm);
> @@ -449,8 +450,9 @@ static inline bool xe_svm_range_is_removed(struct xe_svm_range *range)
>  }
>  
>  static inline const struct drm_pagemap_addr *
> -xe_svm_range_first_dma(struct xe_svm_range *range)
> +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
>  {
> +	*contiguous = false;
>  	return NULL;
>  }
>  
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index aaad5c9b510..9e35584812f 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -380,12 +380,19 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>  /**
>   * drm_gpusvm_pages_first_dma() - Resolve the device address array
>   * @svm_pages: Pointer to the drm_gpusvm_pages.
> + * @contiguous: Where to store whether one entry spans the whole range, or NULL
>   *
>   * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
>   * this function abstracts the access to the first device address. The driver
>   * should use this helper instead of reading dma_addr directly to prevent
>   * array out of bounds access.
>   *
> + * @contiguous comes from the same read of the flags as the array itself, so a
> + * caller cannot see the two disagree and walk past that single entry into the
> + * fields behind it. When it is set the length comes from the range rather than
> + * from the order. The order still states what one PTE may cover: the range
> + * length for a huge page, PAGE_SIZE for an IOVA mapped range of single pages.
> + *
>   * Only get_pages() and the free path switch between the two union members.
>   * Both hold the notifier lock for read, so taking that lock does not stop
>   * them; callers need the driver lock that does, which every reader of the
> @@ -396,13 +403,17 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>   * Return: Pointer to the first device address, NULL if none is populated.
>   */
>  static inline const struct drm_pagemap_addr *
> -drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
> +drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages,
> +			   bool *contiguous)
>  {
>  	struct drm_gpusvm_pages_flags flags = {
>  		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
>  		.__flags = READ_ONCE(svm_pages->flags.__flags),
>  	};
>  
> +	if (contiguous)
> +		*contiguous = flags.inline_dma_mapping;
> +
>  	if (flags.inline_dma_mapping)
>  		return &svm_pages->inline_addr;
>  
> -- 
> 2.34.1
> 
