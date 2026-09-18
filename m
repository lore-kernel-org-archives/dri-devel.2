Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B57CC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 03:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2136110E7DF;
	Fri, 18 Sep 2026 03:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MZW+I07+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F70510E077;
 Fri, 18 Sep 2026 03:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789701769; x=1821237769;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QLaaI/Qf91Mzxzdf5TAr8xWRCMTtovbBPTDJFysLWrM=;
 b=MZW+I07+61Ej4smz2QIfvx/oWdAsX75tvtivrzLVX5+zUu6EjHovn+qO
 GBLjKN7cKQEnF6ogd2tlhSfJnSVddlOSuwuNH/CBrWMJ6gS0rcKyf1MSg
 A/FCS+v9E8GejypybbhY7N/whgnzbPCvzYVZmgrvroOHimqjv7/BS5dWo
 vVJojn1QG4hWt8kzXY25+N0z808xL1v3Sx7kd+WYooZaEGkE0AcRpN5PM
 nFAcxgUl5eBR3wC8Y2WS0kwzzuL8H9iS3ndDYbKJ/UqYMMCF7VVRICn8T
 gCw+BkVUja7S9WH5hJQCKxs4wxob9pY65ixi+niYu9KybBLiW/loFfDJV A==;
X-CSE-ConnectionGUID: QRB50nOuR6WC+JVVfik9eQ==
X-CSE-MsgGUID: CCl9KgvBTiWGegCIlwDIlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90199429"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90199429"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 20:22:48 -0700
X-CSE-ConnectionGUID: OLK3PlAzRoKfUxfcAxmQNg==
X-CSE-MsgGUID: qhh8IIysRtSht0/CCc+Qvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="299265907"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 20:22:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:22:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 20:22:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sASPzarwgT2y2lMiCeqJfmAlhUIZOIsuYSwsjeKjSssmD0IQO70jq6/qhOTAw2BcQSXbEU4XJpsTQuzH+o20cenkSxt6kfyGg1nmh1lieKRfczxzQufqH0K20mWAHL2P/JD3MrtPaUyuLYwiFU++8Cr2/BgIJWa7vSnMY2r9kc0GZLJlbjpHch1LlQGANTgTQklTV3WSEWjDPhLYQK0ue4TCerLkdX4m74X+B5Sg2yMQvZmnl4/0Yn5HdFvrO+iVegyub6/AovGXINipTHRYFDPDjfJQBrgAIqaHb0MoOzNoBg/8AEtl52i5RAde1jlfP1vIZeSCRQJA6lkCVcF9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIDOkaBtzFOvpLsvOZjxuMESjzzxw+zQ60q+C26S/1M=;
 b=n8Lu7Cvzl7YOModqfq67KJworKSTB6GvebjaRwI7A7WXsuQU9otPV5tJkivJA2SorJnYkKUAGt3V+0xG6hbnZ18SGTXie2e/tqby1cnsTJMCOfYn258R7HkiXc63Mqsa4gq+Jit5wo0jiR05DqlgkGxZwj3YsVZwjdCRq1VJVU2q50NBSqMIcwrZZL06LoH1hepPkmxa7kjyJAiw7wISI3qsu6vdCQj7R5Tjm53hkZRAurDPK9ME/NDZsFKpzTc9BjQ72byLexbNmudu/Jk7UeJrxpPaGlAE5mKYewjGHsHjw2/pquL+h1vIHSBeEI41Bu9umpzTSEr4CtYmULFLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:22:36 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:22:35 +0000
Date: Thu, 17 Sep 2026 20:22:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 1/5] drm/xe: Hold a device reference across deferred VM
 destruction
Message-ID: <aqyueX3xWoVJ6P8b@gsse-cloud1.jf.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-2-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916095337.3104891-2-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: c54ff9a7-0b53-4021-6255-08df153415ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CdWDy+LYW9X0PXVkeYiG9fGu95aE94EaAt2A9YQ5FD3Qdhj0PqoAYT6LTN+J/vl1NRsx0+zh9GAWRmphr+OPqtvJqSK3kyUlclmW0TSlCB/zXS35UKyl77kTYeN9gMHiU2+Ar4zLF/jr+PcSxFUcYBGE7Zgf+Qz4A1wZSf4tejFgldT8iPhAtsHNfBdFVKAvDG5nfe4jP4bWvGr4nuJk9u0YHVpCrZ/kj/reb+OSnzG3Vb2SiLsA8mcVHriMm0Q9d5jd3liWh/qDYlsm7YVZlVMqpEkVpzd5jNNpNIxhNBEmCiQ7PzybvtbjO+/K8RfSSRduvJMDvq8Q3J6T92wqmx/MrqF0KQfP65lmWpGWfAJYMzE1x3u8b20NUzveh5JadlHNBptHeVW1PYDkpDi5qFUHNDRxwmT7CRjkSWvz+08fxJ7PWYGkTcuadaKELFl+QgK9CzfeQMtfjUJ0FY4T1JbJh0MErOZyAizHXdLFgf7qIOemd/0tum5fUBloiBGrRCQsEgqQ+TnLpcDvtMdKKQ0OHJU3/pVSBeFopGDdPjrLLW8Hl1qAEEuObg2qRNOXrgU8w0mSO5i92ayP1SgJwuy83wDF5gKG3kVYHMaSQHkoxLJdz1tlyBen3aIGKIgv0dz/tB1clAc/PTyoujOyngtftiyhAcVdDgp4BpTul/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?73dZQS8KTiP0Z7w9ipaf7+8Qntda5CvZiQl1d0MlRosKKtUG8upb8J/t1D?=
 =?iso-8859-1?Q?CvG4WxGDX45QKG7yv6wLJl5PUJwjk0ZAALCUR9+1O6pTxQAiO26KDikwqb?=
 =?iso-8859-1?Q?t6sNfYYwgbpvBF6xBGGwBCb2k4DD1wZP07Op0dbh99UDI7S+ffetFeQbdt?=
 =?iso-8859-1?Q?Ru4FyxJdFwhE8WJWaqBKbhGSfZgohGydtjr/gKrfAyscZxgRXJJp1yw1as?=
 =?iso-8859-1?Q?ysR4NczcLSFp8b723a6TM0q3Xk0KOlMZly6UvA44t/ZXyWS3COeVhR3qSd?=
 =?iso-8859-1?Q?fWqsKj2hvCL98MvYXMygSvhJIXYD1S4gGaKAde9V0NKJxXNph5vu3SMZZt?=
 =?iso-8859-1?Q?QBoxBNIHBQvHbpDSidogAWnMP9RhhIopSVMzbQkESwdvaoBdHZiiD7JztP?=
 =?iso-8859-1?Q?we6XLZl1PKcYfdAYWnsvZKGmAd9YGEfHxwh81e9LJqagxxh0jwt37WVQPf?=
 =?iso-8859-1?Q?LiW1LPWU4JNCpF5FQY03DLHXL9ilRN8ySJYn71tPtKvoJHvhm9ANlL8iFL?=
 =?iso-8859-1?Q?5Mh5dKtQ8Nhrj+XmFjg9lA6EjEdLtPUV2r2PIUfVCKXceQXg15Sh2oa9aC?=
 =?iso-8859-1?Q?u7Wsgh9rCvZ5phojhmO4BWnQ6J7nb/YcutOHJwMtgzCTn0Vsb7yr55roh+?=
 =?iso-8859-1?Q?DsGboCCX4pIUBSIqnwAlgx4q2WR9HS0KUCXmxCeZVX+b65WBK7NZZguNnf?=
 =?iso-8859-1?Q?DuMUVgfqX2zfQk9pSrPCz01xPurYun8ozmWpBcdtR2aXWApL1eLeQuIF2y?=
 =?iso-8859-1?Q?hMqKKzqRNefGxzKEClDctio8C/6m7w5+0M/YsteQPMbHtAhgiFsx0DFo2w?=
 =?iso-8859-1?Q?Sqc1Dm6eP8ynpftTIOBz2nuDBnM0pfUhx+Ff/xD4kSW9yTUYCZv3V+ZMFI?=
 =?iso-8859-1?Q?9pn5HXBFupKt4bOMspfrX3kwWpS9HjDFNs0Vr7P+8naUq5NtM07mvKlk5l?=
 =?iso-8859-1?Q?B/3o7FaU3350DzikdHzAQphMeLCyAxrXgtvFv9g50DH097k+Q2NDEmGOhX?=
 =?iso-8859-1?Q?34Rl1VLV4zWfYAWRdDvz6fHV8oxgkUCV52R7jVjJDDXj94zpG1pDIUDNEX?=
 =?iso-8859-1?Q?Hb3vCLEu2cMzyOdIH/hY2PIwOTJlqWMNeJ+evhzeEd1wZTCVHiTb9Ss5rd?=
 =?iso-8859-1?Q?s19M/T6x9xVtZjWD4B+Zm3FatUy7Nw9HaVEuMscVl0rQEIzUjYjvXri22+?=
 =?iso-8859-1?Q?F1vmTcc7cPzrJoV6LgJ+Zhwti9XM8qpZaWP8tNdNQDPEhrDcUkniAikeZY?=
 =?iso-8859-1?Q?1vN6/Xg6NMwSsW9fhfqpIAy6m7GkSeHqUIsfivDeXOMv14meuCuYpDfN0F?=
 =?iso-8859-1?Q?UuNbNKPX1x2cZYhw0ociMeR4TEH8jEqjq64pcSIPNHrWK16HP9zd2i9TfT?=
 =?iso-8859-1?Q?WpVgzYMfyOOhJpqduTz7KzHl+VzV6rDrb6PM3wNvimlCp0tImqDRebCA5H?=
 =?iso-8859-1?Q?foLxKDT7VhpsxqD2fEuR5AoJct36Reajot7FJckkaJ8v3kKrqzlQ0qUan5?=
 =?iso-8859-1?Q?NzbD0CEAh6qzceq9fXv8olwlF3rQGVu0wva8c3ldlIJ6an2Na8atrfg282?=
 =?iso-8859-1?Q?Y3DSjE5mmZipr0AJbiVCD2sXXGU33bqbUJeamFa39vZg7vmlqQz09OM7YE?=
 =?iso-8859-1?Q?IrHUUTXj4na/PaclUJKOnwwvfLwf5A+w2qeMfoarUfUh+3RGCcC329/Cyu?=
 =?iso-8859-1?Q?zXRsq9prxYggIGxXeuJbqz6Nepu/vEOx0Aifc0Ud4pYujtIfZDxaR7RPCq?=
 =?iso-8859-1?Q?8JZ2EJ2B6kN4XUJ5QfeuSDqqaPz+bLnWZ8tZi+kYd6ssMS7CjRi1foMpPB?=
 =?iso-8859-1?Q?2gDnq9pwug=3D=3D?=
X-Exchange-RoutingPolicyChecked: jCq0ToFaIGb6PF3Rx+p1v1Y/ZUnVeXnirIULE+OpAsjGF5ZIl2pmyzN7+h3NB49ihesuCp81CegqyL68c80Z7Fpfeb4sxq1u0zzMvSSe75oFs4vPzvQKHDRCvAtDcK5NP+Zood+HJLrMk0u14Qs+9eef8UwLu3DT48jJu3Dwwic9Z3RiIVspYSVSu1Q0I6AvpbNfp0XWjEZpql8lJFSoSMIMaNhecgEkoKZluQYILf0ERXrR6HNl56ojDq/hCt8rcyZDmdiXZi3mwxYZbE4+M4W92nnX128HcijGA3nkrAL7TMQ3gvC74b8DVh3yBstuPs+tDJjnSqQalJ4UV2nmkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c54ff9a7-0b53-4021-6255-08df153415ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:22:35.8344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5I3X64yogPzuYKhQEsz0PDLPuGojFBZWUuxu0LlYTPQ2wkeRyKzx04KX4MVSoHvPu33nkynwZw4qWbCyZt0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
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

On Wed, Sep 16, 2026 at 03:23:33PM +0530, Arvind Yadav wrote:
> xe_vm_free() is the drm_gpuvm vm_free callback. It hands the final
> teardown to vm_destroy_work_func() on a workqueue and returns.
> 
> drm_gpuvm_free() drops its device reference immediately after the
> callback returns:
> 
> 	gpuvm->ops->vm_free(gpuvm);
> 	drm_dev_put(drm);
> 
> vm_destroy_work_func() then keeps using device state: xe_pm_runtime_put()
> for an LR mode VM, ttm_lru_bulk_move_fini() on xe->ttm, and the tile
> iteration. If the freed VM held the last device reference, the work runs
> against a released xe_device.
> 
> Take a device reference in xe_vm_free() and drop it once
> vm_destroy_work_func() has finished using the device.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>

This is a fix, IMO. Ideally, we should probably push the delayed-destroy
semantics into gpuvm if they are really needed. I'm also questioning
whether the VM destroy worker is actually required. This dates back to
the very early days of Xe, and I doubt we've ever revisited whether it
is necessary.

Let's follow up with one of the following:
- Introduce async destroy in gpuvm and have it own the drm_dev_get/put.
- Drop delayed destroy entirely in Xe.

As a temporary fix that can be backported, this looks good to me, so
with a Fixes tag:

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index efa5ff6cc823..264bdab75de2 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -2054,12 +2054,21 @@ static void vm_destroy_work_func(struct work_struct *w)
>  		xe_file_put(vm->xef);
>  
>  	kfree(vm);
> +
> +	drm_dev_put(&xe->drm);
>  }
>  
>  static void xe_vm_free(struct drm_gpuvm *gpuvm)
>  {
>  	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
>  
> +	/*
> +	 * drm_gpuvm drops its device reference as soon as this callback
> +	 * returns, but vm_destroy_work_func() still uses device state. Hold a
> +	 * reference across the deferred work.
> +	 */
> +	drm_dev_get(&vm->xe->drm);
> +
>  	/* To destroy the VM we need to be able to sleep */
>  	queue_work(system_dfl_wq, &vm->destroy_work);
>  }
> -- 
> 2.43.0
> 
