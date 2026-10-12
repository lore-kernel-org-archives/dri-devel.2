Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27D8CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1600310E048;
	Mon, 12 Oct 2026 21:58:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9ADA10F2E5;
 Mon, 12 Oct 2026 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791842324; x=1823378324;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sIIV62Xb2PuEvwQO3rLjCl0MDlTJ9kHF5Q7+LoREkfs=;
 b=fA2ZK/xcfCCM73uBXygRQAEQGo/A+yTI26eJ6HzR7NMPwAkXGXLqrmsr
 aLVJrGPx6svtMOVcPXwBtwfjpmfiV4rposdJ00CNaBjG9bE3AmQvkFzQ9
 lv0qJxsXqHih67QSCuy2+6wxcbtW7graDAgNTa7pIDBR6KD7giRFeP2vP
 P4F/vC6pOJiqtRCiQsPyuf2MNcwmlxvjFi4+xI7jVfqkTJ+jS31+G2T2d
 Fiw1K6wEQa07CLQybvOAI5cZPrtqjhKv3IIUIH4R0/73QSa+4OzDYPCfe
 V6sDHqoiC4UKZu086R9D4GljOuIfuk8dusB1J6Tf4TjzF3NpJnZ4ScDGJ Q==;
X-CSE-ConnectionGUID: 4mLmo3jvTEamKIqfXCUyZA==
X-CSE-MsgGUID: gvN+UBaFRdWQlgiYdX8TfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="459093"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="459093"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 14:58:44 -0700
X-CSE-ConnectionGUID: JuBGcbemQsuUqiBAojH0qw==
X-CSE-MsgGUID: hYsy9SXuQwSi82qR06BaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="2846871"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 14:58:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 14:58:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 14:58:43 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 14:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrvzzgH0BIDoOHxmxD5TTZ9Ypp6MT/OnYWWjJ2DygSf+c92qp5lzNLd3hCLBeYy1PBmvZomZc37sk6uDVe+fIXHUVZgxYv6fDfx+I9S5w9PULaPN7Bb40nlhvXCp4nP/JoINctY0FqWRVGGMCGK7X8PmQ4WeZv5Z5yksrNMByvGdw4FInTuExq5e/AWVxeD6jNkvTDt5K10kQiECZo5N/1zeMvbMfXMH3MTE5ZzO/idGppUTbdviuTthRKBEUl3VYrllQHXUJshTgyxKJZsOOPPBe7B0ZUqMGt/f0MBWRYGnD448M8BznY46fi+CsWZEV6mAnU+d/NcjLUUfBg183Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdcCzvr9tq6yTbjn0D5SgMjTgzhNSvAOR/MUI3wuF4Q=;
 b=DKzZ+xOYkJLYR3/tQ74jw/4TUFv0XUKp0oxnLYGxzgecGJz5YC7hnLCae8OFYPJcWroTMwybNCJ1oQbLEH8YJ+KE/g8fGsAsY+tev9LC4iG5xdUMPWqYVO1Z/AhyGhta8FrZIVSUtuodS7QLIQK1vMVqMNnggJacgs8oiK5NNtOjYO3KRqLw38a7jW6XJ0dX23n2YjtJUKeSzlgSVC2o1YlUuCwIcHXTEOuM6m/LiaNq2XZs71rccbgcwiRp1L8YP83TjGzt77byxFGm5DwPFgF3tsfwIKOjDsC917DTxWNcvc1cPeocqeaiP+WgEE301/bwZBjqLRpJaz/brjpXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4792.namprd11.prod.outlook.com (2603:10b6:510:32::11)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 21:58:33 +0000
Received: from PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289]) by PH0PR11MB4792.namprd11.prod.outlook.com
 ([fe80::fec9:8db4:c768:8289%6]) with mapi id 15.21.0472.016; Mon, 12 Oct 2026
 21:58:33 +0000
Date: Mon, 12 Oct 2026 14:58:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/gem: add helper to detect self-imported PRIME
 dma-bufs
Message-ID: <as1YBxIyBNLaChEp@gsse-cloud1.jf.intel.com>
References: <20261012180543.1488703-4-niranjana.vishwanathapura@intel.com>
 <20261012180543.1488703-5-niranjana.vishwanathapura@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261012180543.1488703-5-niranjana.vishwanathapura@intel.com>
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To PH0PR11MB4792.namprd11.prod.outlook.com
 (2603:10b6:510:32::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4792:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 685b9695-9c28-4df8-505e-08df28abf587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|261009221227099003|261009223027099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: zTCEoJzxYDWhqeVAlByqya+mDSypwweZQVLFxHoxB/SxWG9CJwRqzdqbcKc5sapgammq84ojWU+WCBGhsv7Dg1UQG0StLuywEjc87tDDkDG5quAlPR1H9rsNsz9B8J3DYSvF25qAsC8x2/YQz6jV4Be1NiZc9lF0L+ag/mnk1SbEVnymyIJxqcY8bicrzUbaJ4EfhFn4u2580JGTdaylU6wpc9lkEzybRzZInUECv56pDAIclCpMw5rAHmZGAD/EVPhs6rp+91U24lPUhVdrH/Mqmr3H7Y0YmNOSQNtdTS8+JZuhDTrzDizz2VeVX4RPMoY/F1TVU6lTdIqK7LRTU8Q87YlCWFth3yb8f8CArpo2jvZ9QHpmXw4NJu0vZ4g1Tb6MaHtzmpS5rkAXsWqkGG+Gf7IRTfXh0oNkshciNAGKec+ofYDpm8lUyTVAB4j7KLHn4jZchgvNgYwEzYIulxhRT6JhPj/aAs9AZ7RgswoS4k7sBBHFZxHL/q45SBmZCQwnX1P7h+qkH5fHD/LxMwLe28QNtNhPyt33li8ced7LQJszgoGvOT7dcfPEV00ektmZwswkjQvgCaOSqQ84cLWvaE2/EOfzTy6XgogYrpIcg8BPOwiY5AMpjn77xAkcRk2gmHL+G5+lELQwrKKbzxWF4HPYUBL3cL/hvk8pGjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB4792.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(261009221227099003)(261009223027099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/XOf9uxW5cBxJJTxJKlJp/HQAHuEPsWXN/OW5r0CMAdXc0vpk3p7Lv4IhhH?=
 =?us-ascii?Q?YJse/xQJFyLCSRosvzWa7VTxBPr6U07xOm5l0bOHkocN/6S+VNoY3mT644Ln?=
 =?us-ascii?Q?H20aOWTiO9C+KrAtsf6N5KCj5XfmZ4RzjNFAw9dVd986QmpofZcfkbwRzYuF?=
 =?us-ascii?Q?Vrei4rzPgMu9nBtNiM2STm6xKOQ6q+UCruA6N98Qn2K2ro0T+MvpZNuaZIE7?=
 =?us-ascii?Q?xjDzIm2TzaKS1Ut5G3aYe9TpTXravq6v71F5IX6x1fGU1fc5tSC2Lkf/TGhU?=
 =?us-ascii?Q?5ZwvXH7n5SuUXMtmtzC5r6NonsrdCW8uZgRHWoIvENMSXjt7sP67A9s1xX9o?=
 =?us-ascii?Q?rrnQ/TBsSt48OxagyMbDJuM7RysQ8RBGtR1ntZNHumVv2AQSJLenysVvUoMX?=
 =?us-ascii?Q?VQoyHtx0np/FEdZKcVH3wUS8VK7YQXaPB7luf1Glc5kGYcjvQSV5sowtd3VY?=
 =?us-ascii?Q?djqtwFGVTi+87qefNmlMylGIAoWNGA591P5XMEAhaC+PT4NwuGd7WsQDKMyp?=
 =?us-ascii?Q?6NHrijidVigAgeYv/PwSUk4c238AjWChdY2M2VIQbH2SsLIOq52HvLemvP5d?=
 =?us-ascii?Q?JS6OLLgwn06SPfk+bJ/jlQntHMqacKG3RUIgaeZPvFIMVxLTqthcC9ffgHqR?=
 =?us-ascii?Q?Yp4wP6iQmsqXrbJtu4q/Nx8SdNQUKGBsE+9UNvVugJl8zimMr/GG/6YAOfT7?=
 =?us-ascii?Q?DyJEfktTidzKBXOLpPasP3L01/VzLWOgd7L1BaIPchEaGAWrx0PMK00DBJ0H?=
 =?us-ascii?Q?8FPVzEKfUCKFsObCJzmkMwG0tK0wgDFIWzSgT0CtgupM8IjCBEuDPMhGv6jn?=
 =?us-ascii?Q?8oAE4YM2LrkQOAv/0OLSBK5/eG3pDeUiV38qkcwwD3LqLFcW7nEVJvZGUTWu?=
 =?us-ascii?Q?vgHNq1AIHUMBy0DvGzdX8ZIOWocZyONMcJSPo3vxn6+dGWmXUBI68U/qr8Kn?=
 =?us-ascii?Q?c6rLpJpvxnGQKr025IKpbd5uqitBrVhYgKbWrE9RAGfse1Qk9klQgqhbKRnv?=
 =?us-ascii?Q?dXxKnc+lgSuxwOQ2hrADSEJ/gPyWKKAoNtsnBDbtbEXfLIKczF/3zML/L+Xe?=
 =?us-ascii?Q?khcI5haK9l7FGd8Z2fMvczpoBaKkbQQw2F8BpWkiyOkdlirxu52s6Nuh27zL?=
 =?us-ascii?Q?AHScce+IsIGT9TNSq3LRuSxEmmKs4NkyHw5/54c8Iq/DbyObWo4TwOxl8Omq?=
 =?us-ascii?Q?6916Xcoyp70G0pG4zuFXmrBmgQFEFEp1z0yAto7O12B+4lBPjUgwi2GwqBJI?=
 =?us-ascii?Q?7bMhFlB86c5NW2McXTJOoHTffhvzVs58WDpQFsRNdNTLD/wKBtae9bi9vtlA?=
 =?us-ascii?Q?DCmD4HONU9YF8LKGEe3tg5J++9L87GbQIRpA1FVmhNhwkjefpSQZhkT0tXXX?=
 =?us-ascii?Q?YKkOffVkZ5bukHPM4QryBrsk1k9MkWmkoORqEQ1V+yO8pQf3nRzh2Qu+eMXp?=
 =?us-ascii?Q?Pwpx31ZcGYv52HJrDPtADyie3uU2v/Z1PSGHzH1SqkZ2qV3T+9H3wAtey0pB?=
 =?us-ascii?Q?nx584wEDlr/XF3URCIi4wSN7fx8QxyeMPKoRcAXYlb1ndxBBAb8u7gZExjId?=
 =?us-ascii?Q?YT+NoyZLt4RX+OX5mT5eVJrSelmo7l/wNDOKmSVUUT7qBY+bBldy/7+IpcPA?=
 =?us-ascii?Q?2XUtNBommqp2+1ie8OTvpXGfmU3r/AAOE4thfC5Qz7TTBM5J3CkBROOcoPyI?=
 =?us-ascii?Q?uTcWZDtv597oRZ2+g6s6kkkmra8FsC6tKXR2D3xJrJkdMjgCPbyR196DWb1L?=
 =?us-ascii?Q?3ke/YOJzXr+2wwS1dbpvC1nx0/pVNPc=3D?=
X-Exchange-RoutingPolicyChecked: VhjHOmFPVWbNgvBatLnxDdEZNbgmk/d3PcnFOlJf4NvLMSv+DDtA7jE0x5UK+F7PIKcGo26XPp9sceF2d1WPBLcsMRC/99fMaUadGcaGVbW59OeQ/YEi20PFD9scd5XUX8pVD0u5ulNVjlFjuAP43rJIuR7E+TJ0IqlKn0eyblozyc1SLk60LcNScte7YkGhZuSCODDAAqF9iBSmHrOhtjLJXkdSQ3YWI4Y6WV+KLG/F5Rrox2Oh+yMeh3/R5y//UJ4ZNc6bp81XRN0D0RubXzA00uUBvNxH2y4XCFR2QITtctbnaCTglm71kfYr66yXSTo6ehmAbk8Zgk59c5Uwtw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 685b9695-9c28-4df8-505e-08df28abf587
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4792.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 21:58:33.5548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Un1dx7iufEDrLWmASyWlQMMLyDMM6/dbLi/ltmBguAFG9pJFI7Hn8SJdp97X7HHc5fYV6EYdD2gCRO9rqiIoHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
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

On Mon, Oct 12, 2026 at 11:05:42AM -0700, Niranjana Vishwanathapura wrote:
> From: Farah Kassabri <farah.kassabri@intel.com>
> 
> Add drm_gem_prime_self_import() to detect and handle the case where a
> PRIME dma-buf being imported was exported by the same DRM device.
> 
> When the dma-buf originates from the importing device and uses the
> expected dma-buf ops, the helper returns the associated GEM object and
> takes an extra reference on it. This allows drivers to bypass the
> generic PRIME import path and avoid taking an additional reference on
> the dma-buf file.
> 
> The helper simplifies self-import handling and avoids duplication of
> this pattern across DRM drivers.
> 
> Signed-off-by: Farah Kassabri <farah.kassabri@intel.com>
> Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

I would suggest for this series at least one other driver be fixed to
use this helper or all drivers (a decent model should be able to do
this easily) to show this isn't just an Xe idea.

> ---
>  drivers/gpu/drm/drm_prime.c | 48 ++++++++++++++++++++++++++++++-------
>  include/drm/drm_prime.h     |  4 ++++
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77f..588910c250b8 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -974,15 +974,9 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>  	struct drm_gem_object *obj;
>  	int ret;
>  
> -	if (drm_gem_is_prime_exported_dma_buf(dev, dma_buf)) {
> -		/*
> -		 * Importing dmabuf exported from our own gem increases
> -		 * refcount on gem itself instead of f_count of dmabuf.
> -		 */
> -		obj = dma_buf->priv;
> -		drm_gem_object_get(obj);
> +	obj = drm_gem_prime_self_import(dev, dma_buf, &drm_gem_prime_dmabuf_ops);
> +	if (obj)
>  		return obj;
> -	}
>  
>  	if (!dev->driver->gem_prime_import_sg_table)
>  		return ERR_PTR(-EINVAL);
> @@ -1116,3 +1110,41 @@ void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg)
>  	dma_buf_put(dma_buf);
>  }
>  EXPORT_SYMBOL(drm_prime_gem_destroy);
> +
> +/**
> + * drm_gem_prime_self_import - Attempt to import a dma-buf exported by this DRM device
> + * @dev: DRM device performing the import
> + * @dma_buf: dma-buf to import
> + * @expected_ops: dma-buf ops used by this driver
> + *
> + * If @dma_buf was exported by this DRM device using @expected_ops, return the
> + * corresponding GEM object and take an extra reference on it. In this case,
> + * the import avoids taking a reference on the dma-buf file and instead bumps
> + * the GEM object's refcount directly.
> + *
> + * Returns:
> + * A referenced GEM object on success, or %NULL if the dma-buf was not exported
> + * by this device or does not match @expected_ops.
> + */
> +struct drm_gem_object *drm_gem_prime_self_import(struct drm_device *dev,
> +						 struct dma_buf *dma_buf,
> +						 const struct dma_buf_ops *expected_ops)
> +{
> +	struct drm_gem_object *obj;
> +
> +	if (dma_buf->ops != expected_ops)
> +		return NULL;
> +
> +	obj = dma_buf->priv;
> +	if (obj->dev != dev)
> +		return NULL;
> +
> +	/*
> +	 * Importing dmabuf exported from our own gem increases
> +	 * refcount on gem itself instead of f_count of dmabuf.
> +	 */
> +	drm_gem_object_get(obj);
> +
> +	return obj;
> +}
> +EXPORT_SYMBOL(drm_gem_prime_self_import);
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index f50f862f0d8b..d378404f8ab4 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -54,6 +54,7 @@ struct device;
>  struct dma_buf_export_info;
>  struct dma_buf;
>  struct dma_buf_attachment;
> +struct dma_buf_ops;
>  struct iosys_map;
>  
>  enum dma_data_direction;
> @@ -108,6 +109,9 @@ struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>  						struct device *attach_dev);
>  struct drm_gem_object *drm_gem_prime_import(struct drm_device *dev,
>  					    struct dma_buf *dma_buf);
> +struct drm_gem_object *drm_gem_prime_self_import(struct drm_device *dev,
> +						 struct dma_buf *dma_buf,
> +						 const struct dma_buf_ops *expected_ops);
>  
>  void drm_prime_gem_destroy(struct drm_gem_object *obj, struct sg_table *sg);
>  
> -- 
> 2.43.0
> 
