Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33ABC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC7E10E33D;
	Mon, 31 Aug 2026 20:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fXeFMV6l";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF8510E33B;
 Mon, 31 Aug 2026 20:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788209748; x=1819745748;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RnoZrruk7fDNNXofrA0/rTOPnzxMPFM4Xck2+cTHfdE=;
 b=fXeFMV6l2guxFhbuMI+xtMO+VSaj6FxYDEDi4WjP8yy3+2INhZ6sFr3W
 vqBPUNxb/6+AVmg4E7zY5LoODIQvsV90PqMjQLSPlDbRW8IA+GAthnMt6
 AFYSt5QB/08kRw2aCo6rLeBWA9oBGA5fh2gXOcQ8UaVf/Vq+mdz2OmO0a
 V6TIi99e1pBlG/f1ZrapKt5fOZB3m5U7dxPJd8zNBpzU0gRcU0aveTf7T
 ORtFye8yJfEDcoYPZyTNnFF4s2LOgPltxFaEW7FFqpZCyJRkPHqRPO4F9
 TK7Vw2toHkEpM9/rlmuKYk9VXeHEyBjV6fIYEyzV0+FAP6xGGqMzgMJuF g==;
X-CSE-ConnectionGUID: BxRUMePIRUCa9ZstabYgIw==
X-CSE-MsgGUID: bcL+0ZFbTQqrph5Y77Zwag==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88636623"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88636623"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:55:48 -0700
X-CSE-ConnectionGUID: xZdG0yo3S1+4Oj8ja1zfDQ==
X-CSE-MsgGUID: j0eJaCEaS7WpLsqxJVnCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="262761332"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 13:55:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:55:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 13:55:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 13:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9ShgJCOyyihJ+0NxxzUdnqS6IFk1K7RwNMl+SjsOfwBKv3zbwbiCO7uGH4kOHmPXk2u4kMpz2as1O6ZKYcfuVOO6gEabpNgCwYBkgRNDjzDUrBikx+N5C2zRKyXWmfvi4YzIWG+5EMXqgPdTRdrdwXSCQ6CWlZK5UVYm/vAdbCHCbmAfpxUI8GbyFONL96gT8Q/SfMgiKp2AQGbDExNDMCXinIqoRhoIkIDTiUaDhnn4UM3gaH//iqvRYkD1Ir+0d0yTv6tdaYeyqCG+1udedcEf8ZTEIJn3DbiDMRAMh21+OaJnxjB7BSnfpqIHMvdVx9Z+uX2C/2Y91vrMJFsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JErdb4ZoJQUs6oxKvA96MugGZG4kYmUhLYYe6fedJPg=;
 b=dcFv6r2rjQsxseozKRhlinOC4OROUE7TFV2ArJY6fRObO4vNOaX+798Ioz4umPAHXmwGrxrWb7OUumb9bhkQxAfyldhxxRzRbwvkQvaf9sBAP0E0RTmr89CiEnafYqZmE46fyRj7V7KNAOEgieqeiEWy88yuC5ngYOMqYzrar8/x8YlfsVA5I3C1teJ6XFvgmjS55bDCgwY83Zbwp9tK8DRXG9A6ngDBQTDL6a7DEaaEUaBT0K2d6pgv8qmS1z18hbGnpmT3GKPw94YbuZIhw0WOTATZGrPH6ULp9d66lT9TWmP2FEmVtLupQxLuU+jGcu/K4wzOErdwEMnMdAqdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SA3PR11MB168349.namprd11.prod.outlook.com (2603:10b6:806:530::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 20:55:38 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 20:55:38 +0000
Date: Mon, 31 Aug 2026 16:55:33 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <matthew.brost@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 04/13] drm/xe: Stop VM work when device I/O is blocked
Message-ID: <apXqRXClcZThJovR@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-5-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827101801.1247654-5-arvind.yadav@intel.com>
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SA3PR11MB168349:EE_
X-MS-Office365-Filtering-Correlation-Id: 880efdac-d286-4ffc-3455-08df07a2360f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tymTZc/Pl0citHPpGpEreenj0sIGIbyQKe/V7iRwIAtz4/MWxz3q40s7t9SwSJH9CZZN7otrGT4BLyLAP9IqOS4zbVjjrTjepFqJNzhK6ZTnyvT0ccjE3Phe4W+5v4IupyClPXS2ulbOQS7HrxBrwYXKN5+OIlIS9B+8W2xuclYm0r97oApyYttQfglsqbtI0Sx7LJ4KUjMVR50f5UfZLeGZUzL5vI+pcCK/bkflKIrcpk8jz6w+AFw9wjJjxH7CDRFeZ+Ane4KebA6+aWTKk1ud+6+os0f7gJvyf1HICEbwve/dKlmp0sB0nY8t1ga5o6j2KphA/75zA79unBUNf9CT0nJ/D39IOsZJAVQc0bsgp2skQ7+X9kVzNj/bu9iBaEP7gmomFJ17+NV61I7ppP2e6apvD22IuknkdPTtawvEEhC/gD2PMGdsB+ZvJuljTUIF3bbmDsSbYzlpjqV1fNqpUnPGF4MVXVVYGxv8P/f3MXfzapK+OwsWE5Eu73BKfhVmDTO6bxj4W09twkUhl8Huy36dWdcu93p7RvgvZu0gTo2XMluqkFGj/zMQW4nMm9EAlD2XbQMJZeeofhAk0TAQgwhGgCEtWXAMWvizNIsT0hZiMP7JAxEswaaC4a1ITWfCEX6M0sNgcczY2OvBg/mwrQNfOUHIOrB/mTHtDyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/YzbWMykEvarsB94sZR0+gcQgIqLmoz3tHtvNPvA2Nw/cT7V8iF0561H0Z?=
 =?iso-8859-1?Q?gZfn32AmJQw81EKlo306Ci+h2J0Ecj8AzuVMTYPP9GxY3e03s/GLytnL11?=
 =?iso-8859-1?Q?CF1c3APvX4XWDRlhPydaiOUFU1CR3vQ1Ty1OYP/MQus0BPKirp0CY0Buea?=
 =?iso-8859-1?Q?cu5hd0IuPRU3kdYXke0b5UOab7fnjdl8mYqXZXbpez9f/n66ETwSbip1ol?=
 =?iso-8859-1?Q?coK3MclT2HQNfWy065kT2oj72HvbrSn6O5S9Sz6ODU9uJIRysI4OAbd/k6?=
 =?iso-8859-1?Q?FJsyM4gkoH17bO8K1ayqNoDG52KA9yv/4V3qi5r5iPu0QE753GFFYpYjMH?=
 =?iso-8859-1?Q?dA90AoEWz8Us2UCrxRsEf5Jpy6ID8vHrhOgiMcSK/yW66cMOOLlD3Ldnn5?=
 =?iso-8859-1?Q?SOroEgRe8WpxKDlrNHVcDgPgmlQFK4tviXZLc7C7VgV+un+6X3L6HrsuE8?=
 =?iso-8859-1?Q?McHq1u47Qbd/u+fwEvXjt4AwcmnQ4BorRH4GFaxxMEeZHZ2JlMNcex7zvK?=
 =?iso-8859-1?Q?XeNWRQNnM0LgRubCKaH249BMewlDSXFi0kVVHKEsQFFVLkuHWDHrTJkQNo?=
 =?iso-8859-1?Q?AeHSJ15coQIiPZPohUYnqNOVS/xFhCRlidI92/uqxJw047FkLRwK+236n+?=
 =?iso-8859-1?Q?lYJzcrJPFmPGJ1n4ct7imHYjvbOAaNx0sQF2/bKy0NQiZm59WLGh0JUVsO?=
 =?iso-8859-1?Q?yO437v7RIkz1EotdmiqmR/Uve1Jnm6I3qkRC97XXoaEZENa9M8Vb5ySHz5?=
 =?iso-8859-1?Q?cFcvT2V1zLvOz2Zg/VMbFx/BFa34+Lg7vNTjTxTYbigRQA0MkTv+7Ra7e5?=
 =?iso-8859-1?Q?zOVuKI04cJOwRgQGMyu663IBygrS+iaWeSv2BQqSqK1bu8b7cfRGrKA91z?=
 =?iso-8859-1?Q?VqgpdJhej36L4+7T/ihV6XNyjXoFnjpT8yzKp3CJRnEXeWrlyEtJLCpTJH?=
 =?iso-8859-1?Q?spWn8DlF4GRpzLlic0qZD3E0oe5/gRISQ0qvaYmmxqKgMS1YOm8BPzI7OV?=
 =?iso-8859-1?Q?8Yu+jaTyc9LWwB155v/7Vg+BRjaKG4axCv6ePFi1XtfcmW6FwjsukNRJNf?=
 =?iso-8859-1?Q?Pgl50tdcWbTLA6aOfgQOoSNZSYOuhBNGXrvLpJgeWQCekSNeT2z1mG+KUa?=
 =?iso-8859-1?Q?Uc2Q7UcQRh3FGT9FiIL14hjB4Wu1p64VkdPnJrh3nR4plyIQgbRMFJLd5F?=
 =?iso-8859-1?Q?qzIM20NF7SEneluBCEGxVrm46Abw/Wn4RWMm9zYY93YHOp0InWGjRJkQLZ?=
 =?iso-8859-1?Q?xW+p/d6tDVFehvJvZEVS+mzD0+tncAf4+HBW2LyZ5K0o8O81W7E8z6glwX?=
 =?iso-8859-1?Q?2SuqDLRoUnjKCioVZnzjKlp6vHFfOBGXZ1ZZC0OiSqJUQ1ed+fYslc/QE1?=
 =?iso-8859-1?Q?HA0ULy+tpfpuGuh2KRuJiKqosUYmrNsbF3cRbl4F0gF6IL1utu8D2mn2UC?=
 =?iso-8859-1?Q?g1wzwzS99fThFr5PSVM/bL02qivPODEUx2BnmBKHNkA65vY9gakMbQJGNd?=
 =?iso-8859-1?Q?lkewjxsKo5fr6TdXDpeRVOW3jCxngGdZsbLm6EKMeObKY92Kf2P5Mrp2ku?=
 =?iso-8859-1?Q?N/TfRtug0sR3fdwJrxem0/jLIACebEoAcrWN+AkSXZc7mqKuAQDKiOW7lp?=
 =?iso-8859-1?Q?NaI7zkMaJAyBbddjpc6GRU2C5oLq6OxTi/4azvHGX+Q8WaoLxM8PMn+SbT?=
 =?iso-8859-1?Q?6t23trZPvShauroIzCASeJYC6UQYiRyb8Sq0Zw95xiIhw1UGGh+Dem79Ka?=
 =?iso-8859-1?Q?iEiYF57J4AD0uSeUw4AhBl3n3nPAsm2gs4aNtz7Kh50SKHbPTugbTqTB+K?=
 =?iso-8859-1?Q?ud4HYWvx5w=3D=3D?=
X-Exchange-RoutingPolicyChecked: 0MlLnfTvKLi0g6mkqGzt4d+FhCmkvKpkDNpbd5tod9aBCtNZ4x7yqidFVUzjQMQ4Vary8b861rNyP+CeYC8wNfxzn+cN+POZ1meQ7L7L9wUe7YEh+BhhulNG4tnoEkNlLtw3hXQSeJUEfU73CwKf3hg3sEv4al4aXUJ0iAEw82U3Xu8EWxyH6lk6Cgo2Jd9QZytQcQgMzeXlKVTkSfOZF0DrpHY7WL3DOQ+X2+2j/wK29x/J09zyOO+8Nq9CiLasKvlB3eF09iJiHdtnfupIuxamdjo2voI53ctiN9Kjn/CCu5lB/8tz/NfP5er2qh2Cl/GbOV7rUyeW/d1C6kOEKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 880efdac-d286-4ffc-3455-08df07a2360f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 20:55:38.6022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHwFEl1rbe8DEmkAAKhKyM97F4mZr+WjgPcIWdiYEKOr99oj5kY1KMamVL/f458M2xvNESB6Q+015j4zLktqsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB168349
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

On Thu, Aug 27, 2026 at 03:47:52PM +0530, Arvind Yadav wrote:
> SVM fault handling and VM rebind work may still run when PCI error
> recovery starts or the device becomes permanently wedged. This work can
> validate BOs, update page tables or submit migration work after device
> I/O has been blocked.
> 
> Stop SVM fault handling, pagemap population, device-memory copies and
> preempt rebind work when device I/O is blocked.
> 
> SVM invalidation still performs its software cleanup. Do not warn when
> TLB invalidation returns -ECANCELED because hardware access is blocked.
> 
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_svm.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_vm.c  | 16 ++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 627a741293d5..9e78131bfa39 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -11,6 +11,7 @@
>  #include <drm/drm_pagemap_util.h>
>  
>  #include "xe_bo.h"
> +#include "xe_device.h"
>  #include "xe_exec_queue_types.h"
>  #include "xe_gt_stats.h"
>  #include "xe_migrate.h"
> @@ -288,8 +289,11 @@ static void xe_svm_invalidate(struct drm_gpusvm *gpusvm,
>  
>  	err = xe_tlb_inval_range_tilemask_submit(xe, vm->usm.asid, adj_start, adj_end,
>  						 tile_mask, &batch);
> -	if (!WARN_ON_ONCE(err))
> +	if (!err)
>  		xe_tlb_inval_batch_wait(&batch);
> +	else if (!(err == -ECANCELED &&
> +		   xe_device_io_blocked(xe)))
> +		WARN_ON_ONCE(err);

if (!err)
        xe_tlb_inval_batch_wait(&batch);
else
        WARN_ON_ONCE(err != -ECANCELED ||
                     !xe_device_io_blocked(xe));

>  
>  range_notifier_event_end:
>  	r = first;
> @@ -631,6 +635,11 @@ static int xe_svm_copy(struct page **pages,
>  		}
>  		XE_WARN_ON(spage && xe_page_to_vr(spage) != vr);
>  
> +		if (vr && xe_device_io_blocked(xe)) {
> +			err = -ECANCELED;
> +			goto err_out;
> +		}
> +
>  		/*
>  		 * CPU page and device page valid, capture physical address on
>  		 * first device page, check if physical contiguous on subsequent
> @@ -1125,6 +1134,11 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>  	if (!drm_dev_enter(&xe->drm, &idx))
>  		return -ENODEV;
>  
> +	if (xe_device_io_blocked(xe)) {
> +		err = -ECANCELED;
> +		goto out_drm;
> +	}
> +
>  	xe_pm_runtime_get(xe);
>  
>  	xe_validation_guard(&vctx, &xe->val, &exec, (struct xe_val_flags) {}, err) {
> @@ -1165,6 +1179,8 @@ static int xe_drm_pagemap_populate_mm(struct drm_pagemap *dpagemap,
>  		xe_bo_put(bo);
>  	}
>  	xe_pm_runtime_put(xe);
> +
> +out_drm:
>  	drm_dev_exit(idx);
>  
>  	return err;
> @@ -1301,6 +1317,9 @@ static int __xe_svm_handle_pagefault(struct xe_vm *vm, struct xe_vma *vma,
>  		drm_gpusvm_range_put(&range->base);
>  	}
>  
> +	if (xe_device_io_blocked(vm->xe))
> +		return -ECANCELED;
> +
>  	/* Always process UNMAPs first so view SVM ranges is current */
>  	err = xe_svm_garbage_collector(vm);
>  	if (err)
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 19b3d0be7928..0cee5306fb9c 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -497,6 +497,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	}
>  
>  retry:
> +	if (xe_device_io_blocked(vm->xe)) {
> +		err = 0;
> +		goto out_unlock_outer;
> +	}
> +
>  	if (!try_wait_for_completion(&vm->xe->pm_block) && vm_suspend_rebind_worker(vm)) {
>  		up_write(&vm->lock);
>  		/* We don't actually block but don't make progress. */
> @@ -518,6 +523,12 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	drm_exec_until_all_locked(&exec) {
>  		bool done = false;
>  
> +		if (xe_device_io_blocked(vm->xe)) {
> +			xe_validation_ctx_fini(&ctx);
> +			err = 0;
> +			goto out_unlock_outer;
> +		}
> +
>  		err = xe_preempt_work_begin(&exec, vm, &done);
>  		drm_exec_retry_on_contention(&exec);
>  		xe_validation_retry_on_oom(&ctx, &err);
> @@ -531,6 +542,11 @@ static void preempt_rebind_work_func(struct work_struct *w)
>  	if (err)
>  		goto out_unlock;
>  
> +	if (xe_device_io_blocked(vm->xe)) {
> +		err = 0;
> +		goto out_unlock;
> +	}
> +
>  	xe_vm_set_validation_exec(vm, &exec);
>  	err = xe_vm_rebind(vm, true);
>  	xe_vm_set_validation_exec(vm, NULL);
> -- 
> 2.43.0
> 
