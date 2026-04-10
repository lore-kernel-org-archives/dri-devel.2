Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26771F44852
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 12:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7930610E958;
	Fri, 10 Apr 2026 12:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bSzslD6N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7861D10E954;
 Fri, 10 Apr 2026 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775825229; x=1807361229;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=a0pEeKU6OldmTaWufPde+j0QleSm8DZ4lJ5Kd7MsaZQ=;
 b=bSzslD6NTAe9LECGcuHUueJMmPv/C5KVvuhsHlx/E7azcRroBVbpUkKK
 G2KSeYAmrxR1xFlxys21FR2S2aPi/3SM9dCWQK3GiAs9TkUwu6pCgFQep
 AYH8/QcN2O9q92jjfmIJiKo+q3JHBgzzHsr/7j23sy4CFadd00mpkn9/R
 CKMMeQdJS+fMXfqsM7EMPUrUdkueUMBiY94Hw0PKvm5DCEyX+WFi6D6SX
 msbzEc75RbFUdg80AHGZuiKOgX+x0AQOqHt9Xj6OXD/98b+eJqi9v9i5t
 EqfC3l/Y/YF68OmAtZU6DluHzgfx5ZlnnIPRKC0lsVWgnQaDPUjbXd4jH A==;
X-CSE-ConnectionGUID: qXkfjr51SF6nCEjspjfrzQ==
X-CSE-MsgGUID: bdCbvw3QQdSZDBgeXT+b/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80435120"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="80435120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 05:47:08 -0700
X-CSE-ConnectionGUID: l5ajf3eVRBCK3fNLg2Ze8Q==
X-CSE-MsgGUID: 5sf0YbBcSO21J0bB14j/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228995197"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 05:47:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 05:47:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 05:47:07 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 05:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KswmPHco5d4BZ6mky7rC2RXm9WmtWukc5c0mGgzrPASlllOibKy3l5RFbMN9lYnU3fs7Lj8KI23oLlk2ZeiCxFLaBS/FENM6/KNR08YS88youUeUNqn0qrgfYeGiTj2r9vmM8mJ7Nb78EgGXGwvbTizkqOAvZA038A710lWLpZVMo3uZOWqF+wJ9stVApozz3gTyio4wqIXjL0id/HqPc33+npYXM4d2xZoq9Ul9yhAQVCkvFhhMnKWinY/PKHDLpym09kUSS3iEx414PBpwvbv4QT4U/bal95bFlFEgD/topQr73RNNjOwYNBgEzHDyQSGNrXOxWK96urxfdyCdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfMs64nlDHw1dwZX8RkZ93I0w2ZLzJ416VGGOPCPHB0=;
 b=KrKN8nlF9lTRDemxSpWT0HUevuYiEr+TG/R0za28HaC24F9mNAy08UVEzLhF2cZSM8sQ4qlHffXsB9DYSBRoEOxMNTbSCgunirsEeewxkgT3PdxqXkFhlP/YN4EzhiUW2HKkiMsqQz3oOR6jDYHX0Fb/g1P2H/ik6EKMKNqa56rdiaSmNaF7O3TN5gzdDWKswN+TURJPVEhiDOOKatXo00yBuRl5Lb1F5t5wHd+bA6Zy7XB10dX5gUt0wwz+tc6jR4d8/URr+eiv57Q3BrvriG1QuvekNCw2ksPjOa+NaQvhXHEPL2c5akVYY/NoZnEEB7bZt/v52fE5QgR4Y47SMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 10 Apr
 2026 12:47:02 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%3]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 12:47:02 +0000
Date: Fri, 10 Apr 2026 14:46:54 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH] drm/gpusvm,pagemap: Do not assume DRM pagemap owns
 device pages
Message-ID: <adjxPkmE94e1dybe@fdugast-desk>
References: <20260409015512.3670302-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260409015512.3670302-1-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::14) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: c22c763a-e5e4-4f0c-3690-08de96ff4321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: pyM+rIJMeYc3uKuIyoWnJhgUCE5KIBHS/zcQ+Mwy0zsM/HAUCF26sdEkXFk5x5KjDoUwgr5TFvaonJ+PAyv+zYMjRzDj/C25D8dlN+VP96oSEzppogAAybLRsnXVdLGlz38eS1fU2XvN6y9STsxLvpKMe2LGo8vGq6uYJ9KTFnmeNwbdWUJ2+6j4JW6I/mNw+YX370tLYrBzfzHIC6LE5BzvNd28GSqkgNJpOGkQn9lmvzE/0ne59hpS15CGcECkflvcJHvH5ipln9NtW/XeqNMyY1AVGfff74GxIoILjfliyM7MvJ4ydZ/ByCANKwmNysptzqIgZjle6qgStFft++gC32JjPG6x2hjD7GgRCGRIgYc90AiITmlwK5YxTWDGfdV/gFzEoia81hPhpdBLbDlQBVEnLcI4y46KhRFXAiZsBJaxRNHG3xy+3XVSjrSXdbinZrFOGnGLz1iX9+F5QQVTND6YFT/1S1LAFt7Pkg2lXeR4TqsK5rZ/le7Es8IO6cOI5YyCDgAEcEowIM7mLgATGLSDNGKRbVWWSeq8UrxSZcCdW97qIoOwoweDFBakFCRTYlw5Yc1QeNPdaXyusk8hi95vysA1EqscijpvJnzdjsCO+TwHJTgrXZ5Bj3cnWgcYKcWywSdrWYofaOEpCfmVwrm4T74hD2ruJ7rCqU2V3w3X6KNHTmGD0vAanH8YmwYo2+hjeZIAkWurcL/RN7+kkhMKtE1GhyuaQ/AQ9Hs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8AxT8USILAUCDLuMbbjAww2PKhKwPxTWMChORUuFEpxcAjrjZSZRkcWA5BNH?=
 =?us-ascii?Q?jOvb+7OCLwMYkMt5IU/JLtodltEt+4vhnDBWz9MrrIUXUNqjv0M84bVJaELB?=
 =?us-ascii?Q?EbXKSspR9Ynq2mW14+PH9OMoyKT7h6Fj0U0XXoa4AboxLISftxsMmOEAat09?=
 =?us-ascii?Q?q8Ype83ffYMG31MusWEIpT3oOqwmnjMtbRcTJFAXzyhMGpj9uuwmmK7IIXEG?=
 =?us-ascii?Q?EjLt0cA2CkOFNKSfXSarOz8y0Yo+3UahIhPO50WlI9vHidVxpatmu9RCvzGv?=
 =?us-ascii?Q?HnP3ly712dSTi8hQKy+VYNsR/mbMaLcx3tiR3mlVOMGI20xMizUoa2a2LUFJ?=
 =?us-ascii?Q?2O/yKvd0kAM1TUnwBXbDVtRHRitaIMaCHVb9HT8OrZ5W1z/BGOpv/0fSIwkE?=
 =?us-ascii?Q?n1KTtbEUiluk+8oLoxzSO9YbI08SLLRaCUHvQubox1WzMnOEyg+4+ynxEg47?=
 =?us-ascii?Q?wU83OMYJjB+D08zLFGgNKvlT6wGsMP0gTNuj8m5ohr2dqwVDvivik2v4Siuw?=
 =?us-ascii?Q?nUJ6LGGkeGdeSmX1/dcqy31MT9kniWuEFlyJqwhQpsMkPbVhCgQxtifTQSHs?=
 =?us-ascii?Q?tvVOTMn7slxn9jWvg+yZlDdnTFxXSyLL2W3MJNSXAz3vScNt3eJmXq3UjyMi?=
 =?us-ascii?Q?8T2qHtC6dV4Zv4GugVO8SYkuwx3LWQN842rj/eZ2MfBFic64WJ+Pa7cVxStv?=
 =?us-ascii?Q?7uVPDoRRad4EsPiGskDQ3lBOvYHRu+J2M5b1s7CdBVFSUvqzhkXCDH6JE3jF?=
 =?us-ascii?Q?b8eiClVH/coLlPkXFixC8TMT+HRkY6tP+r3Vj0oGBXq/4ZgrP5YvmqvRdblR?=
 =?us-ascii?Q?VFZkkmzbJTkq9os81zEsa55vcvqUGQGMroiRP9WCx3UGXMYZ4iC4aPGL5qgf?=
 =?us-ascii?Q?BknIqxXIVxW2x1RW4PD+eFI+bV4c/nELm75r6p2q65kQLzVB5MPAWrLYgjO5?=
 =?us-ascii?Q?mdFy9kMT11LiS4njEXRnqtrSMbqlVXAEFjpsk91WdySCNNjB+UpGcSMrenR4?=
 =?us-ascii?Q?xGwTtwyXo9XQOOaPxfQlYtnC1A+9V+Ebruluv8gWPAGmkgLWKSCa5MwKNH0C?=
 =?us-ascii?Q?tir2DNgLVsIj4lUUHh+aA6RYJlfJz6Kn1dLr4AGT7sbtUYuRGDNsIzKUTKr4?=
 =?us-ascii?Q?gkUD9kTRWO7gE0+dIc4ddVLkwYWKOtZbOnbPdJ0Hyy/jiofu53tmcaEt25hG?=
 =?us-ascii?Q?jJIQottTqGbjf3jNJOaaqs6I5K64VUJI819WjGpe2huu+//mS8JkFhIggLqi?=
 =?us-ascii?Q?MXdC2WsVfiwudxFoCUq9W+7t5EzMSx/q7LOcfuMm+AqzVCJKfQFeKULur9k0?=
 =?us-ascii?Q?rsGN/UDv4d5Gsjwgu54irNyBoJqNiPJeL8MKNxWuzphRLYMl5sv7gnS6v35m?=
 =?us-ascii?Q?J7j0OMkeQhHDDAX5YhVoWGFSzPKFNZZXXJr0+jWD2U0F2sptCVPU9uHMG853?=
 =?us-ascii?Q?oIkRvpaY3pGze+/9B3zs0Cds9dUqEcEmg0ZFQsxb1ZNJO3UdjvfLPFF09u0Y?=
 =?us-ascii?Q?WNEKcEk4nDkh21ILnW9oymgmq8IsZ7RdJXJ+fSq/bUibI4AN8My+dZ8nVFix?=
 =?us-ascii?Q?oGlY50JxrJXEMsNG2D1h0QFrmfOwxrZ5QXM5O7qvKor/YMg6r3siqIpsN6ti?=
 =?us-ascii?Q?IZiH1FFCnjq0m7Sk+bjqmquJjxrQQ/XKKaio2d74ci4xUE0mZo/TvEDw1ODi?=
 =?us-ascii?Q?AMpY2vODpbcQLTR5MsBVj1jzGRghJylIA/4tnbyNT+jYTpOAW/VNDG17HcAj?=
 =?us-ascii?Q?n0Oogj6yTd5KrVR6zsPkzKpN0BWKKa8=3D?=
X-Exchange-RoutingPolicyChecked: BR0dM/MJIc4I9MwgL5Nr3F1/c97UULW6RFE9zZd+5O08rcrvibPkN9ER7Wjcd+zZgOMZIRQdCIOBTdh2FfQVhnl+zRjQTXXJl0iqGcJFehhmW8zd1gIOxb2qPfLhkZ/v9jbVWWvQCoY9aQ4bPuXn/h9wvpPDUW5r0pja5UltbK8VBG8NJA9uhIdNRnowOlBbcvmPmxnQDAA6if8etWjmZLrSr3GAG71XFFIFPg7/qU6/5w3OpVPfDaXQ425csCwuQbI02/nqXlXG7Ff8ROLZ5KJ45jEdVfm86Ze913KaiRUQGeLFrPVZbXv3rlLSMrHjl9GTKKrsHtpE065+DD+lKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c763a-e5e4-4f0c-3690-08de96ff4321
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:47:02.2607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iE7AnJPkgSvNLHJSu0SmBUjgkwUiWmwpoqNym/3fS5+vbBwd49VEy+9SV1ejwq6xD2Xv1L3kGLLpBS7lXLH2AxC9/Iy1kwZhwOsy5Er9NbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
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

On Wed, Apr 08, 2026 at 06:55:12PM -0700, Matthew Brost wrote:
> Update drm_pagemap_page_zone_device_data() to derive the pgmap ops from
> the page and compare them against the DRM pagemap ops. If the ops do not
> match, return NULL.
> 
> Also harden two risky call sites by checking for NULL after
> hmm_range_fault() or migrate_vma_setup() when migrating to device
> memory, as it is possible to encounter device pages that are not owned
> by DRM pagemap.

Shouldn't we also harden other calls to drm_pagemap_page_zone_device_data() in

    drm_pagemap_migrate_map_device_private_pages()
    drm_pagemap_migrate_unmap_pages()
    drm_pagemap_migrate_populate_ram_pfn()
    __drm_pagemap_migrate_to_ram()
    drm_pagemap_folio_free()
    drm_pagemap_migrate_to_ram()
    drm_pagemap_page_to_dpagemap()

Francois

> 
> Suggested-by: sashiko.dev
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c  |  5 +++++
>  drivers/gpu/drm/drm_pagemap.c | 14 ++++++++++----
>  include/drm/drm_pagemap.h     |  5 ++++-
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 365a9c0b522a..b3cccd047a21 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1506,6 +1506,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  			struct drm_pagemap_zdd *__zdd =
>  				drm_pagemap_page_zone_device_data(page);
>  
> +			if (!__zdd) {
> +				err = -EINVAL;
> +				goto err_unmap;
> +			}
> +
>  			if (!ctx->allow_mixed &&
>  			    zdd != __zdd && i > 0) {
>  				err = -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index d82ea7ccb8da..95c951c5b569 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -753,10 +753,16 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  				own_pages++;
>  				goto next;
>  			}
> -			cur.dpagemap = src_zdd->dpagemap;
> -			cur.ops = src_zdd->devmem_allocation->ops;
> -			cur.device = cur.dpagemap->drm->dev;
> -			pages[i] = src_page;
> +			if (src_zdd) {
> +				cur.dpagemap = src_zdd->dpagemap;
> +				cur.ops = src_zdd->devmem_allocation->ops;
> +				cur.device = cur.dpagemap->drm->dev;
> +				pages[i] = src_page;
> +			} else {
> +				npages = i;
> +				err = -EINVAL;
> +				goto err_finalize;
> +			}
>  		}
>  		if (!pages[i]) {
>  			cur.dpagemap = NULL;
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 95eb4b66b057..9b7c50932db5 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -367,12 +367,15 @@ int drm_pagemap_reinit(struct drm_pagemap *dpagemap);
>   * drm_pagemap_page_zone_device_data() - Page to zone_device_data
>   * @page: Pointer to the page
>   *
> - * Return: Page's zone_device_data
> + * Return: Page's zone_device_data if owned by DRM pagemap, NULL otherwise
>   */
>  static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
>  
> +	if (WARN_ON_ONCE(page_pgmap(page)->ops != drm_pagemap_pagemap_ops_get()))
> +		return NULL;
> +
>  	return folio_zone_device_data(folio);
>  }
>  
> -- 
> 2.34.1
> 
