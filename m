Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D857CC98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B50510E128;
	Fri, 25 Sep 2026 19:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H33lwFpz";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CAF89E9E;
 Fri, 25 Sep 2026 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790366208; x=1821902208;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xFw1i/FxyY1KlyiCogwvqAOJJeXLzFouySTzNBJUOvg=;
 b=H33lwFpzWTtztnEUugvnJhpub6YrMLlOsLgm7PG5DOYrP0xlnW+zSGAY
 ateaeVKQlNiQx1bUsWbccjzLCh9iaDnCDoZu17LUj+zPiR8qPpsqZe6wd
 /9gTSCr9DmHFsRgeJqwZ2Hsgx4TC9KVCkfFqpWkaExNZYT56rqhHFMLoN
 rPt4RoW5Y9n6PPlbjFI01QAm14IFJfqxruBA5NSHS4WfOsDt4IbGgWBXR
 A0DeBdKV++1QfZjYGs7ewTYTBR1GHRgs1ssSIeu05eNV+phC+CkDYsQl8
 TB1gC/Qni/oGDPtUCIh0XiRQ6ZZKzPDSKBf+fM2bCWgKF8gzq0ymLmX01 w==;
X-CSE-ConnectionGUID: K8GppWuvRuO5I/zwZiZEqQ==
X-CSE-MsgGUID: MnMpxQkmS4iZcByjF4huDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="91179440"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="91179440"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 12:56:48 -0700
X-CSE-ConnectionGUID: 1iOd1X/XTxyQfJr3xqShYA==
X-CSE-MsgGUID: PYTm/iQwToiVr/om6+m3bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="277609516"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 12:56:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 12:56:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 12:56:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 12:56:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjUA+RM0SaQC+0W5sI6vWfsB8b7e5l+zEvUhV2yr8G8jD0Lj9asNl6nL/Q1jdkenLAR2gHpXObDRzhdD2/par0PJWNXmQCN43S4w1q270SusGk6YpyKvhICWMardbBzKkp6SmdVF4x4uVStS+62UxU7G1KUAgSKJ+t4j8brm1fkTInDlgTSrONM71ZREq+Qzyfcekkf0DFtvqKzwZsdJ//PrgmwdJVsUV0yjRNUUC4O98Z5RckeJ1M/q7bIVzCNGuSB+he+LoNfbFd9Vo0QAyy5XpjEr/B8USV7xy68mP9WNpOHbTfUIA5EakX72ZLGCaarlG3YKK2yQeWRkGGExVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfRtIu03N43ca1IAVChB+Q5V4vR/5XpjnOQegoFZv9I=;
 b=LgmfPHeha8jng0OB+w2E65gGUhAhP22sIGBt4/pFewdIv7QLpTayYcxRgPwr46tIpRv9UCw2iDZyGIU8GwGTwzr0l2DzX7TUUWif0UODqBMsgVi0LdX12vCN+ex9ki8kolM3Y5KkX60qIC5C2i34XZ98lUMP/ZOukH29s81sD5Gq1aCz4kb00LIFhgkZZoboN8CglcVsLBTtUN/P8WvmsCW5HMQ1kPhltExu7Jo2KhGnGewuhzjbCmP6gHuID09vsobDii0Et0X0LGakliQM/14J6c3Mt/APsNmDcyP//4jdAMJ0ecgsrinaZVUv0to28MchKpq70Li+r4SD6YmiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA3PR11MB877857.namprd11.prod.outlook.com (2603:10b6:208:61f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 19:56:45 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 19:56:45 +0000
Date: Fri, 25 Sep 2026 12:56:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Subject: Re: [PATCH v3 3/3] drm/xe: Route deferred xe_vma/xe_vm teardown off
 system_dfl_wq
Message-ID: <arbR+2Sxc9snuKSM@gsse-cloud1.jf.intel.com>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <20260925133335.149679-4-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925133335.149679-4-thomas.hellstrom@linux.intel.com>
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA3PR11MB877857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de90290-3657-4885-2eb0-08df1b3f20b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aoilX0pFpbPbqHQ1KN+yTvsixnKQZQRmMK4SuIbccCnWeaAIwg1bRWJ6Q0/BDr+5UXt31lcPBNvh6OeUbWJrBVwl+3cRibJI2SCs4NEex3FA/w1FS4NkTofWLWiHUw3SEimXkSU/BC51CD3jn4b8QLH97HpKdJHLcVGA2q306exF0ujYpn1Zsqt3OGn7rTbgJRh8PMmMp54zs+mNobVJPzcj5QY6CO42kZLf075UStzWeHbhshYYjTR1OAWilpHOgvt99Vs0KddPrg/HbZAb9XNRR9uICle4LE7iEcrMlS84X8ScJSv2gPByTdgzx0lvuZ/YL7tAZNUALKcvYsUlSbDkO6ojfGG/6YlFIKvs+D0rKEElC0M4mR2qUCtfxo9sn1EahEHZAwHD1hbbpqMAokvJGvKlOzhfL53pX9PVmt8qvdHGkXBWfhz6vJr+mBkDVnQHVLezmeq0wrjowBIlrEd0Ipadex9DwQoZSqUT4skZWReFGgsBncVpSVil74mXnGSM8IlV9D/LN6wDqHlxKAQa7UWo+8YBDz4+Nk7ZUyG2mRYk8JXcy+bJjNIqskFn6gOoNMUoY6TNO+0eyAUyRa4Xz+Kji3XJ4WWiz+VnICJ9lcaf4jI/zoRhbcRlIclTTCJJim/c3GtKl+iabTQDWrcArRa2FRPCwQwV2iAbMgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?4bi1Qj/DGoDI2Jx3bCzmCApqW7P7ob/xY871KhXdGSrKNWLwqt+wWQUCib?=
 =?iso-8859-1?Q?YGuWb2yh/HYd8nnkXHtnpDMIJjYQvvnyZfg1uKS3vwR+1CPWunPbbwLlU0?=
 =?iso-8859-1?Q?cf3/x+vS++USIILBHfciZVrNuVB43gfggnwifmV48hskr6SF7yIz7/ehoK?=
 =?iso-8859-1?Q?UZP0Ee/zgfUFH+dX/LxjRZRjTCZWeL19Je3sWIu5QXq9hcNmxIxagzxZgr?=
 =?iso-8859-1?Q?Noj0XGwsWvJUqQ22muCR09N6mKymZIPVY3luBjtkDViBfpkAwYLeEAOJx/?=
 =?iso-8859-1?Q?TriAdPu721J+5+ItnY1goxMaqcztHKDfmbtyxwl5vJq4D9GxK/ZuqP9o5E?=
 =?iso-8859-1?Q?tKE78MdlzAfez39cSFGcwJc0Heav6Tyrzf0Ktut8Zl3Njzbky4+3KXKcMy?=
 =?iso-8859-1?Q?hU2t/8E+aYMP6l9+xran9/qmIoU7ldJ0NB10K2spi0s2OMNc4SE/AmhrI1?=
 =?iso-8859-1?Q?TlYGY9ChwHyVtDZG/x2VbDkiMLnK6pXUgeVel22U4j6xkAmLJYWnnEauLq?=
 =?iso-8859-1?Q?rz2H/wSHY63c1RXLiS96o0csefZUg/+mDqNgNPr3ciOOSwqxDULLDo/yX/?=
 =?iso-8859-1?Q?Ksa8uJDe/428cUpiTG7stCF0s64k8RwVHgqcYRwUUOohHP31QFf+fShci/?=
 =?iso-8859-1?Q?jU4u7ygEYOFf/prBnO0mlMbZ+mL3zVF8BzCRk/u3YSCFE8C1ec9/cOAqH8?=
 =?iso-8859-1?Q?uoHTSR42b7D79zSIn8NVeoz89cX2vpxd9/lJdaIyz261T1GCJwraWZtpcS?=
 =?iso-8859-1?Q?IiSzuJcobzuZPhvF/uj4l2F8RxKK+5X7T+HC+JEDhjVz2ka7Qg6eth+h+N?=
 =?iso-8859-1?Q?vMhpbFqypFDc4G6KQyhPIF54iv3cQZ2S8HvRddgyHQISk3+p9M8XDUuF4i?=
 =?iso-8859-1?Q?OUCLDET0J8222sakKfCQM88OR05X6LEulKV74Lyh6MUNkEHzeTJuZKL+o8?=
 =?iso-8859-1?Q?QRVA1PhYE8HihAuuGkCXGW3fAmSVS45Z1esI2EJ/M2aXjdKytYkMR1dvo0?=
 =?iso-8859-1?Q?jC3RHh+aY1M4HRfsnxo0TvGoOLG/kBrFFhM+bo7EVJmK8QH4I1Brao4KsE?=
 =?iso-8859-1?Q?7/FaVZJLj5p1ddN/wViD3kSfNN5pfGUaoeuhOPHoN5F1V/poUkEY6fMhNK?=
 =?iso-8859-1?Q?18vS5cNcq04qbyZms7Kr7HDy/7yL31OAjw2ZQPKgD0VCfRekjiXubujPjT?=
 =?iso-8859-1?Q?Lg9nA7LFI7WGWmNWjDHgBIfV70ql3ESNGfHDtRB4eT+dT08pyj4/MScHny?=
 =?iso-8859-1?Q?YqkK0TClLLUegu6FYGomyMUW/dk3serTXhUcM+/0/vEZsGtiwbUagy7GzC?=
 =?iso-8859-1?Q?s40pEjyD/cMWxgxE32X8O2DgOXyoj7lFCEyUn6bjaL923cVOEGBe6qauno?=
 =?iso-8859-1?Q?yPKuxLM2rGX3Ux9aiQItNYvD4ZTidNXrZEfaDAUYvazkCsmNc766jkpOI/?=
 =?iso-8859-1?Q?DX9clnGSD9cWtDCD/8l9pTy6BkVehR6ExHJWsHwuiC+0LLfVRWvUJ6aS3t?=
 =?iso-8859-1?Q?THJWFUuS17gdA817lrPALB0FvdZUxTQQPA12RHPb4GWF3DndLpoH4T1y0n?=
 =?iso-8859-1?Q?9bbQRUSH8DUvWpVSkvajHNS2pMl2TW22BCmycSuDP6O5VNMEQ205QCcrtC?=
 =?iso-8859-1?Q?X4E3+dRW1T83TrIzsmYqWVfnjbs8Vi7PMcE/zYJLtZWy/HvMExa6fACHfR?=
 =?iso-8859-1?Q?gttcnXKuxQgS4LGzrUTdbez4V+DocboQVGmJ2SVoyuyqdX5ZUR6L21EVsn?=
 =?iso-8859-1?Q?N+b3IXH47m89hnHlmCHY4YBzDXhbReh/H7+zD2P9dbFjpbwY0JPwUCohQc?=
 =?iso-8859-1?Q?bKJhC2whd4Wahb73+YrXzqunaHL94SM=3D?=
X-Exchange-RoutingPolicyChecked: A9XbIwXzychbLExnKDH9wgvVFAD2gFidLpXlWIfoi/Ng0uL+pWAYDMyrQlUehsq592G3HmkTIri+OIAd2cgu0X6GY/MRkMoai+i1TEyj2Nit+qEtQiu7JF0sAxOmbZpDLWvY+9Xhl9r5COCps8/RwVPANI8JdZFOqW5zno0DdN556V3f8OgnDag6Or4MEC4+0l+x8n98ZDv6+3HsZ01r6gP0Sbz6EcoMO75F+HfUl4O4ioWUk56a+1pa0ZVwIwN9SaQ8K4g8xVt3BtoRUXDWvfw8NaE7kSpiAwQ6E6IFVZO5R7a7cVgviklm0Ntgj+4Z2sBANUKzIa7Z0kqa731emA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de90290-3657-4885-2eb0-08df1b3f20b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 19:56:45.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yGu8kH4z2dkDnFoKPwbIoiR4EecOfkW8LY6+xq3ImSnarwJel5zfkwieRWjkfbvNHGCblytJb4i36cjiP+Vzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB877857
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

On Fri, Sep 25, 2026 at 03:33:35PM +0200, Thomas Hellström wrote:
> xe_vma_destroy() can defer the final teardown of a struct xe_vma to a
> dma_fence completion callback (vma_destroy_cb()), and xe_vm_free() (the
> drm_gpuvm_ops.vm_free callback) always defers struct xe_vm teardown to
> a work item, since destroying a VM needs to sleep. Both used to queue
> their work on system_dfl_wq, a global, kernel-wide workqueue that xe
> has no control over and never waits on during module unload.
> 
> drm_gpuvm_free() drops its drm_device reference immediately after
> calling xe_vm_free(), without waiting for the deferred work to run.
> The same applies one level down: whichever xe_vma or xe_vm reference
> happens to be the last one can trigger this chain from a dma_fence
> callback that may fire at an arbitrary time, including after the
> owning file has already been closed and its own module reference
> dropped. Since nothing tracks or waits for work queued on
> system_dfl_wq, `rmmod xe` could succeed and free the module's text
> while vma_destroy_work_func() or vm_destroy_work_func() is still
> queued or running on it, jumping into freed code.
> 
> Fix this by queueing this work on xe_destroy_wq instead, the existing
> module-lifetime workqueue already used for GuC exec queue teardown.
> Unlike a per-device workqueue, this requires no dereference of a
> struct xe_device that may already be gone by the time a deferred
> callback fires, and unlike system_dfl_wq it is guaranteed to be
> drained by xe_destroy_wq_module_exit() before the module is unloaded,
> following the drm_pagemap_dev_hold()/unhold_work precedent of using a
> workqueue that is waited on at module unload rather than a bare module
> reference. The previous commit's reordering of xe_destroy_wq_exit()
> to run after xe_device_exit() guarantees that xe_destroy_wq is only
> torn down once the device-count has reached zero, i.e. after any
> xe_vma or xe_vm whose teardown queues work here has already dropped
> its drm_device reference and thus already queued that work.
> 
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Assisted-by: LLM
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_module.c | 6 ++++--
>  drivers/gpu/drm/xe/xe_vm.c     | 5 +++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> index c61bd33546f2..897724cb5cfb 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -114,8 +114,10 @@ static void xe_destroy_wq_module_exit(void)
>   * xe_destroy_wq_queue() - Queue work on the destroy workqueue
>   * @work: work item to queue
>   *
> - * The destroy workqueue has module lifetime and is used for GuC exec queue
> - * teardown that can outlive a single xe_device. SVM pagemap destroy uses the
> + * The destroy workqueue has module lifetime, and is guaranteed to outlive
> + * any xe_device, and to be drained before the module is unloaded. It is used
> + * for GuC exec queue and xe_vm/xe_vma teardown that can be deferred past the
> + * lifetime of the xe_device that triggered it. SVM pagemap destroy uses the
>   * per-device xe->destroy_wq instead.
>   *
>   * Return: %true if @work was queued, %false if it was already pending.
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 390da884c727..ee369e6c3b28 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -29,6 +29,7 @@
>  #include "xe_exec_queue.h"
>  #include "xe_gt.h"
>  #include "xe_migrate.h"
> +#include "xe_module.h"
>  #include "xe_pagefault.h"
>  #include "xe_pat.h"
>  #include "xe_pm.h"
> @@ -1249,7 +1250,7 @@ static void vma_destroy_cb(struct dma_fence *fence,
>  	struct xe_vma *vma = container_of(cb, struct xe_vma, destroy_cb);
>  
>  	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
> -	queue_work(system_dfl_wq, &vma->destroy_work);
> +	xe_destroy_wq_queue(&vma->destroy_work);
>  }
>  
>  static void xe_vm_assert_write_mode_or_garbage_collector(struct xe_vm *vm)
> @@ -2059,7 +2060,7 @@ static void xe_vm_free(struct drm_gpuvm *gpuvm)
>  	struct xe_vm *vm = container_of(gpuvm, struct xe_vm, gpuvm);
>  
>  	/* To destroy the VM we need to be able to sleep */
> -	queue_work(system_dfl_wq, &vm->destroy_work);
> +	xe_destroy_wq_queue(&vm->destroy_work);

Actually this is still unsafe, right?

destroy_work touches vm->xe which could be gone after gpuvm drops
potentially the final drm_dev_put, right?

Matt 

>  }
>  
>  struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
> -- 
> 2.55.0
> 
