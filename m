Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06600C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F346510E55D;
	Thu, 24 Sep 2026 22:05:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OtMXtZvR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F9010E535;
 Thu, 24 Sep 2026 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790287526; x=1821823526;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=udUO2Ix336pwLOmnL61hDBypdv36Uf6q0Z+cou+/22w=;
 b=OtMXtZvREcS9hwVMbe5EATmso6N2QJBnAHgbKLiW3kxCaFbcw143dJcb
 nf/vPTN+MqQLEqaO69Ou+jDO4ZgpCQLPVCAmnMS6eQ93tFNPc5THiCCFH
 xa9IrnUtSC5d2Z4U4lGLbPkmS3Z/z8Nwllf5TsjZ3YqV02EXPQLuZNesx
 s2Nlo4BTKmQJI/AlEb3EWkZHjEiotPNCu6PrENAyS5DefC8xz5u0hWF8M
 fwFnXnnKw7dZ/4xdD1MLvhs0fIYJppH18R1fiSqut1GDLeoet4bpQsD1V
 oozsrCgUDJqNV6Lqjqa6gYv1S32le2UJRPi5TWgM6fHEJtaIx7B9Es7RS g==;
X-CSE-ConnectionGUID: vGFFNziaQGO+9qDPXOiaUA==
X-CSE-MsgGUID: 1k2Z0jPlQB2qjDrJsCobuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107457024"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="107457024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 15:05:25 -0700
X-CSE-ConnectionGUID: +AENVeaERBCiyZvNM/rxEQ==
X-CSE-MsgGUID: 9eJy3gGyQEuBAF8HbQk7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; d="scan'208";a="270643759"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 15:05:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 15:05:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 15:05:23 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 15:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xj03Hs04Nzvd021Zccia2fyJC5GwY/46oXKjF+DzDzSxZr2HUXrBrW2a/muTYPXAOogY8A4tH338qaQhXwdVaqs2opj9UqtzGuIhtsO2Lh9jjAeeFWSyFyO7b842Nv4LCrFR7QOZcXGUTBJVQ0tIoS/9bFJVsFaJFCclpHQ1PFqQHTkWHRd/O7h6gWO7u4QmbPNDI8DpAxiSzrXaqzJ7i2KxopKU6X3BGO6QViMqZVS5YAp77itrg3tXHKzt9Gr2jH4zEeNRi4UkijLeQo22ckTgm68z7K+BTmobcxhvLJaYVQWyl3CCAqq5S9Je8wjaEYppSoZ3enlZpo98RgxKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVgrkXyWeZUtVt4zHwGdOTHiOxWTr+osqlx68IA2Iac=;
 b=ckrfVRkJtsxgepyoRe4HhbFwALXxY+7d9/l1KIUUoSe08hsRlOs2648+X5KdLOtxM0orXkZvSr/37uY9EiKdYoKgiqzrciJwkfSq7U5QnzKdiaFCn6W7qtD8uLt35OokSL4Bvb6Wys+Ft6Lb8dYZjWNPOVBuCmr60QLbZcE8104Oe1excuLIPbAzQTXYZXXGZoriEdIQqfFPGOSLTzjUzLTtzOe+Pqi0U9SlZ3gPMu9mgY95hxDqD8mSBSrlkBVyKkXzl18zIwrGm3pCKjrmylhgx1JlQLWkZeSGc9srMgYe79OAL/2sENcrH+Y2NJDfvf8WiXCR67IWL2b8RufVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 22:05:21 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 22:05:21 +0000
Date: Thu, 24 Sep 2026 15:05:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 0/3] drm/xe: fix GuC TLB invalidation ack stalls on
 ARL (Wa_22016122933)
Message-ID: <arWenmbBkCZ4m7I8@gsse-cloud1.jf.intel.com>
References: <20260922144634.55130-1-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922144634.55130-1-talesam@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::25) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ace33f6-1985-44c2-aed3-08df1a87ed2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 52NbSgC/7Mz96s9ROSHkelBa2E0aGu94fM3WGXIVwAgUvoO20bCoaR1rIrzwUm0xQsAuAbUpad+ezKkotzfKQ1hbIkGx8AUTpOJN0EP4uBFN+QCKaMkxJ1JbzDHuyNJc+w0AmWSqzZS46MC+NSkL+XAhE9g0K34XEfXaRVqd+u0J4UzrXKTHoRQcTDLIB3gl3t2X/Kmeb23yF2uC47X6xwjaC1PoFYfZB40TbiMisCsAuLRVi9sA6WM24hTV4oVzev/jUp6xawLw6Ro201bTayhz87FVT3LVuxTLmM93SKSRohU+HhxgMKJ3BVwRZWqhB1jcMEh+Jm7xPDifRlpYgWu3ZNpLN0Pl0nzAiamiCaWbwjw4w5zle/Fbl52BqKVfV/D3/gnU5UkGzRepfxbDXilnMXzVPm0xorr6IiVBYiDj8AZyZHMJD71uY8GpLfOlD6CZhj19lcmudi3XA4DIp4vnX6LNHOmUPUXVUrCfytGFGeyorA/aVdX9XpkkAStb48pdchI4/tJwmPKd2nAM5sZZpAZDrUT360YsTZ2gyFIyHzpBeQ3hincfMEzRuX2zhx0F9xIGE076pYL085Vt741zKstLSsv9xQO4shckXkh7DSvyRMkZ4CBBrHdjasTn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?EarlRFJ8KeF9hUMf7Rg2M3vfhx3jGDuFAL4jE/ZeuFz/GA3BeRlKU2Bdh+?=
 =?iso-8859-1?Q?2t7g3V9sDeNQWqxljE8JAisv1HKTJapBwjGOKU20CUDPTuzEpxSL6ngbhO?=
 =?iso-8859-1?Q?AZJWWgTpu5h/tRTLHewnGydrnXaN0nu0FUij9/kvgqAvkYLae+ur7SvxBi?=
 =?iso-8859-1?Q?jb/aLRmb7zlEs8+FQQeeJHKAAJOEPPAnNuK6qa01GMbRJpaE0uRv74KaSS?=
 =?iso-8859-1?Q?GwZMznrh+SckaAAsf4EJ07iLfg5oTF7pYgkicCPnJljh1RJZ67YhLX0rhh?=
 =?iso-8859-1?Q?RpSVnWr8kHtP1aS0i6NxaQv5Z8W8ydYVSoK659IZjOo6lizypfaBqi8G6o?=
 =?iso-8859-1?Q?BhaRULk0FO7NEa16vel5E0V/cH7fKxHx3CZW80xXkrEVDAzDtyHgc6C/9c?=
 =?iso-8859-1?Q?Posb5S94nC+muZ7SMw/nO0BaEX6dTG3dQuhk8eszC+JD1ic/q2Cu/yo3Ii?=
 =?iso-8859-1?Q?CJtaO8sOxq63t8XwweFAZ0DsCg27+2GPld4/Vx+XZYRkx2T3wgixKlYhs9?=
 =?iso-8859-1?Q?9yOTmSOh6ffa4+XgixmLPVnuTwV+ii2k0t6zNzW96Bg/Zgg4gvX75aRrVG?=
 =?iso-8859-1?Q?/szqVMRyvkEudtekEnmOjYiCSCFtL70wWbEnuW276hQUbQcfmHxPXdD0Y9?=
 =?iso-8859-1?Q?Dki2yi8MP4qwtmC+WVbhNj+Qn1nOnwyuDIPvvqvj2bXdBP7uu/BX4w/X7T?=
 =?iso-8859-1?Q?rXkUMyTfrtEm+vpPG2S3ZZm9cX7n0DR0ydaoq9+VgBXpOaJgJf+vkibMnR?=
 =?iso-8859-1?Q?VSR/2KhlldzJodhR8qDRLOUhCf+jC/zvEq1ShmSzyTKfLR4+AN1ccwW8It?=
 =?iso-8859-1?Q?bV+QilKcmyuYh6t6/kHf4ZKkLKjMtPwNl9yacwb2pIXB7ysonb/VR1U3bl?=
 =?iso-8859-1?Q?JtuTZZRHa7MiSnAUeLyClbz7mQ/kdPEwHZSRBcQhmGbX8Pu4uED5Z7kmdV?=
 =?iso-8859-1?Q?tfADsQ7DfIG8TZ7BLLygkN86TK5k/UQiV9DiaQ9L0JfyEofGtK/u63ycHo?=
 =?iso-8859-1?Q?y2pghqnGMWyS+6s0EosdxjN6x+iJJQSDZJGnl6euxqzKnrszWjZHULRUPh?=
 =?iso-8859-1?Q?N8BX9pqQArDrnLdD63oZ0WaBXkTznbfeozd70cUJ4pTQZY7n4r6RTw6SuG?=
 =?iso-8859-1?Q?W8EYQFAMHOWF7/rOmDhAhdq6V19OvhsdYd1b7qWk8NdHrhXaXpyB+8PFM5?=
 =?iso-8859-1?Q?8rH4T10GBeP3vMy56VC+iqcQ0MTbw00eQIBTrPY1/Yb1dg8ewKxVeJFMr6?=
 =?iso-8859-1?Q?U9/EB2x8LJC9o1ZVvKzueR3wQYEyXuHKPYeKitWfftcw5u18TToNTeof//?=
 =?iso-8859-1?Q?YxvcCX1OhMuEyyNZ4zv/eL8jcmHKIjjqWQ71Cu7lBn8DR34TciZgejWpsV?=
 =?iso-8859-1?Q?IZpiSeXO0XKpNXIwdYkQue4P+PUCX9MEgYkymz+vavQMLsmfW6cG177PIZ?=
 =?iso-8859-1?Q?ajXQBxBLrUjbATFc3m5BNWBnKXfz+NyYMWhwxfU/9kD08TZzwC64Xod3/A?=
 =?iso-8859-1?Q?gQxaIY+IPUG3LtlrDBhpdSZD2sevbp+/I6tq41K+in4vTKqTCdEDC9lRPf?=
 =?iso-8859-1?Q?DrPN9vzm5jZX0QzN6wAH5bS8wTGzVdWunP8vP9sGLgBvmA9GvShXnbUrIk?=
 =?iso-8859-1?Q?mKX23T+Tk9Gy84MLD5aFBBCejM+grrKeGdJilTesb/AnF4fJBiyD15f2eW?=
 =?iso-8859-1?Q?McOjEEOqMQqG3lYkA6CoDQRSzAPTanhdotE0eTotL8TVS5GI5oOGJ6h/ve?=
 =?iso-8859-1?Q?2Nj4axCXPNteimz1wl/sKeuKXTlHQ61lekLh6SqF0k3DF3h9SeNQg/2sCQ?=
 =?iso-8859-1?Q?HPNtYHIHzN64ZPl3yLLYmKtTnC0lzd8=3D?=
X-Exchange-RoutingPolicyChecked: 2sX3085gWhkVqt6XQMwUOYTmocQrx+UpoJistM5gkftzhqAKLsMTYWYrk5DiKwKxDc4WGmENzAJOwHAMKfE1sajcLpcxkEbvAcU3B5vL6L24Ovv41dbCBryb5GFmLjVRAjifJJxVESp2OLt/FsuFTbY81nwxGIBxr50r8+vj270f8AHupe8dx1+WEDqOMR0CIjZf7kdyf6thCSk0vLzAf5Tg3LKdY0mjTvl1ryLQ+jzRIZ9kjVRXbCj9qMKPd2pFM2+pGeIm+hVPD+8he26Cffi15PVIqA2HxSflqc3RgtKXGTzePmIeILLn/7BYdhPmp8d2EIyaUA6ANCXKQP8c/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ace33f6-1985-44c2-aed3-08df1a87ed2b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 22:05:21.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VouZ1Q9w9rPcw0Ud9sGqBGssLE6lwFwHmNDY8qTuEuN3RIvEZxWy/D0hDT7hymi2rAwaR1ZRjnVfateqpUf4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
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

On Tue, Sep 22, 2026 at 11:46:31AM -0300, Tales A. Mendonça wrote:

Thanks for the patches, I've merge to drm-xe-next.

Matt

> Hi,
> 
> v6 of the TLB invalidation ack stall fix for ARL. Tracked in:
> 
>   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> 
> The whole series now carries Matthew Brost's Reviewed-by - thank you for
> working through it, including cross-checking patch 3 against the i915
> implementation.
> 
> Recap: on the standalone media GT of MTL/ARL the CPU reads stale cache
> lines for data the GuC has already written. The visible symptom is TLB
> invalidation acks appearing to stall for a near-constant ~2.3s. i915
> works around this as Wa_22016122933; xe never inherited it. Patch 3
> implements it, applying XE_BO_FLAG_NEEDS_UC to the GuC-shared
> allocations (CTBs, log, ADS, SLPC, engine activity) on the standalone
> media GT, scoped by a new OOB rule (22016122933 MEDIA_VERSION(1300)).
> 
> The one code change since v5 is in patch 1, from a second issue Sashiko
> raised: the capture could run without a runtime PM reference. Every
> pending invalidation fence holds one, taken in
> xe_tlb_inval_fence_init(), and xe_tlb_inval_fence_signal() drops it via
> xe_tlb_inval_fence_fini(). The timeout loop signals the expired fences
> and only then calls xe_devcoredump_gt(), whose forcewake acquisition has
> always relied on the caller holding a PM reference. If those were the
> last references the device could begin autosuspending before the
> snapshot touched the hardware. v6 takes a reference while the pending
> fences still guarantee the device is awake, and releases it after the
> capture. Matt confirmed the analysis and the fix on the list.
> 
> I am carrying Matt's tag on patch 1 across that change since he reviewed
> the fix itself, but flagging it here so it is not silently inherited.
> 
> Two open points from earlier revisions, both now settled:
> 
>  - LRC coverage: i915 also marks the LRC UC on non-dGPU
>    (__lrc_alloc_state()). That does not match the erratum's direction -
>    LRC writes come from hardware context save and the GuC reads it -
>    and Matt's guidance was to leave i915 alone and treat it as out of
>    scope for xe.
> 
>  - SIGID: the TLB logging in patch 2 will be converted once a TLB
>    component exists in DEFINE_XE_LOG_COMPONENTS(); a colleague of
>    Matt's volunteered to do that as a follow-up on top of this series.
> 
> Two notes carried over, still open to either answer:
> 
>  1. CPU mapping: keeping XE_BO_FLAG_NEEDS_UC (uncached on both sides).
>     It is the tested configuration and no throughput difference against
>     the CPU-WC variant was measurable. Matching i915's exact CPU-WC +
>     GGTT-UC combination needs either a new BO flag or decoupling the
>     GGTT cache-mode selection from XE_BO_FLAG_NEEDS_UC; happy to add
>     that plumbing if parity is preferred.
> 
>  2. Fixes:/Cc: stable are left out, since MTL/ARL is require_force_probe
>     in xe. Also happy to add them.
> 
> Validation of patch 3 is six weeks on two ARL machines (7d51 and 7dd1),
> across kernels 7.1.6, 7.1.8 and 7.2, with over 10M TLB invalidations
> processed and zero ack stalls. Before the fix both machines reproduced
> 20-60 stalls/day, every day, on two GuC firmware versions. The 7dd1
> machine, which could not survive a day of media workloads on xe without
> a platform freeze, has been running xe full time since 11 August with
> zero incidents.
> 
> checkpatch is clean, except for one --strict CHECK about macro argument
> reuse in the xe_devcoredump() wrapper in patch 1, which is intentional:
> the macro only exists to forward (_q)->gt alongside _q.
> 
> v5 -> v6:
> - Rebased on today's drm-tip; builds clean, no conflicts.
> - Patch 1: hold a runtime PM reference across the devcoredump capture
>   (second issue reported by Sashiko, confirmed by Matt).
> - Patches 1-3: collected Reviewed-by from Matthew Brost.
> - Patches 2-3: otherwise unchanged.
> 
> Thanks,
> Tales
> 
> Tales A. Mendonça (3):
>   drm/xe: Capture devcoredump on TLB invalidation timeout
>   drm/xe: Log when a timed out TLB invalidation ack finally arrives
>   drm/xe: Implement Wa_22016122933
> 
>  drivers/gpu/drm/xe/xe_devcoredump.c         | 46 ++++++++++--------
>  drivers/gpu/drm/xe/xe_devcoredump.h         | 15 ++++--
>  drivers/gpu/drm/xe/xe_guc.c                 | 16 ++++++
>  drivers/gpu/drm/xe/xe_guc.h                 |  2 +
>  drivers/gpu/drm/xe/xe_guc_ads.c             |  3 +-
>  drivers/gpu/drm/xe/xe_guc_ct.c              |  6 ++-
>  drivers/gpu/drm/xe/xe_guc_engine_activity.c |  6 ++-
>  drivers/gpu/drm/xe/xe_guc_log.c             |  7 ++-
>  drivers/gpu/drm/xe/xe_guc_pc.c              |  3 +-
>  drivers/gpu/drm/xe/xe_tlb_inval.c           | 54 +++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 17 +++++++
>  drivers/gpu/drm/xe/xe_wa_oob.rules          |  1 +
>  12 files changed, 143 insertions(+), 33 deletions(-)
> 
> -- 
> 2.55.0
> 
