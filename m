Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F032C624D6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFAC10EB3D;
	Mon, 31 Aug 2026 21:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DLLIV9Zm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB8010EB08;
 Mon, 31 Aug 2026 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788210380; x=1819746380;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=utw75O+91dHQk3hNfWtDWPG1SsGQ8RCqx3NSrQa1lHM=;
 b=DLLIV9ZmZ9iGqwfksg3ftjh9D3x4EGaC/vBdPsIAl6Vnu2PuZ8K4WHCq
 8z+Hiaws5cv4wcHHo+hvUHvgCAd2nFItVAvycv3NktmxDl2EBSZ5zAMDC
 qRXeOoz9WrcfWv2aiuf6+jvJXSYYyKJPRnJ3N1c3eptRJSunRAULaoRyU
 HkRYmW9S/XlBrFsl5kgy8oD2Pf1Qw0T9C8TailPhE4xRMDGFIYA1y6qg6
 EmtIPpm5RcWsz1fT0vRy3slCtEHRpfp1NO7Pp2xi5wwR4uiCMJVh+rs5y
 kOtdcL0AhK4WZGLUtNyjOFTlb4wCk4lfDWG0tgQ25nJvmIXPjTPvT5F9Y w==;
X-CSE-ConnectionGUID: yeUm7YirQnW2dOozvz11UQ==
X-CSE-MsgGUID: BZJLv+v/SqOdTsmmAzGDlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88479908"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88479908"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:06:19 -0700
X-CSE-ConnectionGUID: wm8iw04HQ+Ow5MW+wgHJ9g==
X-CSE-MsgGUID: dpQNSpZ9RCKJ1wQF/fu5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="268949816"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:06:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:06:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:06:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMYba/sxQ19vwXxlcPEWgSvmeDeQOkdrufyNge1zdx3TisX541XjfmO7Kz7RYsOLSB6jcHxy1pziaI39lrA7e++wVxWNBu4kbYe3Uar0uMt5I7/rb3ndN851vC7hv1itKHf85GAAQYTVtauzCJENnJ/tI6JYZ121bRiHh6f/cxyJGnrKcAfqBJtAv7+xWkOT01ZAQV+qUaZ0IIIKX7lDy67cu+nnB36u67GCE+/fTdIpRVU9BoOdES3IAievoeUnflLyToeTltP3EhSuuHyc2SeeEik9lSoYeeCa2L2vRavQDdG8+vWg7vqTPT2IitoIPgBKL2eefyRpXnnMyD0yDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz9OhLXDNLcws3APR3Gb608D60OUgDrb04fPBIzA1kA=;
 b=YEyInx9XgRpLG5mTkfh0ZrP4SkCGNAcluBF3k65tZZ5QtBTkJHesgybOORZEvy6205RgBiljvrzwp+UYH3XmIrgzKTYnfYENkO6l+SEFlCXqkg7WDCD1yYKN0SG2ZHv7hOaoq/Lw+B7BpYkuzVKLMhfkZLnjpk57BUq6OqE3DxouOYHnfaf/5zuqO5Fe7jms00Gp/M7rOIDzAvlucxj/3f/St/8iLCxTmT2wrw4kxmShjmq6Gd+LojyN7u/ZyujMb02ecG2AY8hEmOVc4bWQbkVmryGqPp4o0nqrfCo1A0P8RNH+kfQ/NNChl2bGePgdbb/IawBRvxGkDPTXFOWhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:14 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:06:14 +0000
Date: Mon, 31 Aug 2026 17:06:09 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 08/13] drm/xe/irq: Serialize IRQ suspend and resume
Message-ID: <apXswR3F21zg0DOS@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-9-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-9-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS0PR11MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 23612f57-764a-4f41-b01e-08df07a3b0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mkTsohzfbowBklonUfObfz5zgFF6TpmvoPR6dFyPBzmpVJK//lZ4GG82vY4NyayIa5BpLU4Dz6VHnVHCCehGhembq1mV9fj3ZjWn7HvA66tGGOkcBoixy58t0GFHITqvSYTUqkzBUi0xtornGnt/j176NXbY9XWvlDxD09Qm19zJGbeWHVo9zICvOL1NCN98iUg1lPWpxO7rqObNvImQo+2bZEIR+UzfNuHIC0sznqHkOnBzrWfNJz0LCh4W0h+agU2/lhMxBqkRtwqfVqWqU3XHCmlyAvyzKbXWrDjG9Tghinh5lYwQSdFZx+zx464XLIK+vPQpt9rUs+dhrj8BV88h/pKjTt8t+bNoYDDiDMuJkDcdUQuJ4sLquudyEw7Dj2dU6lTZ1RN7q4uIHkc5tRCqmqO0ht1pX08dydhXFG55wmaZLTLgg1iYfA8Cso0c6lPmT+PlKDFmZlD9k0h/1Ffor7D5lyCRGOD1qhOwH4r8N/eXnx9+CD82LkVYYo6ct/9k1/Lx96G+EajV9AnrG8R1aY3Wit+YYK4c3xOtaQq/oEne4+jz3/63NU3lkRt5GscrvJd5cwZE4a2+JJ0wyhR05rFvCMVbTDmjHSxqFKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?U7KZs7WwqTNpBYJJQoGhtBlbsMIZFI0RrCutOcuESjDLFM7uNxfGfsKNsB?=
 =?iso-8859-1?Q?h7FdY+JKxbivqdDJDvsSDSpWyavtN6pXjEvAB9aOCrDm5UDbYKu/MNCI/s?=
 =?iso-8859-1?Q?G1+8G7Zi/PjIXw37HDrQ+2/K2GekFk2YxO2R2RxvDHuJuaRPl5t4u4P3Xg?=
 =?iso-8859-1?Q?lWdqHWyftqakCFImFP7ilMNH2oTFkWa7rgZvRzXunIsDUEqpMGen+VAJvQ?=
 =?iso-8859-1?Q?ovT47ACejMyGDGENVtIkSmTzPccX4BoH/oZVDf1dEZpeOI/dXGQrmnMm/f?=
 =?iso-8859-1?Q?KA1oo+zPXyPi0HGUqQXY+QMUuU3XNEVnQl3o4aCmnbZdjGgYuPVwZSe5hi?=
 =?iso-8859-1?Q?zKKlaGd4AU/dc3chjDZcSXjX13jfgZqi44YtN2FPGgx7e2tbqcwHzJhiLw?=
 =?iso-8859-1?Q?aEwauMS5tmCc0yfouzgHrmnnbWM2YsYTI5pNp1Uh9L3pvRHXtuLb8iq+dr?=
 =?iso-8859-1?Q?MFic3AiPUJ5BNSc9wOkCmkiIU8nPq89GEMrYE2J82eqgYeYSENXnpjL5a3?=
 =?iso-8859-1?Q?vv1V/kPMQN7g/RFMRrkSAurkvXu/rcP1mC4npc7qPlOk6uMw5beV+gbc1t?=
 =?iso-8859-1?Q?tfXmby1/xBVQ79SDYlDm+3cdMUI8bLEfDgLzM02nPvRsO0HeoYr57WTqOj?=
 =?iso-8859-1?Q?BhxRDj1cQOcsg3aOIn3YSP3FXrTo50UgYdLg6gvkHORazXOkvRZ+cJ323r?=
 =?iso-8859-1?Q?WdJjaWlMyV7g1q1FaaxLd9NWLL+g1kSpR3kxTv333kpKxsaRGDLmL8LgFa?=
 =?iso-8859-1?Q?kMcNN66yjwy2380y2ofz45JelDz9q1rFC5+9Q4oR0M5XT+16cHQsivuc/K?=
 =?iso-8859-1?Q?F60E12r6tTUQElkvWdSKQ+Ez4ygcILdiwQICJQULzvCsqa/o/buJdHnfNJ?=
 =?iso-8859-1?Q?HrnSUM4+PagJEImzGXd++W5XHmsPTMGBTGSRYxCG0U17CVXkFwV1h6EkiB?=
 =?iso-8859-1?Q?5YQjra7c/UW0pDjwCBV50hormmPL4196TKmb6j3TjvoxAAqwTEEVhSUTSN?=
 =?iso-8859-1?Q?8nWutWZW7ANyAsukNdYktKRf8gb5qRFyfQLUPmlulJv+b89bPi8VAboKud?=
 =?iso-8859-1?Q?Pd36Ebz503Gls7i5eODfWdXuGGqdkCq2fK3ZNkmk5zQIHHZtc0eiYAnh+c?=
 =?iso-8859-1?Q?64/nR8o362+WARe/R/stFTIYwhJokz3bdMrMlS6FzvPnYZ3Iu+Vsftb6y2?=
 =?iso-8859-1?Q?JjmIuYV5l7BfVV0THFfmk1RW8nncFaX/ijExNBH8/2jcqYAyk10Ijq+rU3?=
 =?iso-8859-1?Q?XVVSQU2/iXY4APKZwpa3l+EjyVjEon7mSjqWrZe4XzBH+QjKwpabC856Ai?=
 =?iso-8859-1?Q?9uC4FKNP8Ak+Fo3Z4EsD+m6AUFfWsiXyaVzPmtydh97Ui45sS73KAIsBHD?=
 =?iso-8859-1?Q?7f7doqzfUM83lSMSyegw8atP6/AcBtn0vRwnY2oz/cuuYwR1yYd06fOrBq?=
 =?iso-8859-1?Q?+ERVWpPvxs2casKZeP4n8SOkqdhoXyk0/hmdRSaQnlEJtuyYYUh4y2LQCx?=
 =?iso-8859-1?Q?4jX+3y9LC3Prgffx3+Id6muSVqevcAaU6tpCSHBU1kGX15EvH3IWCwjHbU?=
 =?iso-8859-1?Q?V3Tg+gwa5zG0IH/5PpGehTI5UYVECBwFaBuMDumNcuXMH14eqQgTjV/ZIn?=
 =?iso-8859-1?Q?TNVR5kVmhrDvv0avnGFEJ/0gadUA1DoAmtftkfEEEktoe+HvagNftm3doR?=
 =?iso-8859-1?Q?cKRgxqTxilnIWo+T3CIAA3bC3pdjnFxBIFOy08Moz06m+qlsAXN2ijZfg4?=
 =?iso-8859-1?Q?3/khZErinuH6AtDX6eINO3dzGPFjqCw3PnWEPWEPpNOaFn32ZfyrdZ0Ru7?=
 =?iso-8859-1?Q?cDZU6L8i7g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 4PWguZfpnXelPnAhWCkFoZ8HkkiuRSgS+iQhHYTApr7rO3nmKVIhw3co+S9LGaXBOgp9gNdA7+vkx7Ys1fnkP9UUKP3MZwGEX45y861YnWJGIzPxyrOFNTuV+CIzcYRlQgCSLbSOEsSmYtDSYwRR2V1JYH8nGCKSJN70rEGvCiLrAxKB49/QMs4f4jVwpe6AuBNAf930AlrYp9vt+F54hcwD5ZN7n3RuEJq0XSZS3/gISSpP5P8vzxiQtP07oOc/JvOFR9nbgVN8PlAosiEj0EKpe3X+mGJs7eteTwp9N6u1gXhD7oo/MxLIeivensZyTMKmtC8OHguDaCI118bHKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23612f57-764a-4f41-b01e-08df07a3b0da
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:14.1242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCGom8tHhsRpFznVTLBEgO4ybhosSNbeROYfTSSNv/+NYasGaxkjpBbsxZJN/yRGSwGSVsa0EY6ub/AxcmJ+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7481
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

On Thu, Aug 27, 2026 at 03:47:56PM +0530, Arvind Yadav wrote:
> Wedge isolation suspends interrupts from a worker. This can race with
> PM resume and allow resume to enable interrupts after isolation has
> disabled them.
> 
> Add a managed mutex around IRQ suspend and resume. Check the wedged state
> while holding the mutex so either ordering leaves interrupts disabled.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
>  drivers/gpu/drm/xe/xe_irq.c          | 26 +++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 43a86564adf0..dda4d9919ca6 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -6,6 +6,7 @@
>  #ifndef _XE_DEVICE_TYPES_H_
>  #define _XE_DEVICE_TYPES_H_
>  
> +#include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/srcu.h>
>  
> @@ -266,6 +267,9 @@ struct xe_device {
>  		/** @irq.lock: lock for processing irq's on this device */
>  		spinlock_t lock;
>  
> +		/** @irq.pm_lock: Serializes IRQ suspend and resume */
> +		struct mutex pm_lock;
> +
>  		/** @irq.enabled: interrupts enabled on this device */
>  		atomic_t enabled;
>  
> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> index d314993b14a1..9cdcb16f3ca8 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -797,8 +797,14 @@ static void irq_uninstall(void *arg)
>  
>  int xe_irq_init(struct xe_device *xe)
>  {
> +	int err;
> +
>  	spin_lock_init(&xe->irq.lock);
>  
> +	err = drmm_mutex_init(&xe->drm, &xe->irq.pm_lock);
> +	if (err)
> +		return err;
> +
>  	return xe_irq_msix_init(xe);
>  }
>  
> @@ -843,6 +849,8 @@ static void xe_irq_msi_synchronize_irq(struct xe_device *xe)
>  
>  void xe_irq_suspend(struct xe_device *xe)
>  {
> +	mutex_lock(&xe->irq.pm_lock);
> +
>  	atomic_set(&xe->irq.enabled, 0); /* no new irqs */
>  
>  	/* flush irqs */
> @@ -851,6 +859,8 @@ void xe_irq_suspend(struct xe_device *xe)
>  	else
>  		xe_irq_msi_synchronize_irq(xe);
>  	xe_irq_reset(xe); /* turn irqs off */
> +
> +	mutex_unlock(&xe->irq.pm_lock);
>  }
>  
>  void xe_irq_resume(struct xe_device *xe)
> @@ -858,10 +868,17 @@ void xe_irq_resume(struct xe_device *xe)
>  	struct xe_gt *gt;
>  	int id;
>  
> +	mutex_lock(&xe->irq.pm_lock);
> +
> +	if (xe_device_wedged(xe))
> +		goto out_unlock;
> +
>  	/*
> -	 * lock not needed:
> -	 * 1. no irq will arrive before the postinstall
> -	 * 2. display is not yet resumed
> +	 * pm_lock serializes resume against wedge isolation.

if we are using mutex to serialize code we are doing it wrong.
worth reading:  https://blog.ffwll.ch/2022/08/locking-hierarchy.html

> +	 *
> +	 * irq.lock is not needed because:
> +	 * 1. no IRQ arrives before postinstall;
> +	 * 2. display has not been resumed yet.
>  	 */
>  	atomic_set(&xe->irq.enabled, 1);
>  	xe_irq_reset(xe);
> @@ -869,6 +886,9 @@ void xe_irq_resume(struct xe_device *xe)
>  
>  	for_each_gt(gt, xe, id)
>  		xe_irq_enable_hwe(gt);
> +
> +out_unlock:
> +	mutex_unlock(&xe->irq.pm_lock);
>  }
>  
>  /* MSI-X related definitions and functions below. */
> -- 
> 2.43.0
> 
