Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773D2C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08BF10E8A1;
	Mon, 31 Aug 2026 21:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i0x2Q3mP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B9510E8A1;
 Mon, 31 Aug 2026 21:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788210073; x=1819746073;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=IfQaRVQoB6r1MzGcxK/T2zAP4y34NTIaLwDrJ6GJJCM=;
 b=i0x2Q3mP5GPn5RAt0B0abQ5uUXL/B8GGkjsGNDBy1SE+RG+UDA3I7t1m
 ieOSjjXBylovK3ncVN4MPc4Su4EC89LJ668IwwMXayEdcLZaAUdNh623z
 CkTDbEmjsTS0ycOW969Z9BaGMgMZVW9RJIyVsyBlNIeU7waWtm44UV++y
 sUdY/xev4U5ObJmWIBMO80dwHU/9/q1ly370aAOSffjVGC1GH6dX3Uaxh
 CaRhKrqfkbG0muLzGBearVGOu5SAfSSvxeVDj/VS9xzEf13XRf2CSDuGR
 iSTQrNkYlrXTO8b2Fw8Xftx4eJit3lIyrdIR6gLOj5YSWCoiW+36qTIQY Q==;
X-CSE-ConnectionGUID: efZb5+MqSAKqJ036KBC2Fg==
X-CSE-MsgGUID: HFIWf383SjuYcisIX4po7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88555291"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88555291"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:01:13 -0700
X-CSE-ConnectionGUID: JYkxCxU9RFK/71vHx/ObPw==
X-CSE-MsgGUID: KcfL/jabRnWn5U83YATKfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="267583079"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 14:01:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:01:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 14:01:12 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 14:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpvwABopgUx58ftW9YtLQQ+j0kcoDn4QIGbC7O95XhlhqrBHHNhSDXuPs9msOI2e6Xhx74tcAZn1S0q0l8hyZKO1k3gIyBt5MkZGUfCTmK7yBULmyOz/oaUQbu6USXuc+OoXgM42YBpPWdMj4QEfZa510B9JJGmwFoWRQN+z9Rj+oxhwKxAARvs8rokXdHJycCBuxjYRhL4WXf1p7vx2rQFNEKq8acul7Zc2oV8oMC02qz7nzH1bcpSg/yaeluPKG/3Q/s9HOO74C7l30bUGpE12C6H7dbEwmSKnCRLWEiZJlpfE/lDWZnq7S10oJC/S+gnMojOop4PxqbOBlRq7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4QuzHPhfETz7Wm6P2KzzWomp3oRdWLNnqkHFLoSNvU=;
 b=Vc7P1sy+dyxM/f/dGpDalVK0zyyF2JrVgsy4AJ/FQgLZ7YD1+h25uw1SGGZfEv1ntZ7fqd3tWqD/g4RUYE/i3/3atPfMFZn9gopr0TKn1MHrI2mKsqVnD0YTYVffK4u/H7vUpHuvSHl5vzDSy+BOo+riHcV4p+6lJCXuU6U4ycqEKu2iTjBOcwF6Ubqmz69mEMOzndnwoiqyEv/a2kNBcTFX3e/1+SL04l/D3UjDBhSc0dzzIonizu9TnfMdt+EdkoaUm/UktGQjvhK8kMhie0aF9ihkV57NUJBkLQBMDwzCQlfwxN0LAzy80F7PjAEh2FZWQvvU5GbM2g4Go6vfyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:01:10 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 21:01:09 +0000
Date: Mon, 31 Aug 2026 17:01:05 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 11/13] drm/xe/guc: Skip timeout recovery on a wedged device
Message-ID: <apXrkf7p5eTLbPUV@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-12-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-12-arvind.yadav@intel.com>
X-ClientProxiedBy: BYAPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:a03:114::38) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c36f3d-ba86-4b96-ad55-08df07a2fb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10086099003|10067099003|56012099006|4143699003|18092099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7ijsLkyhhsp2cTW8hyCQDR2l4GCulv0mNGty1n4tI13/g/it/czN7qQmk5V/e31y81giS6KstWJAW1mW9nnWZQ34dDCHrFDe0Vhad6xihL4lPXWXQh7nCTjxFDbi6scE9ma9ZVcPHkSOcSjgjqQiAB3012/msI0Jkq9ERgqqQRT4RGs9nL3pg57KNotQoaxs24f9ecWsvLwG5CYw5P1JV6OtpJAX2tesRitF0gUgOG9wkIJuhJssI/YmGyiF1wwF/vMj5xUBwRqCK3FH3bdwlPpIXvqvKOo6c8zmmyvUyZXv0pI1xcWanyKyem5HAQzoIdm5nYh8ucK0fFGU/Dh5bAD20yGjticn8YV+lqj3/DW8pnE3s7TEl2D8zIfFqEvcdnBC1o7Oki2Rx/+rLyeidzHO5NQE/oizhrnjZl01wAZ/Sh69zb50eteiV4IKCvS9440QQiNU5mE2AG4P6kTLgUQWrIG1DQ/EibkSpmrUFs0wmiTV103MyA4LOOyqM2C7zyzfz9PV+n7YLv2+IrupPx0UH0Vjvy6itXEDWogRdNP7EbvIO9tCB039LOrBtM6patq8dZARQjw2mLm0YJCdWfPV/wz6j+4EZRO8tK9TMGEEq4UhA3s9l/mX+TZzALEv4glp6wmNsUC31DGzZaBOOquTg010K12aFiCjDIPaItE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10086099003)(10067099003)(56012099006)(4143699003)(18092099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?e3PYq6WFard6HW0SqLTWRUbq5leacMp4Ta+e1jIWiQKevUulvlAOFbyGlr?=
 =?iso-8859-1?Q?YfiQf6pL8yGjJpBb3pvnghCX4EFeXeSHifVs1nhxRmezbePtMY5YxLmoaG?=
 =?iso-8859-1?Q?Qx6J5VJSN0mrw7Mbh5hTd5IrPVmJtGsQ0ysvDRsV7q49vvV36Z67Brqpw4?=
 =?iso-8859-1?Q?KM8vBdyX2xdek/i3CF2RHDb8TVnBfp8h99e8POzWSTk9dZEg6LbUOfDEpw?=
 =?iso-8859-1?Q?Cd8oCpfXTYcHYvie4ADrLdkFkdvg7DhW46DCVWIiNOwSiVNL6f67m87O7q?=
 =?iso-8859-1?Q?G6YDKAhcWEwHWPJ9dgBoYuv7zhc/nqoQJCbsrwaP8SycgcAkcWg96m4Aw6?=
 =?iso-8859-1?Q?fWO1Z1TGNy/EEryfH8MkiRLrzqVj8hWjrzrlAwST53o88LNytxZFPloD3z?=
 =?iso-8859-1?Q?NSL57jNhaR8d3ofmzkdmbe20RWW0C/VLH15oBPR+DHo3KLYt2RjTjlR73k?=
 =?iso-8859-1?Q?Q8lgT1MuDmEptkqG23pk16z/prTTmWBi9hwcVgiXiZRv3rfTwpcT2vqQJt?=
 =?iso-8859-1?Q?4bk8KwsnLL6PNQhUQrjp4jeFFygabjQO6B60MFWcdwPTDm/t/gyhE7iOH9?=
 =?iso-8859-1?Q?zq0euIQsDW0HEKpLG+QgHpkQwvEMQ01O0dv4zLX6zZ7++w9XCQCcCyZiix?=
 =?iso-8859-1?Q?sQakKh5qJ3YJE8s1/piYYMQ9d3inPnOT9bP5DnIoDpAI7m/D4Ah54zcsFD?=
 =?iso-8859-1?Q?y0zbGMZqLOlF2OZpmo48VQK1ZFlpJhHrmOG65Wj2xJ1ZUzYRNIqgEIow9S?=
 =?iso-8859-1?Q?cqdqLHQbv8lhSZYqaXG5K1n6c5wsB9bFTuUgWq+2dQQTaJYFiliHABKBSa?=
 =?iso-8859-1?Q?i0o/jrUu9D7IFB5dzpubYfHq9v5H3itawVTu7N14LorY2qh6kfeWcfmZmq?=
 =?iso-8859-1?Q?mLvMoSqGS2LsxE1uESugNmRof0mdTcLvA0bMitJ25JcYYy98yqWHUp212P?=
 =?iso-8859-1?Q?7G3HsiFJhnx1DqsRCh5ZCwFbdrDmCCV1CGvbHl+itUY4kBKP26nreiJ727?=
 =?iso-8859-1?Q?6L5zgKPPiHVmFuMz/CaRxyJndaK5w28JjM0gPZSmlcfxDy5zND4/D1/JRh?=
 =?iso-8859-1?Q?npfWShp7ZYW3B/cab42u/XrAtS/k4h7zEnFlRfAH48ZwkmEFNjjIBckj/p?=
 =?iso-8859-1?Q?3fvTIWUSmUlvabYswYpJubAnyyV/ld2mq6k3Abr6mSBW+LgsVtJvPud90H?=
 =?iso-8859-1?Q?GuOQRAgrF8FTa4rggSjK8rRlLDI2wer/t8cNXsf923M4j0RjFtpENhMphB?=
 =?iso-8859-1?Q?nr3MmaIhrPTFoJTffOy+cXdeBg6G4zMQHh05klKvx9KACixSJrG9r7jnJv?=
 =?iso-8859-1?Q?E99/94GO6z5NElyu76MXA/5n50mydowWZd9ZLYIfIRoEnMIUrOpxcQhKiq?=
 =?iso-8859-1?Q?HB6B8jnsCHB4sjlt67uOxJLf5fjmNO8UEOwECDoibQni2i0FfOJLhtCypp?=
 =?iso-8859-1?Q?39SMxh46JhuLhhYgKGZ33Fjrt95Rl+5H6bANOdvebjvQ+wSBUaTmALE5p0?=
 =?iso-8859-1?Q?ug1ZY43Sp2OlepXzjUOGB9HYwcTrWzTmoQZ91nDRlxR3bNS/e1X5F/UYO3?=
 =?iso-8859-1?Q?YLFB+VPnQ+zzbIXwDIEX+e5tWnsZE17ATNbYM4nu5xY0pZJfHQXHPeRwye?=
 =?iso-8859-1?Q?N+OaM12IDzUGnSoYDTOdYfYInSMNAq1/GzvS0gt88SnK5ZmyF7aKriy//n?=
 =?iso-8859-1?Q?A2HnQY9J6x3QhlGshfaFuw4Q8PWildXndPxHrXZK0EdNAYDUZUtx/ZXLIP?=
 =?iso-8859-1?Q?n4TP9AC2wEHiL1AxEf2hnQs9wHh/cYqb88tmKgD+l4hzHCKGbsdEoiAVzG?=
 =?iso-8859-1?Q?iPzkUHRcwQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: MI++OfMkUqPfpq4yMkCb5nFe0HyNtW6liCEmfWR1vDmx6QVf1RXYWabrwu5przg+oYapv3WeoCu0Lnu8DI40dXuEjetE2cG5zM5wa2txl36FJjsc3rtbV23AdrCX4eg1oBQ9DYG9qe1KYq9SlC5KtFvCsA3sxvTdJW5PrabG5G1BNz/rTizn7MBmw7n5CXhrS0z9sc+eDzNzCl/t6uip9JJl7h6QnydR8hDf0PUFcvgDq86+5vqrWw4vzF39e4ZGRRIwa5Sc8ucoB0DSUfkVjhgNl8R1+Tfy23RKb5nQQELDQvpxaQ/OugQgqn5uqPPLuLLjcSy4/YxRU6UaYf7PQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c36f3d-ba86-4b96-ad55-08df07a2fb40
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:01:09.4597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCgf0wb7JF3lZN3kr9MkGjMuJLig0wLr++7NGKAXdz8bBg1xROMIfDJhTQSljyME2mjsgYF0p1qCT/o4y6GHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
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

On Thu, Aug 27, 2026 at 03:47:59PM +0530, Arvind Yadav wrote:
> A scheduler timeout can still run after the device has been declared
> wedged. guc_submit_hint_wedged() only returns true for the no-reset
> debug mode, so other wedge modes can continue into GuC timeout recovery.
> 
> The killed-queue case already preserves an existing wedge. Extend the
> same check to non-killed queues, where guc_submit_hint_wedged() returns
> false outside the no-reset debug mode.
> 
> If the device is already wedged, use the existing wedged cleanup path
> and avoid further hardware recovery. This also avoids the
> kernel-submitted job timeout warning seen after wedge isolation.
> 
> The timeout was observed as:
> [ 8939.200065] xe 0000:03:00.0: [drm] Tile0: GT0: Kernel-submitted job timed out
> [ 8939.200066] WARNING: xe_guc_submit.c:1683 at guc_exec_queue_timedout_job+0x1160/0x2550
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_guc_submit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
> index a307af458cf8..287a30027b1c 100644
> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
> @@ -1594,10 +1594,9 @@ guc_exec_queue_timedout_job(struct drm_sched_job *drm_job)
>  	 * Killed queues must not newly wedge the device, but preserve an
>  	 * already-wedged state to avoid warning on teardown timeouts.
>  	 */
> -	if (!exec_queue_killed(q))
> +	wedged = xe_device_wedged(xe);
> +	if (!wedged && !exec_queue_killed(q))
>  		wedged = guc_submit_hint_wedged(exec_queue_to_guc(q));
> -	else
> -		wedged = xe_device_wedged(xe);
>  
>  	set_exec_queue_banned(q);
>  
> -- 
> 2.43.0
> 
