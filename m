Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B8DCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549D189125;
	Wed, 17 Jun 2026 13:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lYg3n+NB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A86289125
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781704460; x=1813240460;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=J+1XQAjgP1b8D4GeYswAgxvxEaiq9OdRkMLie0ohVsY=;
 b=lYg3n+NBNnJMni/GeYrJc3pvHI1a29RSGPnyl3ck1gKfObZ6yM+J0KJo
 RzNoXubImKi6LvMQmS7qs5Jy1Lm3c3FSD2RwSWu/d/SBbvb44x/JMYJE1
 BzCVjjx8kvBYzMwZA0cbiYHT8u8efqsMgP+PqKsFiiY4ii2PTkAj8oW4D
 8v0E+uc6A99yc3Onhk65/1z8hV7AGhNHUcJdxz5rCZYpReXg8+F9g+U6q
 6ajla5+dxQ6OHmx2bMveeZKS+sDZi0vXKie+qEcrvmZw8HDDNmYxQNmhY
 45dj3DFzkmU+ctavP8Un8vGtL9Q5d0mMDcTU/b4GPuSYz7xOeISo3RFnp Q==;
X-CSE-ConnectionGUID: qUxarJ0ORk60jxnfcbnOfg==
X-CSE-MsgGUID: mx60kGJSQCaAsNirYzyyTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82506244"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82506244"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 06:54:19 -0700
X-CSE-ConnectionGUID: JwV71BCWRsCPUBd1t7YsIg==
X-CSE-MsgGUID: KV47Ye40TbqKs3JGlhUAVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="248139475"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 06:54:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 06:54:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 06:54:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 06:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meliLB03Bwz4yiRDvQLBr/gv3iu0bEiYVfKJW/cc+wprwVDY4R9UdBTotwJ6KwxeExtmFjlksGm2cuUivSHd2S3VmT2gRuR/IKWFZszstA8WlA+PDaDTzIgQVcQsm9ZB+YzK2fgflPbYO3U1QnNQXmqsN+CsHvpsR1niLwKuFL+1UZ1+Ime0C6NHfGkxuTzw9adaPH2KmJYXO5PR1N5tsvMYT3LmJlJeTy9yZWnjO1JtO7XPe6Giazm0715Tr6Bn/syMEfjz2q9aFXHjcI/e/ElptukpuI05UXzu6M2hfqBaGVN3KMU4yG7IN0gc0DyH9VvrgYleE1qT5zDHTCODoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKGgQMCJBOcIPJ7a+uTdKhiMq8mpPFwxvmGgFADSLq4=;
 b=yFaZiQR1oh/QVIgS6Q20j147668qLkow3olL6ZQSOsIniqrFX9lykBWJ27xXqh57MWYHq71mmVKQTlLRuBShOTRVv0Z89g3/LJXZ593wpDPdD/aOBocB6Eb8x4MY2huyA1EolEIAtZm2O1JtP9OT4K2WL9QFBsOE/k4Gt+3k7Ei4tT1a8pVI1COq4A6pMtr6PxGgymlAT6wxSsHwW/GpQ77/hf5c8wBbRC/XrueYiv1cITC8dXGHchMHMSwO7nFTNLktCYiT6D6wxqO2R9OlWmx7NfOrl0x4NMt4A5dUslE2sedpDnj5WzqZSSClK0d0O7jyJKI9VSuk7+nOlLGsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 13:54:15 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 13:54:15 +0000
Date: Wed, 17 Jun 2026 06:54:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Honglei Huang <honglei1.huang@amd.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
Message-ID: <ajKnBV5JF+JCvYzv@gsse-cloud1.jf.intel.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
 <20260617103602.1491609-2-honglei1.huang@amd.com>
 <20260617105025.A3D301F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617105025.A3D301F000E9@smtp.kernel.org>
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|IA0PR11MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 96562bec-102c-4f9c-0ab5-08decc77eb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OH79faaUWYdFyyDPTXxXNOdAVoPiv2VDcKRGLzHjF2nvW1iYOXFSSoVmAcMNWKjvOUDmepMq3dk4RBp7xERNfRd8qX2kL/ngBvvDrgbCdl+RmAqiWc7ClDKJ+wOkqaMAD6DqYHboLOYut+0Zog+zZ/fiTquGoxAHoqma7vy+j5wcGNtAkjJUBySRwDbgz5qBzLOSbMXhRAX7vJ7SvqUj52FmXp+BvEG+e9JQ/vKU8UXolfyDjyqmOJxnef3DGaO3GVLjmwBUAyglxn4zJmgTGQF9mOBzM9i5dK/jG5kh4qHCwBOGtyOLXV1YYsW8EoUvO/hsDdXAnmiqqei6VGKY9wlUrWRUGOjkl6As7GSiVTiEobbFtOTlf9VtxEP1nozZJ1nHLOc4QoC6yWCL3blXalpyqBQYNh3LlJu85kZ3DV7w9y6cljkZwQ4bcEl7zzkU2Ix0SszkzXfA1rYPTfWKap4cORZBrPysnfQPmIDB2LhM/DzJMMHH4z1/cyQ2AhcMy1+XpDWg2jndIXObq7J/LpB2mpy1gk4SWeELw8t+dhFjeXemlKRB1ylIduhsQ/gHePehfX7cx0yOqAbPi4mMv/3pbz6hJXGHgwFzGTq1P4InHyZQ/4gP9Dfr9we/wrSgtDPTDksvNBsZU/lDywY3nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HodYGZotGbHgm75iJcxYfWqJmk3nJCiN1u8ooShGgFF6arEgNHA9lQ8XR8?=
 =?iso-8859-1?Q?TGnj58iNHbuSuPw/pAKtSgw8/JD/XXYZIvhOxqXboSCxMRWqtdXNNcHtJ8?=
 =?iso-8859-1?Q?X7MHfnaTgZVYwiaU0gegK76o6tM5acJjm9X380flYT6b04LXYPsVfqC/5U?=
 =?iso-8859-1?Q?X6f+LP2YQWZi5TRi8r7YDyYnPyMD/9hA602H7pMw6OhxQVo2KK7I5p/M1j?=
 =?iso-8859-1?Q?4TSLV+bbVypA3MoTEsAwAXzHuldkdrW4C3oIpYA4t5WtKa6VgXCKxneezi?=
 =?iso-8859-1?Q?zBFa/dH29a6ylXu6dyoCTLYKJup19NQpXPzh3evcpnXDTO0/z3qhsyXryM?=
 =?iso-8859-1?Q?0XipOw2CqBnbhqUz7o3Fgm+by+vpHYWBEIFwi6UzU4XvtfrxRO7qjCQV5+?=
 =?iso-8859-1?Q?h4i3cgFO86qBILgeJqvpA6z1SbD37FiJSaTn2sf3sZLS95yfnOl1FsDRWr?=
 =?iso-8859-1?Q?6cUKYhsPiv51SonpgAsIDKZIOfTr/flhKZS4kctkLSHqlQ06fVXxsrOvJA?=
 =?iso-8859-1?Q?o9kw0eIjlYVrI2RQDPiQa3dzL763VuxMUIghsP8BezcTdnzcddP8Cgbw71?=
 =?iso-8859-1?Q?SIAvqa1S9sJZKNbJpaDeDvdzyHoBaE5CF5OQDIepFevI16FBeDy+oGl1JL?=
 =?iso-8859-1?Q?x1gs8MgOCHEsRLjlD6TrLY9QkFyTbXOsS20Y6Xan+ZECpXCc8StoinpBYB?=
 =?iso-8859-1?Q?GCzng0ygOlfU0chhlwTCrMsLgY6ECHstWSDLGFhWD2QrIge7VR+SQWSwIo?=
 =?iso-8859-1?Q?6AtMoAC1qpJe38GkATryGLP6oYQIR5x/fqu+qwItclOU4oc7LnxdQcaIAH?=
 =?iso-8859-1?Q?Y+ijL/6eBC5Lz6R+KYxa78hc4Y+jiaiQJRQ/YM0MlhyFA0pEQxC/ZmdYKJ?=
 =?iso-8859-1?Q?1DjUaDmSjoVejMLhPrkND4X3J5tGiAiSyC2WIIXJbAzLazL4kKUjbXfJ0V?=
 =?iso-8859-1?Q?OQaQKcPrC00Rx4/BqNUu3QzsGAf1INxqY9UFosKTCXBRjELSsDXQ89x/w9?=
 =?iso-8859-1?Q?hnX8FcEknH29lRViXPOQxR0T/M00AHEAlD4E95DgyDeWzJHJked3tbbWTh?=
 =?iso-8859-1?Q?O8YS9Lfbzgb8Ruc1inU0sINqkd72fYN+rwPBq9hIYn7d90ad6g7jwgBViO?=
 =?iso-8859-1?Q?bWQtl3egt3VyWnLce67SIeI26OG24zeo+R+Kjvv7ZaX4IOhm2yNBXmuUHW?=
 =?iso-8859-1?Q?I+zrQI7IeVI4rUYD+2+XGcdC2QwPwMDiqqevRXSM4Knwa14HBi9qU38Gmn?=
 =?iso-8859-1?Q?JjUm1tduuNfrOFNXhf01wUgP1CGyRTZgM3cgSEFkKhk/G8apDpdW06dQft?=
 =?iso-8859-1?Q?ReTVR/qBDon56IDroc4Eafcq7s94FFiKW295tdnYphbyAypjlYS/UCjbb4?=
 =?iso-8859-1?Q?ecS6uJfdfyPZaNAIvSE2XUj7CN90DTFMGmu4pbUo3Vbj6Ic1GHEk47VfVq?=
 =?iso-8859-1?Q?QdfZitsx7VFt57aBv2vpnoIzyWMv7rarTMupPO3z54lYn6BIgqsDmfzPp1?=
 =?iso-8859-1?Q?R/KBHYTRd9E/oV5xur+Wp6qjSIxAfdUALSDY9njhDMdnXGrTflh13GPrOR?=
 =?iso-8859-1?Q?l4woq7OiPv4qONAGmsxNfW8+Tr5t1YMls9at7GGoOdfZaM2ZLQ+2xh7IBc?=
 =?iso-8859-1?Q?zTye71cCgRDyGzpp+9vCa66Tj6InyMzl80yrzkKN9AWpjRC3cl7pp4yEg4?=
 =?iso-8859-1?Q?Ww97o7U5bCbnPQ8Hd75vDm+J+pRjh6Wf20npKV/62ok0H7jbn7ZVf3AJeL?=
 =?iso-8859-1?Q?3IgxozJqS2++QG4mk7a/00BupgEbwe2PjPG2uNizvgwHRuDz/AzKJRcsWP?=
 =?iso-8859-1?Q?4LtVl4ZRdA=3D=3D?=
X-Exchange-RoutingPolicyChecked: BrEYwDSRVimq0y7Ykmc0ZMLppc6UL2uluGMjBdKmwpzU1XDtzOoMq1El5rWBql3svbZ55BMKbkoSJ3GkjXE0/CuEmhzCyQvUkSn8Kj57z0f/VTZYhW9mg2yr3FeyMleQm0+vWZ9elMLn7E3Cv3RjpsUE2LTJ9El8E2gsLoixqk8+EIoDeYSfV5cprkuLrwcYjoaGWmGCObIcABRsD7DyQS1FXhNNGzpHA27Ol6HIPaZKVM8gfFg6uIAf7QYR8DrmtM9EBMbhjAQ6+QuPvVphBXwHKWyjgUpA07txAVzEvn6KuLJc+ZzRCqR1qs4ODIZWrUXe8jsRlSq23I0y4lEiCQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96562bec-102c-4f9c-0ab5-08decc77eb33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:54:15.4228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npfyu9KcUiaJY+F+UDm9xVFZK+Jlq/cQAkMsUDcl+DW3PX55+8GEgqMHrADH+j8eNReijWosb2+g0fLEgkkUgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
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

On Wed, Jun 17, 2026 at 10:50:25AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Low] Compilation error due to missing `pages` member in `struct xe_svm_range`.
> 
> Pre-existing issues:
> - [High] Critical error paths swallow error codes by jumping to `out`, causing an infinite GPU page fault livelock.
> --
> 
> commit c7d50cf1df054885b8dfd4565b263894bfd104b3
> Author: Honglei Huang <honghuan@amd.com>
> Subject: drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
> 
> This commit splits the MM state flags out of drm_gpusvm_pages_flags and moves
> them to a new drm_gpusvm_range_flags structure. It keeps the mapping state
> flags in drm_gpusvm_pages_flags and updates usage in the amd and xe drivers.
> 
> Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177
> 
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > index e1651e70c8f01..05578e187d204 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -134,7 +134,8 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
> >  
> >  	range_debug(range, "GARBAGE COLLECTOR ADD");
> >  
> > -	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
> > +	drm_gpusvm_range_set_unmapped(&range->base, &range->pages, 1,
> > +				      mmu_range);
> 
> [Severity: Low]
> Does this cause a compilation error due to pages not being a direct member
> of struct xe_svm_range? It looks like the pages struct is located inside the
> embedded base field (range->base.pages).
> 
> While this might be fixed in a later patch in the series, should each commit
> compile successfully on its own to preserve bisection?
> 

So s/range->pages/range->base.pages/

> [ ... ]
> 
> > @@ -1248,7 +1249,7 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
> >  
> >  	xe_svm_range_fault_count_stats_incr(gt, range);
> >  
> > -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem) {
> > +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
> >  		err = -EACCES;
> >  		goto out;
> >  	}
> 
> [Severity: High]
> This is a pre-existing issue, but can this error path swallow the error code by
> jumping to the out label?
> 
> Looking at __xe_svm_handle_pagefault(), the out label appears to
> unconditionally return 0:
> 
> out:
> 	xe_svm_range_fault_us_stats_incr(gt, range, start);
> 	return 0;
> 
> If we set err = -EACCES and jump to out, or if xe_svm_range_get_pages()
> fails and jumps to out later in the function, does returning 0 cause the
> caller to believe the page fault was handled successfully?
> 
> Since the pages weren't mapped, wouldn't the GPU immediately retry the
> instruction and fault again, potentially causing an infinite livelock? Should
> these error paths jump to err_out instead?
> 

Yep, posted a fix here: https://patchwork.freedesktop.org/series/168716/

Matt

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260617103602.1491609-1-honglei1.huang@amd.com?part=1
