Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189A2C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCC910E08A;
	Tue, 15 Sep 2026 15:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BpxYBqBN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E276A10E08A
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789487521; x=1821023521;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=8vFS92EAS1zkXmlKUeJaA8NZZ1fOC+zZVQX5vI6ELG4=;
 b=BpxYBqBNYY7kCBbqZehHG6T3AG0JlQiRBFbyKq2xuVc9Oio/EE8yc6cT
 9h0Jckie8sPW+4/h19AKcSog81rkNWuIe0qdxlqL9/jAb0FvdYNztaKkm
 JV6INC2tmCsbalfwrMElxPlhgq7p43icbtX8LrlKRYot/OQLL+Yqymy4l
 OVFRkO6defF1oK+1QJxZt7inQYBxy5AEDM1P3/CI/gqk0yUK6jNzwvEa1
 4gzGbr3kOFL1KFExeiHvWk3qdDgxCu3pTuBYfOIl+0AXg/wN5j0BHK7TR
 /3QmViv5Zj3JpfBpSc65Ym9stfrS2Zd8P5yBbYcbSNgRovQpd7EUHtdbq g==;
X-CSE-ConnectionGUID: 2RslAd2NTM+rvj3hOr6MaQ==
X-CSE-MsgGUID: d1tjlNGtTbqN5cDgWAiWjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112626189"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112626189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 08:52:00 -0700
X-CSE-ConnectionGUID: xZvD8odESNmAQjsuQtuD5w==
X-CSE-MsgGUID: Bl5/g+H0Rj+W1VD/eXv2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="311314760"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 08:52:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:52:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 08:52:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 08:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8z5UItlJ70rkaF5YrA5NzOQIy717l84L+PFpmUGOXqvAayHD/55wnyqmFVlEUkZqumkxZwbUvyaNDeBnC9SiSgCEVCwRME6zHn+D4zO/j78FQ+E/wC/6iXgAPC0CuGGSr6eyXN4kIF/R5buWms8Z7jlg6kEwSnRCwDN67XsuUHaEewprRtGfVI7AOxM/6L/zHLppNDmJ38ClDu0huyvw82LLLbzaygpeFX/J/B1foRdcgi1Rm+3VhI6SwDCdjhDnFlVk6atIx63ygA+Oq7+H4GT/gkhqZlpeH5BsjDGj4WqTCkfyd05Qn9WZykb31epQ2Q4hgRbmxuDRtrhboyFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oQx9r8RcK7djet5dxVrvSC6eBw0leFzOse2h8OKM7A=;
 b=rTxvVGO1sO93P6WV2cq2W/uKLW9VobxF1S+32kUgn91L2uOiur+qHppV5N+W+jaG7imDqAuVOt106/8k3QCMBU9sXuEXOnBDyiMudoe9iiBPTpFIqiR5rnjY4u5367g3hH2XyWdb3lVRE5UvhJxgjGyTsIq7TTDp3Dr53WJNFxt3a6ZT1NUiL/rWaOjoS040dW1EMkTPZreRcR7MKpvwSYspE0SlB7jsRg0Zfr1tnsiORa36AiS//PReIp8dI65Lnoi+bp13IE/6fpTsUSBVQNEPKPHQi7bf2aiSiVR8DZSBaOxK9gFpv39EKvbOCWfQT4kYP5WnsJezD0D1QZwKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:51:57 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 15:51:57 +0000
Date: Tue, 15 Sep 2026 08:51:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: <christian.koenig@amd.com>, <ray.huang@amd.com>, <nat@pixelcluster.dev>,
 <arunpravin.paneerselvam@amd.com>, <matthew.auld@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: change TTM maintainers to Natalie and Arun
Message-ID: <aqlpmwiU1ofn3JsV@gsse-cloud1.jf.intel.com>
References: <20260915154804.605772-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915154804.605772-1-christian.koenig@amd.com>
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dac9bc9-5480-4bff-d387-08df134145ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WHFc0SRcwfMTHoRtQ3yMRP9bm9Zoqs62zskwRWvD+neTd/6M+w4Bf4e/UYPaS/ZG8XhaBb9iZLWe6ugJzfbcw96sGwINEiH/qUCNNBBbUb71stZQK8xBDI8LIgaRn9CW+Hm8WhfqepywBn08BLkvOubf/7BFN4cRfvpw0QkYycVps6B9AOIu7CB7sYMzcsuYFFIqdvlFz1G6bHkeYQc/myDHXVUB/b1wiZ5ddbEIzyMbuVlp5L1W/QUrwoGlWNqxOPKSXBdks/W+Hg9eyYoSahELEXS3BNVmlZAmiIRQJrKa7DuM7ehnSVPk9FK7c6Z+ZngiJSysHq4q6iLExEhAfSFqvlHX6J4Aodj9fSWA5hrpOqPLEA0xmUhs5s9synY96yiK7LFr7JwcYPB90OGOlVPdUgzNSxYGwRtiqdRgfsR1Gi0Vm9MlmO521J7tFcMlKDBn8sg1Kh2ZRk7bN+BsteUL3zzNZdrX5uSbZWR7EKmaNPSLmU8ouwXj5v89OyZutmQK/VajCh35lLPn+9SZyw90tNyp6GOio4RIgLYJ7Et/5yQhfTloNNdwjRumjKT11xjcuPv86/yMrlD7qbBMFeUIS4HXCJxV1xJYX5Spa/ihbBR27H0hoHvIdX4DLmWw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tWYiRiZqfqzYJKRQpcTySil/BVgsvMDrh1n07GZtgV7oqnhEWLzJuYngcG?=
 =?iso-8859-1?Q?aHvEFJDdzUVS7/Yo8XCLkmVhWTyubRxyY81ZuwlCYtWRM2YG4NEdGnrsYc?=
 =?iso-8859-1?Q?4KQRxrN+Lku2puU9ascI2ykH4q0hTWuQ6B2d13Edp9CNeroFjdZRH+j/Ke?=
 =?iso-8859-1?Q?DYm71U+2RVhZFRTTw09wWz0VaMC65X/E7h4M3F71idOh00IrjU3LsncQ7c?=
 =?iso-8859-1?Q?LgGg7lBETdOu4XJzgFruXfednY1+Lx+VxJ5iEc84GQ4hMsX7VHU6/VK9aW?=
 =?iso-8859-1?Q?N7hbxLSiLf0wGFH9pLse7Bdvgcvyyvpm1JHdwqFjBJIlNoJQYQds06YhY0?=
 =?iso-8859-1?Q?F3/rCf4gDJjfGcJLhO862Lvr7ZZZKSIklh0/xERjn+QdAcV+4C/kRZp8sV?=
 =?iso-8859-1?Q?6tIFltX4XuSYPolfq+UOCTwTZaAQljB4P3Et4utT5fkfbl5S8M+1LUulf/?=
 =?iso-8859-1?Q?FNLGjtGgG92RM7fWUdm0iTBvEnBAxzv4GvNzpAa9iEUP8hcQ1GZraMiQ+0?=
 =?iso-8859-1?Q?yNPLjDjc3olsyezB4L74xM3ymCrhcx6ujrxXxL4wn/JH76dQrhr/Inm2qs?=
 =?iso-8859-1?Q?BHoXXuQ73qOGQ81T8F05wtNSG5ZfDtXpVT9gPPLDJOJvVSSqvp9zqLsS9O?=
 =?iso-8859-1?Q?S1BbYvETraoqjcXBXimjvaUE798SUSP5Iqgrp3GXAZpR48E7xrb5EickLF?=
 =?iso-8859-1?Q?NXbPTKSkJvT29Uu/KweSwqoFxGHdO/hs1/OjQi/4QsQfme4NinyxJwUJLb?=
 =?iso-8859-1?Q?p5sL0LxLKQl/erUzDokx4A5djlsOmQluRfXJWKVJZ6+rBCyP4yOlnukKjn?=
 =?iso-8859-1?Q?lbf1wT3LrlBaCRq5H/GhfeuBMdkePqcBuQ3+yOZ6bWdze1LPUyTs6bmFIr?=
 =?iso-8859-1?Q?XRe2atJ7zQ9D/FHRsMndoj5s8wscvZFaFcfc4o9ju5N/tEwBfmOIMyLUND?=
 =?iso-8859-1?Q?FDp+DrZnIrGiA4jdg2fH/XXxSLsPE+GmvTAGBdC/JFZB1otjyc9wGJeYum?=
 =?iso-8859-1?Q?VqOWqqD0/sEv+1dhtb2+AysTHFLbg08hvu1yVJq8GzRFRSRqkwdWE00ttx?=
 =?iso-8859-1?Q?WQacoXWSEzezGExDGeg94+TAoLoccfLN3gnLlbyB3kA8Q/fF1A/D4L3/jI?=
 =?iso-8859-1?Q?IXtKx0NhhGfqh3pgWdw30VGBlmgcJhNshqFtafhTAQHioI4B+5esUuZRBx?=
 =?iso-8859-1?Q?OZXD5c7SvVgbC+fE0ArNcZA8yE+6l8w98/pge2fmUM1RY8zqZ022OzEA+O?=
 =?iso-8859-1?Q?evoAC+yY5iOh8F1FJ3aWu4reDRbgskkPAB20gZijm3ZEirhtKgU1gnK/2K?=
 =?iso-8859-1?Q?W8DPy2eY4BZXlwc1Qe77/cQfY6h/f2U3uzKtf+8I7a85KuecqVmGykGnan?=
 =?iso-8859-1?Q?VRGqtStOuzNV8TwbwL0snpWRVkfR0Uy49kKB1DmvPhq6ggWLjN9VcxKhB9?=
 =?iso-8859-1?Q?pOjXAXwk+A4fPIFw64ttty1XYalX9uAczYNvv75INEH9ECRTgdcxvkVCxA?=
 =?iso-8859-1?Q?fqHoOMkoLAVD+/5SKlGQaJWNig265F7PhRhkUo/fQnA837XeIV5uYepK+5?=
 =?iso-8859-1?Q?p90+Y3SbiqaSUKeQUERYb/z59a+uy7Y3fVjKK4GW7X3QV02Ewn7NBH3ts7?=
 =?iso-8859-1?Q?PmESSTxawqhi6C7Oeuwc5e5oaaoIf+KbcKx5EP/0nL5cY3cz+roCNvaZxT?=
 =?iso-8859-1?Q?bNql36gw/2P4Se/MJkzLoqd/O386DhBYFiggQWbM6tawStkhdRY2Kkr5PM?=
 =?iso-8859-1?Q?5LW3gR1RWVMRBlMafCf5y2sP0ybhIlnOtoBPv0nZq0EsNvGyby2YFAAUll?=
 =?iso-8859-1?Q?IKR2Yo/wKQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: L2AMAyvxa7fetwe4LUIY+L/sSd4cVGqtKaXVQCPtJss6HsIxY3NQuV2f1OoDLnyBsri+2LKrFS7ST+wj5TGIANUUjFry3LvzHVzsXxYWLvnuOYW6hFBCwvqgGhAEp/0PEDm++rs3WNVu1lkkMc6giIbJASWvW4pVL0GmvHEpdE+3avnnUK627Z/VrwbIWGrUDJGGgcsvmfW4YSnXqWbEi6gDH6zVtiNOSC3bPfUA8ZhFUbA0a+hqeMibK9boaMi34KFv8gVsb1FF/QNsJfYH1yZkob2BmH6L9cNH4kAdDncClrrgYKtMsIXkuZgeqGLcxW3mtSB4i8DRFf93SDGcsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac9bc9-5480-4bff-d387-08df134145ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:51:57.4064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2xI/0ovnivPnlhb6iS/XIs/B126lUuKPq04BWIhRXUhIan5QxSDaupLsxS12j4nwrw5Qm/PEGEeNdSn26RjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
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

On Tue, Sep 15, 2026 at 05:48:04PM +0200, Christian König wrote:
> The blunt reality is that I don't have time to look into patches or bugs
> any more as it would be necessary. The same counts for Ray.
> 
> Natalie has been working on the dmem cgroup patches for TTM and agreed
> to take over looking more into TTM.
> 
> Arun is working in my team and already maintaining AMDs VRAM backend for
> TTM and the underlying buddy allocator.
> 
> Add Thomas as reviewer as well, better to have more eyes on that
> component.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b5a4e4b35cf..b6e58a138501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9140,10 +9140,11 @@ F:	drivers/gpu/drm/drm_privacy_screen*
>  F:	include/drm/drm_privacy_screen*
>  
>  DRM TTM SUBSYSTEM
> -M:	Christian Koenig <christian.koenig@amd.com>
> -M:	Huang Rui <ray.huang@amd.com>
> +M:	Natalie Vock <nat@pixelcluster.dev>
> +M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
>  R:	Matthew Auld <matthew.auld@intel.com>
>  R:	Matthew Brost <matthew.brost@intel.com>

Acked-by: Matthew Brost <matthew.brost@intel.com>

> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> -- 
> 2.43.0
> 
