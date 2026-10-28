Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C464606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWUwUOZl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8201A10E104;
	Wed, 28 Oct 2026 21:27:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E74F10E086;
 Wed, 28 Oct 2026 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793222820; x=1824758820;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x9VNlgAbKu/PDFL8O/uYfZFKMjSd+g8Jw79aAYEIdos=;
 b=hWUwUOZlLhaSBvZP5xwyOypLvzwBmkfDg3aBVwieWD0ZVUVwsNj6a3wb
 hA6MLc9PlrYJZEHCpxM1xT/LGsybFmc2KNJ99Hue9NySsnPomVwA3TCyy
 J6oF8cEhLQicW8Hbuze+UC/QQHAZiEYNn4Pa9A1dkzoobKdMICygc02Mm
 2jTaVLYYaOfrd3KqFZT3aEZBa1iM6CD/xrxtFmqF0bskHF5hRqMntzfBV
 TOdeoUe/3dKDw7KhSGZ8wxWsSrsgJJQ/VhOp4IqfBIuDHoT/5JuexHo3e
 oBo1GlA8TEjYxvqsoGZ0HEo9IZBiaN69ChQVxaLjxWeA6aqITtlZwhdBE A==;
X-CSE-ConnectionGUID: SO3dOMbrTn+hk+BAfUDdgQ==
X-CSE-MsgGUID: yTokl2bXTDaiRzGfIcsAIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1841104"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1841104"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 14:27:00 -0700
X-CSE-ConnectionGUID: W+5I2qO8QnqcY3tYA38syQ==
X-CSE-MsgGUID: ek7GNIuqQOWYhgricgoRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6717782"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 14:26:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 14:26:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 14:26:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 14:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVkq8YNoI6ophZcfPgjQj8UfFLAdfJmXDVUzFuPPLuFat2Nph1h9RDTXweSDtVEetDgUQk14lxmw3P5vchTmnR2dwF8lDfh4Yn4OxbU5K9q9SKnD8tFNo6RmhSi0YLx3GpiJkGXlmyGos49KpIgv2I+a6RdwAglVXcOynj8RuUNfHPZhz8jkzVOezW/YNTAxkATYjqoEfph8OgTmhUZ6FVKGN8GCW28G3G5f2ITmnekTO9oidJfBo5jPIZd8UObkDVAAwwn4gnlI2Ot0tQDeygHgsxBOKD8vMxIxyrcbGefzEB3Ji0y5VI4f3dIf3jNdZVn/RkWfpukD1Xa9+Xo3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYBAww1GNIE7+tq80L+W2U1n5oXLm6aOmEcU1vV1dfc=;
 b=nc6EBsay4Q2cwCZ49nEIAzavXwtEEsoTBbtMiaMnyD2Y31b6Q/nciGPlzPjTxUx2qQSaDUJaPO55tTtAPUDv8fg+oSa7TndVdCqaUf97ntzNrnW57pjwrYIkNxOS5v3uwQKx5v6ixjqQDufnuIwvdn7kRVUOcnNb4XDDTwvi6bhc2puPJxVAukemaQJ3/w1jRheNMWy1iWcekeZJLNAqlFKbORynWkY08I/cUX7ZgocCYN4dLYDjUFviGHhrdhwPSpZStSGZhU1CDDQ8vh2DtVibFYaroTuBDvsbH/jO8Q9em6muckw2YVuZ1g5eEnOmrYNl1cmtSHzsNmY+0TswYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by SA2PR11MB4890.namprd11.prod.outlook.com (2603:10b6:806:117::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 21:25:55 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 21:25:54 +0000
Date: Wed, 28 Oct 2026 14:25:52 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 1/3] drm/xe: Bump the LRU on a successful page fault
Message-ID: <auJoYA7c/1Raxqbg@gsse-cloud1.jf.intel.com>
References: <20261027224902.1085762-1-matthew.brost@intel.com>
 <20261027224902.1085762-2-matthew.brost@intel.com>
 <dcbb570b-0f53-4df2-9d17-62c66a80a8c4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcbb570b-0f53-4df2-9d17-62c66a80a8c4@intel.com>
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|SA2PR11MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cad2cb9-21b4-4358-faef-08df353a0c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|4143699003|11063799006|56012099006|261022075727099003|10067099003|261028144727099003|261009223027099003|261022105027099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KGuZf76Clh8WL1jOhGFlt36ZIK0g3NkuzE6DBfeqG9sSilF9xyRI77+pwcBL0/O4MwFa6/ZhL+P43hN/lV4Inyn2tvYjRIAtE3woD4Nj8oIH1ecxSOcevi95iN2fDCR+2O16S5WZh4sIrKeK4WXfcYMV3vYvkNPoNk7Uco3ghsviK/UfrrjzPZs5FLXBjrqIZcyH3EVbCrr6vGjz/2gvJpCcQP3gRiHjjLaTDl6XzKb6mn0Oo29GOn8WhBV3z7WDGUCG6RdmwdtQeIWfkqxnxocD60FzcifE4h3tk/y3auCWP0EPdU0sZfO6lLoYxUSn/xJ75tvFsYREdumtq/KMYOtr+T/bNUxDEXwxoxvuvhlFaRM0Vj/SiMMHjBr2v+ssRc7rwqdnQdEE6E8ACtef33n0tR6lhYQM9A2yBfZXukg+Cb/e+rmtntgOXLaazMlpFm/UKP/4GafsfMrwp7WlFjZu+0vavr4wyI8Dv5XNQ1/J0zr2MF23fJoBb8J+rTodnmfhrUCqUrCMKVYyHvNdHlsjoeu5GbBo/c09BpgJy6nFepAvrDGRPDl8igkM9gMdI4wxQRJK1oX9ebTYyLPi+ByLIiL+Bjt1zazIwiinLqGQaKV49pq+zpZlr4WjL5PmdFTW7+1alBLgOwf8spKUuAnn1BxQCKHxGoxD0RM8ks4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(10067099003)(261028144727099003)(261009223027099003)(261022105027099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fsAgbJIi+cRvR6cA7xs+8Ix4fPR9ZrswudnR/yKKNu5SP438OdISn5VrCZGT?=
 =?us-ascii?Q?jo2i7iZTnZ9EW0i9G6DhPObDUlIhu6bJW/+izgTz9lvCGeNGvVUPpMIrwUFo?=
 =?us-ascii?Q?du3gu4cFc9yqxuSElqxoL2lLth1sKVQH1wSc/WSUHHdiHEWCD5CS2GQRDze9?=
 =?us-ascii?Q?WfBXgvRO8j46OOMkxlFYwadh+8n0LHWb9YGca8UTopTOvBUD1o5Rb8gaX2O4?=
 =?us-ascii?Q?SmQwSHc9NVA2+bzNWCG8OjTUwcqY3KDzIPc4uPq4mwhdhkO8o0uLMDOxYY+v?=
 =?us-ascii?Q?3vprvt7oT0XIdfDMoEMaVDjjRY1bBOlPBjDPXuU08o3tAXB2gI+e2RJaauUo?=
 =?us-ascii?Q?GC4hGasLvIxCXQznDQeMC4m4SA18ZhDnKaQajDrldjVGJRuNqkN9uDHwa4iC?=
 =?us-ascii?Q?5c14eEQz0yQGxcayH0xWVyAOGVC2VPkDw+GXa7fxGha4dsG5C2zPb67RabhD?=
 =?us-ascii?Q?ooK2VzyLFvBEwhEomNnFSPlNKah9N/7hO1ocPz3RZ5cKUFEX3w4F2xP3iR56?=
 =?us-ascii?Q?gknfERFMikeTJPHcDGovxfqS5L0c/iiB5x72FZSpHRndsqQtgfz7JiOZYj8P?=
 =?us-ascii?Q?2pGWmD9tsfEf3D53bDbO+gcakE2mH3tyERUVSal0D8Dgo750BEZe8xUzJGHP?=
 =?us-ascii?Q?0gZWcGB1qOriaGFWlkCqF174TqvnW7Pbh7rAkdyTt6DYNGLr54OghD/+hOaZ?=
 =?us-ascii?Q?IH/Cb/tAoWV3jAWtqjC8SJ4ChREiiaMHbs4GmdGlMufKGWeslHjZnhwj0EfV?=
 =?us-ascii?Q?UGptJWlOEjHIenHa0uRxZ6TOfhmDTFpcpiIqjUkiZ0Z1KfFMUcJ0EQZNffu+?=
 =?us-ascii?Q?ZXyM50LW+CeQ/uOXW+m0mh1hr8LDw96pHuKIlkPanJrQsWy1FJhIX3LgtGEo?=
 =?us-ascii?Q?dZsYMnrzragMF7G1bvZBjkXwr/6O+NWG8WaeHpNJHtJyHEh5R4TP3Ns9dyMe?=
 =?us-ascii?Q?wbET/vslV2f3QhynYtJ3UFBegXr0ndIGNIMOIOFYnJ/khHJLpDtDExmavu00?=
 =?us-ascii?Q?XIHlEDSHEivkBWDHHavuy8UWAu0NQ7A2RbO2LaBXi3a/LhlN/kqotdsy167p?=
 =?us-ascii?Q?aUZsuWR+/TK7XFznl38AtKu0kqrwBAe8CtCIZf9vXn/Z/7BkCcWcZqr4tUoK?=
 =?us-ascii?Q?D0EXi+ReHOFaX2LYfxAtab0vESAitMm+F20BXIoxKZcDIAygJgoBtSW+vdMQ?=
 =?us-ascii?Q?ptn1Gt8DY6v/VKmmz98eWTMtk1M1EmfztfbS14CzjMiY/E7MIOdA05FPrK5o?=
 =?us-ascii?Q?C6FfdIDw15/c6hr2xhxmYXpYROvGd4zoCVJ1oEO4HBAs1+HE93FkvH2xLrhL?=
 =?us-ascii?Q?2MZT2y8rdkqnVrXIl15uRmngsb3Z4SUcUZyJ+LV1DGK/0c/6EjHGKIhKoyYN?=
 =?us-ascii?Q?yjg7vJPv3sbqSKCap86j5jl3xodgvUVoyBRQD0q/Zdto6EWgYDgkAvxCh9HG?=
 =?us-ascii?Q?qZ31uBNkz7jpdBXn9pSVFc+IKRdn/oPhiyqq3eIEFRfN2GuWrQFpbzKCq91e?=
 =?us-ascii?Q?NiZA5Eg5gv9ORyMHq+pK9ScFpPkU02Iai0BUPTGIbl2U+O+DVdIbiz+YNBSA?=
 =?us-ascii?Q?mP31tTQhPk18fs7Y/PPp1YbWzrwK7xGD9Zegie5p6b4KxA/dBOx89AcQL/St?=
 =?us-ascii?Q?DWOL6cJYPWbcCFDo7HOeb41K7OofqHeZYDBcScM0z2FWiWPtek4ma2LWMdbX?=
 =?us-ascii?Q?qQRyKxv1gtA6q9I/hnnoiCBFmUMybkz5czogjBJ3W4F5w9PUHF+5cIfK296s?=
 =?us-ascii?Q?G+BFfGjzW0+aZyQXVSeBmZ4aBbvzQ3A=3D?=
X-Exchange-RoutingPolicyChecked: 4rjbxuaqMYEZKLNzfniRPxf4xBwBYLnv9ascJyjx0mBw5dWn6PZjK7kdrTEQAFxUTLdwrFGw8VE36BlowhNwjzrcGJHRSNkE+UUK3/adx4guALQAc4h3JoW0s50KOGg+54sIjAjLOw4PZD7WpsSGPtt/eFquIiOFE0o4KLqgcIE/Sqm1AjZVnoOFfEynIL8sedSyofCo5nmVb+7xV/LlYqaew3mJpsCNHBX+wB1EJJWA1IbEECl3C5T1NWfgPIlZ6VSKGkkRdk4ZMP/X+L8WtNfgHwYAv3acMQOLo7I31WhO62LhVsziKK8LnJ6H6H714k4MJ6ljwolvpc8+c++oeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cad2cb9-21b4-4358-faef-08df353a0c79
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 21:25:54.5663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elY0Xst1LiHvyQPyOE8KyUEGHwQqSrl/0FYP+QIgcoYYGbHN4r4xchKV28WM6nYecbY6BvsLgZgVcLwMHhthhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4890
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 09:59:26AM +0000, Matthew Auld wrote:
> On 27/10/2026 22:49, Matthew Brost wrote:
> > Servicing a page fault validates the VMA's backing store and binds it,
> > making the BO part of the VM's active working set, but unlike exec it
> > never moves anything on the TTM LRU. In fault mode, where a VM may run
> > for a long time without a single exec, the BOs the GPU actually touches
> > therefore drift towards the LRU head and are picked by eviction and by
> > the shrinker ahead of genuinely cold BOs.
> > 
> > Bump the BO's LRU on a successful page fault.
> > 
> > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_pagefault.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> > index 5247321c805e..6828f81df50e 100644
> > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > @@ -201,6 +201,8 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
> >   		xe_validation_ctx_init(&ctx, &vm->xe->val, &exec,
> >   				       (struct xe_val_flags) {});
> >   		drm_exec_until_all_locked(&exec) {
> > +			struct xe_bo *bo = xe_vma_bo(vma);
> > +
> >   			err = xe_pagefault_begin(&exec, vma, tile->mem.vram,
> >   						 needs_vram == 1);
> >   			drm_exec_retry_on_contention(&exec);
> > @@ -221,6 +223,11 @@ static int xe_pagefault_handle_vma(struct xe_gt *gt, struct xe_vma *vma,
> >   				xe_pagefault_set_error(pf, XE_PAGEFAULT_ERROR_VMA_REBIND);
> >   				break;
> >   			}
> > +
> > +			if (bo) {
> > +				scoped_guard(spinlock, &vm->xe->ttm.lru_lock)
> > +					ttm_bo_move_to_lru_tail(&bo->ttm);
> 
> Would it be cleaner to just use ttm_bo_move_to_lru_tail_unlocked() without
> the scoped guard stuff?
> 

Yes, that would be better. Will adjust.

Matt

> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> 
> > +			}
> >   		}
> >   		xe_validation_ctx_fini(&ctx);
> >   	} while (err == -EAGAIN);
> 
