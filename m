Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465F3C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A22A310E38D;
	Tue, 21 Jul 2026 17:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mrkK3LH1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE16010E38D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784655489; x=1816191489;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wD2HPxxdiW2/GvTF++ehU+foMubs/lqbr9pmQbpHVc4=;
 b=mrkK3LH1Q0qAXhIszNtulP5sDzHps8NRAQkehp9yt+lGf8BSAT3laPOJ
 h3VvtwYMU3gfKFrZryCp1+i0j+pxZJ/PDK0mEeXFFN9Drv1al6LJAbO3Y
 rRLdYC7TfiNwjcae1sROMzsh63WEX1bMgaWj06Isi18I5oCJ+N5Zi8kYe
 rVQcy2MLFm0dhwUN+B2LbYN1Btr/za9CRFr/RjMBoQVLfuSNKuRMc3BvS
 JC/KkHveBVttq7+e7SU3dgTK4TIgSTYo+Xj4osvKy3Ll95DYli1MgNXRo
 ffMYabD6kAUDglRQt7aC2z055Nftjcj7A9g/I+aRHCRc2a+2hAKzpyGes Q==;
X-CSE-ConnectionGUID: BRbwqF43T+OzOTF+HDwYCw==
X-CSE-MsgGUID: G8Yh/D97S5aWNsVYfKwLeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85028865"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="85028865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:38:06 -0700
X-CSE-ConnectionGUID: KzFIhHBuTUeSrYIjLbyYVA==
X-CSE-MsgGUID: 9ILdw3aOQSaZgZ7PcjWICg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; d="scan'208";a="281108996"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 10:38:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:38:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 10:38:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 10:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shFrmy8vLWFCajv8I//qI2VjWCYmRgpOfJnkFIGDkovkYyjAh3r9HeCjhF2qdowJBYd+LTCVMUi5AHPFllIT+/AqZIQ5iduQwL/jXgzZxNvQaCx/VEtQq+bcfn6agrtJIaGDIqagax2853bw/wvNGClMXWlbI6OUw1HaL+6i/9M7LUe91sn75+grrqaAO6f89xPN97I/1IJEk1q2KattmPVlfDMFlz4KKK+YMm5MB3BZ5Ob57e4+2x8V11ZDeVh3zFKccuRL1WWTrgU38tKoMgHOjEqNdT0iq/+nHsOBTY9mHBAzkwWBvJCAXMWMHyS2f9S0LGwSqf5E+6H+b7VLkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wr4+HMI7REutQccnYY5fFK1fcUBHSdYAbmx1C4DSY8=;
 b=rdO9Dy2KrG0bHHNa8S6DXi6HWz0fYr24wBRzQTsRb8AWI3Iklelk5a1H3nIks86FNeL6Gb1u/lpIClr174pIu47whuJ4P0hX0O5V7PSi2iMcdlxepKHhA9ixZg3gV7ZGmL/44DGqcHpglarit98cKs51R6uheIfl5CtjQgVUIycnWCbJE5PomInTwbaTK2nWoRFzfBskk5y8CG3Y0lLZAf4oQo3EAya+AJ/S+BGSODFlV5pNiS/2BdOHeUMNzCcrSVGBBB6YSbeLqLmfufGNfoO0FL13D8NvjugThPfWMs4sej7Bx3HeNSleOoMeWUDDwLa610nj3umBl3PtOqAexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SJ0PR11MB6624.namprd11.prod.outlook.com (2603:10b6:a03:47a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 17:38:00 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 17:38:00 +0000
Date: Tue, 21 Jul 2026 13:37:56 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
Message-ID: <al-udBqjgYOGgzja@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
 <20260720101815.526813-8-mallesh.koujalagi@intel.com>
 <20260720104816.51BD11F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720104816.51BD11F00A3A@smtp.kernel.org>
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SJ0PR11MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 240d0ae5-7dac-4d70-a655-08dee74ecefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: vRWSwiZIYMNTVHbuqyQeg2eEQpfUHUpr3j5wYGGrdVoFJy1TSivr43OOqKmNfuQEPMm+oJNU1hMpMIFGgZ5WDmHCH8ZU6Zc4aGPCzhPXmQhIV5qogLThYwrUG1pETk1fh0/tOUs6DGVqNVfOY0mYBTmMXMevtF/W/EWmvda/XmXA5r+92mEOSlngxwcE9uDAS7lHOZ8zEIo857163QuMGoGbQKm9tHmUUu+p5/wA7v0hbky29rwOmOtQN/yTxdtuN9UsMidABeMkmSqQHEuUI+s3p3PyfyD07j7bIUTMtMgp14XOIOLnZRAdKSk1b1bUiN7Ilv1KbHq0XVcXx0GNwHLptsetu5Vgrzk97ZmbRRRB4Sjr9TxsslKOykN2L/yV8ftm7vKDu5/evQ5dNUoN9GhY4o/nY9kj3PR+QPdnoFk4xGJQpridGQsVQ691NV9jGvzYUCmBjFPzSKiDTmCXcFL610C+Mw4rIJQIRUlSgqrtspmivzNIwFebTI0i/rCKOLle+gr7bkwzLnHZQrsnXCfmAd1wvf+mzOuasjIgWyn4KrTvikuf4yopSvzlsObNTOwhq7NwhF6lhVXynL6VWwc/tisTDQ8Wh41fadjYEIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kb7ibfZhvS44lltkDSDsDxPgf5wdAzCUirI/xv7k0xH/K/P0fSY6VMzftr?=
 =?iso-8859-1?Q?hn+IFpLg2uVKMe+RMGvyTEzyaeHd3MRUMkAcwZFQnSMnK72133laRGJtEj?=
 =?iso-8859-1?Q?i/De0+CkNmiD1CeZvFX8PmiZcJG8mpi0UBgwpOQHhJN+0CErvgqmEw6a0+?=
 =?iso-8859-1?Q?67n6ey0IS5BSWRaY7McW99lyTTQ7Ag9zsw5YooF32EuM6MFqDKxVWzFRz1?=
 =?iso-8859-1?Q?lkdw+uOBkd9eGaY1g9H27ThKyia21cKMQcQjEydtkUUzFs+NlsCTfq+YMo?=
 =?iso-8859-1?Q?JCLixmJu2bYlhizrT7Ftxm2MFiNA+TzIzfMYEDQ/kpFtP+DUtpa/7+QLp8?=
 =?iso-8859-1?Q?ng83+V/gez6H2XDbQQi2hYRa5KxE2kYI/om++asFhq85pJJAOkPfS66kvf?=
 =?iso-8859-1?Q?tvvZ0ZVWyZQHOy95Qftzek/arwz6a0SzrgCcishunCuUbHYpQZtVqzFfIy?=
 =?iso-8859-1?Q?gr9E47+2HSd8uxPtB/6AXr/e4HavcNIDoTJWwkI+rt+FQg6ZVqc5YGUFAn?=
 =?iso-8859-1?Q?O8enS3PDKlnxnNrjuUoN2UwcOdEDx+hShtCO8LaFmoZj5fq+rIWzhpEvhA?=
 =?iso-8859-1?Q?1dgUzvlElzDHmzs10GWI95+OASKQIsQDcG/7sK7Kd7fw+iFIjixepjubJp?=
 =?iso-8859-1?Q?JE59r23cm3s9Mqm0KwIs/aT4EI8LpLWwwaTCgQYrn8iMUEQ3ikjRMeithr?=
 =?iso-8859-1?Q?l/7kTzYPfDT6QX7VU0ozkDJkn94QboMBo+Dw2ShSP8EizdKCQia/mguZrH?=
 =?iso-8859-1?Q?WTvwC1tYIZhiReBGbHC7trdcA1xbD7hwlNUv1SRD84FYSiO6ul9rdGwzf4?=
 =?iso-8859-1?Q?LMipIsbL4WLbNwPRtI6ohrneyrSFAr920YoqgXNLleG7QtJT/sJnyyAScW?=
 =?iso-8859-1?Q?NXpOIrLrRqEfmFiAOnwQtUZZFZzS678YyuM8nMZmYy0DNU13ZdxAQwAF+W?=
 =?iso-8859-1?Q?Xe1wKojWDKJX1OIME94Jt/DYXj7B9Pxo/ea8knegZyYhFz1cKKE0A63kWx?=
 =?iso-8859-1?Q?QQhuITkSXHY/Z9ffhOsH+M53VILQC1nlXfcAEmizVfkndbW9uEhLN9C/Od?=
 =?iso-8859-1?Q?JzzhCLl+QSsz2yGnRlJvyMpkud1BrecBYxAyh8wgN8sTQi9yDU7EYWpjoR?=
 =?iso-8859-1?Q?I8ZmB1pxlPx7KxyCrvgLkb+oKwMClZWSFslMZfSZ1G46PW88MLEVL6N0yl?=
 =?iso-8859-1?Q?7fAVEWyKEDyyaVsFvlAkg3uTXu6V29mhyqLXAw5s5oUa4bJvLSZVMNeqyt?=
 =?iso-8859-1?Q?WJZEvyV3Skn0Ht+Q/n7vpWeA6s7AlPhqOTFE7Yl78HKAsn3q5+yOMWGxmn?=
 =?iso-8859-1?Q?gu78dpTbLuiItsUqIOdx2u+y5825q0RhbnpLjXgNwwD8SgrgJprHUa3vSh?=
 =?iso-8859-1?Q?E/ux6KfxMmbMCLZn6uYMi45lH5V86SC8iJUBZk+IQxpocvooZWWux2ibR8?=
 =?iso-8859-1?Q?RAQj/KdyM9vf/bybcdWtJvI9b0yL7QiB/WJPcA/Kw8nPzdf7KhowoWpAe1?=
 =?iso-8859-1?Q?H8L1CHhl6FT0GeGQs8DYDskrodhJV03BlfveZDSEvVN9eVlFwqEZIUSDAy?=
 =?iso-8859-1?Q?IxyIsvO8yDrCRuwZ/8XplYH+C9EyQUAMWgvseZtb/HWJLkFU0ks4maXMAJ?=
 =?iso-8859-1?Q?uyxU4QBPjHJHo2fK0XJvvU77GaTmm3AtvxQNEdjDokm4Txw8b6dxhQLcGU?=
 =?iso-8859-1?Q?ThtXgpbF1+YE5FiFw/Paqhng/eXv82F6TVS9lQRZ76X1FGHJJPVcc/Gfix?=
 =?iso-8859-1?Q?Xq1bVtb4bpAItKKEzcGdYr+nuVfTCoQVJET5ufmGqJg9Am1ECLklGnmsim?=
 =?iso-8859-1?Q?QrpuE2cYPw=3D=3D?=
X-Exchange-RoutingPolicyChecked: mOzpB6mUCQcB83jxtzmZtJr5MgBlgwZYmyXBHNjTpimLIQCwOJr0AIYf48gdbkPl7nL4I5eOFDZsZppHfM2B2WkvC61H2DhPSfh52UM+a94ScwZZhRo3PhrM1BjChY8D740NLFqq3p+fXoN+SI+QfKkeTEvJaTJt0S15W959U8KrIrAt4AcNhiSzoeHyrFoRrNGne6gMKn796gLt0BMdQKtcrLsNCoMYYQB96IotTlz4HTS0SZN9mVhJjcHrUMy7nflxVfztgqSX81EQqishyNkak8XI0EqpS3gXAmMl1EtgOgh2AeQP4t4ICEv8P9jGfvFVXBC4mFsQEA2Q/pQCEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 240d0ae5-7dac-4d70-a655-08dee74ecefe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:38:00.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUJGYX/+ExF4IzFIC/jq+qGMBQV6AUqufr6vW42s5ChGdQJ2EC+bgylJY9+9dbiRgFiVAAd/S1ODcbZWFr0Opw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6624
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

On Mon, Jul 20, 2026 at 10:48:15AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Calling `xe_device_declare_wedged()` during early driver probe fails to notify userspace because the DRM device is not yet registered in sysfs.
> --
> 
> --- Patch [3]: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting cold-reset recovery ---
> commit e4801339581daca0be0db10f90d94f25e72cfa52
> Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> 
> drm/xe: Handle PUNIT errors by requesting cold-reset recovery
> 
> When PUNIT (power management unit) errors are detected that persist across
> warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
> and notify userspace that a complete device power cycle is required to
> restore normal operation.
> 
> > diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> > index a31e06b8aa67a..92b4181026cbe 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_ras.c
> [ ... ]
> > @@ -236,6 +236,12 @@ static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
> >  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
> >  }
> >  
> > +static void punit_error_handler(struct xe_device *xe)
> > +{
> > +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> > +	xe_device_declare_wedged(xe);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> [Severity: High]
> Does calling xe_device_declare_wedged() here fail to notify userspace when
> triggered during early driver probe?
> 
> If a PUNIT error is present at driver load, the call chain is:
> 
> xe_device_probe()
>   xe_ras_init()
>     xe_ras_process_errors()
>       handle_soc_internal_errors()
>         punit_error_handler()
>           xe_device_declare_wedged()
>             drm_dev_wedged_event()
> 
> Since drm_dev_register() has not yet been called at this stage of the probe
> path, the sysfs directory for the DRM device does not exist, and the KOBJ_ADD
> event has not been emitted.
> 
> Consequently, userspace (e.g., udev) will likely drop or ignore the KOBJ_CHANGE
> uevent emitted by drm_dev_wedged_event().
> 
> Will this cause the device to finish probe successfully but leave userspace
> unaware of the wedged state, breaking the automated cold reset recovery
> mechanism?

Mallesh, could you please add a fault-inject test to this flow here and
ensure that we are indeed getting the notification we are willing to get?

It looks that right now we are really never getting the uevent that we
are willing to get.

Thanks,
Rodrigo.

> 
> > +}
> > +
> >  static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras_error_array *arr)
> >  {
> >  	struct xe_ras_soc_error *info = (void *)arr->details;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720101815.526813-5-mallesh.koujalagi@intel.com?part=3
