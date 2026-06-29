Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8ECC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F11D410E8F5;
	Mon, 29 Jun 2026 15:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UzZW77ms";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3C910E6C0;
 Mon, 29 Jun 2026 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782746883; x=1814282883;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xJAZSkcPF0xrJoOEd8c8eE47NVij8LC3McIYUlcjy/M=;
 b=UzZW77ms4YIgOegqAXp3/Q02KKLOEiF+PD3mzjxo+R/7JRIMS3huOfEP
 mUEWrE41+M6gQXjoab0BcK0gqXp07zDPJo1kjR1RADO8V5spR0DnAapTJ
 +KYkWNPHeal3VUW5I/udsOkegXfuSZ7Mva9gFEq2aR52MkZdOKtBg41y9
 qKa0fmZEkCpdBO3CtVMdCd78YFJAR+5a6Y1y0QYYmbRn415J0UCwxddJT
 j4rSInuyXE7IJnGgtoH5F+fTRpmZOcHCORtT4M0ztCjp+02ANZribXyZn
 XTCFT92XQ3cOk0MFx6orhxwztJiSoEMEktfE3TMGw2LjV1KPLStrx/wfp g==;
X-CSE-ConnectionGUID: ZWc1NojcTGqrQhbbEYmRag==
X-CSE-MsgGUID: fzHSRmlQR1i8ee6xuHuTDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94097209"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="94097209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:28:02 -0700
X-CSE-ConnectionGUID: dB44BITgRUCXRjPhpxGC6g==
X-CSE-MsgGUID: ZoN3XUfTS8+uD7War4az6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="248015113"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 08:28:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:28:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 08:28:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 08:28:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR3nEYIlDdPxSbHs+0Xd5WcIs9KxQsZjSK8mIveQTgYuSXhRXMzfj8yTMrKdGhyedegP0m/hHNDtA6yXa1pcYdLEo6sp9Nf0DgTkn3BtKK1svjxdDzeomefspy8NPflvl6XmFM5of57yYMKJEeK0tZzqA+j2F4kDtDmvkkjkR6VswktcrImpw8RhQ0TqAxwdsyRsoeWzUEy30VQi17Lj/yJ4B8mDune6ntYk8uSrJdl/VaE4Rufxkn0WiTS6AJk7ddghlAbbYbYEGPhmP4dMUsDHboNT//2cQycg/Oi7C+5U2nMRhvmNshXLFgQvLhDR9RUGoB2UY376JSkudkv4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR9BdCRRPDHOJZGVBVkxxydT0G+O8zkUq+uT+QrF0Ps=;
 b=rhGZbJZRMRoG2bHIJ0j9OuyGoqPJB8n/4ihCmKF9vIkGzzpgGEUG8Tke8VAzdG879yY+Jk6NfuOA1EOTY6tGGsG+rdBLy6xIULtn2jMDy/0lgINdZcWyUScOWCprR4Wlk8GYvb/4SKUdRTfk/v6QKbCKB5kDR6kcwrRJiM3HGgbuQy/iuQLXxHd+O1YJXga/lUuNuVVZOwqcYgPiD1Y5+5ZbMK8PjLhT7wA/zrbcpDDoWwuYUiABz7542D3IkactnWNKkmB8WrbhZ7vKpWZuYZGcjtog9lffps39KZPFB/aT9vZIaaUnsgeGl3Ov/B6sPECYwhrs/GUGsy8lUOX8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 15:27:57 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 15:27:57 +0000
Date: Mon, 29 Jun 2026 08:27:55 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Chen, Junjia" <junjia.chen@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <Chen@gsse-cloud1.jf.intel.com>
Subject: Re: [PATCH] drm/xe: Add creator TID to sched job trace points
Message-ID: <akKO+/REqcVGgukr@gsse-cloud1.jf.intel.com>
References: <20260629061527.146714-1-junjia.chen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260629061527.146714-1-junjia.chen@intel.com>
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe3e343-f53f-4755-465e-08ded5f2ff45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: LzDlz05dEZVPFwDbnAbg+OZmdYiVm5VMMgX6tDwKnndmaHkyoiYCYnFxRLH+ZoVDvxdZU3OW5kU+LVZVs42mAoFIlEpDxxk9y0WXd09DVuwOBCUoyfE7fWqNyCfrGIdzaHryJFg36eHaDJZRNjk3mdct55Se+SNvc7PUC7/HMQpHAi4HPcHjJ4arKR+DCQYF0AGuNVjCw/N1/Iw5Ef5tDF4MdGuFEgNiDJvvkRIfBIdPmR4EGkZ5H9g4jDMgPNYQSYsRmOgaWRkZ9zdZKhu20l8Llm7/Z7jlnWrzs7kJhJZEi+k617YPKqn01uchTtj6dxHF16QMfiDjhrsH4a1gAeP8jf8NmZWSO7iKDBsmS1U4jATv91tZthK+uaEnEREqlQeux+HXCDO6ITELnt/hIEdv+YoJYP00ik3Tu/KpR2qyL/vHp38kvjt5qb6KgyNzSMwWyV6+rNjc0w1P7sMJ9SQpPZZydea5iNsarVjF3ri46iWYcjoxiMa5gcw7RjtKdRGwHavgn5mlFhc6Xf2KiULlrDM2mTd7EY2Ecoq7vPEMX0DK/ajv51G5dzEYoPZ0qiKQLhuxVPaPFqQmHbP3zWHn8xZf5OlgdZTW5kMk6/KPbNjoBBiS9VW3VLMshhaMEtpH0gWuhf0Awo9IuFD0ERJhezRcedJ6JpWsZBatiwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBFYkkpPNJNdqBFtdn0V4QsI3xQrA+ZgFR1SvlYlg1+Wd6Z7OPxK3Cs1vqS7?=
 =?us-ascii?Q?t+st5mxuInmGguAKs8i7elHrEZc6iVvEDHsdmLeqMtvkoGI/GiDdCdxwAZZe?=
 =?us-ascii?Q?ENoipV/KKlNByXEtxsFIV238hufrgIzAEELN++1LXcwoay1aAnNFLhZ+B48e?=
 =?us-ascii?Q?NEr2gFXnlz6oBhSu+PLZwLPrHiypQUqCjhWdc1d4ySjA+f9FQVJZOmIzOGBv?=
 =?us-ascii?Q?jPWq6/650zNMLgDtykvjb2c5+JwxoQsugogAH62jgVgwR+BcPZSyuwiFP1vh?=
 =?us-ascii?Q?ZTLlipLS9S56I3tisPiUJpZruIY9HvSWGekHRRP8me8Wvy1PStw6dUdLgNVi?=
 =?us-ascii?Q?kauv2YqbHbi9mGq8ZZUOE2hoWk429Z/taY33/YRlYndTpWZAARqLytNcjFJW?=
 =?us-ascii?Q?zaNQe/uLpTp8VFK2V4hGDys+2EsS1IswkETWVZ+aAPD0trpuMWHknUAFLhYB?=
 =?us-ascii?Q?JsZTUTVwgFGbBCjT7agq6vAyj0Pql74ituyc8B+DhEjbmS0DUKT2txEka7xO?=
 =?us-ascii?Q?XJov1MJY/KLO/z8tftOXG8DR9nnW2slQLFtpplEGhy5sbFrPQW0iMYwtwmrF?=
 =?us-ascii?Q?VtIkiqFrGym5qDZXFoFdyFERjIsFPw8IE/NmhYgEyli0xbHNqHLy+ifNK6jw?=
 =?us-ascii?Q?WqxZv4/T4FjdG2VV6wzEO1J+3a73wQ4O1ZLb/d9J9vaVGKwN3HkRugSoKo7Q?=
 =?us-ascii?Q?lmRaXFOMsEcXhnsMOIAjBYW8PTnji1W3743UhOLumCOmP4ziJGwZQDednjVt?=
 =?us-ascii?Q?TbHTz4YPlS6dQkvYNFKBoe2P0SCd3tgIaXw1mqwQOAx+3kcpcHPunmdcI7YS?=
 =?us-ascii?Q?J92U7ePpDEQr+MCjK51jbXPw7AIGNnwspdoPfu+Grao5zylh6k+gs5yh8IZJ?=
 =?us-ascii?Q?eyHQMCnS9C9n4yTGymYXtilbR5F9xytd3JuEvC9X7Guzsu5/XJ3OVHxhLuYQ?=
 =?us-ascii?Q?aG4hl1ItexX2hAITlnax3PPgTE9ANNrG6DcPr8nyK0WIYxietQnz+pf+6IMZ?=
 =?us-ascii?Q?TJeaAwVmskDSY5gw2eGoC1KKtAIm9xgU2ttCGLHNlFKdMzMDuAjjfYL6X2hj?=
 =?us-ascii?Q?8nVT/vfs/widE8C8ktnLttjaVA+ocgLmOuBVJuItx7WJxJpqHp4XAtjo6W7X?=
 =?us-ascii?Q?+81YJ1TkbMsqiiuHmi1exrctTVmMOf9R3BdCkkJy7Uw/YDvGUkSChgJTXXB5?=
 =?us-ascii?Q?Auhihp/3fGlZCGdLjw18QiUFkZ5n1eQJIDHDuFFYzxrY+MtFiekSgILpPyda?=
 =?us-ascii?Q?zgU/0p0HVPuTzjzGUbPQdknEEPx6hO/dQtrC+WrR6kTFtWys9mNkbXfPNoVy?=
 =?us-ascii?Q?M1au/NAf81bxWE/eBpDS8tphb3RGPnwhG7N1s7xUNXRlHhZl8437DPlmjgJZ?=
 =?us-ascii?Q?KEP2MznZpUidRB2SJFXN2/BSc/TrlPuZ1mgUc4RRBsFdIBN2ivbUn9fDMHps?=
 =?us-ascii?Q?VAPGHJ2VPWxwSQsQIr/G9ciXFmejoteEU9wnj1tWvEgd0CvZCiKpVanv+cPd?=
 =?us-ascii?Q?rW6ldROtinfvVjQ3O1lmXFKPfrAezcg7IYNZw6czLzcgYAxJZv51bHXTYADQ?=
 =?us-ascii?Q?Yp6zXczaA+ZKVp5plPXSHjOzuq3Xy9+oGZLeQnYYbK9LTSosfhpaML9pqFxf?=
 =?us-ascii?Q?/5Pxgxl8TLif3sYMnaCr4Gb8b5jyspVa0DZlqWCXejsfl5nw/LRpKVzlodD8?=
 =?us-ascii?Q?mblO8x0W1+HJE1K65j0gEF9zZkfHnHESPjaI4Uy8O47OzR5CEJU4v4+2FJwd?=
 =?us-ascii?Q?Pf8QNbPo/Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: bqwZBWf1mrelLvWOGMpzT/av2Cx+ymCCIgdXKGvvsf9OoJVu1pYMnQZ7UfKe8sKnDQ2V3sbNJx0kWezcue5zO7dh734bUpUZ9Gy1DcnC3MvnlgtVdThcAlCGBQcAfASU+dDGYj0uNsunsTS7ZFF1K1B5hkTAabKdah6MIsr26pea7GJylE62WqdwBt/cvGAp4QUlhQ29tM12ftW1tQdjh456k3uQEaIEsbvoKUGM2F6AYTpN0C1ILjvyZQaD7fesANx6V/aP0f93yNzA6D4vzElWVq8Tl3zwlrTPbj/8+UVqfgpliaVziICfW1WF93W8sJO8WRmKfBGVBuFk80q5Ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe3e343-f53f-4755-465e-08ded5f2ff45
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:27:57.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8EMdpp9aCpnDkDvArEh98spb2NCV6lI3KZUUvW47MNW3zLpo8G8AQ2bykJy4wLrj23sr0d8BiYaTuFf05HNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
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

On Mon, Jun 29, 2026 at 02:15:27PM +0800, Chen, Junjia wrote:
> Capture the creating task pid when a scheduler job is allocated
> and emit it in the sched job trace events alongside the
> exec queue pointer.
> 
> This makes it easier to correlate queue activity back to
> the userspace thread that submitted the work.
> 
> Signed-off-by: Chen, Junjia <junjia.chen@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_sched_job.c       |  2 ++
>  drivers/gpu/drm/xe/xe_sched_job_types.h |  3 +++
>  drivers/gpu/drm/xe/xe_trace.h           | 12 +++++++++---
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_sched_job.c b/drivers/gpu/drm/xe/xe_sched_job.c
> index b64e6a434807..1356755cd180 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job.c
> +++ b/drivers/gpu/drm/xe/xe_sched_job.c
> @@ -7,6 +7,7 @@
>  
>  #include <uapi/drm/xe_drm.h>
>  #include <linux/dma-fence-chain.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  
>  #include "xe_device.h"
> @@ -111,6 +112,7 @@ struct xe_sched_job *xe_sched_job_create(struct xe_exec_queue *q,
>  
>  	job->q = q;
>  	job->sample_timestamp = U64_MAX;
> +	job->creator_tid = task_pid_nr(current);
>  	kref_init(&job->refcount);
>  	xe_exec_queue_get(job->q);
>  
> diff --git a/drivers/gpu/drm/xe/xe_sched_job_types.h b/drivers/gpu/drm/xe/xe_sched_job_types.h
> index 0490b1247a6e..f2ad94105b37 100644
> --- a/drivers/gpu/drm/xe/xe_sched_job_types.h
> +++ b/drivers/gpu/drm/xe/xe_sched_job_types.h
> @@ -7,6 +7,7 @@
>  #define _XE_SCHED_JOB_TYPES_H_
>  
>  #include <linux/kref.h>
> +#include <linux/types.h>
>  
>  #include <drm/gpu_scheduler.h>
>  
> @@ -59,6 +60,8 @@ struct xe_sched_job {
>  	u32 lrc_seqno;
>  	/** @migrate_flush_flags: Additional flush flags for migration jobs */
>  	u32 migrate_flush_flags;
> +	/** @creator_tid: task pid that created this job */
> +	pid_t creator_tid;
>  	/** @sample_timestamp: Sampling of job timestamp in TDR */
>  	u64 sample_timestamp;
>  	/** @ring_ops_flush_tlb: The ring ops need to flush TLB before payload. */
> diff --git a/drivers/gpu/drm/xe/xe_trace.h b/drivers/gpu/drm/xe/xe_trace.h
> index dfd87f03c4fd..a3115d6e4c6a 100644
> --- a/drivers/gpu/drm/xe/xe_trace.h
> +++ b/drivers/gpu/drm/xe/xe_trace.h
> @@ -258,8 +258,10 @@ DECLARE_EVENT_CLASS(xe_sched_job,
>  
>  		    TP_STRUCT__entry(
>  			     __string(dev, __dev_name_eq(job->q))
> +			     __field(struct xe_exec_queue *, q)

I'm not sure how helpful the 'q' is here as it can be inferred the gt_id
and guc_id + correlated exec_queue trace points too. Also the exec_queue
trace don't print the queue tracepoint either. 

>  			     __field(u32, seqno)
>  			     __field(u32, lrc_seqno)
> +			     __field(pid_t, creator_tid)
>  			     __field(u8, gt_id)
>  			     __field(u16, guc_id)
>  			     __field(u32, guc_state)
> @@ -271,8 +273,10 @@ DECLARE_EVENT_CLASS(xe_sched_job,
>  
>  		    TP_fast_assign(
>  			   __assign_str(dev);
> +			   __entry->q = job->q;
>  			   __entry->seqno = xe_sched_job_seqno(job);
>  			   __entry->lrc_seqno = xe_sched_job_lrc_seqno(job);
> +			   __entry->creator_tid = job->creator_tid;

Should we also include the creator_tid in exec_queue trace points too?

Generally the exec_queue and job tracepoints are used together.

Matt

>  			   __entry->gt_id = job->q->gt->info.id;
>  			   __entry->guc_id = job->q->guc->id;
>  			   __entry->guc_state =
> @@ -283,9 +287,11 @@ DECLARE_EVENT_CLASS(xe_sched_job,
>  			   __entry->batch_addr = (u64)job->ptrs[0].batch_addr;
>  			   ),
>  
> -		    TP_printk("dev=%s, fence=%p, seqno=%u, lrc_seqno=%u, gt=%u, guc_id=%d, batch_addr=0x%012llx, guc_state=0x%x, flags=0x%x, error=%d",
> -			      __get_str(dev), __entry->fence, __entry->seqno,
> -			      __entry->lrc_seqno, __entry->gt_id, __entry->guc_id,
> +		    TP_printk("dev=%s, q=%p, fence=%p, seqno=%u, lrc_seqno=%u, creator_tid=%d, gt=%u, guc_id=%d, batch_addr=0x%012llx, guc_state=0x%x, flags=0x%x, error=%d",
> +			      __get_str(dev), __entry->q, __entry->fence,
> +			      __entry->seqno, __entry->lrc_seqno,
> +			      __entry->creator_tid,
> +			      __entry->gt_id, __entry->guc_id,
>  			      __entry->batch_addr, __entry->guc_state,
>  			      __entry->flags, __entry->error)
>  );
> -- 
> 2.43.0
> 
