Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E9AC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22DF10E5A6;
	Fri,  3 Jul 2026 09:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ghj3HR4Q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970C110E5A6
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783069584; x=1814605584;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TTDePaaeUDnm71GuD8p58AyykqoN4NPRtJw63/4xGBA=;
 b=ghj3HR4Q4SFLGH0Yh+7P50AdG24lbOYLNsxRrs3DClX/3dwghgF4LUj9
 g489AchooTSqkzWEVQ6sYIEzR28YyYBIayf5rhNaB6GWDr1CLOVgNzVn9
 QtTinHE+Wd2BTrZ7lQkx1Muith812C+igTV7O8MlK3VMrGIW+VW67Tad8
 T5rLDGdsLIchjTG1+KXUphwx/Amz26524vHlBiX2eJBkXQpXOixIHRWoP
 fAEnBI+tc1uzzDqqZUVJHu4X8JKO0trfEFpRK5NM6zvvW0G0QsHq59WiW
 1J6UytA1aryo06wcxXTks7eVn3MfjCMYfJlNdQ3LIGOdkk7dzr0B4MSzH w==;
X-CSE-ConnectionGUID: ps7zYotiRPOIzdJp2fhITA==
X-CSE-MsgGUID: rqAiI2gcR32Z7j9yaRbhpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95327523"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="95327523"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:06:23 -0700
X-CSE-ConnectionGUID: wG7+A8UJQY6AKynU+0mKuQ==
X-CSE-MsgGUID: m5Rr2ssQTMOKD5uBnUbXiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="257955794"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:06:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:06:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 02:06:22 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:06:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUyc0ZHFvmzHh1lVcEnI9sDS3/XO3hRmShV+5pgu3yUbHrQ8tPsydDFDbhFrAdW0w2TLBlYicrAjugz7KlsYLsgMPriXLBNDvcwDpGbKHar3R7VUh7TvK7D0+/azTrPq3LjYVkzu68ajEPbdqLTsEQIBfwqz8E3F59Br3N+V//INkr/LQVGfhbP5mS4Ou9gdUFiSQEBrkg0D7MFNsauAda2p8dvOzVggOxB/OWGu8EVeXvZ3V1MbVHSWv7v0yBEi+ttXj/J/YkQSYO1x9iFRGCEoVn2fXAh0jtYvRO3bguaSJFldBNGCnEBy7jlTYuILXwaTuGLQGgZhjx3FIE/SqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDSUfScDzLl9BT/XoTic9nAyHCQGb9xUSy3RNA4cn1U=;
 b=nQVO57OvD1EkYdbgOChsrskeyqvFdrD/OgWL12Uks+Q7BUl8k6DSfOXYloX+D6vv/5olzBFtt2/sEaW7xsciyJRWivtcnHB1LfIgZno3MkPtUgz83PXXh54/TIklcw8+VT0OAt7az1lq65cU+mgPQ6fNSguBiQPODdBZNC9Mr9NEvAZnA+L0gIIBAvKZk/2jrBBNP4eiRkFgt+dlMaYlRVt/ei0oWk8R4fJ12pfbz77RIC7wPcqHZFmzh+hSWS5DxmXENbtmKLwxpuj6c6rHPHnpmKvoqQ6JrWnam5uIQlp09iPQLlpWrJ1s5ESkSZ0yq0XobxEYwXpB/bX6g4Hv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA1PR11MB8832.namprd11.prod.outlook.com (2603:10b6:208:59a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 09:06:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:06:19 +0000
Date: Fri, 3 Jul 2026 02:06:16 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [RFC 4/8] drm/xe: Convert to per gt scheduler workers
Message-ID: <akd7iFDLUgwhj6+H@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702143745.79293-5-tvrtko.ursulin@igalia.com>
X-ClientProxiedBy: MW4PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:303:b9::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA1PR11MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 30de0446-60b9-4eb6-e50b-08ded8e25893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PBwmjdQbtcvCpdkMIwYeh3UILqnXBg83s6gRno/+LeBV/e37kmCd9gHYtjhnSUv+tAXeOgsgNaTQInI6J5KXwnDs02Q+LoDTMUZlwMFOJRWc8ZlaIIkLyfjd2iOEAqcmjuP5TscQIAAui7iyt8LStkjnpTWHmplxSfFhvvIrBakEc9zx7HuhCW74zT4Car2JxtialP2gV58E1wje7dMfCR0ehtoUoewYBkZsgqQg2UqnVMBR1D69ltlaQk669/G1MF3BApL0wiIHjB07acRL8iRYn8pKXBzKcxkk3V4d/DAvtGqsDomiM6qVCFSS0F+ctStduom5VY8GgUlvcYrAaAgYIvXwPZs2a7ZMWFTLk7NLsyMOgnmbRtufH6Us0XwXbv0NSP3WhiuJmyy+YBMbG2hGJHJiv+7irRQ71SWpP48DFmy/KULwO8ADntOfRIcOtl8LgaUJiRt/OVCP7FAvZc1bmonV+QOaUrCbG04MD1sXWvac0Q6qdXl18bHmMEuHhaLEBrpa98xKG1TeoKuaTTDBT269Cgr1aH/k1tUj7NDPQ5wH8X5GdGMZOvaTdVTJAs8kckp+vjPAsRZG8JSgERuVtVFbnMs026tAMZdTJk/2pC5NXmyv9znzwxcWJmqUoh/y0vOpoeaMVMkGOd23Z7O4oceIkX2Jld0BBHIWB4U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?DiNxjinhRoo9IZNKp4SisCK9F1i5DPd3kbSge8yROGH2NqB+4b1TSPzlPR?=
 =?iso-8859-1?Q?ffHPSNB+byaOOaCYncAooPQ55XSBGrefO8OhgUcxKiLRxJKOsqss5DYYqD?=
 =?iso-8859-1?Q?+rmGDd3eYY+the+LY/bWEh3QMY1AscwqeN9QwkOYHiRWDkn9999I29wSXl?=
 =?iso-8859-1?Q?ilg1rChCg34kZYFMpuIQuSSH4jZpFWsCUKY0LwwkRc8l2chBXR94yzGRO5?=
 =?iso-8859-1?Q?YsWxRjfYwMgkm1dyR9Tpe2yL1ArtlnkezjU4YOf1cAR5CUnWuqZaLo2bI2?=
 =?iso-8859-1?Q?hJ6X3iOrVoUKoDWpXWHSYrM4Y/uxsasRYkUeNEI1LYUBplCjU8h9wkhVej?=
 =?iso-8859-1?Q?qx4NXB67mWoKdHeOYeO82lmbETXX240jjP97gP6KdkU3xLJPo7/Wcs2hRp?=
 =?iso-8859-1?Q?K97Tio2HBFP0ti1GSdSnqp6NMqotxKrbn/Vsem034tP4HC+FwEvw7HUWF6?=
 =?iso-8859-1?Q?KAjv46KY7FFEp865cq72iRLRJ/Sva935fIuR3kSXkQT621RttVMFxggM5H?=
 =?iso-8859-1?Q?01Vj/IDK55lNymOMnPAyyk9FMiNFKFGcMPtYrDMocPKnrjpRXkH4XIRRpA?=
 =?iso-8859-1?Q?GUh5ISansjHmkKdWRa2v+nkHif0vFqZasg6d0O4zQgW7vfefyvtTiVxinx?=
 =?iso-8859-1?Q?lus+kUMq5qpCPrO1V5tFYRGkJGrSp63kQLiEEze+N/bGu2O28lnUcHeMy9?=
 =?iso-8859-1?Q?ulvyxlTo8++W7cz2de1TMa0OI6XKQKBx4TL8qPg97IiD5fTDhsP5U7oue1?=
 =?iso-8859-1?Q?TLFl+QV4nn8WPrLsKiNUoPCU8FAOdmNXtbVjbHPy7MncEFIWiYKDpHdlbf?=
 =?iso-8859-1?Q?y6Q9Og6qz5TJvISuswc3F5vR31ARh4oMJBeoOUeswNout4Ny0waPqYSG2g?=
 =?iso-8859-1?Q?bbHlFLfO7st9zVlLzfidrnadMEW1ml1H9lSKutE/WBTXiPhqcVF1E8/KUD?=
 =?iso-8859-1?Q?vnS3TWQdWAZK2WiDvQz7TPjIgG5AHqc6R0WtuAh0kgdAe3gPIf1JB1ULCS?=
 =?iso-8859-1?Q?a5R6ZJAKErpEnYMquCbqJQmLEyKj9mWm5ZmGUYxG8yy5IsbnbXZN8ag+Bx?=
 =?iso-8859-1?Q?VKFSx/Jwi7pX/IJULs/pqGf3GTP6hCUCPoeunNomHYPflatcz5Jp82YYV+?=
 =?iso-8859-1?Q?NM63wJ3mQsbRP424XmwXVOIK8M72UgTXRIELeaESMiFPcxl2iJqSzBwXik?=
 =?iso-8859-1?Q?zN+nF+QB7Vh2mGmB6EK1nBTI38WqbY2ggVrJCWECq3N1c9j+yoiRRWWUUA?=
 =?iso-8859-1?Q?i1sYUqarr4pS2xAA7AAk0etaNlAG85yItvDE/TR8HVJPRDskKvllroB/9r?=
 =?iso-8859-1?Q?Fa1mqk/gS2KFloH7//RAQX1p9nuN1FUWsmtDwm3O2VrSrPkLiLxpvzhBuL?=
 =?iso-8859-1?Q?mQQQNSeTVtMw6Ur4JJsgAJXXdNciuOeo9KiIQi2JKLt6kMg/JJ0+afUvBq?=
 =?iso-8859-1?Q?K3Jc1j6KgPPJArd6n4RTJWk0dRrBbPwFitoHs2bgXw8ePAE5+WDBN7Ig9u?=
 =?iso-8859-1?Q?kdFDz2FLDd3DTg+yYI0iIfCn0X6jgnWIHXSEBVv3RFbqW0hRXZerJwA671?=
 =?iso-8859-1?Q?9awAOd93BgExd1RbixlmdzVIV2V9Ex+PCD5kaC9eXfNnMNiXGziWbBwuTR?=
 =?iso-8859-1?Q?1qo5a7wALICsZFpqKX/xFGLMBHt98OQeEIQln45A/G5thmj9cZxSv6dfvj?=
 =?iso-8859-1?Q?CyxzKQEEoQeOAeyOO0X2c5vCxhDek+A58HizfPi+PuPtTMg3RS44lhjDDC?=
 =?iso-8859-1?Q?5Bi6mveDFN6wyr3BfcvEi0CBgf6e5jGf02ojGaDqzRIHXHTwrclyG2uCyK?=
 =?iso-8859-1?Q?FAiOdcHVxw=3D=3D?=
X-Exchange-RoutingPolicyChecked: oWkNHMwF7/xIVEnTeUEjDZ+NLeSEDKDnOgAPgun8tdLNGgdkGZq+3Tc3OOtk1dg8fiBDGk3AVHZ/Xof77RPJpoV9P/VlfmFkM3yflGm7XS1jGwVzjl2WxPs7AVf1Y7o5EZFbLLQfUN2rYA7QwfSSojdZRIg+DZSp/4VzTmJCHJsO/H2uGFVV+rzdhaB/kxZJF2uoDDGT4YWgQwq706jlPIDn3cl2BJ1m+UTIA0XsJepEvZ9yNExfG2X4JlrLuwtq25tUpLdBqk7nYXrtf185y0yXGDlcE3hdsMO6ysWw/9sQX3zNqvJlBPlv5wiqnT3pgTwpvkl/zEZjIP7jTWsq9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 30de0446-60b9-4eb6-e50b-08ded8e25893
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:06:19.5328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rkc9muzHQT41QU1Jhfk9zQAm666GipZycZukBP+F+3Wo/gSyxYcc4lvFbhYHeLHajewpWoQRF83vdT+AJFZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8832
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

On Thu, Jul 02, 2026 at 03:37:41PM +0100, Tvrtko Ursulin wrote:
> As the submission side of xe is serialized by the global GuC CT lock, we
> can easily afford to create our own per gt work queues. Whereas before
> kernel could create up to the number of CPUs threads, we now create one
> per GT.
> 

This breaks down for any execution queue that waits in a scheduler work
item for any reason. Long-running preemption queues do this for
time-slicing, multi-queue registration, and possibly a few other cases.

I've looked at this before and rough divide is this works for 3D but not
long running.

Matt

> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> ---
>  drivers/gpu/drm/xe/xe_gt.c         |  7 +++++++
>  drivers/gpu/drm/xe/xe_gt_types.h   |  3 +++
>  drivers/gpu/drm/xe/xe_guc_submit.c | 11 +++++++----
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> index 783eb6d631b5..fb2db9eff341 100644
> --- a/drivers/gpu/drm/xe/xe_gt.c
> +++ b/drivers/gpu/drm/xe/xe_gt.c
> @@ -706,6 +706,8 @@ static void xe_gt_fini(void *arg)
>  	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
>  		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
>  
> +	destroy_workqueue(gt->submit_wq);
> +
>  	xe_gt_disable_host_l2_vram(gt);
>  }
>  
> @@ -716,6 +718,11 @@ int xe_gt_init(struct xe_gt *gt)
>  
>  	INIT_WORK(&gt->reset.worker, gt_reset_worker);
>  
> +	gt->submit_wq = alloc_ordered_workqueue("xe-submit-gt%u",
> +						WQ_MEM_RECLAIM, gt->info.id);
> +	if (IS_ERR(gt->submit_wq))
> +		return PTR_ERR(gt->submit_wq);
> +
>  	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i) {
>  		gt->ring_ops[i] = xe_ring_ops_get(gt, i);
>  		xe_hw_fence_irq_init(&gt->fence_irq[i]);
> diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> index e5588c88800a..175c42672546 100644
> --- a/drivers/gpu/drm/xe/xe_gt_types.h
> +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> @@ -248,6 +248,9 @@ struct xe_gt {
>  	/** @exec_queue_ops: submission backend exec queue operations */
>  	const struct xe_exec_queue_ops *exec_queue_ops;
>  
> +	/** @submit_wq: ... */
> +	struct workqueue_struct *submit_wq;
> +
>  	/**
>  	 * @ring_ops: ring operations for this hw engine (1 per engine class)
>  	 */
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index 9458bf477fa6..858f84dc8fed 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1928,11 +1928,12 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
>  	struct xe_gpu_scheduler *sched;
>  	struct xe_guc *guc = exec_queue_to_guc(q);
>  	struct workqueue_struct *submit_wq = NULL;
> +	struct xe_gt *gt = guc_to_gt(guc);
>  	struct xe_guc_exec_queue *ge;
>  	long timeout;
>  	int err, i;
>  
> -	xe_gt_assert(guc_to_gt(guc), xe_device_uc_enabled(guc_to_xe(guc)));
> +	xe_gt_assert(gt, xe_device_uc_enabled(guc_to_xe(guc)));
>  
>  	ge = kzalloc_obj(*ge);
>  	if (!ge)
> @@ -1964,12 +1965,14 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
>  		struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
>  
>  		submit_wq = primary->guc->sched.base.submit_wq;
> +	} else {
> +		submit_wq = gt->submit_wq;
>  	}
>  
>  	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
> -			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES, 64,
> -			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
> -			    q->name, gt_to_xe(q->gt)->drm.dev);
> +			    submit_wq, xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
> +			    64, timeout, gt->ordered_wq, NULL, q->name,
> +			    gt_to_xe(gt)->drm.dev);
>  	if (err)
>  		goto err_release_id;
>  
> -- 
> 2.54.0
> 
