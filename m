Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ECFC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B2E10F448;
	Fri, 14 Aug 2026 08:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YJpP9mPC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5AC10E611;
 Fri, 14 Aug 2026 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786695529; x=1818231529;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=l4lvm4jftKkobE5GE8KY9v5LKAZTxaLlcSWfl0nJLxs=;
 b=YJpP9mPC0LHDM+mLtC5DdzN2nysWX/Mk+G/eQG0txfB0+5SpKcD1+L8n
 QuBaa46//WxcFsR8RoI3oUVoj09MG0YM71UEygmiGn/WYXNAM4qR8Q9uL
 5a6Vkmg3egCbmhqJUnUa2YC5AmiwGDEiSl160d0a6x6xM044Fg2gsPTP1
 kG7x2R77YKS8adT5v44hbUiLAv/G9DRAejsL+hNbTeEkv9kSx1q6qe5z9
 BfszcNLtPJO0uIsM6ZDMIjWgX/QRuchCif3FcGRmoaVZPNkpNR9KdUGC+
 KWtAs2LZ6DzuENg5waMyEwM2zemJyjXM5PzNDw0irDGr556Rges2vdru8 A==;
X-CSE-ConnectionGUID: t1KP7PGOSyGzJW7Tw+fGXA==
X-CSE-MsgGUID: Iy24BvqcS+Kdwkc5ExrT1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="110062667"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="110062667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:18:48 -0700
X-CSE-ConnectionGUID: HSuuVgA0QtSwAU3tYiJYjw==
X-CSE-MsgGUID: epqZrEGTRbSCkiFUyalXlA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 01:18:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:18:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 01:18:46 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 01:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odB2Rl0CeYbfVrXt2Nxw+tsq1iNG7vcRS31pFtRvGcnOfSqpISDWZDJCamWgGrbOgF5BGVrRidHPAUUMZflUcmIHAJncvBKRrqyXvx/FRhC1IEFdLJxCXdRW12iHUT8j1+R1rX7lF3icuF/omLOj4UjaE/tCkuc8J/BmsCPJERO+p3MHa4japkPoua2M9aBJ5Si29negWnvQ7IkJMhbVG9C5DrR7Xk3LqzUXBJC9s0h8JYtXYYrCdCSBr2sPAp5udOGoQFRyIES7e0IL/sgpYdY5zK0GQYhzNlZc5m3xnJ/KMfDiyjSE65Ls+p3ejU2tOQTZuekfVuWnchEofPq62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crX2UXHmF9TMjIKcW99PxcrU9Mwm++0nh2DUxsbtZnE=;
 b=NRHtMFbJjLmRirrmrlXUWj4fs+eaGl7YWjiJ9BINRAGPFqPzAmdXF67j5UiEINz26CQtP/9h04vwZWILM+dN7o3ISVyrF3AgbtvMF8Zg2BbzJOcHOAUMS8yHSXYSHIi1FTM2PGqtWrVNW1Q7X85qJ9Re1rz8QqtfWIeE/Y3v0KwExns0fGT/x+iMavV9aSKr7+Tid4bSk1oxwFM9zhm7N3cIkZZXyklLLZ4r9XE4KgU6fk+BoI38JK77cYWR9YuQT5o3WV/mmvxYEzwNpNggHIONgxE3kPQRooX2QkBSO4GHjBuv9PaSQflQDSKqUsNDYkJq4gydj568NjKx7jYYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 08:18:44 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 08:18:44 +0000
Date: Fri, 14 Aug 2026 01:18:42 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/gpuvm: allow locking external objects in two
 passes
Message-ID: <an7PYrd8zDssAtAs@gsse-cloud1.jf.intel.com>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <20260814073258.893007-2-matthew.brost@intel.com>
 <20260814075107.C2A4A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814075107.C2A4A1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CO1PR11MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e0ed04-dcc2-46ac-537f-08def9dca81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mVvipMYdT4XUK1SC8tkHRogbul6uf3Ep6zJuksz1rZORTWZVwcZ20Frcg9pOJrJBdA8KU2SQAavX8MaeN6txS0QX6/6L8OQxtpS0jReG0XO7W1ECDzQSyb90lqZI5rx2By0ellDYE7vq87gHFfet1e1rTcunGKloQpHkerIxkqEMrPC7rbKoKJrn1lJ2vQ4XxCIaEvoqzzzNz7p7q+JuEW+ygZMUUv+hiC5k8A1nS5jas0GfNPdcTPn2BZqEun4OC8tB/4u4jBQFHv2Aj6RSvs2eiliIK8SceeAT6TL6qlN9DwUjr1TVblXyeiYTCJ+fUmNNqCBRDNnjSh/4FlLwlxkiiECaCkVvGH8CpaT+M2X3yxcX+KsOkaiijS6QRbE2NALdy2fweSGEQwIlkOv06TNrLk5ui6l+JR3OaeGpk782HowOtr4b9N8fRGprwgpezWOl7Zpw7zCqUxLZzwbUtTWU/OcruHE4jfr4tFJpQaBirLILNcVwUzI1dL9CoYYONW0GNjiDfBCwLaOYAecFYze128hHyEq50LVdZSB3iYgk/9EAlX/X9ZF+gxuKgNrc3oeTc3iBNsexRqEarvrBEgmcJ3bMS9C5Vwn9JkAPIVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n4LLp/nYgxc1v9nixuiIRVnCNjETV5mZZ9Ti34fQnZPMu7sPwBCb2oW+/m?=
 =?iso-8859-1?Q?kRWeGk9cYC83rsTrzyHzHO6nK6iqdB0p0fZFIcqw+z9W2UPyoILwCGV+MI?=
 =?iso-8859-1?Q?eZMmFjAJZ55AG62yRNDDDB4Lj5Ds78MeJawnPwjePx3josJHGqcZPnbGNt?=
 =?iso-8859-1?Q?wSgo6FH1C5ZhoCA7bYhJtozOt/nZpTy0pfd7mUMho+zoLjh9kBGZzYC7BG?=
 =?iso-8859-1?Q?BiZ84VxzIFl++NV5bbDu7b/EN2+AiWD9v1z+mijpTwNWm9bCDZWbotGQc3?=
 =?iso-8859-1?Q?mdLBAYdyZlCSgI6Gr3vg9CVaS2KgjJWUWMHWujX16JLmjBUQLK4Tsb4wnb?=
 =?iso-8859-1?Q?aFmNumGtW0o15JDMUgLDSi0EIFTIaC/US6yoBew0FzXqSFc7gLQ0aenbX2?=
 =?iso-8859-1?Q?aBI7oyySWw17+dmN7WWnYXQnwGkaAL+pUXuNRIlQfZ7rCGHwzs6WD+JI+k?=
 =?iso-8859-1?Q?6VkpLIUyLDe3GJtIVEMZlm2JRk5aK3mTr53AFbBJS6inXFl6ro8owbn9y4?=
 =?iso-8859-1?Q?a4LV+Wcrow6VjILjJrwZbLQc5bteMNjZJPqcvT6pDV6adJuV9dwYScTfgy?=
 =?iso-8859-1?Q?2G57oUstg7URPHT+OLom0WEPc+KGqEVEBKnvDO4N2IpF3zYNPBtL4Gofl/?=
 =?iso-8859-1?Q?L7Ntf80kTF4+vJY3PnYurIY3/ReDyJ+FWWjclXmLtceGF9C+ys+YaiH8YA?=
 =?iso-8859-1?Q?1L/NRorocnaJLr97fBwE6ASzuWzJ1IKPI8ehTjaVaoVd2sCS15CBXfGL2R?=
 =?iso-8859-1?Q?QE+cOwbMzhvsO64ub9kcAfzNh7fg5D7apQemIh4SmL0KsXU1pMLMVosLoL?=
 =?iso-8859-1?Q?znP1M61HfRpdyXKDZDLG2eY/y7TSXIWpv3rYdaW5pOROLbUfQOWuMga1fd?=
 =?iso-8859-1?Q?iCIVx0FC9Ta2Mj8J9/pkbYL55uGXzr596i7AuYV2BrmN7CPtOKjd4wiq0z?=
 =?iso-8859-1?Q?SC5GGRhnfu++NGedxJIISVYblTRgQe1yr98leNKlQmSR+JJXQZGrHwiFbY?=
 =?iso-8859-1?Q?8hv6F/yQPAlulsK6tnypsjWUytOtCxUfbG8vQ5mKIIvMsykzOzJDP0qLRW?=
 =?iso-8859-1?Q?NBCTd9BL2ThKrr8qHhDjrlAaUhVV12zyCwTnEd8HmY7nD+bXLUaHMXBO0a?=
 =?iso-8859-1?Q?BG5fb0kAQN5H1qE6sz96hDaxjIyGxmIGkjYxttg2biNdFSp4YKQNxrnBn7?=
 =?iso-8859-1?Q?l0b3uYEJpS7HwPx+m6iyJwM4yPIXNeSKAHTSaUc5ENVd37yLjze2kyCgwp?=
 =?iso-8859-1?Q?M/FkGGFUFL5C7OaWhG8NYx2E7nXmNRb7LujP9M1IdG4pumF91o0VyEa2Vi?=
 =?iso-8859-1?Q?xC1HhJ7BQd9b599VzHI1YiMDiyFpblUveoOslHfKVALeDbWjgqhin+J6EI?=
 =?iso-8859-1?Q?ZQ3tbf0Cz4j8I+qCdct0LHMk2zlqrNICbJPwaa/djNUHDby8WZo1EoQOUr?=
 =?iso-8859-1?Q?2S3Z19iNH89FVyseyZ8rllHnXmognZFPn1ve8Dq69eft90XHvdDRclZX7O?=
 =?iso-8859-1?Q?5X43ta0SpPLM3bQeY8/IA7Ad95dsfzfv6PdB0p252q5Q7DU351OjgpgSa9?=
 =?iso-8859-1?Q?0jC+SqIE+xUl9/1kuEuLioFQ8/fpWu+R993yKTCxifGKToBCdzDT8MZfLf?=
 =?iso-8859-1?Q?Am0zBfPZ7J2gDK5L/w35kRazVYMJtlF0sw4k2+c/X+J7Wiisf32vXPpyIq?=
 =?iso-8859-1?Q?TlQbZKV2ZbZdBrkbBGXc8W3IMGQzuj0KP0pa3xHaWkYDp2rHqhOlhfK6Mo?=
 =?iso-8859-1?Q?BPA7UEYujIeeuiLTiogn3GI+prbXIxRf6HxpfijCBOBtvABs7ZBjIE53oO?=
 =?iso-8859-1?Q?oYd5B7Wa8A=3D=3D?=
X-Exchange-RoutingPolicyChecked: aIyBrZuZXnmWSo5y5eSASmS5xQ7OfpsLwZ7HAAnNHBjFhNB7hWO1GMTPzQgOxbAoH3vezozDuSqQAAJLapkvGH8wtJzdPXhVMCqzxEss701xJIu44w3JL78+OSDv8LMp2mXS/kuzPMhunEbqfDRu6WwMgiC6G5AEOgTlobiH41+ZhtlxbxeZlLZsKCJ0C3h/Q5DPydfIKd3wOb8SdL0bRh5ZaLJSo8GVu7Xj6f6rB1K2nXw2y6EAdqs9X+l6770DtTa5/DT0zzmnjknQbizk7mPi3tac6vQvf/+M26FyzZ0tH6tasOktSb5Br0ER2HXJYbgvodESH3IJ/Z9VC4kKwg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e0ed04-dcc2-46ac-537f-08def9dca81b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:18:44.3821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwUN++wz3OUlS5bBFc4wNe4mGEFfiTphz6P8xgn8JA2M/GLM3OwPusqtiRI2K1/Hf/5NFGDXJMNhH4x/uJKmXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
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

On Fri, Aug 14, 2026 at 07:51:07AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Missing WRITE_ONCE() for vm_bo->evicted causes a data race with a newly introduced lockless reader.
> 
> Pre-existing issues:
> - [High] The xe driver bypasses drm_gpuvm_bo_evict() when clearing vm_bo->evicted, which permanently leaks the newly introduced num_evicted counter.
> --
> 
> --- Patch [1]: [PATCH 1/3] drm/gpuvm: allow locking external objects in two passes ---
> commit 8dc4616b6b0a651e19f9a8c0a513982ffa694e85
> Author: Matthew Brost <matthew.brost@intel.com>
> 
> drm/gpuvm: allow locking external objects in two passes
> 
> This patch introduces an optimization to drm_gpuvm by allowing a split
> in the drm_exec transaction. It locks private and evicted objects first,
> then locks resident external objects later in a second pass. This reduces
> the time locks are held for resident shared objects during migration.
> 
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> > index d1c80ad3deadb..f6ec90640d372 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> [ ... ]
> > @@ -1220,16 +1301,88 @@ drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_vm);
> >  
> [ ... ]
> > +static bool
> > +drm_gpuvm_prepare_skip(struct drm_gpuvm_bo *vm_bo,
> > +		       enum drm_gpuvm_exec_pass pass)
> > +{
> > +	drm_gpuvm_pass_assert_held(vm_bo->vm, pass);
> > +
> > +	switch (pass) {
> > +	case DRM_GPUVM_EXEC_PASS_EARLY:
> > +		vm_bo->lock_skipped = !READ_ONCE(vm_bo->evicted);
> > +		break;
> > +	case DRM_GPUVM_EXEC_PASS_LATE:
> [ ... ]
> > @@ -1959,6 +2389,11 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_bo_extobj_add);
> >   * @evict: indicates whether the object is evicted
> >   *
> >   * Adds a &drm_gpuvm_bo to or removes it from the &drm_gpuvm's evicted list.
> > + *
> > + * An external object of a %DRM_GPUVM_RESV_PROTECTED &drm_gpuvm is the
> > + * exception: the evicted list is protected by the GPUVM's common dma-resv
> > + * there, which this does not hold, so such an object is only accounted for
> > + * and is put on the list later, by drm_gpuvm_prepare_objects().
> >   */
> >  void
> >  drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
> > @@ -1966,6 +2401,7 @@ drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
> >  	struct drm_gpuvm *gpuvm = vm_bo->vm;
> >  	struct drm_gem_object *obj = vm_bo->obj;
> >  	bool lock = !drm_gpuvm_resv_protected(gpuvm);
> > +	bool was_evicted = vm_bo->evicted;
> >  
> >  	dma_resv_assert_held(obj->resv);
> >  	vm_bo->evicted = evict;
> 
> [Severity: Low]
> Does this write need to use WRITE_ONCE()?
> 
> This plain write pairs with the lockless READ_ONCE(vm_bo->evicted) added
> in drm_gpuvm_prepare_skip(). Without a WRITE_ONCE() here, KCSAN will report
> a data race.
> 

Correct, look preexisting though. Will fix.

> > @@ -1974,8 +2410,16 @@ drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
> >  	 * internal spinlocks, since in this case the evicted list is protected
> >  	 * with the VM's common dma-resv lock.
> >  	 */
> > -	if (drm_gpuvm_is_extobj(gpuvm, obj) && !lock)
> > +	if (drm_gpuvm_is_extobj(gpuvm, obj) && !lock) {
> > +		/*
> > +		 * Count them instead, so drm_gpuvm_needs_two_pass() can tell
> > +		 * whether any are evicted without walking the list. The
> > +		 * object's dma-resv is held, so the transition is stable.
> > +		 */
> > +		if (evict != was_evicted)
> > +			atomic_add(evict ? 1 : -1, &gpuvm->extobj.num_evicted);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but the xe driver manually clears
> the evicted flag (vm_bo->evicted = false) during validation in
> drivers/gpu/drm/xe/xe_vm.c:xe_gpuvm_validate() instead of using the
> drm_gpuvm_bo_evict() API.
> 
> Because drm_gpuvm_bo_evict() is bypassed for clearing the flag, this counter
> decrement will never execute for the xe driver. Does this mean the
> num_evicted counter will permanently leak, continuously incrementing and
> permanently forcing drm_gpuvm_needs_two_pass() to return true, thereby
> defeating the optimization?

Xe uses the drm_gpuvm_bo_evict API in the following patch when enabling
two-pass GPUVM locking. So correct, but non-issue in the context of the
series.

Matt

> 
> >  		return;
> > +	}
> >  
> >  	if (evict)
> >  		drm_gpuvm_bo_list_add(vm_bo, evict, lock);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814073258.893007-1-matthew.brost@intel.com?part=1
